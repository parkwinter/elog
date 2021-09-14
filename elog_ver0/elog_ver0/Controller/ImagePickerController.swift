//
//  UIImagePickerController.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/30.
//

import UIKit

protocol AddImageDelegate {
    func addImage(image: UIImage, data: String)
}

class ImagePickerController: UIViewController{
    
    var delegate: AddImageDelegate?
    var imageURL: String?
    
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
        print("btn2onClick")
    }
    
    @IBAction func btn3onClick(_ sender: Any) {
        print("btn3onClick")
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
}
