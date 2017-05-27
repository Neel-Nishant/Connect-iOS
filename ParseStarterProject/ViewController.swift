/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    var signUpMode = true
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpOrLoginBtn: MaterialButton!
    
    @IBOutlet weak var changeSignUpModeBtn: MaterialButton!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let user = PFObject(className: "Users")
//        user["name"] = "Neel"
//        user.saveInBackground { (success, error) in
//            if success {
//                print("Object saved")
//            }
//            else{
//                if let error = error {
//                    print(error)
//                }
//                else{
//                    print(error)
//                }
//            }
//        }
        
       let query = PFQuery(className: "Users")
        query.getObjectInBackground(withId: "iMOTcG2yNV") { (object, error) in
            
            if error != nil {
                print(error)
            }
            else{
                if let user = object {
//                    print(user)
//                    print(user["name"])
                    user["name"] = "Kirsten"
                    user.saveInBackground(block: { (success, error) in
                        if success {
                            print("saved")
                        }
                        else{
                            print(error)
                        }
                        
                        
                    })
                }
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        if PFUser.current()?.username != nil {
            self.performSegue(withIdentifier: "showUserTable", sender: self)
            print(PFUser.current())
            
            
        }
        self.navigationController?.navigationBar.isHidden = true

        
    }
    @IBAction func signUpOrLogin(_ sender: Any) {
        print(signUpMode)
        if emailTextField.text == "" || passwordTextField.text == "" {
            createAlert(title: "Error in Form", message: "please enter email and password")
        }
        else{
            
                activityIndicator = UIActivityIndicatorView(frame: (CGRect(x: 0, y: 0, width: 50, height: 50)))
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents()
            
            if signUpMode {
                // sign up
                
                let user = PFUser()
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackground(block: { (success, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        var displayMessage = "Please try later"
                        
                            displayMessage = (error?.localizedDescription)!
                        self.createAlert(title: "Error", message: displayMessage)
                    }
                    else {
                        print("user signedup")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                        self.selfFollow()
                    }
                })
            }
            else{
                // login
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    if error != nil {
                        var displayMessage = "Please try later"
                        displayMessage = (error?.localizedDescription)!
                        self.createAlert(title: "login error", message: displayMessage)
                    }
                    else {
                        print("logged in")
                        print("PFUSER: \(PFUser.current())")
                        self.navigationController?.navigationBar.isHidden = true
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                        
                        
                    }
                })
            }
        }
        
    }
    @IBAction func changeSignUpMode(_ sender: Any) {
        if signUpMode {
            // change to login
            signUpOrLoginBtn.setTitle("Login", for: [])
            
            changeSignUpModeBtn.setTitle("Sign Up", for: [])
            
            messageLabel.text = "Don't have an account?"
            
            signUpMode = false
        }
        else {
            signUpOrLoginBtn.setTitle("Sign Up", for: [])
            
            changeSignUpModeBtn.setTitle("Login", for: [])
            
            messageLabel.text = "Already have an account?"
            
            signUpMode = true
        }
    }
    func createAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func selfFollow()
    {
        let following = PFObject(className: "Followers")
        following["following"] = PFUser.current()?.objectId
        following["follower"] = PFUser.current()?.objectId
        
        following.saveInBackground()
    }
    
}
