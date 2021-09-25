//
//  DataManager.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/04.
//

import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

// https://babbab2.tistory.com/66
// 싱글톤 패턴 (Singleton Pattern)
class UserManger {

    static let shared = UserManger()

    var user: KakaoSDKUser.User?

    var isUser: Bool { user != nil }

    var id: Int? {

        // 일반적인 if문
//        if user?.id == nil {
//            return nil
//        } else {
//            let userId = user!.id!
//            return Int(userId)
//        }


        // if let 으로 단축
//        if let userId = user?.id {
//            return Int(userId)
//        }

        // guard 문
        guard let userId = user?.id else { return nil }
        return Int(userId)
    }

    var name: String? {
        user?.properties?["nickname"]
    }

    var thumbnailImage: String? {
        user?.properties?["thumbnail_image"]
    }

    var profileImage: String? {
        user?.properties?["profile_image"]
    }

    var hasThumbnailImage: Bool {
        user?.properties?["isDefaultImage"] == "true"
    }

    var currentNote: Note?
    
    var currentWriting: Writing?
}
