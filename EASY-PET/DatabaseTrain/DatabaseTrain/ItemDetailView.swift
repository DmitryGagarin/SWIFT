//
//  ItemDetailView.swift
//  DatabaseTrain
//
//  Created by Dmitry Fatsievich on 03.11.2023.
//

import SwiftUI
import RealmSwift

struct ItemDetailView: View {
    
    @ObservedRealmObject var item: Item
    
    var body: some View {
        VStack {
            Text("Enter a new name")
            TextField("New name", text: $item.name)
                .textFieldStyle(.roundedBorder)
                .navigationTitle(item.name)
                .navigationBarItems(trailing: Toggle(isOn: $item.isFavourite) {
                    Image(systemName: item.isFavourite ? "heart.fill" : "heart")
                })
            Button {
                if let newItem = item.thaw(),
                   let realm = newItem.realm {
                    try? realm.write {
                        realm.delete(newItem)
                        
                    }
                }
            } label: {
                Text("delete")
            }
            .padding()
        }
        .padding()
    }
}
#Preview {
    ItemDetailView(item: Item.previewExample())
}
