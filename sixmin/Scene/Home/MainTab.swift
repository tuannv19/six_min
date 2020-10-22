
import SwiftUI

struct MainTab: View {
    var body: some View {
        TabView{
            HomeView(model: HomeViewModel(path: ApiServices.path.topHeadLines))
                .tabItem { Text("Head lines") }
            HomeView(model: HomeViewModel(path: ApiServices.path.topHeadLines))
                .tabItem { Text("Everything") }
            HomeView(model: HomeViewModel(path: ApiServices.path.topHeadLines))
                .tabItem { Text("Source") }
        }
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab()
    }
}

struct TabItem {
    let name: String
    let path: ApiServices.path
}
