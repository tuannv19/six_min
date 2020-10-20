//
//  ImageFromeURL.swift
//  sixmin
//
//  Created by tuan.nguyenv on 10/19/20.
//

import SwiftUI
import Combine

struct ImageFromURL: View {
    @ObservedObject var loader: ImageLoader
    
    init(url: String) {
        loader = ImageLoader(urlString: url)
    }
    
    var body: some View {
        Image(uiImage: loader.image ?? UIImage())
            .frame(width: 40, height: 40, alignment: .center)
            .aspectRatio(contentMode: .fit)
            .clipped()
    }
}

struct ImageFromeURL_Previews: PreviewProvider {
    static var previews: some View {
        ImageFromURL(url: "aaa")
    }
}

class ImageLoader: ObservableObject {
    @Published var image : UIImage?

    init(urlString: String) {
        if let data = ImageCache.imgWith(url: urlString) {
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                ImageCache.save(url: urlString, data: data)
            }
        }
        task.resume()
    }
}
