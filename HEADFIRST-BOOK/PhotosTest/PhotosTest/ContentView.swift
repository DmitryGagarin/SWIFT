//
//  ContentView.swift
//  PhotosTest
//
//  Created by Dmitry Fatsievich on 20.10.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ScrollView{
                Image("doggie1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(alignment: .center)
                Spacer()
                Image("doggie2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(alignment: .center)
                Spacer()
                Image("doggie3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(alignment: .center)
                Spacer()
                Image("doggie4")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(alignment: .center)
                Spacer()
                Image("doggie5")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(alignment: .center)
                Spacer()
                AsyncImage(url: URL(string: "https://luckydogpetlodge.com/wp-content/uploads/2019/02/doggie-daycare.jpg"))
                    .aspectRatio(contentMode: .fill)
                    .frame(alignment: .center)
                Spacer()
                AsyncImage(url: URL(string: "https://cataas.com/cat?type=square"))
                { image in image.resizable() } placeholder: {
                    ProgressView()
                } 
                .frame(alignment: .center)
                .aspectRatio(contentMode: .fill)
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
