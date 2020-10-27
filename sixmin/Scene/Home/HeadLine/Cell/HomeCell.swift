
import SwiftUI
import KingfisherSwiftUI

struct HomeCell: View {
    let model : CellModel
    var body: some View {
        
        ZStack(alignment: .leading){
            if let url = model.cellURLToImage {
                KFImage(URL(string: url))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5.0)
            }
            
            VStack(alignment: .leading){
                Spacer()
                ZStack(alignment: .bottomLeading) {
                    VStack(alignment: .leading) {
                        Text(model.cellTitle )
                            .font(Font.system(size: 19))
                            .fontWeight(.black)
                            .lineLimit(2)
                            .foregroundColor(.primary)
                        if let content = model.cellContent {
                            Spacer().frame(height: 5)
                            Text(content)
                                .font(Font.system(size: 15))
                                .lineLimit(2)
                                .foregroundColor(.primary)
                        }
                        Spacer().frame(height: 10)
                    }.frame(minWidth: 0, maxWidth: .infinity)
                    .alignmentGuide(.bottom, computeValue: { dimension in
                        dimension[.bottom ]
                    })
                    .background(
                        LinearGradient(gradient:
                                        Gradient(colors:
                                                    [Color.white,
                                                     Color.white.opacity(0.9),
                                                     Color.white.opacity(0.01)]
                                        ),
                                       startPoint: .bottom, endPoint: .top)
                            .padding(EdgeInsets(top: -20, leading: 0, bottom: -1, trailing: 0))
                    )
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
        }
        
    }
}


protocol CellModel {
    var cellTitle: String {get}
    var cellURLToImage: String? {get}
    var cellContent: String {get}
}
