//
//  QuestionCaretaker.swift
//  Questionnaire
//
//  Created by developer on 02.03.2021.
//

import Foundation

final class QuestionCaretaker {
    
    private var encoder = JSONEncoder()
    private var decoder = JSONDecoder()
    
    private let key = "questions"
    
    func saveQuestion(question: Question) {
        do {
            var storedData = self.retrieveQuestions()
            storedData.append(question)
            let data = try self.encoder.encode(storedData)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveQuestions() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([Question].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
    func deleteQuestions() {
        UserDefaults.standard.setValue(nil, forKey: key)
    }
    
}
