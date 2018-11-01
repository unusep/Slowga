//
//  RootViewController.swift
//  Slowga
//
//  Created by Deshun Cai on 8/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    let dummyCurrentReadingVc = UIViewController()
    let mangaReaderController = MangaReaderViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == dummyCurrentReadingVc {
            present(mangaReaderController, animated: true)
            return false
        } else {
            return true
        }
    }
    
    func setup() {
        // initialise each tab
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        
        mangaReaderController.modalPresentationStyle = .overFullScreen
        
        dummyCurrentReadingVc.title = "Reading"
        
        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.search, tag: 0)
        
        self.viewControllers = [homeViewController, dummyCurrentReadingVc, searchViewController]
        
        // default view controller
        self.selectedViewController = homeViewController
        
        self.modalPresentationStyle = .overFullScreen
        
        // tab bar controller delegate
        self.delegate = self
    }
}