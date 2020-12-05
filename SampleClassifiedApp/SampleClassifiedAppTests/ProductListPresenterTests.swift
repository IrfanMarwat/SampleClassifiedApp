//
//  ProductListPresenterTests.swift
//  SampleClassifiedAppTests
//
//  Created by irfan on 05/12/2020.
//

import XCTest
@testable import SampleClassifiedApp

class MockDisplayable: ProductListDisplayable {
    
    var displayProductsCalledOnVC = false
    var displayAlertCalledOnVC = false
    var displayLoaderCalledOnVC = false
    var hideLoaderCalledOnVc  = false
    var viewModel: ProductListViewModel.ViewModel?
    
    func displayProducts(_ viewModel: ProductListViewModel.ViewModel) {
        displayProductsCalledOnVC = true
        self.viewModel = viewModel
    }
    
    func displayAlertView(message: String) {
        displayAlertCalledOnVC = true
    }
    
    func displayLoader() {
        displayLoaderCalledOnVC = true
    }
    
    func hideLoader() {
        hideLoaderCalledOnVc = true
    }
}

class ProductListPresenterTests: XCTestCase {
    
    var sut : ProductListPresenter!
    var displayable: MockDisplayable!

    override func setUpWithError() throws {
        displayable = MockDisplayable()
        sut = ProductListPresenter(viewController: displayable)
    }
    
    func testIfViewModelIsCreatedFromProduct() {
        let mockProductResponse = ProductListViewModel.ProductListResponse(products: [Product(name: "Test", price: "AED 5", dateCreated: "23-04-07", imageUrls: ["sample_url"], thumnailUrls: ["sample_thumbnail"])])
        
        sut.presentProducts(mockProductResponse)
        
        XCTAssertNotNil(displayable.viewModel)
        XCTAssertEqual(displayable.viewModel!.products.count, mockProductResponse.products.count)
        
        XCTAssertEqual(displayable.viewModel!.products.first!.name, mockProductResponse.products.first!.name)
        XCTAssertEqual(displayable.viewModel!.products.first!.price, mockProductResponse.products.first!.price)
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
            // Put the code you want to measure the time of here.
        }
    }

}
