//
//  Game.swift
//  Questionnaire
//
//  Created by Игорь Пенкин on 23.02.2021.
//

import Foundation

class Game {
    
    public static let shared = Game()
    
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
    
    public func startGame(gameSession: GameSession) {
        self.gameSession = gameSession
    }
    
    public func stopGame() {
        self.gameSession = nil
    }
    
    public func ensureStatistic() {
        let accuracity = Double(gameSession?.askedQuestions ?? 0)/Double(gameSession?.totalQuestions ?? 1)
        let date = Date()
        let score = Score(date: date, accuracity: accuracity)
        statistics.insert(score, at: 0)
    }
    
    public func getScores() -> [Score] {
        return self.statistics
    }

}
