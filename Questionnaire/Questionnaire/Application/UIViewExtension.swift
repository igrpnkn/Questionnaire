//
//  UIViewExtension.swift
//  Questionnaire
//
//  Created by Игорь Пенкин on 02.03.2021.
//

import Foundation
import UIKit

extension UIView {
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        addGestureRecognizer(tapGesture)
    }
    
}
