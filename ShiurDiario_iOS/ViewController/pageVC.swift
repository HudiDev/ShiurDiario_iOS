//
//  PageVC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/22/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {
    
    var tabsView: TabView!
    var currentIndex: Int = 0
    var prefix: String?
    var sqldate: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        tabsView.menuDelegate = self
        
        if self.prefix != nil {
            if let firstVC = self.orderedViewControllers.first {
                self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            }
        } else {
            retrieveCurrentPrefix { (prefix) in
                
                DispatchQueue.main.async {
                    
                    self.prefix = prefix
                    self.sqldate = Utils.getCurrentDate()
                    if let firstVC = self.orderedViewControllers.first {
                        self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
                    }
                }
                
            }
        }
        
       
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [generateVC(id: "video"), generateVC(id: "text"), generateVC(id: "previousShiurim"), generateVC(id: "allMasechtot")]
    }()
    
    func generateVC(id: String) -> UIViewController {
        let vc = UIStoryboard.init(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "\(id)_VC" )
        
        switch vc {
        case is Video_VC:
            let castedVC = vc as! Video_VC
            castedVC.prefix = self.prefix
            return castedVC
        case is Text_VC:
            let castedVC = vc as! Text_VC
            castedVC.prefix = self.prefix
            return castedVC
        case is Dapim_VC:
            let castedVC = vc as! Dapim_VC
            castedVC.sqldate = self.sqldate
            castedVC.isLoadedFromMasechtotVC = false
            return castedVC
        case is Masechtot_VC:
            let castedVC = vc as! Masechtot_VC
            return castedVC
        default:
            return vc
        }
    }
    
    
    
    func retrieveCurrentPrefix(completion: @escaping (_ prefixResult: String) -> Void) {
        
        guard let url = URL(string: "http://ws.shiurdiario.com/dafyomi.php?date=\(getCurrentDate())") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if err != nil {
                print("ERR IS: \(err!.localizedDescription)")
            }
            do {
                let currentPrefix = try JSONDecoder().decode(MasechtaResponse.self, from: data!)
                completion(currentPrefix.d.prefix)
            } catch let jsonErr {
                print("JSON ERR IS: \(jsonErr)")
            }
        }.resume()
    }
    
    func getCurrentDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateInFormat = dateFormatter.string(from: currentDate)
        return dateInFormat
    }
}




extension PageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else {return}
        
        guard let vc = pageViewController.viewControllers?.first else {return}
        
        switch vc {
        case is Video_VC:
            currentIndex = 0
            break
        case is Text_VC:
            currentIndex = 1
            break
        case is Dapim_VC:
            currentIndex = 2
            break
        case is Masechtot_VC:
            currentIndex = 3
            break
        default:
            currentIndex = 3
            break
        }
        
        tabsView.tabsCollectionView.selectItem(at: IndexPath.init(item: currentIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        tabsView.tabsCollectionView.scrollToItem(at: IndexPath.init(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        
    }
    
    
}


extension PageVC: MenuBarDelegate {
    func menuBarDidSelectItemAt(menu: TabView, index: Int) {
        if currentIndex != index {
            setViewControllers([orderedViewControllers[index]], direction: .forward, animated: false, completion: nil)
            currentIndex = index
            tabsView.tabsCollectionView.scrollToItem(at: IndexPath.init(item: index, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}
