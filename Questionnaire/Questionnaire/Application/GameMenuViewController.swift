//
//  GameMenuViewController.swift
//  Questionnaire
//
//  Created by Игорь Пенкин on 22.02.2021.
//

import UIKit

final class GameMenuViewController: UIViewController {

    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var previousResult: UILabel!
    
    var gameSession: GameSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previousResult.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newGamePressed(_ sender: Any) {
        gameSession = GameSession(total: QuestionProvider.shared.countQuestions())
        Game.shared.startGame(gameSession: gameSession ?? GameSession())
        guard let newGameVC = storyboard?.instantiateViewController(identifier: "GameViewController") as? GameViewController else { return }
        newGameVC.modalTransitionStyle = .flipHorizontal
        newGameVC.modalPresentationStyle = .fullScreen
        newGameVC.delegate = self
        self.present(newGameVC, animated: true, completion: nil)
    }
    
    @IBAction func viewScorePressed(_ sender: Any) {
        guard let scoreListVC = storyboard?.instantiateViewController(identifier: "ScoreViewController") as? ScoreViewController else { return }
        scoreListVC.modalPresentationStyle = .formSheet
        self.present(scoreListVC, animated: true, completion: nil)
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        guard let settingsVC = storyboard?.instantiateViewController(identifier: "SettingsViewController") as? SettingsViewController else {
            return
        }
        settingsVC.modalPresentationStyle = .formSheet
        self.present(settingsVC, animated: true, completion: nil)
    }
    
}

extension GameMenuViewController: GameDelegate {
    
    func snapshot(questionNumber: Int, isDropHalfUsed: Bool, isCallFriendUsed: Bool, isGroupHelpUsed: Bool) {
        previousResult.text = "Previous result: \(questionNumber)"
        previousResult.isHidden = false
        gameSession?.updateGameSession(asked: questionNumber, dropUsed: isDropHalfUsed, callUsed: isCallFriendUsed, groupUsed: isGroupHelpUsed)
        Game.shared.ensureStatistic()
        Game.shared.stopGame()
    }
    
}
