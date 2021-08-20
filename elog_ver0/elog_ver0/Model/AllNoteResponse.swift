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
    let result: [NoteT]
}

// MARK: - Result
struct NoteT: Codable {
    let title: String
    let image: String
  
}


//"isSuccess": true,
//    "code": 1000,
//    "message": "성공",
//    "result": [
//        {
//            "title": "은지 노트",
//            "created_at": "2021-06-07T15:16:29.000Z",
//            "img": null,
//            "id": 7
//        },
//        {
//            "title": "다시 볼만한 뉴스 입니다,",
//            "created_at": "2021-06-07T15:46:42.000Z",
//            "img": null,
//            "id": 8
//        },
