//
//  KakaoLogin.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/09/26.
//

import Foundation

struct KakaoLogin: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
    let jwt: String
    let userIdx: Int
    let name: String
}
