
import SwiftUI

struct MainTab: View {
    var body: some View {
        
        TabView{
            NavigationView{
                HeadLineView(model: HeadLineViewModel(path: ApiServices.path.topHeadLines))
            }
            .tabItem { Text("1").tag(0) }.id(UUID())
            NavigationView{
                HeadLineView(model: HeadLineViewModel(path: ApiServices.path.topHeadLines))
            }
            .tabItem { Text("1").tag(1) }.id(UUID())
            NavigationView{
                HeadLineView(model: HeadLineViewModel(path: ApiServices.path.topHeadLines))
            }
            .tabItem { Text("1").tag(2) }.id(UUID())
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
