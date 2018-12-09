//
//  MangaDetailView.swift
//  Slowga
//
//  Created by Deshun Cai on 2/11/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import UIKit

protocol MangaDetailViewDelegate {
    func dismissVC()
}

class MangaDetailView: UIView {
    var mangaCover: MangaCover!
    var delegate: MangaDetailViewDelegate?
    
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
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.addTarget(self, action: #selector(buttonWasTapped(sender:)), for: UIControl.Event.touchUpInside)
        button.backgroundColor = .blue
        self.addSubview(button)
        
    }
    
    @objc func buttonWasTapped(sender: UIButton) {
        print("touched")
        self.delegate?.dismissVC()
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
