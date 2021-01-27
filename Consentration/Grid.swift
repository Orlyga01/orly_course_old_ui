//
//  GridView.swift
//  Consentration
//
//  Created by Orly on 23/01/2021.
//

import SwiftUI

struct Grid<Item, Double, ItemView >: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var aspectRatio: Double
    var viewForItem: (Item, Int) -> ItemView
    var body: some View {
        GeometryReader {metrics in
            body(for: GridLayout(itemCount: items.count, in: metrics.size))
        }
         }
    func body (for layout: GridLayout) -> some View {
        ForEach(items.indices, content: {index in
            itemBody(for: items[index], in: layout, index: index)
                       })
    }
    func itemBody (for item: Item, in layout: GridLayout, index: Int) ->some View {
        viewForItem(item, index)
            .frame (width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))

    }
}


