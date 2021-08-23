//
//  WriteViewController.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/05/17.
//

import UIKit
import Floaty
import DropDown
import BTNavigationDropdownMenu

class WriteViewController: UIViewController, FloatyDelegate{

    var floaty = Floaty()
    
    let transiton = SlideInTransition()
    var topView: UIView?

    var note: Note? = UserManger.shared.currentNote
    
    @IBOutlet weak var noteTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutFAB()
        //floaty.addDragging()
        beforeTransition()
        //hideKeyboard()

    }


    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    func beforeTransition() {
        self.title = note?.title
        noteTitle.text = note?.title
    }
    
    func transitionToNew(_ menuType: MenuType) {
        // title 표시하는 부분
        let title = String(describing: menuType).capitalized
        self.title = title

        topView?.removeFromSuperview()
        switch menuType {
        //            case .profile:
        //                // Storyboard에서 뷰 컨트롤러에서 identifier가 미리 설정이 되어있어야 한다.
        //                let webPage = self.storyboard?.instantiateViewController(withIdentifier: "MonthlyViewController")
        //                // B 컨트롤러 뷰로 넘어간다.
        //                self.present(webPage!, animated: true, completion: nil)
        //            let view = UIView()
        //            view.backgroundColor = .yellow
        //            view.frame = self.view.bounds
        //            self.view.addSubview(view)
        //            self.topView = view
        //        case .camera:
        //            let view = UIView()
        //            view.backgroundColor = .blue
        //            view.frame = self.view.bounds
        //            self.view.addSubview(view)
        //            self.topView = view
        default:
            break
        }
    }

}

extension WriteViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
    
    func layoutFAB() {
        //      let item = FloatyItem()
        //      item.hasShadow = false
        //      item.buttonColor = UIColor.yellow
        //      item.circleShadowColor = UIColor.red
        //      item.titleShadowColor = UIColor.blue
        //      item.titleLabelPosition = .right
        //      item.title = "titlePosition right"
        //      item.handler = { item in
        //
        //      }

        
        floaty.hasShadow = false
        //floaty.addItem(title: "I got a title")
//        floaty.addItem("오프라인 글 삽입", icon: UIImage(named: "camIcon"))
        floaty.addItem("오프라인 글 삽입", icon: UIImage(named: "camIcon")) { item in
            let alert = UIAlertController(title: "안녕", message: "여기 카메라 켜질거야", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        floaty.addItem("갤러리", icon: UIImage(named: "folderIcon")) { item in
            let alert = UIAlertController(title: "안녕", message: "여기 갤러리 켜질거야", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        //floaty.addItem(item: item)
        //floaty.paddingX = self.view.frame.width/2 - floaty.frame.width/2
        floaty.paddingY = self.view.frame.height/10
        floaty.fabDelegate = self

        floaty.buttonColor = UIColor.gray
        //floaty.buttonImage = UIImage(named : "2")

        self.view.addSubview(floaty)
        floaty.frame = view.bounds
    }
    
    
    
    
}
