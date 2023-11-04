//
//  HomeView.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 04.11.2023.
//
//  View of the main (home) view with information and start option

import SwiftUI
import Firebase
import FirebaseFirestore

struct HomeView: View {
    
    @State private var quizInfo: Info? // create object of optional Info
    @State private var questions: [Question] = [] // crearte object of array of Questions
    @State private var startQuiz: Bool = false // contols whether quiz is started
    @AppStorage("log_status") private var logStatus: Bool = true // checks whether user is logged by reading UserDefaults
    
    var body: some View {
        if let info = quizInfo { // if info is not nil, view is created
            VStack(alignment: .leading, spacing: 20) {
                TopHomeViewInfo(info)
                
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
            downloadingView // if info == nil then i see ProgressView() and try to fetch data again
        }
    }
    
    private func TopHomeViewInfo(_ info: Info) -> some View {
        VStack {
            Text(info.title)
                .font(.title)
                .fontWeight(.semibold)
            CustomLabel("list.bullet.rectangle.portrait", "\(questions.count)", "Multiple Choice Questions")
            CustomLabel("person", "\(info.peopleAttended)", "Attended the exercise")
            Divider()
        }
    }
    
    private var downloadingView: some View {
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
    
    @ViewBuilder
    func RulesView(_ rules: [String]) -> some View {
        VStack (alignment: .leading, spacing: 15) {
            showRulesText
            ForEach(rules, id: \.self) { rule in
                HStack(alignment: .top, spacing: 10){
                    showRulesDots
                    Text(rule)
                        .font(.callout)
                        .lineLimit(3)
                }
            }
        }
    }
    
    private var showRulesText: some View {
        Text("Before you start")
            .font(.title3)
            .fontWeight(.bold)
            .padding(.bottom, 12)
    }
    
    private var showRulesDots: some View {
        Circle()
            .fill(.black)
            .frame(width: 8, height: 8)
            .offset(y: 6)
    }
    
    @ViewBuilder
    func CustomLabel(_ image: String, _ title: String, _ subTitle: String) -> some View {
        HStack {
            customLabelImage(image)
            customLabelText(title, subTitle)
        }
    }
    
    private func customLabelImage(_ image: String) -> some View {
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
    }
    
    private func customLabelText(_ title: String, _ subTitle: String) -> some View {
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
    
    private func fetchData() async throws {
        try await loginUserAnonymous()
        let info = try await  Firestore.firestore().collection("Quiz").document("Info").getDocument().data(as: Info.self) // checks whether Info document has something
        let questions = try await Firestore.firestore().collection("Quiz").document("Info").collection("Questions").getDocuments().documents // checks wheter questions collection inside Info document has something
            .compactMap {
                try $0.data(as: Question.self)
            }
        await MainActor.run(body: {
            self.quizInfo = info
            self.questions = questions
        })
    }
    
    private func loginUserAnonymous() async throws {
        if logStatus {
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
                CustomButtonLabel(title)
            }
            .padding([.bottom, .horizontal], -15)
            .buttonStyle(PlainButtonStyle())
            Spacer()
        }
    }
    
    private func CustomButtonLabel(_ title: String) -> some View {
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
}

#Preview {
    HomeView()
}
