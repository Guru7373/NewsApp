//
//  RestAPIManager.swift
//  NewsApp
//
//  Created by Karthi CK on 23/02/22.
//

import Foundation

class RestAPIManager: NSObject {
    
    static let shared = RestAPIManager()
    
    private let apiKey = "16beb75d96af4cbda05fcee654f5dc8f"
    private let baseURL = "https://newsapi.org/v2/everything"
    
    func getNewsArticles(input: NewsArticleModal.Request, completion: @escaping (Error?, NewsArticleModal.Response?) -> ()) {
        guard let url = URL(string: baseURL + "?q=\(input.query)&apiKey=\(apiKey)") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var json: NewsArticleModal.Response?
            
            if let data = data {
                json = try? JSONDecoder().decode(NewsArticleModal.Response.self, from: data)
            }
            
            completion(error, json)
        }.resume()
        
    }
    
}
