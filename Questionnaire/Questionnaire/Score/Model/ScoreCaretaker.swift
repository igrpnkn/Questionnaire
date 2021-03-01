//
//  ScoreCaretaker.swift
//  Questionnaire
//
//  Created by Игорь Пенкин on 23.02.2021.
//

import Foundation

class ScoreCaretaker {
    
    private var encoder = JSONEncoder()
    private var decoder = JSONDecoder()
    
    private let key = "scores"
    
    func saveScores(scores: [Score]) {
        do {
            let data = try self.encoder.encode(scores)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveScores() -> [Score] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([Score].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
    func deleteScores() {
        UserDefaults.standard.setValue(nil, forKey: key)
    }
    
}
