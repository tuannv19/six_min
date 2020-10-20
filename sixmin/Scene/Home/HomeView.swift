//
//  HomeView.swift
//  sixmin
//
//  Created by tuan.nguyenv on 10/14/20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel = HomeViewModel()
    var body: some View {
        NavigationView{
            List{
                ForEach(homeViewModel.articles){ article in
                    HomeCell(article: article)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
            .navigationTitle(Text("Why?"))
            
        }
        .onAppear(perform: {
            ApiServices.getTopHeadLines { article in
                DispatchQueue.main.async {
                    self.homeViewModel.articles = article
                }
            }
        })
        
    }
}
class HomeViewModel: ObservableObject {
    @Published var articles : [Article] = []
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
