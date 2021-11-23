//
//  ResponseData.swift
//  SergelenbaatarTsogtbaatar
//
//  Created by Sergelenbaatar Tsogtbaatar on 23/11/21.
//

import Foundation

struct ResponseData: Decodable {
    let after: String
    let children: [Child]
}
