//
//  GameViewController.swift
//  Questionnaire
//
//  Created by Игорь Пенкин on 22.02.2021.
//

import UIKit

protocol GameDelegate: class {
    
    func snapshot(questionNumber: Int, isDropHalfUsed: Bool, isCallFriendUsed: Bool, isGroupHelpUsed: Bool)
    
}

final class GameViewController: UIViewController {
    
    weak var delegate: GameDelegate?

    @IBOutlet weak var questionTitile: UILabel!
    @IBOutlet weak var questionBody: UITextView! 
    @IBOutlet weak var callFriend: UIButton!
    @IBOutlet weak var groupHelp: UIButton!
    @IBOutlet weak var dropHalf: UIButton!
    @IBOutlet weak var stopGame: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "answerCell"
    
    private var questionnaire = Game.shared.getQuestions()
    private var questionCount: Int = 0
    private var isDropHalfUsed: Bool = false
    private var isCallFriendUsed: Bool = false
    private var isGroupHelpUsed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        ensureQuestion()
    }
    
    private func ensureQuestion() {
        self.questionTitile.text = "Question \(questionCount + 1) of \(questionnaire.count)"
        self.questionBody.text = questionnaire[questionCount].question
        questionBody.textAlignment = .justified
        questionBody.backgroundColor = .systemGray6
        questionBody.clipsToBounds = true
        questionBody.layer.cornerRadius = 10
        questionBody.isUserInteractionEnabled = false
    }

    @IBAction func stopGamePressed(_ sender: Any) {
        let alert = UIAlertController(title: "Are you shure?", message: nil, preferredStyle: .actionSheet)
        let alertContinue = UIAlertAction(title: "Continue", style: .cancel) { [weak self] _ in
        }
        let alertStop = UIAlertAction(title: "Leave", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.snapshot(questionNumber: self.questionCount, isDropHalfUsed: self.isDropHalfUsed, isCallFriendUsed: self.isCallFriendUsed, isGroupHelpUsed: self.isGroupHelpUsed)
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(alertContinue)
        alert.addAction(alertStop)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func callFriendPressed(_ sender: Any) {
        guard isCallFriendUsed == false else {
            return
        }
        var hypothesis: String {
            let randomIndex = Int.random(in: 0...questionnaire[questionCount].options.count)
            if randomIndex == questionnaire[questionCount].options.count {
                return "I don't know :("
            } else {
                return "I think the answer is: \(questionnaire[questionCount].options[randomIndex])"
            }
        }
        let alert = UIAlertController(title: "Friend said:", message: hypothesis, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok, thanks!", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true) {
            self.isCallFriendUsed = true
            self.callFriend.isHidden = true
        }
    }
    
    @IBAction func groupHelpPressed(_ sender: Any) {
        guard isGroupHelpUsed == false else {
            return
        }
        var quote = 100
        let firstPercentage = Int.random(in: 0..<quote)
        quote = quote - firstPercentage
        let secondPercentage = Int.random(in: 0..<quote)
        quote = quote - secondPercentage
        let thirdPercentage = Int.random(in: 0..<quote)
        let fourthPercentage = quote - thirdPercentage
        let message = "AUDIENCE HAS VOTED FOLLOWING\n\n\(questionnaire[questionCount].options[0]) -> \(firstPercentage)\n\(questionnaire[questionCount].options[1]) -> \(secondPercentage)\n\(questionnaire[questionCount].options[2]) -> \(thirdPercentage)\n\(questionnaire[questionCount].options[3]) -> \(fourthPercentage)"
        let alert = UIAlertController(title: "Voices", message: message, preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true) {
            self.isGroupHelpUsed = true
            self.groupHelp.isHidden = true
        }
    }
    
    @IBAction func dropHalfPressed(_ sender: Any) {
        guard isDropHalfUsed == false else {
            return
        }
        var deletions = 0
        var deletedIndex: Int?
        while deletions < 2 {
            let randomIndex = Int.random(in: 0..<questionnaire[questionCount].options.count)
            if randomIndex != questionnaire[questionCount].answerIndex &&
               randomIndex != deletedIndex {
                questionnaire[questionCount].options[randomIndex] = ""
                deletedIndex = randomIndex
                deletions += 1
            }
        }
        isDropHalfUsed = true
        dropHalf.isHidden = true
        tableView.reloadData()
    }
    
    private func didLose() {
        let alert = UIAlertController(title: "WRONG ANSWER", message: "You are fucking loser!", preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "I know :((", style: .cancel) { _ in
            self.delegate?.snapshot(questionNumber: self.questionCount, isDropHalfUsed: self.isDropHalfUsed, isCallFriendUsed: self.isCallFriendUsed, isGroupHelpUsed: self.isGroupHelpUsed)
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func didWin() {
        let alert = UIAlertController(title: "YOU HAVE WON", message: "But you won't get your money :)", preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "Damn it...", style: .cancel) {_ in
            self.delegate?.snapshot(questionNumber: self.questionCount+1, isDropHalfUsed: self.isDropHalfUsed, isCallFriendUsed: self.isCallFriendUsed, isGroupHelpUsed: self.isGroupHelpUsed)
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! AnswerTableViewCell
        let answer = questionnaire[questionCount].options[indexPath.row]
        cell.configureView(logo: UIImage(systemName: "hand.tap"), answer: answer)
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == questionnaire[questionCount].answerIndex {
            if self.questionCount < (questionnaire.count-1) {
                self.questionCount += 1
                ensureQuestion()
                tableView.reloadData()
            } else {
                didWin()
            }
        } else {
            didLose()
        }
    }
    
}
