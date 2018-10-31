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
    
    public func configure(with mangaCover: MangaCover, service: MangaRetrievalService) {
        self.mangaCover = mangaCover
        service.getCoverImage(for: mangaCover) { (imagePath) in
            DispatchQueue.main.async {
                var image: UIImage
                if let path = imagePath {
                    image = UIImage(contentsOfFile: path) ?? UIImage(named: placeHolderImageName)!
                } else {
                    image = UIImage(named: placeHolderImageName)!
                }
                
                self.imageView.image = image
            }
        }
    }
}
