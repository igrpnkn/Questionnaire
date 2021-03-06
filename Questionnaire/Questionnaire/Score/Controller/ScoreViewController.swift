//
//  ScoreViewController.swift
//  Questionnaire
//
//  Created by Игорь Пенкин on 23.02.2021.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var scoreTable: UITableView!
    
    let cellIdentifier = "scoreCell"
    var scoreData: [Score] = Game.shared.getScores()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreTable.delegate = self
        scoreTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        self.scoreData = Game.shared.deleteScores()
        scoreTable.reloadData()
    }
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ScoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ScoreTableViewCell
        var content = cell.defaultContentConfiguration()
        content.text = "\(scoreData[indexPath.row].accuracity * 100) % progress"
        content.secondaryText = "\(scoreData[indexPath.row].date)"
        content.image = UIImage(systemName: "person.circle")
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
}
