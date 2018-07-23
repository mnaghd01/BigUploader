//
//  LoginViewController.swift
//  BigUploader
//
//  Created by Mehdi Naghdi Tam on 7/8/18.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let sagueToRegisterFromLogin = "sagueToRegisterFromLogin"
    let segueToUploadViewFromLogin = "uploadViewSegue"
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func loginButton(_ sender: UIButton) {
        if username.text != "" && password.text != "" {
            AuthorizationProvider.Instance.login(email: username.text!, password: password.text!, loginHandler: { (message) in
                
                if message != nil {
                    self.alertTheUser(title: "Problem With Authentication", message: message!)
                    
                }
                else {
                    print("Login Completed")
                    self.performSegue(withIdentifier: self.segueToUploadViewFromLogin, sender: self)
                }
            })
        }
        else{
            alertTheUser(title: "Email and Password Are Required", message: "Please Enter Valid Email and Password")
        }
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: self.sagueToRegisterFromLogin, sender: self)
    }
    
    private func alertTheUser(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
