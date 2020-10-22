
import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel : HomeViewModel
    
    init(model: HomeViewModel) {
        self.homeViewModel = model
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(homeViewModel.articles){ article in
                    ZStack {
                        HomeCell(article: article)
                            .padding(.top, 10)
                        NavigationLink(destination: WebPage(viewModel: ViewModel(url: article.url!))) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }.animation(nil)
                }
            }
            .navigationTitle(Text("Headlines"))
        }
        .onAppear(perform: {
            homeViewModel.fetch()
        })
        
    }
}

import Combine
class HomeViewModel: ObservableObject {
    @Published var articles : [Article] = []
    private var disposables = Set<AnyCancellable>()
    
    var path : ApiServices.path
    var service: ApiServices
    
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
        } receiveValue: { (articles: Articles) in
            self.articles = articles.articles
        }
        .store(in: &disposables)
        
        
    }
    
}


