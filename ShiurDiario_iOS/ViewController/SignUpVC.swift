//
//  SignUpVC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 3/10/19.
//  Copyright © 2019 Hudi Ilfeld. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    
    private let db: Firestore = Firestore.firestore()
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    
    var emailStr: String {
        return emailField.text ?? ""
    }
    
    var passwordStr: String {
        return passwordField.text ?? ""
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func loginBtn(_ sender: UIButton) {
        guard isFieldsValid() else { return }
        
        Auth.auth().signIn(withEmail: emailStr, password: passwordStr) { (result, err) in
            guard err == nil else {
                self.displayErrorAlert(title: "Login Error", msg: err!.localizedDescription)
                return
            }
            guard result != nil else { return }
            print("you logged in successfully")
        }
    }
    
    @IBAction func signUpBtn(_ sender: UIButton) {
        guard isFieldsValid() else { return }
        
        Auth.auth().createUser(withEmail: emailStr, password: passwordStr) { (result, err) in
            guard err == nil else {
                self.displayErrorAlert(title: "Login Error", msg: err!.localizedDescription)
                return
            }
            
            guard result != nil else { return }
            print("you signed up successfully")
            
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = "Hudi"
            changeRequest?.commitChanges(completion: { (err) in
                guard err == nil else {
                    self.displayErrorAlert(title: "Change Error", msg: err!.localizedDescription)
                    return
                }
                
                print("you have successfully changed user details")
            })
        }
    }
    
    
    private func isFieldsValid() -> Bool {
        if !isValidEmail(testStr: emailField.text ?? "") {
            displayErrorAlert(title: "Login error", msg: "Invalid email address")
            return false
        }
        if passwordField.text!.count < 5 {
            displayErrorAlert(title: "Login error", msg: "Password requires at least 5 characters")
            return false
        }
        return true
    }
    
    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

}



extension UIViewController {
    func displayErrorAlert(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
