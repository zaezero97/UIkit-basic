//
//  OnBoardingPageViewController.swift
//  OnBoardingViewApp
//
//  Created by 재영신 on 2021/10/19.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let itemVC1 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        let itemVC2 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        let itemVC3 = OnBoardingItemViewController(nibName: "OnBoardingItemViewController", bundle: nil)
        
        itemVC1.mainText = "Focus on your ideal buyer"
        itemVC1.topImage = UIImage(named: "onboarding1")
        itemVC1.subText = "When you write a product description with a huge crowd of buyers in mind, your descrptions become wishy-washy and you end up addressing no one at all"
        itemVC2.mainText = "Entice with benefits"
        itemVC2.topImage = UIImage(named: "onboarding2")
        itemVC2.subText = "When you write a product description with a huge crowd of buyers in mind, your descrptions become wishy-washy and you end up addressing no one at all"
        itemVC3.mainText = "Avoid yeah, yeah phrases"
        itemVC3.topImage = UIImage(named: "onboarding3")
        itemVC3.subText = "When you write a product description with a huge crowd of buyers in mind, your descrptions become wishy-washy and you end up addressing no one at all"
        
        pages.append(itemVC1)
        pages.append(itemVC2)
        pages.append(itemVC3)
        
        setViewControllers([itemVC1], direction: .forward, animated: true, completion: nil)
        
        self.delegate = self
        self.dataSource = self
    }
}


extension OnBoardingPageViewController : UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last
        }else{
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == pages.count - 1 {
            return pages.first
        }else{
            return pages[currentIndex + 1]
        }
    }
}

extension OnBoardingPageViewController : UIPageViewControllerDelegate{
    
}
