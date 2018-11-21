//
//  ViewController.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/18/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    var isSideMenuOpened = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
      addPanGesture(view: self.view)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideSideMenu), name: NSNotification.Name("hideMenu"), object: nil)
        
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(toggleMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    @objc func hideSideMenu() {
        sideMenuConstraint.constant = -300
    }
    
    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        var getInitialX: CGFloat = 0.0
        
        switch sender.state {
        case .began:
            getInitialX = sender.translation(in: self.view).x
            break
        case .changed:
            let x_delta = sender.translation(in: self.view).x - getInitialX
            if x_delta < -70 {
                UIView.animate(withDuration: 0.4) {
                    self.sideMenuConstraint.constant = -300
                    self.view.layoutIfNeeded()
                }
            }
            
        default:
            print("fingers off the screen")
        }
    }
    
    
    @IBAction func menuBtn(_ sender: Any) {
        
        toggleMenu()
    }
    
    
    func toggleMenu() {
        isSideMenuOpened = !isSideMenuOpened
        if isSideMenuOpened {
            UIView.animate(withDuration: 0.4) {
                self.sideMenuConstraint.constant = -300
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.4) {
                self.sideMenuConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//extension UIView {
//    func addPanGesture(view: UIView, sideConstraint: NSLayoutConstraint) {
//        let pan = UIPanGestureRecognizer(target: view, action: #selector(handlePan(sender:constraint:)))
//        view.addGestureRecognizer(pan)
//    }
//
//    @objc func handlePan(sender: UIPanGestureRecognizer, constraint: NSLayoutConstraint) {
//        var getInitialX: CGFloat = 0.0
//
//        switch sender.state {
//        case .began:
//            getInitialX = sender.translation(in: self).x
//            break
//        case .changed:
//            let x_delta = sender.translation(in: self).x - getInitialX
//            if x_delta < -70 {
//                UIView.animate(withDuration: 0.5) {
//                    constraint.constant = -300
//                    self.layoutIfNeeded()
//                }
//            }
//
//        default:
//            print("fingers off the screen")
//        }
//    }
//}

