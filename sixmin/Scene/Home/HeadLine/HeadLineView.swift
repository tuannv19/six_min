
import SwiftUI

struct HeadLineView: View {
    @ObservedObject var viewModel : HeadLineViewModel
    
    init(model: HeadLineViewModel) {
        self.viewModel = model
    }
    
    var body: some View {
        VStack {
            List{
                ForEach(self.viewModel.itemValues){ article in
                    ZStack {
                        HomeCell(model: article)
                            .padding(.top, 10)
                        NavigationLink(destination: WebPage(viewModel: ViewModel(url: article.url!))) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }.animation(nil)
                    .id(UUID())
                }
            }
            .navigationTitle(Text(viewModel.path.rawValue))
        }
        .onAppear(perform: {
            viewModel.fetch()
        })
        .overlay(
            Group {
                if viewModel.isLoading {
                    ZStack {
                        Text("")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(.systemBackground))
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                }
                else {
                    EmptyView()
                }
            })
        
        
    }
}

import Combine
class HeadLineViewModel: ObservableObject {
    
    @Published var itemValues : [Article] = []
    @Published var isLoading : Bool = false
    
    var disposables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    var service: ApiServices
    var path: ApiServices.path
    
    init(path: ApiServices.path, service: ApiServices = ApiServices()) {
        self.path = path
        self.service = service
    }
    
    func fetch() {
        isLoading = true
        service.fetch(path: path).sink { (completion) in
            switch completion {
            case .failure(let error):
                print(error)
            case.finished:
                break
            }
        } receiveValue: { [weak self] (articles: Articles) in
            self?.itemValues = articles.articles
            self?.isLoading = false
        }
        .store(in: &disposables)
    }
}
