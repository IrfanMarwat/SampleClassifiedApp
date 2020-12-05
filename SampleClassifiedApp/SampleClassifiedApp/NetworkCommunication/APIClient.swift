//
//  APIClient.swift
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

import Foundation

typealias JSON = [String: Any]

enum ServiceError: Error {
    case noInternetConnection
    case custom(String)
    case other
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No Internet connection"
        case .other:
            return "Something went wrong"
        case .custom(let message):
            return message
        }
    }
}

extension ServiceError {
    init(json: JSON) {
        if let message =  json["message"] as? String {
            self = .custom(message)
        } else {
            self = .other
        }
    }
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

extension URL {
    init(baseUrl: String, path: String, params: JSON, method: RequestMethod) {
        var components = URLComponents(string: baseUrl)!
        components.path += path
        self = components.url!
    }
}

extension URLRequest {
    
    init(baseUrl: String, path: String, method: RequestMethod, params: JSON) {
        
        let url = URL(string: baseUrl + path)!
        self.init(url: url)
        
        httpMethod = method.rawValue
        
        switch method {
        case .post:
            httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        default:
            break
        }
    }
}


protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

class APIClient {
    
    static let apiClient = APIClient()
    
    private var baseUrl: String
    private let session: URLSessionProtocol
    
    init(baseUrl: String, session: URLSessionProtocol = URLSession.shared) {
        self.baseUrl = baseUrl
        self.session = session
    }
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.baseUrl = Constants.environment.baseURL
        self.session = session
    }
    
    func executeRequest(path: String, method: RequestMethod, params: JSON,completion: @escaping (Result<Any, ServiceError>) -> Void) {
        
        // Checking internet connection availability
        if !Reachability.isConnectedToNetwork() {
            return completion(Result.failure(ServiceError.noInternetConnection))
        }
        
        // Creating the URLRequest object
        let request = URLRequest(baseUrl: baseUrl, path: path, method: method, params: params)
        
        // Sending request to the server.
        let task = session.dataTask(with: request) { data, response, error in
            var object: Any? = nil
            if let data = data {
                object = try? JSONSerialization.jsonObject(with: data, options: [])
            }
            
            if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
                DispatchQueue.main.async {
                    return completion(Result.success(data as Any))
                }
            } else {
                let error = (object as? JSON).flatMap(ServiceError.init) ?? ServiceError.other
                DispatchQueue.main.async {
                    return completion(Result.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

//MARK: Conform the protocol
extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}


