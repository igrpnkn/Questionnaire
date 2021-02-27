//
//  GameSession.swift
//  Questionnaire
//
//  Created by Игорь Пенкин on 23.02.2021.
//

import Foundation

class GameSession {
    
    var dateStart: Date?
    var totalQuestions: Int?
    var askedQuestions: Int?
    var isDropHalfUsed: Bool?
    var isCallFriendUsed: Bool?
    var isGroupHelpUsed: Bool?
    
    public init() {
    }
    
    public init(total: Int) {
        self.dateStart = Date()
        self.totalQuestions = total
        self.askedQuestions = 0
        self.isDropHalfUsed = false
        self.isGroupHelpUsed = false
        self.isCallFriendUsed = false
    }
    
    func updateGameSession(asked: Int, dropUsed: Bool, callUsed: Bool, groupUsed: Bool) {
        self.askedQuestions = asked
        self.isDropHalfUsed = dropUsed
        self.isCallFriendUsed = callUsed
        self.isGroupHelpUsed = groupUsed
        print("\nINFO: GameSession has been updated with answered Q: \(askedQuestions!)")
    }
    
}
