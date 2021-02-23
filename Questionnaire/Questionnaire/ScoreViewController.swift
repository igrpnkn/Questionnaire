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
    var scoreData: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreTable.delegate = self
        scoreTable.dataSource = self
        // Do any additional setup after loading the view.
        for i in 0...20 {
            scoreData.append(i)
        }
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
        content.text = "Result"
        content.secondaryText = String(scoreData[indexPath.row])
        content.image = UIImage(systemName: "person.circle")
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
}
