//
//  RegisterViewController.swift
//  BigUploader
//
//  Created by Mehdi Naghdi Tam on 7/14/18.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    let sagueToUploadFromRegister = "sagueToUploadFromRegister"
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func register(_ sender: UIButton) {
        if email.text != "" && password.text != "" {
            
        AuthorizationProvider.Instance.createUser(email: email.text! , password: password.text!, loginHandler: { (message) in
            
            if message != nil{
                self.alertTheUser(title: "Registeration Error", message: "Unable to Create User")
            }
            else {
                print("User is Created")
                //create a shippo address
                
                
                //segue away to the other views
                self.performSegue(withIdentifier: self.sagueToUploadFromRegister, sender: nil)
                
            }
            
        })
    }
    else {
    self.alertTheUser(title: "Blank Fields", message: "Please Fill Out All Fields")
    }
}

private func alertTheUser(title: String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(ok)
    present(alert, animated: true, completion: nil)
    
}
}
