//
//  NetworkDataFetcher.swift
//  PhotosGallery
//
//  Created by Алим Куприянов on 16.10.2020.
//  Copyright © 2020 Алим Куприянов. All rights reserved.
//

import Foundation
import UIKit


class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    func fetchImages(searchTerm: String, completion: @escaping(SearchResults?)-> () ) {
        
        networkService.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("error recieved requesting data\(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJson(type: SearchResults.self, from: data)
            completion(decode)
            
        }
    }
    
    func decodeJson <T:Decodable>(type: T.Type, from: Data?) ->T? {
        let decoder = JSONDecoder()
        
        guard let data = from else {return nil}
        
        
        do{
            let obj = try decoder.decode(type.self, from: data)
            return obj
        } catch let jsonError   {
            print("failed to decode JSON",jsonError)
            return nil
        }
    }
}
