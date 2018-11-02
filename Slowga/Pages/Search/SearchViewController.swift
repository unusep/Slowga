//
//  SearchViewController.swift
//  Slowga
//
//  Created by Deshun Cai on 8/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import UIKit

class SearchViewController: UINavigationController, UINavigationControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    let mangaRetrievalService = AppDelegate.mangaRetrievalService
    
    var searchController: UISearchController!
    var searchResultsCollectionViewController: SearchResultsCollectionViewController!
    
    func updateSearchResults(for searchController: UISearchController) {
        mangaRetrievalService.searchCache(for: searchController.searchBar.text) { (mangaCovers) in
            searchResultsCollectionViewController.data = mangaCovers
            searchResultsCollectionViewController.collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mangaRetrievalService.search(for: searchBar.text) { (mangaCovers) in
            searchResultsCollectionViewController.data = mangaCovers
            searchResultsCollectionViewController.collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        // nav bar styling
        self.navigationBar.prefersLargeTitles = true
        
        // add collection view
        searchResultsCollectionViewController = SearchResultsCollectionViewController(mangaRetrievalService: mangaRetrievalService)
        searchResultsCollectionViewController.navigationItem.hidesSearchBarWhenScrolling = false
        searchResultsCollectionViewController.collectionView.backgroundColor = .white
        searchResultsCollectionViewController.title = "Search"
        searchResultsCollectionViewController.definesPresentationContext = true
        
        // add search bar
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.isActive = true
        searchResultsCollectionViewController.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Manga"
        
        self.setViewControllers([searchResultsCollectionViewController], animated: false)
        
        // set presentation context
        self.definesPresentationContext = true
    }
    
}
