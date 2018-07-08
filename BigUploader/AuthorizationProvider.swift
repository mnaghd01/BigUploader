//
//  AuthorizationProvider.swift
//  BigUploader
//
//  Created by Mehdi Naghdi Tam on 7/8/18.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias LoginHandler = (_ message: String?) -> Void

struct LoginErrorCode {
    static let invalidEmail = "Invali Email Address"
    static let wrongPassword = "Wrong Password Entered"
    static let problemConnecting = "Problem Connecting to Database, Please Try Later"
    static let userNotFound = "User Not Found"
    static let emailInUse = "Email Already in Use"
    static let weakPassword = "Password Should Be at Least 6 Characters Long"
}

class AuthorizationProvider {
    
    private static let _instance = AuthorizationProvider()
    static var Instance: AuthorizationProvider{
        return _instance
    }
    
    
    
    func login (email: String , password: String, loginHandler: LoginHandler?){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
                } else {
                loginHandler?(nil)
            }
        }

    }
    
    func createUser (email: String, password: String, loginHandler: LoginHandler?){
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
                
            } else{
                if user?.uid != nil {
                    self.login(email: email, password: password, loginHandler: loginHandler)
                }
                
            }
        }
    }
    
    func logOut() -> Bool {
        if Auth.auth().currentUser != nil{
            do{
                try Auth.auth().signOut()
                return true
            } catch {
                
                return false
            }
        }
        return true
    }
    
    private func handleErrors(err: NSError, loginHandler: LoginHandler?) {
        
        if let errCode = AuthErrorCode(rawValue: err.code){
            switch errCode {
            case.wrongPassword:
                loginHandler?(LoginErrorCode.wrongPassword)
                break;
            case.invalidEmail:
                loginHandler?(LoginErrorCode.invalidEmail)
                break;
            case.emailAlreadyInUse:
                loginHandler?(LoginErrorCode.emailInUse)
                break;
            case.userNotFound:
                loginHandler?(LoginErrorCode.userNotFound)
                break;
            case.weakPassword:
                loginHandler?(LoginErrorCode.weakPassword)
                break;
            default:
                loginHandler?(LoginErrorCode.problemConnecting)
                break;
                
            }
        }
        
        
        
        
    }
    
    
}
