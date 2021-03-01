//
//  QuestionStrategyRandom.swift
//  Questionnaire
//
//  Created by developer on 01.03.2021.
//

import Foundation

final class QuestionStrategyRandom: QuestionStrategy {
    
    func getQuestions(for questions: [Question]) -> [Question] {
        var questions = questions
        var randomizedQuestions: [Question] = []
        while !questions.isEmpty {
            let randomIndex = Int.random(in: 0..<questions.count)
            let question = questions.remove(at: randomIndex)
            randomizedQuestions.append(question)
        }
        return randomizedQuestions
    }

}
