//
//  LoginVC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 3/11/19.
//  Copyright © 2019 Hudi Ilfeld. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    
    
    var emailStr: String { return emailField.text ?? "" }
    var passwordStr: String { return passwordField.text ?? "" }
    
    
    private lazy var maskView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = .black
        view.alpha = 0.0
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.maskView)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func goBackToSignUp(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func loginBtn(_ sender: UIButton) {
        guard isFieldsValid() else { return }
        
        self.maskView.alpha = 0.5
        loaderIndicator.startAnimating()
        
        Auth.auth().signIn(withEmail: emailStr, password: passwordStr) { (result, err) in
            
            self.maskView.alpha = 0.0
            self.loaderIndicator.stopAnimating()
            
            guard err == nil else {
                self.displayErrorAlert(title: "Login Error", msg: err!.localizedDescription)
                return
            }
            guard result != nil else { return }
            print("you logged in successfully")
        }
    }
    
    
    private func isFieldsValid() -> Bool {
        
        if !isValidEmail(testStr: emailStr) {
            displayErrorAlert(title: "Login error", msg: "Invalid email address")
            return false
        }
        if passwordStr.count < 5 {
            displayErrorAlert(title: "Login error", msg: "Password requires at least 5 characters")
            return false
        }
        return true
    }

}
