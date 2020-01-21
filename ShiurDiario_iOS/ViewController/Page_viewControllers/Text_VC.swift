//
//  Text_VC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/23/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit
import PDFKit

class Text_VC: ShiurDiarioBaseViewController {
    
    let pdfView = PDFView()
    var prefix: String?
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var indicatorBar: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorBar.startAnimating()
        displayPDF()
    }
    
    func displayPDF() {
        DispatchQueue.global(qos: .userInteractive).async {
            if self.prefix == nil {
                self.prefix = "Menachot_95"
            }
            guard let url = URL(string: "http://shiurdiario.com/media/pdf/\(self.prefix!).pdf") else { return }
            if let document = PDFDocument(url: url) {
                DispatchQueue.main.async {
                    self.indicatorBar.stopAnimating()
                    self.addConstraints()
                    print("PDF DATA IS: \(document)")
                    self.pdfView.document = document
                    self.pdfView.autoScales = true
                }
            } else {
                DispatchQueue.main.async {
                    self.indicatorBar.stopAnimating()
                    self.indicatorBar.isHidden = true
                    self.errorLabel.addBorder(width: 0.5, color: UIColor.black.cgColor)
                    self.errorLabel.text = "Page is unavailable at this moment"
                }
            }
        }
    }
    
    func addConstraints() {
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}
