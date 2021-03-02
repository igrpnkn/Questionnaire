//
//  QuestionProvider.swift
//  Questionnaire
//
//  Created by Игорь Пенкин on 22.02.2021.
//

import Foundation

enum QuestionOrder: String {
    case serial, random
}

protocol QuestionStrategy {
    func getQuestions(for questions: [Question]) -> [Question]
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
                        "Одет с ниточки"]), /*
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
                        "Казнить купцов"]),
            Question(question: "Как звали первого человека вышедшего в открытый космос?", answerIndex: 1, options: [
                        "Юрий Гагарин",
                        "Алексей Леонов",
                        "Нил Армстронг",
                        "Валентина Терешкова"]),
            Question(question: "Что означает буква R на рычаге коробки передач в автомобиле?", answerIndex: 2, options: [
                        "Ракета",
                        "Руками не трогать",
                        "Реверс",
                        "Разворот"]), */
            Question(question: "Чему равняется длина удава в попугаях?", answerIndex: 3, options: [
                        "28 попугаев",
                        "31 попугай",
                        "33 попугая",
                        "38 попугаев"])
        ]
    }
    
    public func countQuestions() -> Int {
        return questions.count
    }
    
    public func getQuestions(with strategy: QuestionOrder) -> [Question] {
        let questionsPack = appendCustomQuestions(to: self.questions)
        switch strategy {
        case .serial:
            return QuestionStrategySerial().getQuestions(for: questionsPack)
        case .random:
            return QuestionStrategyRandom().getQuestions(for: questionsPack)
        }
    }
    
    private func appendCustomQuestions(to questions: [Question]) -> [Question] {
        var fulfilleduestions = questions
        let caretaker = QuestionCaretaker()
        let customQuestions = caretaker.retrieveQuestions()
        fulfilleduestions.append(contentsOf: customQuestions)
        return fulfilleduestions
    }
    
}
