//
//  NetworkManager.swift
//  elog_ver0
//
//  Created by 김선우 on 2021/08/04.
//

import Foundation
import Alamofire

class NetworkManager {

    static let baseURL = "http://3.34.116.127"

    static func getUserInfos(completionHandler: @escaping (Users?) -> Void) {
        // https://medium.com/@jgj455/%EC%98%A4%EB%8A%98%EC%9D%98-swift-%EC%83%81%EC%8B%9D-closure-aa401f76b7ce
        // 클로져

        AF.request(baseURL + "/app/users").response { response in // Closure
            if let data = response.data {
//                let text = String(decoding: data, as: UTF8.self)
                let users = try? JSONDecoder().decode(Users.self, from: data)

                completionHandler(users)

            } else {
                completionHandler(nil)
            }
        }
    }

    static func createNote(title: String, email: String, completionHandler: @escaping (NoteResponse?) -> Void) {

        let parameter: [String: String] = ["title": title, "email": email]

        // let headers = HTTPHeaders(["kakaoAuth": "kjfdhfksdjfjwl3k2jtkl"])
        let headers = HTTPHeaders()

        AF.request(baseURL + "/app/note",
                   method: .post,
                   parameters: parameter,
                   headers: headers)
            .response { response in // Closure
                if let data = response.data {
                    let response = try? JSONDecoder().decode(NoteResponse.self, from: data)

                    completionHandler(response)

                } else {
                    completionHandler(nil)
                }
            }
    }

    static func getAllNote(userId: String, completionHandler: @escaping (AllNoteResponse?) -> Void) {
        // http://3.34.116.127/app/notes?userId=1
        
        AF.request(baseURL + "/app/notes" + "?userId=\(userId)").response { response in // Closure
            if let data = response.data {
//                let text = String(decoding: data, as: UTF8.self)
                let notes = try? JSONDecoder().decode(AllNoteResponse.self, from: data)

                completionHandler(notes)

            } else {
                completionHandler(nil)
            }
        }
    }

    
    static func getAllNoteTest(userId: String, completionHandler: @escaping (AllNoteTest?) -> Void) {
        // http://3.34.116.127/app/notes?userId=1
        
        AF.request(baseURL + "/app/notes" + "?userId=\(userId)").response { response in // Closure
            if let data = response.data {
//                let text = String(decoding: data, as: UTF8.self)
                let notes = try? JSONDecoder().decode(AllNoteTest.self, from: data)

                completionHandler(notes)

            } else {
                completionHandler(nil)
            }
        }
    }
}



