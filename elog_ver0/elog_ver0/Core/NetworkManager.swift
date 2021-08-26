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

            print(response.data?.toString() ?? "")
            if let data = response.data {
//                let text = String(decoding: data, as: UTF8.self)
                let users = try? JSONDecoder().decode(Users.self, from: data)

                completionHandler(users)

            } else {
                completionHandler(nil)
            }
        }
    }

    static func createNote(title: String, userId: String, completionHandler: @escaping (NoteResponse?) -> Void) {

        let parameter: [String: String] = ["title": title]

        // let headers = HTTPHeaders(["kakaoAuth": "kjfdhfksdjfjwl3k2jtkl"])
        //let headers = HTTPHeaders()
        let headers = HTTPHeaders(["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwiaWF0IjoxNTk5NTQ5NjkyLCJleHAiOjE2MzEwODU2OTIsInN1YiI6InVzZXJJbmZvIn0.mbnu91lpaefAXbJYjfcnxMHIbNsjYgtqx9TIWeW-yng"])
       
        
        AF.request(baseURL + "/app/note" + "?userId=\(userId)",
                   method: .post,
                   parameters: parameter,
                   headers: headers)
            .response { response in // Closure

                print(response.data?.toString() ?? "")
                if let data = response.data {
                    let response = try? JSONDecoder().decode(NoteResponse.self, from: data)
                    
                    completionHandler(response)

                } else {
                    completionHandler(nil)
                }
            }
    }


    // TODO: Edit Note 에 맞게 수정해야 합니다. 임시로 만들었습니다.
    static func editNote(title: String, email: String, completionHandler: @escaping (NoteResponse?) -> Void) {

        let parameter: [String: String] = ["title": title, "email": email]

        // let headers = HTTPHeaders(["kakaoAuth": "kjfdhfksdjfjwl3k2jtkl"])
        let headers = HTTPHeaders()

        AF.request(baseURL + "/app/note",
                   method: .post,
                   parameters: parameter,
                   headers: headers)
            .response { response in // Closure

                print(response.data?.toString() ?? "")
                if let data = response.data {
                    let response = try? JSONDecoder().decode(NoteResponse.self, from: data)

                    completionHandler(response)

                } else {
                    completionHandler(nil)
                }
            }
    }

//    static func getAllNote(userId: String, completionHandler: @escaping (AllNoteResponse?) -> Void) {
//        // http://3.34.116.127/app/notes?userId=1
//
//
//        AF.request(baseURL + "/app/notes" + "?userId=\(userId)").response { response in // Closure
//
//            print(response.data?.toString() ?? "")
//            if let data = response.data {
////                let text = String(decoding: data, as: UTF8.self)
//                let notes = try? JSONDecoder().decode(AllNoteResponse.self, from: data)
//
//                completionHandler(notes)
//
//            } else {
//                completionHandler(nil)
//            }
//        }
//    }

    
    static func getAllNoteTest(userId: String, completionHandler: @escaping (AllNoteTest?) -> Void) {
        // http://3.34.116.127/app/notes?userId=1
        
        
        // let headers = HTTPHeaders(["kakaoAuth": "kjfdhfksdjfjwl3k2jtkl"])
        let headers = HTTPHeaders(["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwiaWF0IjoxNTk5NTQ5NjkyLCJleHAiOjE2MzEwODU2OTIsInN1YiI6InVzZXJJbmZvIn0.mbnu91lpaefAXbJYjfcnxMHIbNsjYgtqx9TIWeW-yng"])
        
        //AF query string 찾아보기
        print(baseURL + "/app/notes" + "?userId=\(userId)")
        AF.request(baseURL + "/app/notes" + "?userId=\(userId)", headers: headers).response { response in // Closure
            
            print(response.data?.toString() ?? "")
            
            if let data = response.data {
                print("1")
//                let text = String(decoding: data, as: UTF8.self)
                let notes = try? JSONDecoder().decode(AllNoteTest.self, from: data)
                completionHandler(notes)

            } else {
                print("2")
                completionHandler(nil)
            }
        }
    }
    
    
    static func getAllWritings(noteIdx: Int, completionHandler: @escaping (AllWritings?) -> Void) {
        // http://3.34.116.127/app/notes/:noteIdx/posts
        //3.34.116.127/app/notes/2/posts
        
        
        let headers = HTTPHeaders(["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwiaWF0IjoxNTk5NTQ5NjkyLCJleHAiOjE2MzEwODU2OTIsInN1YiI6InVzZXJJbmZvIn0.mbnu91lpaefAXbJYjfcnxMHIbNsjYgtqx9TIWeW-yng"])
        
        //AF query string 찾아보기
        print(baseURL + "/app/notes/" + "\(noteIdx)" + "/posts")
        AF.request(baseURL + "/app/notes/" + "\(noteIdx)" + "/posts", headers: headers).response { response in // Closure
            
            print(response.data?.toString() ?? "")
            
            if let data = response.data {
//                let text = String(decoding: data, as: UTF8.self)
                let writings = try? JSONDecoder().decode(AllWritings.self, from: data)
                completionHandler(writings)
                print("writings networkmanager에서 잘 받아왔습니다~")

            } else {
                print("2")
                completionHandler(nil)
            }
        }
    }
    
    
    static func createWritings(title: String, subtitle: String, content: String, img: String, note_id: Int, completionHandler: @escaping (NoteResponse?) -> Void) {

        let parameter: [String: String] = ["title": title, "subtitle": subtitle, "content": content, "img": img]

        // let headers = HTTPHeaders(["kakaoAuth": "kjfdhfksdjfjwl3k2jtkl"])
        //let headers = HTTPHeaders()
        let headers = HTTPHeaders(["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RAZ21haWwuY29tIiwiaWF0IjoxNTk5NTQ5NjkyLCJleHAiOjE2MzEwODU2OTIsInN1YiI6InVzZXJJbmZvIn0.mbnu91lpaefAXbJYjfcnxMHIbNsjYgtqx9TIWeW-yng"])
       
        
        AF.request(baseURL + "/app/post" + "?note_id=\(note_id)",
                   method: .post,
                   parameters: parameter,
                   headers: headers)
            .response { response in // Closure

                print(response.data?.toString() ?? "")
                if let data = response.data {
                    let response = try? JSONDecoder().decode(NoteResponse.self, from: data)
                    
                    completionHandler(response)

                } else {
                    completionHandler(nil)
                }
            }
    }
}



