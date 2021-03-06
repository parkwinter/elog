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
    
    
    @IBOutlet weak var cameraBtn: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(cameraBtnTapped(sender:)))
        
        imageView2?.isUserInteractionEnabled = true
        imageView2?.addGestureRecognizer(tapGestureRecognizer)
        
        cameraBtn?.isUserInteractionEnabled = true
        cameraBtn?.addGestureRecognizer(tapGestureRecognizer2)

        
        
        //photoL()

        // Do any additional setup after loading the view.
    }

    @objc func imageTapped(sender: UITapGestureRecognizer) {
        //         Your action
        print("image tapped")
        photoL()
        
    }
    
    @objc func cameraBtnTapped(sender: UITapGestureRecognizer) {
        //         Your action
        print("camera button tapped")
        camClick()
        
    }
    
    func camClick() {
        //print("cam btn click")
        
        let picker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            // ????????????
            picker.sourceType = .camera
        }else {
            //???????????????
            let alert = UIAlertController(title: "??????", message: "?????? ????????? ????????????", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        //picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
        
    }
    
    @IBAction func btn1onClick(_ sender: Any) {
        print("btn1onClick (????????? ??????)")
        //        vcbefore.imageView?.image = imageView2.image

        guard
            let imageURL = imageURL ,
              let image = imageView2.image else {

                  
                  
                  let alertViewController = UIAlertController(title: "???????????? ????????????.", message: "???????????? ????????? ???????????? ??????????????????.", preferredStyle: .alert)
                  alertViewController.addAction(.init(title: "OK", style: .default))
                  present(alertViewController, animated: true)
                  return

              }
        vcbefore.onUserAction(data: imageURL)
        vcbefore.onUserAction2(data: image)
        
        //        guard let pvc = self.presentingViewController else { return }
        //
        //        self.dismiss(animated: true) {
        //            self.present(WriteViewController(), animated: true, completion: nil)
        //        }
        print("???????????? ????????? ????????????~ \(imageURL)")
        delegate?.addImage(image: image, data: imageURL)
        
    }
    
    @IBAction func btn2onClick(_ sender: Any) {

        guard let image = imageView2.image ,
        let imageURL = imageURL else {

            let alertViewController = UIAlertController(title: "???????????? ????????????.", message: "???????????? ????????? ???????????? ??????????????????.", preferredStyle: .alert)
            alertViewController.addAction(.init(title: "OK", style: .default))
            present(alertViewController, animated: true)
            return

        }

        print("btn2onClick (photoEditor ??????)")
        photoEditor(image, editModel: self.resultImageEditModel)
    }
    
    @IBAction func btn3onClick(_ sender: Any) {


        guard let imageURL = imageURL,
              let image = imageView2.image else {

                  let alertViewController = UIAlertController(title: "???????????? ????????????.", message: "???????????? ????????? ???????????? ??????????????????.", preferredStyle: .alert)
                  alertViewController.addAction(.init(title: "OK", style: .default))
                  present(alertViewController, animated: true)
                  return

              }

        print("btn3onClick (ocr ??????)")
        //fb ????????? & url ????????? ???
        uploadImage2Cloud(img: image)
        print("?????????~~~~~\(self.ocrURL)" ) // nil ??? ????????? ????????? ?????? ?????? ????????? ?????? ??????????????????
        //ocr(imageURL: <#T##String#>)
    }
    
    
    func photoL() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        print("photoL ??????????")
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
            print("??? ?????????????")
            print(urlString)
            print(self.imageURL!)
            
        }
        else {
            self.imageURL = "no_url"
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
            
            print("ocr ?????? ????????? : ")
            print(res!)
            
            // ????????? ????????? ?????? / ?????????
            let alert = UIAlertController(title: "???????????? ?????? ??????????????????????",
                                          message: "",
                                          preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "?????? O", style: .default) { [weak alert] _ in
                    let imageURL = imageURL
                    let image = self.imageView2.image
                
                self.vcbefore.onUserAction(data: imageURL)
                self.vcbefore.onUserAction2(data: image!)
                self.delegate?.addImage(image: image!, data: imageURL)
                
                self.vcbefore.getOcrText(data: res!)
                self.delegate?.addOcrText(data: res!)
            }

            let action2 = UIAlertAction(title: "?????????", style: .cancel) { _ in
                self.vcbefore.getOcrText(data: res!)
                self.delegate?.addOcrText(data: res!)
            }
            
            alert.addAction(action1)
            alert.addAction(action2)
            self.present(alert, animated: true, completion: nil)
            
            
//            self.vcbefore.getOcrText(data: res!)
//            self.delegate?.addOcrText(data: res!)
            
            
        }
        
        
    }
    
    func uploadImage2Cloud(img : UIImage){
        print("uploadImage2Cloud ?????? ?????????")
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
                print("????????? ????????? ??????")
                print("gs://elog-d6ddd.appspot.com/\(plusOcr)")
                print(self.fbURL)
                //https://firebasestorage.googleapis.com/v0/b/elog-d6ddd.appspot.com/o/90ocr?alt=media
                self.ocrURL = "https://firebasestorage.googleapis.com/v0/b/elog-d6ddd.appspot.com/o/\(plusOcr)?alt=media"
                print(self.ocrURL)
                
                
                // ocr ?????? ??????
                self.ocr(imageURL: self.ocrURL!)
            }
        }
        
    }
}
