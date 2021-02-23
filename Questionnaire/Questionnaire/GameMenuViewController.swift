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
    @IBOutlet weak var previousResult: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newGamePressed(_ sender: Any) {
        guard let newGameVC = storyboard?.instantiateViewController(identifier: "GameViewController") as? GameViewController else { return }
        newGameVC.modalTransitionStyle = .flipHorizontal
        newGameVC.modalPresentationStyle = .fullScreen
        self.present(newGameVC, animated: true, completion: nil)
    }
    
    @IBAction func viewScorePressed(_ sender: Any) {
        guard let scoreListVC = storyboard?.instantiateViewController(identifier: "ScoreViewController") as? ScoreViewController else { return }
        scoreListVC.modalPresentationStyle = .formSheet
        self.present(scoreListVC, animated: true, completion: nil)
    }
    
}

extension GameMenuViewController {
    
}
