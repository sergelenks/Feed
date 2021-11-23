//
//  SergelenbaatarTsogtbaatarTests.swift
//  SergelenbaatarTsogtbaatarTests
//
//  Created by Sergelenbaatar Tsogtbaatar on 23/11/21.
//

import XCTest
import Combine
@testable import SergelenbaatarTsogtbaatar

class SergelenbaatarTsogtbaatarTests: XCTestCase {
    
    var fakeAPIManager = FakeAPIManager()
    var viewModel: ViewModel!
    var subscribers = Set<AnyCancellable>()

    override func setUpWithError() throws {
        viewModel = ViewModel(apiManager: fakeAPIManager)
    }

    func testLoadDataSuccess() throws {
        
        // Given
        let data = try load(json: "data_success")
        let response = try JSONDecoder().decode(Response.self, from: data)
        let items = response.data.children.map { $0.data }
        fakeAPIManager.result = Result(items, "keyAfter")
        let expectation = XCTestExpectation(description: "wait for data")
        
        // When
        viewModel
            .$stories
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { stories in
                XCTAssertEqual(stories.count, 25)
                expectation.fulfill()
            }
            .store(in: &subscribers)
        
        viewModel.loadData()
        
        // Then
        wait(for: [expectation], timeout: 2)
    }

    private func load(json: String) throws -> Data {
        let bundle = Bundle(for: SergelenbaatarTsogtbaatarTests.self)
        guard let file = bundle.url(forResource: json, withExtension: "json")
        else { fatalError("File \(json) could not be loaded") }
        return try Data(contentsOf: file)
    }

}
