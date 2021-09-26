//
//  WritingSentiment.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/09/26.
//

import Foundation

struct WritingSentiment: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result2
}

// MARK: - Result
struct Result2: Codable {
    let mood: String
}
