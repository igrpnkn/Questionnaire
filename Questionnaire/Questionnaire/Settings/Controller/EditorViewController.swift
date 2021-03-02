//
//  EditorViewController.swift
//  Questionnaire
//
//  Created by developer on 02.03.2021.
//

import UIKit

class EditorViewController: UIViewController {

    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var optionZero: UITextField!
    @IBOutlet weak var optionOne: UITextField!
    @IBOutlet weak var optionTwo: UITextField!
    @IBOutlet weak var optionThree: UITextField!
    @IBOutlet weak var answerMark: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let question = questionField.text,
              !question.isEmpty,
              let optionZero = optionZero.text,
              !optionZero.isEmpty,
              let optionOne = optionOne.text,
              !optionOne.isEmpty,
              let optionTwo = optionTwo.text,
              !optionTwo.isEmpty,
              let optionThree = optionThree.text,
              !optionThree.isEmpty
        else {
            let alert = UIAlertController(title: "Warning", message: "All input fields are required! Try again.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        var options: [String] = []
        options.append(optionZero)
        options.append(optionOne)
        options.append(optionTwo)
        options.append(optionThree)

        let builder = QuestionBuilder()
        builder.setQuestion(question: question)
        builder.setAnswer(index: answerMark.selectedSegmentIndex)
        builder.setOptions(options: options)
        
        let addedQuestion = builder.build()
        
        let caretaker = QuestionCaretaker()
        caretaker.saveQuestion(question: addedQuestion)
        /*
        var storedQuestion = caretaker.retrieveQuestions()
        print("\nINFO: Stored:\n\(storedQuestion)")
        
        caretaker.deleteQuestions()
        storedQuestion = caretaker.retrieveQuestions()
        print("\nINFO: Stored after deletion:\n\(storedQuestion)")
        */
        clearInputIfSuccess()
    }
    
    private func clearInputIfSuccess() {
        let alert = UIAlertController(title: "Success", message: "Your question is saved successfully", preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] _ in
            self?.questionField.text = ""
            self?.optionZero.text = ""
            self?.optionOne.text = ""
            self?.optionTwo.text = ""
            self?.optionThree.text = ""
            self?.answerMark.selectedSegmentIndex = 0
        })
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }

}
