//
//  MangaDetailViewController.swift
//  Slowga
//
//  Created by Deshun Cai on 1/11/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import UIKit

class MangaDetailViewController: UIViewController, MangaDetailViewDelegate, UIGestureRecognizerDelegate {
    var mangaCover: MangaCover!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    @objc func backgroundViewWasTapped(_ sender: UITapGestureRecognizer? = nil) {
        print("bg was tapped")
        dismissVC()
    }
    
    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        print("attempted to pan or something")
    }
    
    private func setupView() {
        // set up background
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundViewWasTapped(_:)))
        tapGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizer)
        self.view.isUserInteractionEnabled = true
        
        // set up detail view
        let detailView = MangaDetailView(mangaCover: mangaCover)
        self.view.addSubview(detailView)
        let safeArea = self.view.safeAreaLayoutGuide
        let padding: CGFloat = 10
        let paddingTop: CGFloat = 20
        let cornerRadius: CGFloat = 10
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding).isActive = true
        detailView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding).isActive = true
        detailView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: paddingTop).isActive = true
        detailView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true

        detailView.layer.cornerRadius = cornerRadius
        detailView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        detailView.clipsToBounds = true
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        detailView.addGestureRecognizer(panGestureRecognizer)
        detailView.backgroundColor = PRIMARY_COLOR
        
        detailView.delegate = self
    }
    
    init(for mangaCover: MangaCover) {
        self.mangaCover = mangaCover
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
}
