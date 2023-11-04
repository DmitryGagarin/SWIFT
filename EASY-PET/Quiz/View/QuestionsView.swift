//
//  QuestionsView.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 04.11.2023.
//
//  This view shows screen after start button was tapped
//  Responsible for showing title, questions, answers and next question button

import SwiftUI
import FirebaseFirestore

struct QuestionsView: View {
    
    var info: Info // creates object info of type Info
    @State var questions: [Question] // creates object questions of type [Question]
    var onFinish: () -> ()
    @Environment(\.dismiss) private var dismiss // creates workable xmark
    @State private var progress: CGFloat = 0 // responsible for progress line at the top
    @State private var currentIndex: Int = 0 // responsible for question number
    @State private var score: CGFloat = 0
    @State private var showScoreView: Bool = false // responsible for showing ScoreView at the end of the quiz
    
    var body: some View {
        VStack {
            dismissButton
            
            Text(info.title)
                .font(.title)
                .fontWeight(.semibold)
            
            progressBar
            
            showQuestionsView()
            
            Spacer()
            
            customButtonView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill the entire screen
        .background(Color("BG"))
        .environment(\.colorScheme, .dark)
        .fullScreenCover(isPresented: $showScoreView) {
            ScoreCardView(score: score / CGFloat(questions.count) * 100) {
                dismiss()
                onFinish()
            }
        }
    }
    
    private var dismissButton: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
            }
            Spacer()
        }
    }
    
    private var progressBar: some View {
        GeometryReader {
            let size = $0.size
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.black.opacity(0.2))
                Rectangle()
                    .fill(Color("Progress"))
                    .frame(width: progress * size.width, alignment: .leading)
            }
            .clipShape(Capsule())
        }
        .frame(height: 5)
        .padding(.top, 5)
    }
    
    private func showQuestionsView() -> some View {
        VStack {
            if questions.isEmpty {
                Text("No questions available")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
            } else {
                showQuestionCards()
            }
        }
    }
    
    private func showQuestionCards() -> some View {
        GeometryReader {
            _ in
            ForEach(questions.indices, id: \.self) { index in
                if currentIndex == index {
                    QuestionView(questions[currentIndex])
                        .transition(.asymmetric(insertion: .push(from: .bottom), removal: .move(edge: .leading)))
                }
            }
        }
        .padding(.vertical, 15)
    }
    
    private func customButtonView() -> some View {
        VStack {
            CustomButton(title: currentIndex == (questions.count - 1) ? "Finish" : "Next") {
                if currentIndex == (questions.count - 1) {
                    showScoreView.toggle()
                } else {
                    withAnimation(.easeInOut) {
                        currentIndex += 1
                        progress = CGFloat(currentIndex) / CGFloat(questions.count - 1)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func QuestionView(_ question: Question) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            showQuestionName(question)
            VStack(spacing: 12) {
                showOptionsInTheCard(question)
            }
        }
        .padding(15)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
        }
        .padding(.horizontal, 15)
    }
    
    private func showQuestionName(_ question: Question) -> some View {
        VStack {
            Text("Question \(currentIndex + 1)/\(questions.count)")
                .font(.callout)
                .foregroundColor(.gray)
            Text(question.question)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.black)
        }
    }
    
    private func showOptionsInTheCard(_ question: Question) -> some View {
        VStack {
            ForEach(question.option, id: \.self) {option in
                showOptionView(question, option)
                .contentShape(Rectangle())
                .onTapGesture {
                    checkOptionIsCorrect(question, option)
                }
            }
        }
    }
    
    private func showOptionView(_ question: Question, _ option: String) -> some View {
        ZStack {
            OptionView(option, .gray)
                .opacity(question.answer == option && question.tappedAnswer != "" ? 0 : 1)
            OptionView(option, .green)
                .opacity(question.answer == option && question.tappedAnswer != "" ? 1 : 0)
            OptionView(option, .red)
                .opacity(question.tappedAnswer == option && question.tappedAnswer != question.answer ? 1 : 0)
        }
    }
    
    private func checkOptionIsCorrect(_ question: Question, _ option: String) {
        guard questions[currentIndex].tappedAnswer == "" else {return}
        withAnimation(.easeInOut){
            questions[currentIndex].tappedAnswer = option
            if question.answer == option {
                score += 1
            }
        }
    }
    
    @ViewBuilder
    func OptionView(_ option: String, _ tint: Color) -> some View {
        Text(option)
            .foregroundColor(tint)
            .padding(.horizontal, 15)
            .padding(.vertical, 20)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(tint.opacity(0.15))
                    .background {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(tint, lineWidth: 2)
                    }
            }
    }
}

struct ScoreCardView: View {
    var score: CGFloat
    var onDismiss: ()->()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            showScoreView
                .foregroundColor(.black)
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
                .background {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(.white)
                }
        }
        CustomButton(title: "Back to Home") {
            Firestore.firestore().collection("Quiz").document("Info").updateData(["peopleAttended" : FieldValue.increment(1.0)])
            onDismiss()
            dismiss()
        }
        .padding(15)
        .background {
            Color("BG")
                .ignoresSafeArea()
        }
    }
    
    private var showScoreView: some View {
        VStack(spacing: 15) {
            Text("Results")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            VStack(spacing: 15) {
                Text("GRATZ")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Text(String(format: "%.0f", score) + "%")
                    .font(.title.bold())
                    .padding(.bottom, 10)
                Image("medal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
            }
        }
    }
}

#Preview {
    ContentView()
}
