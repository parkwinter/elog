//
//  Users.swift
//  elog_ver0
//
//  Created by 김선우 on 2021/08/04.
//

import Foundation


// https://app.quicktype.io/
// json -> swift 바꿔주는 사이트

// MARK: - Users
struct Users: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [User]
}

// MARK: - Result
struct User: Codable {
    let email: String
    let name: String
}

//"result": [
//        {
//            "email": "sss",
//            "name": "sss"
//        },
//        {
//            "email": "hhh",
//            "name": "hhh"
//        }
//    ]
