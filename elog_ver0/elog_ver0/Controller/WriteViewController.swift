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
import FirebaseStorage
import Firebase
import SwiftUI
import ConfettiSwiftUI
import simd

class WriteViewController: UIViewController, FloatyDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate{

    let storage = Storage.storage()
    var fbURL : NSURL?
    var downloadString : String?
    
    var floaty = Floaty()
    
    let transiton = SlideInTransition()
    var topView: UIView?

    var note: Note? = UserManger.shared.currentNote
    var writings : [Writing] = []
    
    
    var numOfwritings = 0
    
    var changeImage : UIImage?
    var changeImageUrl: String?
    
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteDate: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutFAB()
        //floaty.addDragging()
        
        loadWritings()
      
        beforeTransition()
        //hideKeyboard()

        
    }
    @IBAction func sentiment(_ sender: Any) {
        print("감정알아보기 버튼 클릭했움")
        
        if UserManger.shared.currentSentiment == nil {
            getSentiment(content: self.textView.text, id: UserManger.shared.currentNote!.id)
        } else {
            let mySentiment2 = UserManger.shared.currentSentiment!
            print("버튼 클릭 시 감정이 있네여 \(mySentiment2)")
        }
        
        //let mySentiment = "y" // y or n or else
        let mySentiment2 = UserManger.shared.currentSentiment!
        
        let swiftuiview = SwiftUIView(sentiment: mySentiment2)
        
        let host = UIHostingController(rootView: swiftuiview)
        navigationController?.pushViewController(host, animated: true)
        
        
    }
    
    //기존 저장! 버튼 (floaty 때문에 안먹음)
    @IBAction func onClick(_ sender: Any) {
        print("초기생성! 버튼 클릭하였습니당")
        
        let newWritings = textView.text ?? ""
        print(newWritings)

        putWritings(title: "anytitle", subtitle: "any~", content: newWritings, img: " ")

        let alert = UIAlertController(title: "초기생성 완료~!", message: "",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            self.loadWritings()
            print("초기생성 완료 확인 버튼 눌림")
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        print("저장버튼 클릭되었습니다.")
        let newWritings = textView.text ?? ""
        let newImage = changeImageUrl ?? ""
        print(newWritings)
        
        
        updateWritings(content: newWritings, title: "1", subtitle: "newSubtitle", img: newImage)
        //updateImageWritings(change: newImage)
        
        let alert = UIAlertController(title: "저장 완료~!", message: "",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            print("저장완료 확인 버튼 눌림")
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
//    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
//        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
//        menuViewController.didTapMenuType = { menuType in
//            self.transitionToNew(menuType)
//        }
//        menuViewController.modalPresentationStyle = .overCurrentContext
//        menuViewController.transitioningDelegate = self
//        present(menuViewController, animated: true)
//    }
    
    func beforeTransition() {
        self.title = note?.title
        noteTitle?.text = note?.title
        self.noteDate?.text = note?.created_at
    
        
        print("========================")
        print(numOfwritings) //0
        
//        if writings.count == 0 {
//            textView.text="안녕! 무엇을 더 입력할까?"
//        } else {
//            textView.text="이미 글 있음"
//        }
////        textView.text="안녕! 무엇을 더 입력할까?"
//        textView.text.append("\n\n")
        
    }
    
//    func transitionToNew(_ menuType: MenuType) {
//        // title 표시하는 부분
//        let title = String(describing: menuType).capitalized
//        self.title = title
//
//        topView?.removeFromSuperview()
//        switch menuType {
//        //            case .profile:
//        //                // Storyboard에서 뷰 컨트롤러에서 identifier가 미리 설정이 되어있어야 한다.
//        //                let webPage = self.storyboard?.instantiateViewController(withIdentifier: "MonthlyViewController")
//        //                // B 컨트롤러 뷰로 넘어간다.
//        //                self.present(webPage!, animated: true, completion: nil)
//        //            let view = UIView()
//        //            view.backgroundColor = .yellow
//        //            view.frame = self.view.bounds
//        //            self.view.addSubview(view)
//        //            self.topView = view
//        //        case .camera:
//        //            let view = UIView()
//        //            view.backgroundColor = .blue
//        //            view.frame = self.view.bounds
//        //            self.view.addSubview(view)
//        //            self.topView = view
//        default:
//            break
//        }
//    }

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
            
        
            let picker = UIImagePickerController()
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                // 사용가능
                picker.sourceType = .camera
            }else {
                //사용불가능
                let alert = UIAlertController(title: "안녕", message: "여기 카메라 켜질거야", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            //picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true)
            
//            let alert = UIAlertController(title: "안녕", message: "여기 카메라 켜질거야", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
            
            
            //카메라 사용가능한지 체크
//            guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
//            let imagePickerController = UIImagePickerController()
//            imagePickerController.sourceType = .camera
////            imagePickerController.delegate = self
//            imagePickerController.allowsEditing = false
//            self.present(imagePickerController, animated: true)
            
            //imagePickerController.allowsEditing = true // 촬영 후 편집할 수 있는 부분이 나온다.
        
        }
        
        
        floaty.addItem("갤러리", icon: UIImage(named: "folderIcon")) { item in
//            let alert = UIAlertController(title: "안녕", message: "여기 갤러리 켜질거야", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "imagePickerController") as! ImagePickerController
            secondViewController.delegate = self
            self.present(secondViewController, animated: true, completion: nil)
            
            
            
            
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
    
    
    func loadWritings(){
        print("Writings 로드 시작~!")
        
        NetworkManager.getAllWritings(noteIdx: note!.id) { [weak self] allWritings in
            guard let self = self else { return }
            let writings2 = allWritings?.result ?? []
            print("아 제발\(writings2)")
            let writings = allWritings?.result ?? []
            self.writings = writings
            
            
            print("전체 글 갯수 : \(writings.count)")
            self.numOfwritings = writings.count
            
            if writings.count == 0 {
                self.textView.text="안녕! 무엇을 더 입력할까?\n"
            } else {
                self.textView?.text=""
            }
    //        textView.text="안녕! 무엇을 더 입력할까?"
//            self.textView.text.append("\n\n")
            
            print("전체 글 : \(writings)")
            print("content only : ")
            for i in 0..<writings.count{
                
                
                print(writings[i].content)
                print(writings[i].id)
//                self.textView.text.append("\n" + writings[i].content)
                self.textView?.text.append(writings[i].content)
                //self.textView?.text.append(writings[i].img)
                UserManger.shared.currentWriting = writings[i]
                }
        
            
            print("loadWritings 에서 저장된 이미지는 \(self.changeImageUrl ?? "")")
            print("loadWritings 에서 저장된 이미지는 \(UserManger.shared.currentWriting?.img)")
            
//            self.getSentiment(content: UserManger.shared.currentWriting?.content ?? "")
            self.getSentiment(content: self.textView.text ?? "", id: UserManger.shared.currentWriting?.id ?? 0)
            print("감정감별에 들어간 텍스트는 \(self.textView.text)")
            //print("loadWritings의 sentiment는 \()")
            //print("저장된 이미지는 : \()")
            
            //pager 안써서 무시?
            // 그 다음 reloadData 를 해줘야지만 ui가 갱신됩니다.
//            self.pager.reloadData()
            
//            if UserManger.shared.currentWriting?.img == "" {
//                if UserManger.shared.currentWriting?.img == nil {
//                    print("찐으로 이미지 없음")
//                }else {
//                    print("야야야야야야ㅑ야야야양 여기봐라")
//                    print("저장된 이미지 없음(nil은 아니고 기본값으로 없음)")
//                }
//
//            }else {
//                print(UserManger.shared.currentWriting?.img)
//                //downloadImageFromCloud(imgView: self.imageView) 안됨 self explicit 어쩌구
//                //downloadImageFromCloud()
//            }
//             self.downloadImageFromCloud()
            
            // MARK: 이미지 세팅
            // https://firebasestorage.googleapis.com/v0/b/elog-d6ddd.appspot.com/o/nocontentyet.png?alt=media&token=01c76203-040c-460e-bd7b-90d9669fa23f
            print("하,,")
            print(UserManger.shared.currentWriting?.content)
            
            if writings.count == 0 {
                UserManger.shared.currentWriting?.img =  ""
                ("이제 막 노트 만들었니? 글이 없는 상태니?")
            }
            
            self.imageView.imageFromServerURL2(urlString:UserManger.shared.currentWriting?.img  ?? "", PlaceHolderImage: UIImage(named:"nocontentyet" ))

            //self.downloadImageFromCloud()
        }
        
        //downloadImageFromCloud()
        
    }
    
    func putWritings(title: String?, subtitle: String?, content: String, img: String?){
        print("Writings 추가 하기~!")
        
        let noteId = note?.id
        let newWritings = textView.text ?? ""
        let content = newWritings
        //let img = changeImageUrl ?? ""
        let img = self.downloadString ?? ""
        
        print("putWritings func 에서 확인하기 : \(self.changeImageUrl) &&&&&& \(img)")
        
        if img != "" {
            print("여기 이미지 저장할거라구요~")
            print(UserManger.shared.currentNote?.id)
            uploadImage2Cloud(img: self.changeImage!)
            
            //self.loadWritings()
        }
        
        NetworkManager.createWritings(title: title ?? "", subtitle: subtitle ?? "", content: content, img: img , noteId: noteId!){  allWritings in
            print("note에 글 추가 api 도착")
            print("createWritings API 에 들어간 이미지는 : \(img)")
            
            //self.getSentiment(content: content)
            
            self.loadWritings()
        }
//        if img != "" {
//            print("여기 이미지 저장할거라구요~")
//            print(UserManger.shared.currentNote?.id)
//            uploadImage2Cloud(img: self.changeImage!)
//
//            self.loadWritings()
//        } else {
//            self.loadWritings()
//        }
        
        //self.loadWritings()
    }
    
    
    func updateWritings(content: String?, title: String?, subtitle: String?, img: String?){
        print("Writings 수정 하기~!")
        
        let writing = UserManger.shared.currentWriting
        print(writing!.id)
        let postIdx = writing!.id

        let newWritings = textView.text ?? ""
        let content = newWritings
        
//        let img = self.downloadString ?? ""
        //let img = changeImageUrl ?? ""
        
        print("api 호출 전 : \(writing?.content)")
        print("app content : \(content)")
        
        if (self.changeImage != nil){
            uploadImage2Cloud(img: self.changeImage!)
        }
        let img = self.downloadString ?? ""
        
        NetworkManager.updateWriting(postIdx: postIdx, content: content, title: title ?? "", subtitle: subtitle ?? "", img: img ){  allWritings in
            print("글 수정 api 도착")
            print(title!)
            print(subtitle!)
            print("수정후 바뀐 거는 : \(writing?.content)")
            print("img느 \(img)")
            
            //self.getSentiment(content: content)
        }
        
//        if (self.changeImage != nil){
//            uploadImage2Cloud(img: self.changeImage!)
//        }
        //uploadImage2Cloud(img: self.changeImage!)
//            self?.loadWritings()
        }
    
//    func updateImageWritings(change: String?){
//        print("Writings 수정 하기~!")
//
//        let writing = UserManger.shared.currentWriting
//        print(writing!.id)
//        let postIdx = writing!.id
//
//        let change = changeImageUrl ?? ""
//
//        NetworkManager.updateWriting(postIdx: postIdx, change: change ){  allWritings in
//            print("글 수정 api 도착")
//        }
//
////            self?.loadWritings()
//        }
    
    func onUserAction(data: String){
        print("data received : \(data)")
        self.changeImageUrl = data
        
    }
    
    func onUserAction2(data: UIImage) {
        print("image received: \(data)")
        imageView?.image = data
       
        
    }
    
    func getOcrText(data: String){
        print("data ocr text received : \(data)")
       // self.textView?.text.append(data)
       // print(self.textView?.text)
    }
    
    func getSentiment(content: String, id:Int){
        print("get sentiment 함수시작")
        
        NetworkManager.getSentiment(content: content, id: id){ writingSentiment in
            let sentimentResult = writingSentiment?.result
            
            print("받아온 감성 결과 값은")
            print(UserManger.shared.currentSentiment)
            print(sentimentResult?.mood)
            
        }
        
        
    }
    
    func uploadImage2Cloud(img : UIImage){
        print("uploadImage2Cloud 함수 불러옴")
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        //let filePath = "\(UserManger.shared.currentWriting)+\(self.changeImageUrl)"
        
        let filePath = String(UserManger.shared.currentNote!.id)
        let fbString = "gs://elog-d6ddd.appspot.com/\(filePath)"
//    https://firebasestorage.googleapis.com/v0/b/elog-d6ddd.appspot.com/o/90ocr?alt=media
        
        self.downloadString = "https://firebasestorage.googleapis.com/v0/b/elog-d6ddd.appspot.com/o/\(filePath)?alt=media"
        
        self.fbURL = NSURL(string: fbString)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.reference().child(filePath).putData(data,metadata: metaData){
            (metaData,error) in if let error = error{
                print(error.localizedDescription)
                return
            } else {
                print("이미지 업로드 성공")
                print("gs://elog-d6ddd.appspot.com/\(filePath)")
                print(self.fbURL)
                //self.localPath = "gs://elog-d6ddd.appspot.com/\(filePath)"
                //print("self.local Path : \(self.localPath!)")
//                self.localURL = URL(string: "gs://elog-d6ddd.appspot.com/\(self.changeImageUrl)")
                
            }
        }
        
    }
    
    func downloadImageFromCloud(){
        print("downloadImageFromCloud 함수 불러옴")
        
        let filePath = String(UserManger.shared.currentNote!.id)
        var fbString : String!
        
        if (UserManger.shared.currentWriting?.img == "") {
            
                print("야야야야야야ㅑ야야야양 여기봐라")
                print("저장된 이미지 없음(nil은 아니고 기본값으로 없음)")
            fbString = "gs://elog-d6ddd.appspot.com/nocontentyet.png"
            
        }else if (UserManger.shared.currentWriting?.img == nil) {
            print("찐으로 이미지 없음")
            fbString = "gs://elog-d6ddd.appspot.com/nocontentyet.png"
        }else {
            print("이미지 있음")
            fbString = "gs://elog-d6ddd.appspot.com/\(filePath)"
           
        }
        
        print(fbString)
        self.downloadString = fbString
        storage.reference(forURL: fbString).downloadURL { [self] (url, error) in
            let data = NSData(contentsOf: url!)
            print("download 한 이미지 url은 \(data)")
            //let image = UIImage(data: (data!) as Data)
            //imgView.image = image
            //self.imageView.image = image
        }
        
    }
    
    
}


extension WriteViewController: AddImageDelegate {
    func addImage(image: UIImage, data: String) {
        print("delegate 불러옴~")
        self.dismiss(animated: true){
            self.imageView.image = image
            self.changeImage = self.imageView.image
        }
        print("delegate에서 받아온 data : \(data)")
        self.changeImageUrl = data
        print("delegate에서 바꾼 data: \(self.changeImageUrl ?? "")")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let camImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        imageView.image = camImage
    }
    
    func addOcrText(data: String){
        self.dismiss(animated: true){
            self.textView.text.append(data)
        }
    }
    
}



