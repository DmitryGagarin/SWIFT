//
//  ItemResultView.swift
//  DatabaseTrain
//
//  Created by Dmitry Fatsievich on 03.11.2023.
//

import SwiftUI
import RealmSwift

struct ItemResultView: View {
    
    @ObservedResults(Item.self) var items
    @ObservedResults(Item.self,
                     filter: NSPredicate(format: "name CONTAINS[c] %@", "a"))
    var filteredItems
    @ObservedResults(Item.self,
                     sortDescriptor: SortDescriptor.init(keyPath: "name", 
                                                         ascending: true))
    var sortedItems

    var body: some View {
        List {
            Section(header: Text("All")) {
                ForEach(items) { item in
                    ItemRow(item: item)
                }
            }
            Section(header: Text("Filtered Items")) {
                ForEach(filteredItems) { filteredItem in
                    ItemRow(item: filteredItem)
                }
            }
            Section(header: Text("Sorted Items")) {
                ForEach(sortedItems) { sortedItems in
                    ItemRow(item: sortedItems)
                }
            }
        }
    }
}

#Preview {
    return ItemResultView()
        .environment(\.realm, RealmHelper.realmWithItems())
}

