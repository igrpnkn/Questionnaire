//
//  QuestionProvider.swift
//  Questionnaire
//
//  Created by Игорь Пенкин on 22.02.2021.
//

import Foundation

struct Question {
    var question: String
    var answerIndex: Int
    var options: [String]
}

final class QuestionProvider {
    
    public static let shared = QuestionProvider()
    
    private var questions: [Question] = []
    
    private init() {
        questions = [
            Question(question: "Как характеризуют человека, одетого во всё новое?", answerIndex: 0, options: [
                        "Одет с иголочки",
                        "Одет с наперсточка",
                        "Одет с булавочки",
                        "Одет с ниточки"]),
            Question(question: "Из чего сделаны ядра орехов, которые грызёт белка в Сказке о царе Салтане?", answerIndex: 1, options: [
                        "Янтарь",
                        "Изумруд",
                        "Рубин",
                        "Гранит"]),
            Question(question: "Кто занимался подготовкой волокна к прядению?", answerIndex: 3, options: [
                        "Болтун",
                        "Фразер",
                        "Балабол",
                        "Трепач"]),
            Question(question: "Как жители Лондона прозвали свой метрополитен?", answerIndex: 0, options: [
                        "Труба",
                        "Червяк",
                        "Горло",
                        "Вена"]),
            Question(question: "Где изображён герб на 10-рублёвой монете?", answerIndex: 3, options: [
                        "На грунте",
                        "На канте",
                        "На реверсе",
                        "На аверсе"]),
            Question(question: "Кто не играл в кино сотрудника МУРа Владимира Шарапова?", answerIndex: 1, options: [
                        "Владимир Конкин",
                        "Алексей Баталов",
                        "Георгий Жженов",
                        "Сергей Шакуров"]),
            Question(question: "Что с 1714 года Пётр I запретил делать во всех российских городах, кроме Санкт-Петербурга?", answerIndex: 2, options: [
                        "Устраивать балы",
                        "Ездить в каретах",
                        "Строить каменные дома",
                        "Казнить купцов"])
        ]
    }
    
    public func getRandomized() -> [Question] {
        var randomizedQuestions: [Question] = []
        while !questions.isEmpty {
            let randomIndex = Int.random(in: 0..<questions.count)
            let question = questions.remove(at: randomIndex)
            randomizedQuestions.append(question)
        }
        self.questions = randomizedQuestions
        return self.questions
    }
    
}
