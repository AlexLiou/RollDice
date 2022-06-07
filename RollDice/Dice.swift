//
//  Dice.swift
//  RollDice
//
//  Created by Alex Liou on 6/4/22.
//

import Foundation

struct Dice: Identifiable, Codable {
    var id = UUID()
    let low: Int
    let high: Int
    
    static let example = Dice(low: 1, high: 6)
    
    func rollDice() -> Int {
        return Int.random(in: low..<high+1)
    }
}

class Dices: ObservableObject {
    static let saveKey = "savedData"
    @Published var results = [Int]()
    
    init() {
        self.results = []
        
        let filename = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        
        do {
            let data = try Data(contentsOf: filename)
            results = try JSONDecoder().decode([Int].self, from: data)
        } catch {
            print("Can't load saved data")
        }
    }
    
    func reset() {
        self.results = []
        
        let filename = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        
        do {
            let data = try Data(contentsOf: filename)
            results = try JSONDecoder().decode([Int].self, from: data)
        } catch {
            print("Can't load saved data")
        }
    }
    
    private func save() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
            let data = try JSONEncoder().encode(results)
            try data.write(to: filename, options: [.atomic, .completeFileProtection])
        } catch {
            print("Can't save data in the documents directory")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func addResult(result: Int) {
        results.append(result)
        if results.count > 8 {
            results.remove(at: 0)
        }
        save()
    }
    
    func clearAll() {
        results.removeAll()
        save()
    }
}

