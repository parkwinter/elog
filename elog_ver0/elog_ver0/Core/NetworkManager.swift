//
//  NetworkManager.swift
//  elog_ver0
//
//  Created by 김선우 on 2021/08/04.
//

import Foundation
import Alamofire

class NetworkManager {

    static func getUserInfos(completionHandler: @escaping (Users?) -> Void) {
        // https://medium.com/@jgj455/%EC%98%A4%EB%8A%98%EC%9D%98-swift-%EC%83%81%EC%8B%9D-closure-aa401f76b7ce
        // 클로져

        AF.request("http://3.34.116.127/app/users").response { response in // Closure
            if let data = response.data {
//                let text = String(decoding: data, as: UTF8.self)
                let users = try? JSONDecoder().decode(Users.self, from: data)

                completionHandler(users)

            } else {
                completionHandler(nil)
            }
        }
    }
}



