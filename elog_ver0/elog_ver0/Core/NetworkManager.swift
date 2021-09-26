//
//  NetworkManager.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/04.
//

import Foundation
import Alamofire

class NetworkManager {

    static let baseURL = "http://3.34.116.127"

//    static var syToken : String = UserManger.shared.kakaoJwt ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"
    
    
    
    static let kakaoAcessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"
    
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

    // TODO: postman 확인 후 수정해야 함
    static func login(access: String, completionHandler: @escaping (KakaoLogin?) -> Void) {
        
        let parameter: [String: String] = ["access": access]
        
        AF.request(baseURL + "/app/login",
                   method: .post,
                   parameters: parameter).response { response in // Closure
            
            print(response.data?.toString() ?? "")
            
            if let data = response.data {
//                let text = String(decoding: data, as: UTF8.self)
                let kakaoInfo = try? JSONDecoder().decode(KakaoLogin.self, from: data)
                completionHandler(kakaoInfo)
                print("kakaoLogin networkmanager에서 잘 받아왔습니다~")
//                syToken = kakaoInfo?.result.jwt
                guard let kakaoInfo = kakaoInfo else {
                    UserManger.shared.kakaoJwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"
                    return
                    
                }
//                if let kakaoInfo.result.jwt != nil {
//
//                }
                UserManger.shared.kakaoJwt = kakaoInfo.result.jwt
                print("usermanager shared kakao jwt : \(UserManger.shared.kakaoJwt)")

            } else {
                print("2")
                completionHandler(nil)
            }
        }
    }
    
    static func createNote(title: String, userId: String, completionHandler: @escaping (NoteResponse?) -> Void) {

        let parameter: [String: String] = ["title": title]

        //let syToken : String = UserManger.shared.kakaoJwt ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"
        // let headers = HTTPHeaders(["kakaoAuth": "kjfdhfksdjfjwl3k2jtkl"])
        //let headers = HTTPHeaders()
        let headers = HTTPHeaders(["x-access-token": UserManger.shared.kakaoJwt!])
       
        
        AF.request(baseURL + "/app/note" ,
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


    // TODO: Edit Note 에 맞게 수정해야 함. 임시.
    static func editNote(title: String, img: String, noteId: Int,completionHandler: @escaping (NoteResponse?) -> Void) {

        let parameter: [String: String] = ["title": title, "img": img]
       // let syToken : String = UserManger.shared.kakaoJwt ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"
        // let headers = HTTPHeaders(["kakaoAuth": "kjfdhfksdjfjwl3k2jtkl"])
        
        let headers = HTTPHeaders(["x-access-token": UserManger.shared.kakaoJwt!])
        
        
        AF.request(baseURL + "/app/note" + "?noteIdx=\(noteId)",
                   method: .patch,
                   parameters: parameter,
                   headers: headers)
            .response { response in // Closure

                print(response.data?.toString() ?? "")
                print("networkManager의 editNote 실행 완료")
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

    
//    static func getAllNoteTest(userId: String, completionHandler: @escaping (AllNoteTest?) -> Void) {
//        // http://3.34.116.127/app/notes?userId=1
//
//       // let syToken : String = UserManger.shared.kakaoJwt ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"
//        // let headers = HTTPHeaders(["kakaoAuth": "kjfdhfksdjfjwl3k2jtkl"])
//        let headers = HTTPHeaders(["x-access-token": syToken])
//
//        //AF query string 찾아보기
//        print(baseURL + "/app/notes" + "?userId=\(userId)")
//        AF.request(baseURL + "/app/notes" + "?userId=\(userId)", headers: headers).response { response in // Closure
//
//            print(response.data?.toString() ?? "")
//
//            if let data = response.data {
//                print("1")
////                let text = String(decoding: data, as: UTF8.self)
//                let notes = try? JSONDecoder().decode(AllNoteTest.self, from: data)
//                completionHandler(notes)
//
//            } else {
//                print("2")
//                completionHandler(nil)
//            }
//        }
//    }
    static func getAllNoteTest( completionHandler: @escaping (AllNoteTest?) -> Void) {
        // http://3.34.116.127/app/notes?userId=1
        
       // let syToken : String = UserManger.shared.kakaoJwt ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"
        // let headers = HTTPHeaders(["kakaoAuth": "kjfdhfksdjfjwl3k2jtkl"])
        let headers = HTTPHeaders(["x-access-token": UserManger.shared.kakaoJwt ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"])
        
        //AF query string 찾아보기
        print(baseURL + "/app/notes")
        print(UserManger.shared.kakaoJwt)
        
        AF.request(baseURL + "/app/notes", headers: headers).response { response in // Closure
            print("getAllNoteTest headers : \(headers) ")
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
        
        //let syToken : String = UserManger.shared.kakaoJwt ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"
        let headers = HTTPHeaders(["x-access-token": UserManger.shared.kakaoJwt ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"])
        
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
    
    
    static func createWritings(title: String, subtitle: String, content: String, img: String, noteId: Int, completionHandler: @escaping (NoteResponse?) -> Void) {

        let parameter: [String: String] = ["title": title, "subtitle": subtitle, "content": content, "img": img]
        //let syToken : String = UserManger.shared.kakaoJwt ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"
        // let headers = HTTPHeaders(["kakaoAuth": "kjfdhfksdjfjwl3k2jtkl"])
        //let headers = HTTPHeaders()
        let headers = HTTPHeaders(["x-access-token": UserManger.shared.kakaoJwt!])
       
        
        AF.request(baseURL + "/app/post" + "?noteId=\(noteId)",
                   method: .post,
                   parameters: parameter,
                   headers: headers)
            .response { response in // Closure

                print(response.data?.toString() ?? "")
                print("networkmanger 에서의 img : \(img)")
                if let data = response.data {
                    let response = try? JSONDecoder().decode(NoteResponse.self, from: data)
                    
                    completionHandler(response)

                } else {
                    completionHandler(nil)
                }
            }
    }
    
    
    static func deleteNote(noteIdx: Int, completionHandler: @escaping (NoteResponse?) -> Void) {

        let parameter: [String: Int] = ["noteIdx": noteIdx]
        //let syToken : String = UserManger.shared.kakaoJwt ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"
        // let headers = HTTPHeaders(["kakaoAuth": "kjfdhfksdjfjwl3k2jtkl"])
        //let headers = HTTPHeaders()
        let headers = HTTPHeaders(["x-access-token": UserManger.shared.kakaoJwt ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"])
       
        
        AF.request(baseURL + "/app/note" + "/\(noteIdx)" + "/status",
                   method: .patch,
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
    
    
    static func updateWriting(postIdx: Int, content: String, title: String, subtitle: String, img: String, completionHandler: @escaping (NoteResponse?) -> Void) {

        let parameter: [String: String] = ["title": title, "subtitle": subtitle, "content": content, "img":img]
        //let syToken : String = UserManger.shared.kakaoJwt ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"
        // let headers = HTTPHeaders(["kakaoAuth": "kjfdhfksdjfjwl3k2jtkl"])
        //let headers = HTTPHeaders()
        let headers = HTTPHeaders(["x-access-token": UserManger.shared.kakaoJwt ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzMDQ3NjUxNSwiZXhwIjoxNjYyMDEyNTE1LCJzdWIiOiJ1c2VySW5mbyJ9.uZFEPTzRFKNGY0tU1xflUCN-1dCNzY4y0gE09OJmrxI"])
       
        
        AF.request(baseURL + "/app/posts" + "/\(postIdx)" ,
                   method: .patch,
                   parameters: parameter,
                   headers: headers)
            .response { response in // Closure

                print(response.data?.toString() ?? "")
                //print("잘 받아오나 \(title)" )
//                print("잘 받아오나 \(subtitle)" )
                if let data = response.data {
                    let response = try? JSONDecoder().decode(NoteResponse.self, from: data)

                    completionHandler(response)

                } else {
                    completionHandler(nil)
                }
            }
    }
    
    
    static func ocr(imageURL: String, completionHandler: @escaping (ImageOcr?) -> Void) {

        let parameter: [String: String] = ["imageURL": imageURL]

        AF.request(baseURL + "/app/ocr" ,
                   method: .post,
                   parameters: parameter)
            .response { response in // Closure

                print(response.data?.toString() ?? "")
                
                if let data = response.data {
                    let response = try? JSONDecoder().decode(ImageOcr.self, from: data)
                    
                    completionHandler(response)

                } else {
                    completionHandler(nil)
                }
            }
    }
    
    
    static func getSentiment(content: String, completionHandler: @escaping (WritingSentiment?) -> Void) {
        
        //AF query string 찾아보기
        let parameter: [String: String] = ["content": content]
        
        AF.request(baseURL + "/app/sentiment",
                   method: .post,
                   parameters: parameter).response { response in // Closure
            
            print(response.data?.toString() ?? "")
            
            if let data = response.data {
//                let text = String(decoding: data, as: UTF8.self)
                let sentiment = try? JSONDecoder().decode(WritingSentiment.self, from: data)
                completionHandler(sentiment)
                print("sentiment networkmanager에서 잘 받아왔습니다~ \(sentiment!.document.sentiment)")
                //print(sentiment!.sentences.)
                print("sentiment networkmanager에서 parameter \(parameter)")
                UserManger.shared.currentSentiment = sentiment?.document.sentiment

            } else {
                print("2")
                completionHandler(nil)
            }
        }
    }
}



