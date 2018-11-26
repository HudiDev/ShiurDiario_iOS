//
//  Text_VC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/23/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit
import PDFKit

class Text_VC: UIViewController {
    
    let pdfView = PDFView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        displayPDF()
    }
    
    func displayPDF() {
        addConstraints()
        guard let url = URL(string: "http://shiurdiario.com/media/pdf/Menachot_95.pdf") else { return }
        if let document = PDFDocument(url: url) {
            pdfView.document = document
        }
    }
    
    func addConstraints() {
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        pdfView.maxScaleFactor = pdfView.scaleFactorForSizeToFit
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
