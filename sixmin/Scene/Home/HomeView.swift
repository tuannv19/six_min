//
//  HomeView.swift
//  sixmin
//
//  Created by tuan.nguyenv on 10/14/20.
//

import SwiftUI

struct HomeView: View {
    let lessons : [Lesson]
    var body: some View {
        NavigationView{
            List(lessons ){ lesson in
                HomeCell(lesson: lesson)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }.frame(minWidth: 0, maxWidth:  .infinity)
            .navigationBarTitle(Text("Why"))
        }
    
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(lessons: lessons)
    }
}

struct Lesson: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let subTitle: String
}
let lessons = [
    Lesson(image: "photo", title:"Coronavirus: Dealing with m unemployment" , subTitle: "The coronavi"),
    Lesson(image: "photo", title:"Coronavirus: Dealing with mass unemployment" , subTitle: "The coronavi"),
    Lesson(image: "photo", title:"Coronavirus: Dealing with mass unemployment" , subTitle: "The coronavi"),
    Lesson(image: "photo", title:"Coronavirus: Dealing with mass unemployment" , subTitle: "The coronavi"),
    Lesson(image: "photo", title:"Coronavirus: Dealing with mass unemployment" , subTitle: "The coronavi"),
    Lesson(image: "photo", title:"Coronavirus: Dealing with mass unemployment" , subTitle: "The coronavi"),
    Lesson(image: "photo", title:"Coronavirus: Dealing with mass unemployment" , subTitle: "The coronavi"),
    Lesson(image: "photo", title:"Coronavirus: Dealing with mass unemployment" , subTitle: "The coronavi"),
    Lesson(image: "photo", title:"Coronavirus: Dealing with mass unemployment" , subTitle: "The coronavi")
    
]

