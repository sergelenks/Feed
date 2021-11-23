//
//  FakeAPIManager.swift
//  SergelenbaatarTsogtbaatarTests
//
//  Created by Sergelenbaatar Tsogtbaatar on 23/11/21.
//

import Foundation
import Combine
@testable import SergelenbaatarTsogtbaatar

class FakeAPIManager: APIProtocol {
    
    var result: Result?
    var error: Error?
    
    func downloadImage(from url: String) -> AnyPublisher<Data, APIError> {
        fatalError("Missing implementation")
    }
    
    func getStories(from url: String) -> AnyPublisher<Result, APIError> {
        
        if let error = error {
            return Fail(error: APIError.other(error)).eraseToAnyPublisher()
        }
        
        if let result = result {
            return CurrentValueSubject<Result, APIError>(result).eraseToAnyPublisher()
        }
        
        fatalError("Need error or response")
    }
    
    
}
