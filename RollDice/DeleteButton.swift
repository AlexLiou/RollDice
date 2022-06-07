//
//  DeleteButton.swift
//  RollDice
//
//  Created by Alex Liou on 6/6/22.
//

import SwiftUI

struct DeleteButton: View {
    @State private var isShowingRemove: Bool = false
    
    var body: some View {
        Button("Remove All", role: .destructive) {
            isShowingRemove = true
        }
        .confirmationDialog("Remove All?", isPresented: $isShowingRemove) {
            Button("Delete all items?", role: .destructive) {
                
            }
        }
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton()
    }
}
