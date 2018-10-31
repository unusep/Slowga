//
//  MangaReaderViewController.swift
//  Slowga
//
//  Created by Deshun Cai on 8/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import UIKit


class MangaReaderViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func backWasTapped(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func rewindWasTapped(sender: UIButton) {
        
    }
    
    @objc func forwardWasTapped(sender: UIButton) {
        
    }
    
    func setupNavigationBar() {
        // layout navigation bar
        let navigationBar : UINavigationBar = UINavigationBar(
            frame: CGRect(x: 0, y: 0, width: 0, height: 0)
        )
        self.view.addSubview(navigationBar)
        let safeArea = self.view.safeAreaLayoutGuide
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        navigationBar.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive = true
        
        // styling navigation bar
        navigationBar.barTintColor = UIColor.white
        
        // setup navigation item for navigation bar
        let navItem = UINavigationItem(title: "Currently Reading")
        let backItem = UIBarButtonItem(
            image: UIImage(named: "chevron-down"),
            style: UIBarButtonItem.Style.done,
            target: nil,
            action: #selector(backWasTapped)
        )
        navItem.leftBarButtonItem = backItem
        navItem.hidesBackButton = true
        navigationBar.setItems([navItem], animated: false)
        
        // set navigation bar delegate
        navigationBar.delegate = self
    }
    
    func setupToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.view.addSubview(toolbar)
        let safeArea = self.view.safeAreaLayoutGuide
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        toolbar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        toolbar.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive = true
        
        // styling navigation bar
        toolbar.barTintColor = UIColor.white
        
        // setup barbutton items
        let rewindButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.rewind,
            target: nil,
            action: #selector(rewindWasTapped)
        )
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let forwardButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.fastForward,
            target: nil,
            action: #selector(forwardWasTapped)
        )
        
        toolbar.setItems([rewindButton, spacer, forwardButton], animated: false)
    }
    
    func setupReaderView() {
        let readerView = MangaReaderView()
        self.view.addSubview(readerView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        readerView.translatesAutoresizingMaskIntoConstraints = false
        readerView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        readerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        readerView.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive = true
        
        self.view.sendSubviewToBack(readerView)
    }
    
    func setup() {
        setupNavigationBar()
        setupToolbar()
        setupReaderView()
    }
}

extension MangaReaderViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
