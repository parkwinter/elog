//
//  ImageEditViewController.swift
//  
//
//  Created by You Jong Park on 2021/05/27.
//

import UIKit
import Mantis

class ImageEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,CropViewControllerProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]){
        
        imageSelected = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        
        let imageCropViewController = Matis.cropViewController(image : imageSelected!)
        imageCropViewController.delegate = self
        self.present(imageCropViewController, animated: true, completion : nil)
        
        
    }
    
    func didGetCroppedImage(image : UIImage){
        imageView.image = image
        checkNextButtonForEnable()
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
