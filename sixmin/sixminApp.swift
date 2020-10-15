//
//  sixminApp.swift
//  sixmin
//
//  Created by tuan.nguyenv on 10/14/20.
//

import SwiftUI

@main
struct sixminApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(lessons: lessons)
        }
    }
}

struct sixminApp_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(lessons: lessons)
    }
}
