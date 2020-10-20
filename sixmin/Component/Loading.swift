//
//  Loading.swift
//  sixmin
//
//  Created by tuan.nguyenv on 10/16/20.
//

import SwiftUI

struct Loading: View {
    var body: some View {
        Image("photo")
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}
