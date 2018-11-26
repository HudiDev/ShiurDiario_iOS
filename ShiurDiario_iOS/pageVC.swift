//
//  pageVC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/22/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class pageVC: UIPageViewController {
    
    var tabsView: TabView!
    var currentIndex: Int = 0
    var prefix: String?
    var sqldate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        tabsView.menuDelegate = self
       
        if let firstVC = orderedViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
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
        case is PreviousShiurim_VC:
            let castedVC = vc as! PreviousShiurim_VC
            castedVC.sqldate = self.sqldate
            return castedVC
        case is AllMasechtot_VC:
            let castedVC = vc as! AllMasechtot_VC
            return castedVC
        default:
            return vc
        }
    }
}




extension pageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
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
        case is PreviousShiurim_VC:
            currentIndex = 2
            break
        case is AllMasechtot_VC:
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


extension pageVC: MenuBarDelegate {
    func menuBarDidSelectItemAt(menu: TabView, index: Int) {
        if currentIndex != index {
            setViewControllers([orderedViewControllers[index]], direction: .forward, animated: false, completion: nil)
            currentIndex = index
            tabsView.tabsCollectionView.scrollToItem(at: IndexPath.init(item: index, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    
}
