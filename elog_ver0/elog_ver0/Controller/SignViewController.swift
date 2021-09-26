//
//  SignViewController.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/05/17.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class SignViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    var isUser = false

    override func viewDidLoad() {
        super.viewDidLoad()

        isUser = UserManger.shared.isUser

        if isUser {
            topLabel.text = "환영합니다!!"
        } else {
            topLabel.text = "환영합니다!"
        }

        // 로그인 정보를 보여주는 무언가!
        // Do any additional setup after loading the view.
    }


    // 코드 정리 단축키: control + i

    @IBAction func loginKakao(_ sender: Any) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] oauthToken, error in
                if let error = error {
                    print("설마 카카오 오류나냐ㅠㅠㅠㅠㅠㅠㅠㅠ")
                    print(error)
                    return
                }

                print("loginWithKakaoTalk() success.")
                //self?.updateUserInfo()

                //do something
                _ = oauthToken
                print(oauthToken)
                print("카카오 어세스토큰만 뽑아내기 : ")
                print(oauthToken!.accessToken)
                self?.getJWT(access: oauthToken!.accessToken)
                
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
                if let error = error {
                    print("설마 카카오 오류나냐ㅠㅠㅠㅠㅠㅠㅠㅠ")
                    print(error)
                    return
                }

                print("loginWithKakaoAccount() success.")
                //self?.updateUserInfo()

                //do something
                _ = oauthToken
                print(oauthToken)
                print("카카오 어세스토큰만 뽑아내기 : ")
                print(oauthToken!.accessToken)
                self?.getJWT(access: oauthToken!.accessToken)
                
                
//                 //노트조회 테스트 -> 안됨 -> 엥 성공
//                NetworkManager.getAllNoteTest() { allNoteTest in
//                   if let noteArray = allNoteTest?.result {
//                        print(noteArray[1].title)
//                    //은지노트라고 잘 받아옴
//                    }
//                }
//                
//
//                //글 조회 테스트
//                NetworkManager.getAllWritings(noteIdx: 3) { AllWritings in
//                   if let writingsArray = AllWritings?.result {
//                    print("글 조회 : (ggggg) =")
//                    print(writingsArray[0].content)
//                   } else {
//                    print("글 조회 실패")
//                   }
//                }
            }
        }
    }

    func getJWT(access : String?){
        NetworkManager.login(access: access!) { kakaoLogin in
            //let writings = allWritings?.result ?? []
            let result = kakaoLogin?.result.jwt
            
            print("세영이한테 받아온 jwt : \(result!)")
            UserManger.shared.kakaoJwt = result
            self.enterCreateViewController()
            
        }
    }
    
    func updateUserInfo() {
        UserApi.shared.me { user, error in
            print("save user info")
            UserManger.shared.user = user
            self.enterCreateViewController()
        }
    }

    @IBAction func createButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateDiaryViewController")



        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func carouselButton(_ sender: Any) {
        enterCreateViewController()
    }

    func enterCreateViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateViewController")

        navigationController?.pushViewController(viewController, animated: true)

    }

}
