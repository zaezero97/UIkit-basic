//
//  DetailViewController.swift
//  NavigationBarDesign
//
//  Created by 재영신 on 2021/10/26.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.navigationController?.navigationBar.backgroundColor = .yellow
        self.statusBar?.backgroundColor = .yellow
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController{
    var statusBar : UIView?{
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        if let hasStatusBar = sceneDelegate?.statusBarView{
            window?.addSubview(hasStatusBar)
        }
        return sceneDelegate?.statusBarView
    }
}
