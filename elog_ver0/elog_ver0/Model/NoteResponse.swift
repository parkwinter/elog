//
//  NoteResponse.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/15.
//

import Foundation

// MARK: - NoteResponse
struct NoteResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: NoteInfo
}

// MARK: - Result
struct NoteInfo: Codable {
    let email: String
    // ????
}
