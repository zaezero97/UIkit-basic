//
//  OnBoardingPageViewController.swift
//  OnBoardingViewApp
//
//  Created by 재영신 on 2021/10/19.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {
    var pages = [UIViewController]()
    var buttonButtomMargin : NSLayoutConstraint?
    var pageControl = UIPageControl()
    let startIndex = 0
    var currentIndex = 0
    {
        didSet{
            pageControl.currentPage = currentIndex
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        makePageVC()
        makeBottomButton()
        makePageControl()
    }
}


extension OnBoardingPageViewController : UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == startIndex {
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
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let currentVC = pageViewController.viewControllers?.first else { return }
        guard let currentIndex = pages.firstIndex(of: currentVC) else { return }
        
        self.currentIndex = currentIndex
        buttonPresentationStyle()
        
    }
}


extension OnBoardingPageViewController{
    func makePageVC(){
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
        
        setViewControllers([itemVC1], direction: .forward, animated: true, completion: nil) //  시작 page item 지정
        
        self.delegate = self
        self.dataSource = self
    }
    func makeBottomButton(){
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        
        button.addTarget(self, action: #selector(dismissPageVC), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        buttonButtomMargin = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: 100) //constant를 100을 주게 되면 버튼이 내려가서 보이지 않게 된다.
        buttonButtomMargin?.isActive = true
    }
    func makePageControl(){
        self.view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = startIndex //코드를 짤 때 항상 의미를 생각하자 0 (x) / startIndex = 0 -> currentPage = startIndex (O)
        
        pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
    }
    @objc func pageControlTapped(sender : UIPageControl){
        
        if sender.currentPage > self.currentIndex{
            setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        }else{
        setViewControllers([pages[sender.currentPage]], direction: .reverse, animated: true, completion: nil)
        }
        //delegate의 메소드는 제스처 기반 탐색 및 방향 변경에 따라 호출됩니다.
        //따라서 pageControl을 클릭하여 setViewControllers 메소드로 화면전환시에는 delegate가 호출하지 않는다.
        self.currentIndex = sender.currentPage
        buttonPresentationStyle()
        
    }
    @objc func dismissPageVC(){
        self.dismiss(animated: true, completion: nil)
    }// objective-c 런타임에서 실행할 수 있는 규격이기 때문에 objc를 앞에 적어야한다.
    func buttonPresentationStyle(){
        if currentIndex == pages.count - 1 {
            //show button
            showButton()
        }else{
            //hide button
            hideButton()
        }
        //        UIView.animate(withDuration: 0.5) {
        //            self.view.layoutIfNeeded()
        //        }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseInOut],animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    func showButton(){
        buttonButtomMargin?.constant = 0
    }
    func hideButton(){
        buttonButtomMargin?.constant = 100
    }
}
