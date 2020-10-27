
import SwiftUI

struct SourceView: View {
    @ObservedObject var viewModel : SourceViewModel
    
    init(model: SourceViewModel) {
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
class SourceViewModel: ObservableObject {
    
    @Published var itemValues : [Source.SourceElement] = []
    
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
        } receiveValue: { [weak self] (articles: Source) in
            self?.itemValues = articles.sources
        }
        .store(in: &disposables)
    }
}
