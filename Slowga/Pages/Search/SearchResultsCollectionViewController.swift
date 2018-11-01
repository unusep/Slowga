//
//  SearchResultsCollectionViewController.swift
//  Slowga
//
//  Created by Deshun Cai on 30/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MangaCoverCell"

private let padding: CGFloat = 8
private let itemsPerRow: CGFloat = 3

class SearchResultsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var data: [MangaCover] = []
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var mangaRetrievalService: MangaRetrievalService!
    
    convenience init(mangaRetrievalService: MangaRetrievalService) {
        self.init()
        self.mangaRetrievalService = mangaRetrievalService
    }
    
    init() {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(MangaCoverViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // set delegates
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return data.count > 0 ? 1 : 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MangaCoverViewCell
    
        // Configure the cell
        let mangaCover = data[indexPath.row]
        cell.configure(with: mangaCover)
        
        mangaRetrievalService.getCoverImage(for: mangaCover) { imageFilePath in
            DispatchQueue.main.async {
                if let unwrappedImageFilePath = imageFilePath,
                    let image = UIImage(contentsOfFile: unwrappedImageFilePath) {
                    cell.imageView.image = image
                } else {
                    self.data.removeAll { mc in
                        return mc.objectID == mangaCover.objectID
                    }
                    self.collectionView.reloadData()
                }
            }
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // return CGSize(width: collectionView.frame.size.width, height: 60)
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - padding * (itemsPerRow+2))/itemsPerRow
        let height = width * 3/2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

