//
//  QuestionsView.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 04.11.2023.
//

import SwiftUI
import FirebaseFirestore

struct QuestionsView: View {
    var info: Info
    @State var questions: [Question]
    var onFinish: () -> ()
    @Environment(\.dismiss) private var dismiss
    @State private var progress: CGFloat = 0
    @State private var currentIndex: Int = 0
    @State private var score: CGFloat = 0
    @State private var showScoreView: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    // Add action for the "xmark" button
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                }
                Spacer() // Push the "xmark" button to the top-left corner
            }
            Text(info.title)
                .font(.title)
                .fontWeight(.semibold)
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
            
            if questions.isEmpty {
                Text("No questions available")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
            } else {
                GeometryReader {
                    let size = $0.size
                    ForEach(questions.indices, id: \.self) { index in
                        if currentIndex == index {
                            QuestionView(questions[currentIndex])
                                .transition(.asymmetric(insertion: .push(from: .bottom), removal: .move(edge: .leading)))
                        }
                    }
                }
                .padding(.vertical, 15)
            }
            
            Spacer()
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
    
    @ViewBuilder
    func QuestionView(_ question: Question) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Question \(currentIndex + 1)/\(questions.count)")
                .font(.callout)
                .foregroundColor(.gray)
            Text(question.question)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            VStack(spacing: 12) {
                ForEach(question.option, id: \.self) {option in
                    ZStack {
                        OptionView(option, .gray)
                            .opacity(question.answer == option && question.tappedAnswer != "" ? 0 : 1)
                        OptionView(option, .green)
                            .opacity(question.answer == option && question.tappedAnswer != "" ? 1 : 0)
                        OptionView(option, .red)
                            .opacity(question.tappedAnswer == option && question.tappedAnswer != question.answer ? 1 : 0)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        guard questions[currentIndex].tappedAnswer == "" else {return}
                        withAnimation(.easeInOut){
                            questions[currentIndex].tappedAnswer = option
                            if question.answer == option {
                                score += 1
                            }
                        }
                    }
                }
            }
        }
        .padding(15)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
        }
        .padding(.horizontal, 15)
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
        }
        .padding(15)
        .background {
            Color("BG")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
