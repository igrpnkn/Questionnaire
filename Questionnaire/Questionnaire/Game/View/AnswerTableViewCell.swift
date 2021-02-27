//
//  AnswerTableViewCell.swift
//  Questionnaire
//
//  Created by Игорь Пенкин on 22.02.2021.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var answer: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(logo: UIImage?, answer: String) {
        self.answer.text = answer
        if answer.count == 0 {
            self.logo.isHidden = true
        } else if let image = logo {
            self.logo.isHidden = false
            self.logo.image = image
            self.logo.clipsToBounds = true
            self.logo.layer.cornerRadius = 24
        }
    }
    
}
