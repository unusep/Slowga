//
//  MangaDetailView.swift
//  Slowga
//
//  Created by Deshun Cai on 2/11/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import UIKit

class MangaDetailView: UIView {
    var mangaCover: MangaCover!
    
    init(mangaCover: MangaCover){
        self.mangaCover = mangaCover
        
        super.init(frame: CGRect.zero)
        
        // setup
        setupViews()
    }
    
    func setupViews() {
        let imageView = UIImageView(frame: CGRect.zero)
        
        imageView.image = mangaCover.image
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView.layer.cornerRadius = 2
        imageView.clipsToBounds = true
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
