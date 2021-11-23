//
//  APIManager.swift
//  SergelenbaatarTsogtbaatar
//
//  Created by Sergelenbaatar Tsogtbaatar on 23/11/21.
//

import Foundation
import Combine

class APIManager: APIProtocol {
    
    private let session = URLSession.shared
    
    func downloadImage(from url: String) -> AnyPublisher<Data, APIError> {
        
        guard let url = URL(string: url) else {
            return Fail(error: APIError.badURL).eraseToAnyPublisher()
        }
        
        return session
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .mapError{ error in APIError.other(error) }
            .eraseToAnyPublisher()
    }
    
    func getStories(from url: String) -> AnyPublisher<Result, APIError> {
        
        guard let url = URL(string: url) else {
            return Fail(error: APIError.badURL).eraseToAnyPublisher()
        }
        
        return session
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Response.self, decoder: JSONDecoder())
            .map { response -> Result in
                let stories = response.data.children.map{ $0.data }
                let after = response.data.after
                return Result(stories, after)
            }
            .mapError{ error in APIError.other(error) }
            .eraseToAnyPublisher()
    }
}
