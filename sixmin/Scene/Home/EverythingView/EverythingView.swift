
import SwiftUI

struct EverythingView: View {
    @ObservedObject var viewModel : EverythingViewModel
    
    init(model: EverythingViewModel) {
        self.viewModel = model
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(self.viewModel.itemValues){ article in
                    ZStack {
                        HomeCell(model: article)
                            .padding(.top, 10)
                        NavigationLink(destination: WebPage(viewModel: ViewModel(url: article.url))) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }.animation(nil)
                }
            }
            .navigationTitle(Text(viewModel.path.rawValue))
        }
        .onAppear(perform: {
            viewModel.fetch()
        })
        
    }
}

import Combine
class EverythingViewModel: ObservableObject {
    
    @Published var itemValues : [Everything.Article] = []
    
    var disposables: Set<AnyCancellable> = Set<AnyCancellable>()

    var service: ApiServices
    var path: ApiServices.path

    init(path: ApiServices.path, service: ApiServices = ApiServices()) {
        self.path = path
        self.service = service
    }
    
    func fetch() {
        service.fetch(path: path).sink { (completion) in
            switch completion {
            case .failure(let error):
                print(error)
            case.finished:
                break
            }
        } receiveValue: { [weak self] (articles: Everything) in
            self?.itemValues = articles.articles
        }
        .store(in: &disposables)
    }
}


struct Everything: Codable {
    let articles: [Article]
    // MARK: - Article
    struct Article: Codable {
        let source: Source
        let author: String?
        let title, articleDescription: String
        let url: String
        let urlToImage: String?
        let publishedAt: String?
        let content: String

        enum CodingKeys: String, CodingKey {
            case source, author, title
            case articleDescription = "description"
            case url, urlToImage, publishedAt, content
        }
    }

    // MARK: - Source
    struct Source: Codable {
        let id: String?
        let name: String
    }

}

extension Everything.Article : CellModel {
    var cellTitle: String {
        title
    }
    
    var cellURLToImage: String? {
        urlToImage
    }
    
    var cellContent: String {
        content
    }
}
extension Everything.Article : Identifiable {
    var id: UUID {UUID()}
}
