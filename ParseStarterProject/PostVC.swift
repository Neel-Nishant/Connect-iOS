//
//  PostVC.swift
//  Connect
//
//  Created by Neel Nishant on 22/05/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class PostVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var imageToPost: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageToPost.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func createAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
   
    @IBAction func chooseAnImageBtnPressed(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }

    @IBAction func postImage(_ sender: Any) {
        
        activityIndicator = UIActivityIndicatorView(frame: (CGRect(x: 0, y: 0, width: 50, height: 50)))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    
        var post = PFObject(className: "Posts")
        post["message"] = messageTextField.text
        post["userid"] = PFUser.current()?.objectId!
        let imageData = UIImageJPEGRepresentation(imageToPost.image!,0.2)
//        let imageData = UIImagePNGRepresentation(imageToPost.image!)
        
        let imageFile = PFFile(name: "image.jpg", data: imageData!)
        post["imageFile"] = imageFile
        
        post.saveInBackground { (success, error) in
            
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error != nil {
                self.createAlert(title: "Could not post image", message: "try again later")
            }
            else {
                self.createAlert(title: "Image posted", message: "Your image was successfully posted")
                self.messageTextField.text = ""
                self.imageToPost.image = UIImage(named: "upload1.png")
            }
        }
    }
}
