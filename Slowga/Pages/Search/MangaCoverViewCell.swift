//
//  MangaCoverViewCell.swift
//  Slowga
//
//  Created by Deshun Cai on 30/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import UIKit

let placeHolderImageName = "PlaceHolderMangaCoverImage"

class MangaCoverViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    var mangaCover: MangaCover?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
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
    
    public func configure(with mangaCover: MangaCover) {
        self.mangaCover = mangaCover
        self.imageView.image = UIImage(named: placeHolderImageName)
    }
}
