//
//  ImageOcr.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/09/22.
//

import Foundation

struct ImageOcr: Codable {
    let isSuccess: Bool
    let code: Int
    let message, result: String
}
