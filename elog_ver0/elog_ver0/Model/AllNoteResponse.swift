//
//  AllNoteResponse.swift
//  elog_ver0
//
//  Created by 김선우 on 2021/08/15.
//

import Foundation

// MARK: - NoteResponse
struct AllNoteResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [Note]
}

// MARK: - Result
struct Note: Codable {
    let title: String
    let image: String
}
