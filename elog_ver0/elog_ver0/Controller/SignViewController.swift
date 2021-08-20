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
            topLabel.text = "회원님 환영합니다!!"
        } else {
            topLabel.text = "앗 유저가 아니시군요"
        }

        // 로그인 정보를 보여주는 무언가!
        // Do any additional setup after loading the view.
    }


    // 코드 정리 단축키: control + i

    @IBAction func loginKakao(_ sender: Any) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] oauthToken, error in
                if let error = error {
                    print(error)
                    return
                }

                print("loginWithKakaoTalk() success.")
                self?.updateUserInfo()

                //do something
                _ = oauthToken
                print(oauthToken)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
                if let error = error {
                    print(error)
                    return
                }

                print("loginWithKakaoAccount() success.")
                self?.updateUserInfo()

                //do something
                _ = oauthToken

            }
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
