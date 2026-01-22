//
//  HomeListItemView.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 16/01/2026.
//

import SwiftUI

struct HomeListItemView: View {
    let item: HomeCategory

    var body: some View {
        HStack{
            StrokeText(text: item.title, width: 1, color: .black)
                .foregroundColor(.white)
                .font(.system(size: 28, weight: .bold, design: .rounded))

            Spacer()
            Image(item.imageName)
        }
        .padding(.vertical,16)
        .padding(.horizontal,30)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(item.colorName))
        )
    }
}

#Preview {
    HomeListItemView(item: HomeCategory(title: "NUMBERS", imageName: "numbersImg", colorName: "Green"))
}
