//
//  APIError.swift
//  SergelenbaatarTsogtbaatar
//
//  Created by Sergelenbaatar Tsogtbaatar on 23/11/21.
//

import Foundation

enum APIError: Error {
    case badURL
    case other(Error)
    
    var localizedDescription: String {
        switch self {
        case .badURL:
            return "Bad URL"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
