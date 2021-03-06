//
//  QuestionBuilder.swift
//  Questionnaire
//
//  Created by developer on 02.03.2021.
//

import Foundation

struct Question: Codable {
    var question: String
    var answerIndex: Int
    var options: [String]
}

class QuestionBuilder {
    
    private var question: String
    private var answerIndex: Int
    private var options: [String]
    
    public init() {
        self.question = ""
        self.answerIndex = 0
        self.options = []
    }
    
    public func build() -> Question {
        let newQuestion = Question(question: question, answerIndex: answerIndex, options: options)
        return newQuestion
    }
    
    public func setQuestion(question: String) {
        self.question = question
    }
    
    public func setOptions(options: [String]) {
        self.options = options
    }
    
    public func setAnswer(index: Int) {
        self.answerIndex = index
    }
    
}
