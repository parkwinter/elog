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
            print("오잉")
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                    return
                }

                print("loginWithKakaoTalk() success.")

                //do something
                _ = oauthToken

            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                    return
                }

                print("loginWithKakaoAccount() success.")

                //do something
                _ = oauthToken

            }
        }
    }
    
    @IBAction func createButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateDiaryViewController")



        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func carouselButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateViewController")



        navigationController?.pushViewController(viewController, animated: true)
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    

}
