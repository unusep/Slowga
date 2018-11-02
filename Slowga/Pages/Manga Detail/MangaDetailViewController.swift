//
//  MangaDetailViewController.swift
//  Slowga
//
//  Created by Deshun Cai on 1/11/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import UIKit

class MangaDetailViewController: UIViewController {
    var mangaCover: MangaCover!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        let detailView = MangaDetailView()
        self.view.addSubview(detailView)
        
        // layout detail view
        let safeArea = self.view.safeAreaLayoutGuide
        let padding: CGFloat = 10
        let cornerRadius: CGFloat = 10
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding).isActive = true
        detailView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding).isActive = true
        detailView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding).isActive = true
        detailView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true

        detailView.layer.cornerRadius = cornerRadius
        detailView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        detailView.clipsToBounds = true
        
        detailView.backgroundColor = PRIMARY_COLOR
    }
    
    init(for mangaCover: MangaCover) {
        self.mangaCover = mangaCover
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
