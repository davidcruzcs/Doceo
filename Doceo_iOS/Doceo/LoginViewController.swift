//
//  LoginViewController.swift
//  Doceo
//
//  Created by Juan David Cruz Serrano on 8/19/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//

import UIKit
import FirebaseAuth


protocol LoginViewControllerDelegate {
    func userDidLoggedInFromLoginView()
}

class LoginViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate



    @IBOutlet weak var usernamePassView: UIView!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func loginWithCredentials(sender: AnyObject) {
        
        FIRAuth.auth()?.signIn(withEmail: textFieldEmail.text!, password: textFieldPassword.text!, completion: { (user, error) in
            if error == nil {
                self.delegate?.userDidLoggedInFromLoginView()
            }
        })
        
    }
    
    @IBAction func loginWithFacebook(sender: AnyObject) {
       
    }
    
    
    @IBAction func loginWithGoogle(sender: AnyObject) {
        
    }
    
    func registerWithCredentials() {
        FIRAuth.auth()?.createUser(withEmail: textFieldEmail.text!, password: textFieldPassword.text!, completion: { (user, error) in
            if let user = user {
                print(user)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField == textFieldEmail) {
            textFieldEmail.resignFirstResponder()
            textFieldPassword.becomeFirstResponder()
        } else if (textField == textFieldPassword) {
            textFieldPassword.resignFirstResponder()
            
            loginWithCredentials(sender: "KeyboardDelegate" as AnyObject)
        }
        
        return true
    }
    
}
