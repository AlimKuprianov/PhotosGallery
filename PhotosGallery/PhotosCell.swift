//
//  PhotosCell.swift
//  PhotosGallery
//
//  Created by Алим Куприянов on 16.10.2020.
//  Copyright © 2020 Алим Куприянов. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class PhotosCell: UICollectionViewCell {
    
    
    static let reuseid = "PhotosCell"
    
    private let checkmark: UIImageView = {
        let image = UIImage(named: "checkmark")
        let imageview = UIImageView(image: image)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.alpha = 0
        return imageview
    }()
    
    
    override var isSelected: Bool {
        didSet{
            updateSelectedState()
        }
    }
    
    
    private let photoImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoUrl = unsplashPhoto.urls["regular"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            
            photoImageView.sd_setImage(with: url, completed: nil)
            
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
    }
    
    
    private func updateSelectedState () {
        photoImageView.alpha = isSelected ? 0.7 : 1
        checkmark.alpha = isSelected ? 1 : 0
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        setupPhotoImageView()
        setupCheckMarkView()
        updateSelectedState()
    }
    
    
    private func setupPhotoImageView () {
        
        addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    private func setupCheckMarkView () {
        
        addSubview(checkmark)
        checkmark.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -8).isActive = true
        
        checkmark.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor,constant: -8).isActive = true
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
