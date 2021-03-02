//
//  GameSession.swift
//  Questionnaire
//
//  Created by Игорь Пенкин on 23.02.2021.
//

import Foundation

class GameSession {
    
    var dateStart: Date?
    //var totalQuestions: Int?
    var askedQuestions: Int?
    var isDropHalfUsed: Bool?
    var isCallFriendUsed: Bool?
    var isGroupHelpUsed: Bool?
    
    private var questionOrder: QuestionOrder {
        if let order = UserDefaults.standard.object(forKey: Game.shared.orderKey) as? QuestionOrder.RawValue {
            return QuestionOrder.init(rawValue: order)!
        } else {
            return .serial
        }
    }
    
    public init() {
        self.dateStart = Date()
        self.askedQuestions = 0
        self.isDropHalfUsed = false
        self.isGroupHelpUsed = false
        self.isCallFriendUsed = false
    }
    
    public func getQuestionOrder() -> QuestionOrder {
        return self.questionOrder
    }
    
    public func updateGameSession(asked: Int, dropUsed: Bool, callUsed: Bool, groupUsed: Bool) {
        self.askedQuestions = asked
        self.isDropHalfUsed = dropUsed
        self.isCallFriendUsed = callUsed
        self.isGroupHelpUsed = groupUsed
        print("\nINFO: GameSession has been updated with answered Q: \(askedQuestions!)")
    }
    
}
