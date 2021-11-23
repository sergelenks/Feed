//
//  APIUrl.swift
//  SergelenbaatarTsogtbaatar
//
//  Created by Sergelenbaatar Tsogtbaatar on 23/11/21.
//

import Foundation

enum APIUrl {
    static private let urlBase = "https://www.reddit.com/.json"
    static let keyAfter = "$AFTER_KEY"
    static let storiesURL = "\(urlBase)?after=\(keyAfter)"
}
