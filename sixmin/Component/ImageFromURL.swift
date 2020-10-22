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
    private let placeHolderImage = UIImage(named: "bg")
    
    init(url: String) {
        loader = ImageLoader(urlString: url)
    }
    
    var body: some View {
        Image(uiImage: (loader.image ?? UIImage(named: "bg"))!)
            .resizable()
            .aspectRatio(contentMode: .fit)
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
//        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                let screenWidth = UIScreen.main.bounds.size.width
                let image  = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
                //            ImageCache.save(url: urlString, data: image)
            }
            task.resume()
//        }
    }
}
extension UIImage {
    func scaledDown(into size:CGSize, centered:Bool = false) -> UIImage {
        var (targetWidth, targetHeight) = (self.size.width, self.size.height)
        var (scaleW, scaleH) = (1 as CGFloat, 1 as CGFloat)
        if targetWidth > size.width {
            scaleW = size.width/targetWidth
        }
        if targetHeight > size.height {
            scaleH = size.height/targetHeight
        }
        let scale = min(scaleW,scaleH)
        targetWidth *= scale; targetHeight *= scale
        let sz = CGSize(width:targetWidth, height:targetHeight)
        if !centered {
            return UIGraphicsImageRenderer(size:sz).image { _ in
                self.draw(in:CGRect(origin:.zero, size:sz))
            }
        }
        let x = (size.width - targetWidth)/2
        let y = (size.height - targetHeight)/2
        let origin = CGPoint(x:x,y:y)
        return UIGraphicsImageRenderer(size:size).image { _ in
            self.draw(in:CGRect(origin:origin, size:sz))
        }
    }
}
