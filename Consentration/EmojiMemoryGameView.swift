//
//  ContentView.swift
//  Consentration
//
//  Created by Orly on 21/01/2021.
//

import SwiftUI


struct EmojiMemoryGameView: View {  
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        Grid(items: viewModel.cards, aspectRatio: 1.5)
                 { card, index in
                     CardView(card: viewModel.cards[index]).onTapGesture   {
                        viewModel.choose(card: viewModel.cards[index], index: index)
                     }
                     .padding(2.0)
               }
            .foregroundColor(Color.orange)
            .padding(8.0)
    }

}
struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        return
            GeometryReader {metrics in
                ZStack(){
                            if (card.isFaceUp){
                                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: 3)
                                Text(card.content)
                            } else if (!card.isMatched) {
                                RoundedRectangle(cornerRadius: cornerRadius).fill()
                            }

            }
            .font(Font.system(size: getFontSize(metrics.size)))
        }
    }
    // MARK: drawing Constatns
    let cornerRadius: CGFloat = 10.0
    private func getFontSize(_ size: CGSize) -> CGFloat{
        return min(size.width, size.height)*0.75
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
