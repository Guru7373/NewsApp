//
//  NewsArticleModal.swift
//  NewsApp
//
//  Created by Karthi CK on 23/02/22.
//

import Foundation

struct NewsArticleModal {
    
    struct Request {
        let query: String
    }
    
    struct Response: Codable {
        let articles: [Articles?]?
    }
    
    struct Articles: Codable {
        let title: String?
        let description: String?
    }
}


