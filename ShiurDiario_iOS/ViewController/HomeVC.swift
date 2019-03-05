//
//  ViewController.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/18/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    
    
    lazy var mask: UIView = {
        let view = UIView(frame: self.scrollView.frame)
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleContainer: UIView!
    @IBOutlet weak var introText: UILabel!
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstSubTitleView: UIView!
    @IBOutlet weak var secondSubTitleView: UIView!
    
    var isSideMenuOpened = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.addSubview(self.mask)
        
        firstSubTitleView.addBorder(width: 0.5, color: UIColor.black.cgColor)
        
        secondSubTitleView.addBorder(width: 0.5, color: UIColor.black.cgColor)
        titleContainer.addBorder(width: 0.5, color: UIColor.black.cgColor)
        addPanGesture(view: self.view)
        addEdgePanGesture(view: self.view)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideSideMenu), name: NSNotification.Name("hideMenu"), object: nil)
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
                    self.mask.alpha = 0
                    self.view.layoutIfNeeded()
                }
            }
        default:
            print("fingers off the screen")
        }
    }
    
    
    func addEdgePanGesture(view: UIView) {
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleEdgePan(sender:)))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
    }
    
    
    @objc func handleEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            UIView.animate(withDuration: 0.4) {
                self.sideMenuConstraint.constant = 0
                self.mask.alpha = 0.5
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    @IBAction func menuBtn(_ sender: Any) {
        
        toggleMenu()
    }
    
    
    func toggleMenu() {
        isSideMenuOpened = !isSideMenuOpened
        if isSideMenuOpened {
            UIView.animate(withDuration: 0.4) {
                self.sideMenuConstraint.constant = -250
                self.mask.alpha = 0
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.4) {
                self.sideMenuConstraint.constant = 0
                self.mask.alpha = 0.5
                self.view.layoutIfNeeded()
            }
        }
    }
}
