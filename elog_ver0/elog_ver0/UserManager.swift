//
//  DataManager.swift
//  elog_ver0
//
//  Created by 김선우 on 2021/08/04.
//

import Foundation

// https://babbab2.tistory.com/66
// 싱글톤 패턴 (Singleton Pattern)
class UserManger {

    static let shared = UserManger()


    var isUser = false

    var id: String?
    var password: String?
    var name: String?

}
