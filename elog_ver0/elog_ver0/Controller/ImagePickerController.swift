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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        photoL()

        // Do any additional setup after loading the view.
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
