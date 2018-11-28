//
//  DedicationVC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/27/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class DedicationVC: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var container: UIView!
    
    
    var gradientLayer: CAGradientLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBorder()
     
        retrieveData { (arr) in
            DispatchQueue.main.async {
                self.titleLabel.text = "A ELEVAÇÃO DA ALMA DE:"
                self.nameLabel.text = arr[1]
            }
        }
    }
    
    func addBorder() {
        container.layer.borderWidth = 0.5
        container.layer.borderColor = UIColor.black.cgColor
    }

//    func createGradient() {
//        gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.view.bounds
//        gradientLayer.colors = [UIColor.black.cgColor, UIColor.blue.cgColor]
//        self.view.layer.insertSublayer(gradientLayer, at: 0)
//    }
    
    func addLabels() {
        titleLabel = UILabel(frame: CGRect(x: 50, y: 30, width: 70, height: 20))
        nameLabel = UILabel(frame: CGRect(x: 50, y: 80, width: 70, height: 20))
        titleLabel?.text = "HELLO WORLD"
        titleLabel?.textColor = .white
        nameLabel?.text = "YO YO YO"
        nameLabel?.textColor = .white
        self.view.addSubview(titleLabel!)
        self.view.addSubview(nameLabel!)
    }
    
    func retrieveData(completion: @escaping (_ dedicationName: [String]) -> Void) {
        
        guard let url = URL(string: "http://ws.shiurdiario.com/dafyomi.php?date=\(getCurrentDate())") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if err != nil {
                print("URLSession ERR IS: \(err!.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let name = try JSONDecoder().decode(MasechtaResponse.self, from: data)
                    let dedicationArr =  name.d.dedication.components(separatedBy: ":")
                    completion(dedicationArr)
                } catch let jsonError {
                    print("JSON_ERR IS: \(jsonError)")
                }
            } else {
                print("NO DATA COMING BACK FROM SERVER")
            }
            
        }.resume()
    }
    
    
    func getCurrentDate() -> String{
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateInFormat = dateFormatter.string(from: currentDate)
        return dateInFormat
    }
}
