//
//  ContentView.swift
//  Consentration
//
//  Created by Orly on 21/01/2021.
//

import SwiftUI


struct ConsentrationView: View {  
    var viewModel: EmojiMemoryGame
    var body: some View {
        return HStack(spacing: 0) {
            let fontSize = viewModel.numberOfPairsOfCards < 5 ? Font.largeTitle : nil
            ForEach(viewModel.cards, content: {card in
                CardView(card: card).onTapGesture{viewModel.choose(card: card)}
           })
             .foregroundColor(.orange)
             .padding(2.0)
            .font(fontSize)
        }
//            .padding()
    }
}
struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        return
            GeometryReader {metrics in
                let cardHeight = metrics.size.width * 1.5
                ZStack(){
                            if (card.isFaceUp){
                                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                                Text(card.content)
                            } else {
                                RoundedRectangle(cornerRadius: 10.0).fill()
                            }

            }.frame(height: cardHeight)
            

        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConsentrationView(viewModel: EmojiMemoryGame())
    }
}
