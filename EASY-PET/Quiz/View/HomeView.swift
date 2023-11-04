//
//  HomeView.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 04.11.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct HomeView: View {
    @State private var quizInfo: Info?
    @State private var questions: [Question] = []
    @State private var startQuiz: Bool = false
    @AppStorage("log_status") private var logStatus: Bool = false
    
    var body: some View {
        if let info = quizInfo {
            VStack(alignment: .leading, spacing: 20) {
                Text(info.title)
                    .font(.title)
                    .fontWeight(.semibold)
                CustomLabel("list.bullet.rectangle.portrait", "\(questions.count)", "Multiple Choice Questions")
                CustomLabel("person", "\(info.peopleAttended)", "Attended the exercise")
                Divider()
               
                if !info.rules.isEmpty {
                    RulesView(info.rules)
                }
                Spacer()
                CustomButton(title: "Start Test", onClick: {
                    startQuiz.toggle()
                })
            }
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .fullScreenCover(isPresented: $startQuiz) {
                QuestionsView(info: info, questions: questions) {
                    quizInfo?.peopleAttended += 1
                }
            }
        } else {
            VStack {
                ProgressView()
                Text("Please wait")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .task {
                do {
                    try await fetchData()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @ViewBuilder
    func RulesView(_ rules: [String]) -> some View {
        VStack (alignment: .leading, spacing: 15) {
            Text("Before you start")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 12)
            ForEach(rules, id: \.self) { rule in
                HStack(alignment: .top, spacing: 10){
                    Circle()
                        .fill(.black)
                        .frame(width: 8, height: 8)
                        .offset(y: 6)
                    Text(rule)
                        .font(.callout)
                        .lineLimit(3)
                }
            }
        }
    }
    
    @ViewBuilder
    func CustomLabel(_ image: String, _ title: String, _ subTitle: String) -> some View {
        HStack (alignment: .top){
            Image(systemName: image)
                .font(.title3)
                .frame(width: 45, height: 45)
                .background {
                    Circle()
                        .fill(.gray.opacity(0.1))
                        .padding(-1)
                        .background {
                            Circle()
                                .stroke(Color("BG"), lineWidth: 1)
                        }
                }
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("BG"))
                Text(subTitle)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }
        }
    }
    
    func fetchData() async throws {
        try await loginUserAnonymous()
        do {
            let documentSnapshot = try await Firestore.firestore().collection("Quiz").document("Info").getDocument()
            if documentSnapshot.exists {
                if let data = documentSnapshot.data() {
                    print(data)
                    self.quizInfo = try? documentSnapshot.data(as: Info.self)
                } else {
                    print("Data is nil.")
                }
            } else {
                print("Document doesn't exist.")
            }
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
        let info = try await Firestore.firestore().collection("Quiz").document("Info").getDocument().data(as: Info.self)
        let questions = try await Firestore.firestore().collection("Quiz").document("Info").collection("Questions").getDocuments().documents
            .compactMap {
                try $0.data(as: Question.self)
            }
        await MainActor.run(body: {
            self.quizInfo = info
            self.questions = questions
        })
    }
    
    func loginUserAnonymous() async throws{
        if !logStatus {
            try await Auth.auth().signInAnonymously()
        }
    }
}

struct CustomButton: View {
    var title: String
    var onClick: () -> ()
    var body: some View {
        HStack {
            Spacer()
            Button {
                onClick()
            } label: {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 15)
                    .padding(.bottom, 10)
                    .foregroundColor(.white)
                    .background {
                        Rectangle()
                            .fill(Color("Pinkie"))
                            .ignoresSafeArea()
                    }
            }
            .padding([.bottom, .horizontal], -15)
            .buttonStyle(PlainButtonStyle())
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
