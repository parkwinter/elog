//
//  UIImagePickerController.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/30.
//

import UIKit

class ImagePickerController: UIViewController{
    
    
    @IBOutlet weak var imageView2: UIImageView!
    let vc = WriteViewController()
   
    
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
        print("btn1onClick")
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
            
//            vc.imageView!.image = image


        }

        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
