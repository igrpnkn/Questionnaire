//
//  Game.swift
//  Questionnaire
//
//  Created by Игорь Пенкин on 23.02.2021.
//

import Foundation

class Game {
    
    public static let shared = Game()
    
    public var orderKey: String {
        get {
            return "questionOrder"
        }
    }
    
    private var gameSession: GameSession?
    private var statistics: [Score] {
        didSet {
            self.scoreCaretaker.saveScores(scores: statistics)
        }
    }
    
    private let scoreCaretaker = ScoreCaretaker()
    
    private init() {
        self.statistics = self.scoreCaretaker.retrieveScores()
    }
    
    private func informAboutDefault() {
        // There might be some alert here in the future...
    }
    
    public func getQuestions() -> [Question] {
        guard let strategy = self.gameSession?.getQuestionOrder() else {
            informAboutDefault()
            return QuestionProvider.shared.getQuestions(with: .serial)
        }
        return QuestionProvider.shared.getQuestions(with: strategy)
    }
    
    public func startGame(gameSession: GameSession) {
        self.gameSession = gameSession
    }
    
    public func stopGame() {
        self.gameSession = nil
    }
    
    public func ensureStatistic(questionsWas total: Int) {
        guard let askedQuestions = self.gameSession?.askedQuestions else {
            return
        }
        let accuracity = Double(askedQuestions)/Double(total)
        let date = Date()
        let score = Score(date: date, accuracity: accuracity)
        statistics.insert(score, at: 0)
    }
    
    public func getScores() -> [Score] {
        return self.statistics
    }
    
    @discardableResult
    public func deleteScores() -> [Score] {
        self.statistics = []
        return self.statistics
    }

}
