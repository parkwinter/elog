//
//  UIImagePickerController.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/30.
//

import UIKit
import ZLImageEditor
import FirebaseStorage
import Firebase

protocol AddImageDelegate {
    func addImage(image: UIImage, data: String)
    func addOcrText(data: String)
}

class ImagePickerController: UIViewController{
    
    let storage = Storage.storage()
    var fbURL : NSURL?
    var ocrURL : String?
    
    var ocrTexts: [ImageOcr] = []
    var writings : [Writing] = []
    
    var delegate: AddImageDelegate?
    var imageURL: String?
    
    var resultImageEditModel: ZLEditImageModel?
    
    @IBOutlet weak var imageView2: UIImageView!
    let vcbefore = WriteViewController()
        
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        imageView2.isUserInteractionEnabled = true
        imageView2.addGestureRecognizer(tapGestureRecognizer)

        
        
       //photoL()

        // Do any additional setup after loading the view.
    }

    @objc func imageTapped(sender: UITapGestureRecognizer) {
//         Your action
        print("image tapped")
        photoL()
        
    }
    
    @IBAction func btn1onClick(_ sender: Any) {
        print("btn1onClick (그대로 버튼)")
//        vcbefore.imageView?.image = imageView2.image
        
        vcbefore.onUserAction(data: self.imageURL!)
        vcbefore.onUserAction2(data: imageView2.image!)
        
//        guard let pvc = self.presentingViewController else { return }
//
//        self.dismiss(animated: true) {
//            self.present(WriteViewController(), animated: true, completion: nil)
//        }
        print("다시한번 이미지 유알엘은~ \(self.imageURL!)")
        delegate?.addImage(image: imageView2.image!, data: self.imageURL!)
        
    }
    
    @IBAction func btn2onClick(_ sender: Any) {
        print("btn2onClick (photoEditor 버튼)")
        photoEditor(self.imageView2.image!, editModel: self.resultImageEditModel)
    }
    
    @IBAction func btn3onClick(_ sender: Any) {
        print("btn3onClick (ocr 버튼)")
        //fb 업로드 & url 가져온 후
        uploadImage2Cloud(img: self.imageView2.image!)
        print("여기서~~~~~\(self.ocrURL)" ) // nil 로 받아옴 왜냐면 위에 함수 시간이 너무 오래걸려서ㅠ
        //ocr(imageURL: <#T##String#>)
    }
    
    
    func photoL() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        print("photoL 잘되니?")
    }

}

extension ImagePickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage {

            imageView2.image = image
            
//            vc.imageView!.image = imagevc.imageView?.image = image
            
            
        }

        
        if let imageUrl = info[UIImagePickerController.InfoKey.referenceURL] as? URL{
            
                     print("image url : \(imageUrl) ")
           
            var myurl: NSURL
            myurl = imageUrl as NSURL
            let urlString: String = myurl.absoluteString!
            self.imageURL = urlString
            print("야 이건되냐?")
            print(urlString)
            print(self.imageURL!)
            
        }

        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func photoEditor(_ image : UIImage, editModel: ZLEditImageModel?){
        
        
        ZLImageEditorConfiguration.default().editImageTools = [.draw, .clip, .imageSticker, .textSticker, .mosaic, .filter]

        ZLEditImageViewController.showEditImageVC(parentVC: self, image: image, editModel: editModel) { [weak self] (resImage, editModel) in
            self?.imageView2.image = resImage
            self?.resultImageEditModel = editModel
        }
    }
    

    func ocr(imageURL : String){
        
        
        NetworkManager.ocr(imageURL: imageURL){ [weak self] imageOcr in
            
            guard let self = self else { return }
            let res = imageOcr?.result
            //let imageToOcr = imageOcr?.result ?? []
            
            //self.ocrTexts = res
            
            print("ocr 돌린 결과는 : ")
            print(res!)
            
            self.vcbefore.getOcrText(data: res!)
            self.delegate?.addOcrText(data: res!)
            
            
        }
        
        
    }
    
    func uploadImage2Cloud(img : UIImage){
        print("uploadImage2Cloud 함수 불러옴")
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        //let filePath = "\(UserManger.shared.currentWriting)+\(self.changeImageUrl)"
        
        let filePath = String(UserManger.shared.currentNote!.id)
        let plusOcr = "\(filePath)ocr"
        let fbString = "gs://elog-d6ddd.appspot.com/\(plusOcr)"
        self.fbURL = NSURL(string: fbString)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.reference().child(plusOcr).putData(data,metadata: metaData){
            (metaData,error) in if let error = error{
                print(error.localizedDescription)
                return
            } else {
                print("이미지 업로드 성공")
                print("gs://elog-d6ddd.appspot.com/\(plusOcr)")
                print(self.fbURL)
                //https://firebasestorage.googleapis.com/v0/b/elog-d6ddd.appspot.com/o/90ocr?alt=media
                self.ocrURL = "https://firebasestorage.googleapis.com/v0/b/elog-d6ddd.appspot.com/o/\(plusOcr)?alt=media"
                print(self.ocrURL)
                
                
                // ocr 함수 호출
                self.ocr(imageURL: self.ocrURL!)
            }
        }
        
    }
}
