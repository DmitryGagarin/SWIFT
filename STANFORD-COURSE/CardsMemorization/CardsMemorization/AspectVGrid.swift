//
//  AspectVGrid.swift
//  CardsMemorization
//
//  Created by Dmitry Fatsievich on 25.10.2023.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    let items: [Item]
    var aspectRatio: CGFloat = 1
    let content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemSizeThatFits(
                availableWidth: geometry.size.width,
                itemCount: items.count
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    private func gridItemSizeThatFits(availableWidth: CGFloat, itemCount: Int) -> CGFloat {
        var columnCount = floor(sqrt(CGFloat(itemCount)))
        if (items.count == 24){
            columnCount = 5
        }
        let itemWidth = availableWidth / columnCount
        return itemWidth
    }
}

