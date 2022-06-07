//
//  ContentView.swift
//  RollDice
//
//  Created by Alex Liou on 6/4/22.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var dices = Dices()
    @Published var selection = 6
    @Published var display = "?"
    let diceTypes = [4, 6, 8, 10, 12, 20, 100]
    
    func setSelection(index: Int) {
        selection = diceTypes[index]
    }
    
    func rollDisplay() {
        display = String(Int.random(in: 1..<selection+1))
    }
    
    func rollDice() {
        objectWillChange.send()
        let dice = Dice(low: 1, high: selection)
        let result = dice.rollDice()
        print("Rolling \(selection) die: \(result)")
        dices.addResult(result: result)
    }
    
    func clearAll() {
        objectWillChange.send()
        dices.clearAll()
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
}

struct ContentView: View {
    @State private var timeDiceRoll = 1.5
    @State private var isDiceRoll = false
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    @State private var isShowingRemoveAll = false
    @ObservedObject var vm = ContentViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        ForEach(0..<vm.dices.results.count, id: \.self) { index in
                            Text(String(vm.dices.results[index]))
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
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25, style:.continuous)
                            .stroke(Color.black, lineWidth: 2)
                        .shadow(radius: 10)
                        Text(String(vm.display))
                            .font(.largeTitle)
                            .onReceive(timer) { time in
                                guard isDiceRoll else { return }
                                
                                if timeDiceRoll > 0 {
                                    timeDiceRoll -= 0.25
                                    vm.rollDisplay()
                                } else {
                                    timeDiceRoll = 2
                                    isDiceRoll = false
                                    vm.rollDice()
                                    vm.display = "?"
                                }
                            }
                    }
                    .frame(width: 110, height: 110)
                    .padding()
                    
                    HStack {
                        ForEach(0..<vm.diceTypes.count, id: \.self) { index in
                            Button {
                                vm.setSelection(index: index)
                                isDiceRoll = true
                            } label: {
                                DiceView(dice: Dice(low: 1, high: vm.diceTypes[index]))
                            }
                            .onTapGesture(perform: vm.simpleSuccess)
                        }
                    }
                }
            }
            .toolbar {
                Button("Remove All", role: .destructive) {
                    isShowingRemoveAll = true
                }
                .confirmationDialog("Remove All?", isPresented: $isShowingRemoveAll) {
                    Button("Delete all items?", role: .destructive) {
                        vm.clearAll()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
