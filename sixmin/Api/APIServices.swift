//
//  APIServices.swift
//  sixmin
//
//  Created by tuan.nguyenv on 10/15/20.
//

import Foundation
//https://newsapi.org/v2/top-headlines?country=us&apiKey=15aea5edc0944e75910d5a2cfb35dfec
//https://newsapi.org/v2/everything?q=bitcoin&apiKey=15aea5edc0944e75910d5a2cfb35dfec
//https://newsapi.org/v2/sources?apiKey=15aea5edc0944e75910d5a2cfb35dfec

class ApiServices {
    private static let apiKey = "15aea5edc0944e75910d5a2cfb35dfec"
    private let baseAPI = "https://newsapi.org/v2/"
    
    enum path : String {
        case topHeadLines = "top-headlines"
        case everything = "everything"
        case sources = "sources"
    }
    
    private static let session = URLSession(configuration: URLSessionConfiguration.default)
    
}
extension ApiServices{
    static func getTopHeadLines( completion: @escaping ([Article]) -> Void){
        let url  = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=15aea5edc0944e75910d5a2cfb35dfec")
        let task  = session.dataTask(with: url!) { (data, response, error) in
            
            if let error = error {
                
            }
            else if let reponse = response {
                
            }
            if let data = data {
                let article = try! JSONDecoder().decode(Articles.self, from: data)
                completion(article.articles)
            }
        }
        task.resume()
    
    }
    static func getEveryThing(){
        
    }
    static func getSources(){
        
    }
}

struct Articles: Decodable {
    let articles : [Article]
}
struct Article: Decodable , Identifiable{
    let id = UUID()
    let source : Source
    let author: String?
    let title: String?
    let description: String?
    let url : String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Decodable {
    let id: String?
    let name : String?
    
}
