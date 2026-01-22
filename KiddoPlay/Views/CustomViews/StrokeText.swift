//
//  StrokeText.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 16/01/2026.
//

import SwiftUI

struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}

#Preview {
    StrokeText(text: "Sample Text", width: 0.5, color: .red)
        .foregroundColor(.black)
        .font(.system(size: 12, weight: .bold))
}
