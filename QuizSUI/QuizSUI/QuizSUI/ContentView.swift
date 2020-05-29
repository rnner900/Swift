//
//  ContentView.swift
//  QuizSUI
//
//  Created by Jacob on 23.03.20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import SwiftUI

let questions: [String] = [
    "What is 6x7?",
    "How much wood would a woodchuck chuck?",
    "What is brown and sticky?"
]
let answers: [String] = [
    "42. The Answer to life & universe & everything.",
    "As much as he could.",
    "A stick."
]
var currentQuestionIndex: Int = 0
let hideAnswer = "???"

struct ContentView: View {
    
    @State var question: String
    @State var answer: String
    
    var body: some View {
        VStack(spacing: 20.0) {
            Text(question).animation(.easeInOut(duration: 0.5))
            Button(action: {self.showNextQuestion()}) {
                Text("Next Question")
            }
            
            Text(answer)
            Button(action: {self.answer = answers[currentQuestionIndex]}) {
                Text("Show Answer")
            }
        }
    }
    
    func showNextQuestion() {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        question = questions[currentQuestionIndex]
        answer = hideAnswer
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(question: questions[0], answer: "???")
    }
}
