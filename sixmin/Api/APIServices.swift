

import Foundation
import Combine
//https://newsapi.org/v2/top-headlines?country=us&apiKey=15aea5edc0944e75910d5a2cfb35dfec
//https://newsapi.org/v2/everything?q=bitcoin&apiKey=15aea5edc0944e75910d5a2cfb35dfec
//https://newsapi.org/v2/sources?apiKey=15aea5edc0944e75910d5a2cfb35dfec

class ApiServices {
    private static let apiKey = "15aea5edc0944e75910d5a2cfb35dfec"
    private static let baseAPI = "https://newsapi.org/v2/"
    
    private static let sessionProcessingQueue = DispatchQueue(label: "sixmin.queue")
    
    enum path : String {
        case topHeadLines = "top-headlines"
        case everything = "everything"
        case sources = "sources"
        
        var url: URL  {
            return URL(string: "\(ApiServices.baseAPI)\(self.rawValue)?country=us&apiKey=\(ApiServices.apiKey)")!
        }
    }
    
    private static let session = URLSession(configuration: URLSessionConfiguration.default)
    
}
extension ApiServices{
     func fetch<T: Decodable>(path: ApiServices.path) -> AnyPublisher<T, Error>{
          return ApiServices.session.dataTaskPublisher(for: path.url)
            .receive(on: RunLoop.main)
            .subscribe(on: Self.sessionProcessingQueue)
            .map( {return $0.data})
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            
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
struct Source: Decodable {
    let id: String?
    let name : String?
    
}
    let id = UUID()
    let source : Article.Source
    let author: String?
    let title: String?
    let description: String?
    let url : String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
}




struct Source: Codable {
    let sources: [SourceElement]

    // MARK: - SourceElement
struct SourceElement: Codable {
    let id, name, sourceDescription: String
    let url: String
    let category: Category
    let language, country: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case sourceDescription = "description"
        case url, category, language, country
    }
}

enum Category: String, Codable {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
}

}

