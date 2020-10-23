//
//  PhotosCollectionVC.swift
//  PhotosGallery
//
//  Created by Алим Куприянов on 21.09.2020.
//  Copyright © 2020 Алим Куприянов. All rights reserved.
//

import Foundation
import UIKit


class PhotosCollectionVC: UICollectionViewController {
    
    
    var networkDataFetcher = NetworkDataFetcher()
    
    private var timer: Timer?
    private var photos = [UnsplashPhoto]()
    private let itemPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    
    
//MARK: - BarButtonItems
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
       
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped))
    }()
    
    
    private lazy var actionBarButtonItem: UIBarButtonItem = {
       
        
        return UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionBarButtonTapped))
    }()
    
   
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        setupNavigationBar()
        setupCollectionView()
        setupSearchBar()
        
    }
    
    
    
    
    
    
     //MARK: - NavigationItems Action
    
    
    @objc private func addBarButtonTapped(){
        print(#function)
    }
    
    
    @objc private func actionBarButtonTapped(){
        
        print(#function)
    }
    
    
    
    
    
    
     //MARK: - Setup UI Elements
    
    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.reuseid)
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    
    private func setupNavigationBar () {
        
        let titleLabel = UILabel()
        titleLabel.text = "Photos"
        titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        titleLabel.textColor = .label
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        navigationItem.rightBarButtonItems = [actionBarButtonItem, addBarButtonItem]
    }
    
    
    
    
    
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    
    
    
    
    
    //MARK: - UICollectionView DataSource, UICollectionView Delegate
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseid, for: indexPath  ) as! PhotosCell
        
        let unsplashPhoto = photos [indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        
        return cell
    }
}


//MARK: - UISearchBar Delegate


extension PhotosCollectionVC:  UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            self.networkDataFetcher.fetchImages(searchTerm: searchText) { [weak self] (searchResults) in
                
                guard let fetchedPhotos = searchResults  else { return }
                self?.photos = fetchedPhotos.results
                self?.collectionView.reloadData()
            }
        })
       
        
     
    }
}

//MARK: - UICollectionViewDelegateFlowLayout


extension PhotosCollectionVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let photo = photos[indexPath.item]
        let paddingSpace = sectionInserts.left * (itemPerRow+1)
        let avalaibleWidth = view.frame.width - paddingSpace
        let widthPerItem = avalaibleWidth / itemPerRow
        let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
        
        return CGSize(width: widthPerItem, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           
        return sectionInserts
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInserts.left
        
        
    }
    
}
