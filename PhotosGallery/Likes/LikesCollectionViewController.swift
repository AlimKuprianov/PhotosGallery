//
//  LikeVC.swift
//  PhotosGallery
//
//  Created by Алим Куприянов on 30.10.2020.
//  Copyright © 2020 Алим Куприянов. All rights reserved.
//

import Foundation
import UIKit

class LikesCollectionViewController: UICollectionViewController {
    
    var photos = [UnsplashPhoto]()
    
    private lazy var trashBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
    }()
    
    private let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "You haven't add a photos yet"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(LikesCollectionViewCell.self, forCellWithReuseIdentifier: LikesCollectionViewCell.reuseId)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        setupEnterLabel()
        setupNavigationBar()
        
    }
    
    // MARK: - Setup UI Elements
    
    private func setupEnterLabel() {
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        enterSearchTermLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 50).isActive = true
    }
    
    private func setupNavigationBar() {
       
        let titleLabel = UILabel()
               titleLabel.text = "Favorites"
               titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
               titleLabel.textColor = .label
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        navigationItem.rightBarButtonItem = trashBarButtonItem
        trashBarButtonItem.isEnabled = false
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = photos.count != 0
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikesCollectionViewCell.reuseId, for: indexPath) as! LikesCollectionViewCell
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        return cell
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout

extension LikesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width/3 - 1, height: width/3 - 1)
    }
}

