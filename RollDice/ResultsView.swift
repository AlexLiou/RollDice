//
//  ResultsView.swift
//  RollDice
//
//  Created by Alex Liou on 6/4/22.
//

import SwiftUI

struct ResultsView: View {
    @State var results: Array<Int>
    var body: some View {
        HStack {
            ForEach(0..<results.count, id: \.self) { index in
                Text(String(results[index]))
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                .shadow(radius: 10)
            }
        }
        .padding()
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(results: [1,2,3])
    }
}
