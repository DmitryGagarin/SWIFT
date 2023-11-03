//
//  ItemListView.swift
//  DatabaseTrain
//
//  Created by Dmitry Fatsievich on 03.11.2023.
//

import SwiftUI
import RealmSwift

struct ItemListView: View {
    
    @ObservedRealmObject var group: Group
    
    var body: some View {
        NavigationView {
            List {
                ForEach(group.items) { item in
                    ItemRow(item: item)
                }
                .onMove(perform: $group.items.move)
                .onDelete(perform: $group.items.remove)
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Items", displayMode: .large)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: EditButton())
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        $group.items.append(Item())
                    } label: {
                        Image(systemName: "plus")
                    } .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }
}

struct ItemRow: View {
    @ObservedRealmObject var item: Item
    var body: some View {
        NavigationLink(destination: ItemDetailView(item: item), label: {
            Text(item.name)
            if item.isFavourite {
                Image(systemName: "heart.fill")
            }
        })
    }
}

#Preview {
    ItemListView(group: Group())
}
