//
//  HomeCell.swift
//  sixmin
//
//  Created by tuan.nguyenv on 10/14/20.
//

import SwiftUI

struct HomeCell: View {
    let lesson : Lesson
    var body: some View {
        HStack{
            Image(systemName: "photo")
                .frame(width: 40, height: 40, alignment: .center)
            VStack(alignment: .leading){
                Text(lesson.title)
                    .font(.title3)
                Text(lesson.subTitle)
                    .font(.subheadline)
                    .truncationMode(.tail)
                    .lineLimit(3)
            }
        }
    }
}

struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        let lesson : Lesson = Lesson(image: "", title: "Coronavirus: Dealing with mass unemployment", subTitle: "The coronavirus pandemic has caused millions of people to lose their jobs and forced thousands more temporarily out of work, with no idea if they'll still have a job to go back to. In this programme, we’ll be assessing the post-Covid job landscape and asking")
        HomeCell(lesson: lesson)
    }
}
