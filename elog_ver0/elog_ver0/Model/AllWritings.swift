//
//  AllWritings.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/24.
//

import Foundation

// MARK: - Welcome
struct AllWritings: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [Writing]
}

// MARK: - Result
struct Writing: Codable {
    let createdAt, title, subtitle, content, img: String
    let id: Int
   

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case title, subtitle, content, img, id
    }
}


//{
//    "isSuccess": true,
//    "code": 1000,
//    "message": "성공",
//    "result": [
//        {
//            "created_at": "2021-06-06T20:50:02.000Z",
//            "title": "post4",
//            "subtitle": "sub4",
//            "content": "ggggg",
//            "id": 4
//        }
//    ]
//}
