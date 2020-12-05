//
//  ProductListInteractorTests.swift
//  SampleClassifiedAppTests
//
//  Created by irfan on 05/12/2020.
//

import XCTest
@testable import SampleClassifiedApp

class MockProductPresenter: ProductListPresentationLogic {
    
    var presentLoaderCalled = false
    var presentProductCalled = false
    var alertShownCalled = false
    var hideLoaderIsCalled = false
    
    func presentLoader() {
        presentLoaderCalled = true
    }
    func presentAlertView(message: String) {
        alertShownCalled = true
    }
    func presentProducts(_ productResponse: ProductListViewModel.ProductListResponse) {
        presentProductCalled = true
    }

    func hideLoader() {
        hideLoaderIsCalled = true
    }
}

class ProductListInteractorTests: XCTestCase {
    
    var sut: ProductListInteractor!
    var presenter: MockProductPresenter!
    
    func testThatPresentLoaderIsCalledOnPresenter() {
        sut.fetchProductList({ (_) in })
        XCTAssertTrue(presenter.presentLoaderCalled)
    }
    
    // Interactor Must call hide loader upon the api response, both in case of success and failure
    func testIfHideLoaderIsCalledAfterResponse() {
        let expectation = XCTestExpectation(description: "Fetch Data")
        sut.fetchProductList({ (_) in
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 20.0)
        XCTAssertTrue(presenter.hideLoaderIsCalled)
    }
    
    // Once the data is fetched successfully, it is stored in interactor's allProduct array
    func testIfProductsHaveBeenFetchedWithinTimeout() {
        var anErrorOccured = false
        
        let expectation = XCTestExpectation(description: "Fetch Data")
        sut.fetchProductList({ (success) in
            if !success {
                anErrorOccured = true
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 20.0)
        if anErrorOccured {
            XCTAssertTrue(sut.allProducts.count == 0)
        } else {
            // interactor will contain list of products upon successfull API Fetch
            XCTAssertTrue(sut.allProducts.count > 0)
        }
    }
    
    // presenter present method is called after successful fetch
    func testIfPresentProductsHaveBeenCalledAfterSuccessfulDataFetch() {
        var anErrorOccured = false
        let expectation = XCTestExpectation(description: "Fetch Data")
        sut.fetchProductList({ (success) in
            
            if !success {
                anErrorOccured = true
            }
            
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 20.0)
        if anErrorOccured {
            XCTAssertTrue(presenter.alertShownCalled)
        } else {
            XCTAssertTrue(presenter.presentProductCalled)
        }
    }

    override func setUpWithError() throws {
        presenter = MockProductPresenter()
        sut = ProductListInteractor(presenter: presenter)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            let expectation = XCTestExpectation(description: "Fetch Data")
            sut.productWorker.fetchProducts { (_, _) in
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 20.0)
        }
    }

}
