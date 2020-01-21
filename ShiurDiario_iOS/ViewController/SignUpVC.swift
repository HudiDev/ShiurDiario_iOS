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
    
    typealias NameUniqueCompletion = (_ isUnique: Bool) -> ()
    
    
    private var db: Firestore!
    private let users: String = "users"
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordVerificationField: UITextField!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    private var nameStr: String { return nameField.text ?? "" }
    private var emailStr: String { return emailField.text ?? "" }
    private var passwordStr: String { return passwordField.text ?? "" }
    private var passwordVerificationStr: String { return passwordVerificationField.text ?? "" }
    
    var trimmedName: String {
        return nameStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    private lazy var viewMask: UIView = {
        let view = UIView(frame: self.view.frame)
        view.alpha = 0.0
        view.backgroundColor = .black
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = Auth.auth().currentUser {
            print("current user name is: \(currentUser.displayName)")
        } else {
            print("current user is nil")
        }
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.hideKeyBoardWhenTouchedAround()
        
        self.view.addSubview(viewMask)

        db = Firestore.firestore()
    }
    
    
    @IBAction func goToLogin(_ sender: UIButton) {
        
    }
    
    
    
    @IBAction func signUpBtn(_ sender: UIButton) {
        guard isFieldsValid() else { return }
        
        self.viewMask.alpha = 0.5
        self.loadingIndicator.startAnimating()
        
        self.isUserNameUnique { (isUnique) in
            guard isUnique else {
                self.displayErrorAlert(title: "Login error", msg: "user name already exists")
                return
            }
            
            Auth.auth().createUser(withEmail: self.emailStr, password: self.passwordStr) { (result, err) in
                guard err == nil else {
                    self.displayErrorAlert(title: "Login error", msg: err!.localizedDescription)
                    return
                }
                
                guard result != nil else { return }
                print("you signed up successfully")
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.trimmedName
                changeRequest?.commitChanges(completion: { (err) in
                    guard err == nil else {
                        self.displayErrorAlert(title: "Change Error", msg: err!.localizedDescription)
                        return
                    }
                    
                    self.addNewUserToDB()
                    
                    self.loadingIndicator.stopAnimating()
                    self.viewMask.alpha = 0.0
                    
                    print("you have successfully changed user details")
                })
            }
            
        }
        
        
    }
    
    
    
    private func isUserNameUnique(completion: @escaping NameUniqueCompletion) {
        
        db.collection(self.users).whereField("display_name", isEqualTo: self.nameStr)
            .getDocuments { (snapshot, err) in
                guard err == nil else {
                    print("error attempting to query users with similar name: \(err!.localizedDescription)")
                    return
                }
                guard let snapshot = snapshot else { return }
                snapshot.count == 0 ? completion(true) : completion(false)
        }
    }
    
    
    private func addNewUserToDB() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("couldn't get uid of current user")
            return
        }
        self.db.collection(self.users).document(uid).setData([
            "display_name": nameStr,
            "email": emailStr]) { (err) in
                guard err == nil else {
                    print("error saving new user to db: \(err!.localizedDescription)")
                    return
                }
        }
        
        
        
//        self.db.collection(self.users).document(uid).setData([
//            "display_name": nameStr,
//            "email": emailStr])
    }
    
    
    private func isFieldsValid() -> Bool {
        
        if nameStr.count == 0 {
            displayErrorAlert(title: "Login error", msg: "user name is empty")
            return false
        }
        if !isValidEmail(testStr: emailStr) {
            displayErrorAlert(title: "Login error", msg: "Invalid email address")
            return false
        }
        if passwordStr.count < 5 {
            displayErrorAlert(title: "Login error", msg: "Password requires at least 5 characters")
            return false
        }
        if passwordVerificationStr != passwordStr {
            displayErrorAlert(title: "Login error", msg: "verification does not match password")
            return false
        }
        return true
    }
    
}



extension UIViewController {
    func displayErrorAlert(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
