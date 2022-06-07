//
//  DiceView.swift
//  RollDice
//
//  Created by Alex Liou on 6/4/22.
//

import SwiftUI

class DiceViewModel: ObservableObject {
    
}

struct DiceView: View {
    @ObservedObject var vm = DiceViewModel()
    let dice: Dice
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style:.continuous)
                .stroke(Color.black, lineWidth: 2)
                .shadow(radius: 10)
            Text(String(dice.high))
                .font(.title)
        }
        .frame(width: 90, height: 90)
        .padding(5)
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(dice: Dice.example)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
