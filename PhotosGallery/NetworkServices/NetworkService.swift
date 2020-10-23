//
//  NetworkService.swift
//  PhotosGallery
//
//  Created by Алим Куприянов on 22.09.2020.
//  Copyright © 2020 Алим Куприянов. All rights reserved.
//

import Foundation
import UIKit

class NetworkService {
    
    //построение запроса данных по URL
    func request (searchTerm:String, completion: @escaping (Data?, Error?)  -> Void) {
        
        
        let parametrs = self.prepareParams(searchTerm: searchTerm)
        let url = self.url(params: parametrs)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        return
    }
    
    private func prepareHeader () -> [String:String]? {
        var headers = [String:String]()
        headers["Authorization"] = "Client-ID skcbKmcP1Oy0KVHZJel_aqU9sQfRmoiKqMqVGrMOv88"
        return headers
    }
    
    
    
    
    private func prepareParams(searchTerm: String?) -> [String:String] {
        
        var parameters = [String:String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        
        return parameters
        
    }
    
    
    private func url(params:[String:String]) -> URL {
        
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "api.unsplash.com"
        comp.path = "/search/photos"
        comp.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return comp.url!
        
    }
    
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data,error)
            }
            
        }
    }
}

