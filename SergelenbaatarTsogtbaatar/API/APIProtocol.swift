//
//  APIProtocol.swift
//  SergelenbaatarTsogtbaatar
//
//  Created by Sergelenbaatar Tsogtbaatar on 23/11/21.
//

import Foundation
import Combine

typealias Result = (stories: [Story], after: String)

protocol APIProtocol {
    func downloadImage(from url: String) -> AnyPublisher<Data, APIError>
    func getStories(from url: String) -> AnyPublisher<Result, APIError>
}
