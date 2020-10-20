//
//  HomeCell.swift
//  sixmin
//
//  Created by tuan.nguyenv on 10/14/20.
//

import SwiftUI

struct HomeCell: View {
    let article : Article
    var body: some View {
        HStack{
            ImageFromURL(url: article.urlToImage ?? "")
            VStack(alignment: .leading){
                Text(article.title ?? "")
                    .font(.title3)
                Text(article.content ?? "")
                    .font(.subheadline)
                    .truncationMode(.tail)
                    .lineLimit(3)
            }
        }
    }
}

struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        let article = Article(source: Source(id: "aa", name: "bb"), author: "bbcc", title: "aabb", description: "aabbcc", url: "", urlToImage: "", publishedAt: "", content: "")
        HomeCell(article: article)
    }
}
