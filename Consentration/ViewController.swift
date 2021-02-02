
import UIKit
    
///
/// View-controller of the concentration game
///
class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2) // model
    lazy var emojiChoices: [String] = game.getCurrentTheme().emojiSet!
    
    /// Label that shows how many flips we've done
    
    @IBOutlet weak var flipCountLabel: UILabel! {
        didSet {
            setLabelAttrs()
        }
    }
    /// Array of cards in the UI
    @IBOutlet var cardButtons: [UIButton]! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var numScore: UILabel!

    ///
    @IBOutlet weak var newGame: UIButton!
    /// Handle the touch (press) of a card
    ///
    @IBAction func touchCard(_ sender: UIButton) {
        
        // A card was touched, increment the flip counter
        flipCount += 1
        
        // Get the index of the selected/touched card
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            // Tell the model which card was chosen
            game.chooseCard(at: cardNumber)
            
            // Update the view accordingly
            updateViewFromModel()
        }
        else {
            print("Warning! The chosen card was not in cardButtons")
        }
    }
    
    ///
    /// Keeps the view updated based on the model's state
    ///
    func updateViewFromModel() {
        
        // Loop through each card (we care about the index only)
        for index in game.cards.indices {
            // Get the button at current indext
            let button = cardButtons[index]
            
            // Get the card (from the model) at the current index
            let card = game.cards[index]
            
            // If card is face-up, show it
            if card.isFaceUp {
                // Show the card's emoji
                button.setTitle(emoji(for: card), for: .normal)
                // Set a "face-up" color
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            // If card is not face-up, could be (1) face-up or (2) matched/hidden
            else {
                // No emoji when card is down or already matched
                button.setTitle("", for: .normal)
                let color: UIColor = game.getCurrentTheme().cardBgColor!                
                // If card is matched, hide it (with clear color), else show a "face-down" color
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : color
            }
        }
    }
 
    var emoji = [Card:String]()

    ///
    /// Get an emoji for the given card
    func emoji(for card: Card) -> String {
        
        // If card doesn't have an emoji set, add a random one
        if emoji[card] == nil, emojiChoices.count > 0 {
            // Get a random index between 0-number_of_emoji_choises
            let randomIndex = Int.random(in: 0..<emojiChoices.count)
                        // Add the random emoji to this card
            emoji[card] = emojiChoices[randomIndex]
            
            // Remove emoji from emojiChoices so that it doesn't get selected again
            self.emojiChoices.remove(at: randomIndex)
        }
        
        // Return the emoji, or "?" if none available
        if emoji[card] != nil {
            return emoji[card]!
        } else {
            return "?"
        }
    }
    
    ///
    /// Track how many flips have been made
    ///
    private var flipCount = 0  {
        didSet {
            // Keep the flipCountLabel in sync
            setLabelAttrs()
           
        }
    }
    //MARK: actionds
    @IBAction func newGame(_ sender: Any) {
       setNewGame()
    }
    private func setNewGame(){
        self.game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2) // model
        self.emoji = [:]
        self.emojiChoices = game.getCurrentTheme().emojiSet!
        updateViewFromModel()
    }
    private func setLabelAttrs(){
        let attr: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: game.getCurrentTheme().cardBgColor!
        ]
        let attrString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attr)
        flipCountLabel.attributedText = attrString
    }
    
}
