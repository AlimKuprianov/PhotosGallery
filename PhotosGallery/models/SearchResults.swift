//
//  SearchResults.swift
//  PhotosGallery
//
//  Created by Алим Куприянов on 16.10.2020.
//  Copyright © 2020 Алим Куприянов. All rights reserved.
//

import Foundation
import UIKit


struct SearchResults: Decodable {
    
    let total: Int
    let results: [UnsplashPhoto]
    
    
}



struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    
    let urls: [UrlKing.RawValue:String]
    
    
    enum UrlKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
