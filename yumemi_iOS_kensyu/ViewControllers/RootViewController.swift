//
//  RootViewController.swift
//  yumemi_iOS_kensyu
//
//  Created by takatoshi.ichige on 2021/04/08.
//

import UIKit

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController")
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
        
    }
}
