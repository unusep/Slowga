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
    var mangaReaderViewController: MangaReaderViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == dummyCurrentReadingVc, let vc = mangaReaderViewController {
            self.present(vc, animated: true)
            return false
        } else {
            return true
        }
    }
    
    func setup() {
        // initialise each tab
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        
        dummyCurrentReadingVc.title = "Reading"
        
        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.search, tag: 0)
        
        // TODO: only show dummy current reading vc if we are currently reading a manga
        var vcs: [UIViewController] = []
        vcs.append(homeViewController)
        if let currentlyReadingManga = AppDelegate.mangaRetrievalService.getCurrentlyReadingManga() {
            mangaReaderViewController = MangaReaderViewController(mangaCover: currentlyReadingManga)
            mangaReaderViewController?.modalPresentationStyle = .overFullScreen
            vcs.append(mangaReaderViewController!)
        }
        vcs.append(searchViewController)
        
        self.viewControllers = vcs
        
        // default view controller
        self.selectedViewController = homeViewController

        // tab bar controller delegate
        self.delegate = self
    }
}
