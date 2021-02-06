//
//  ViewController.swift
//  Set
//
//  Created by Orly on 02/02/2021.
//

import UIKit

class ViewController: UIViewController {
    // 100 for side padding
    let padding: CGFloat = 10.0
    var wrapperWidth: CGFloat {cardWrapper.bounds.width + 2*padding}
    let minWidth: CGFloat = 70.0
    var minHeight: CGFloat {minWidth * 1.5}

    private lazy var game = SetGame()
    // The card has 4 digits as text, 1st digit determines the shape, 2nd determined the color, 3rd the amount, and 4th the fill
    var shapes: [String] = ["●", "■", "▲"]
    var colorChoices: [UIColor] = [UIColor.blue, UIColor.red, #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)]
    var colorMode: [CGFloat] = [10.0, -3.0, -3.0]
    var lastCardPosition: CardPosition?

    @IBOutlet weak var cardWrapper: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cardWrapper.setDefaultConstraints(wrapperView: self.view)
        cardWrapper.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 20)
        newGame()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func newGame(_ sender: Any) {
        newGame()
    }
    func newGame() {
        game = SetGame()
        cardWrapper.subviews.forEach { $0.removeFromSuperview() }
        lastCardPosition = nil
        game.startGame()
        updateFromModel()

    }
    
    private func isOutline (num: Int) -> Bool {
        return num == 2
    }
    
    func NextPosition(_ previousPosition: CardPosition? ) -> CardPosition {
        var prev: CardPosition
        if previousPosition == nil {
             prev = CardPosition(x: -minWidth, y: self.padding)
        } else {
             prev = previousPosition!
        }
        let outerCardSizer = minWidth+2 * self.padding
        if (wrapperWidth - prev.x - outerCardSizer) > (outerCardSizer) {
            return CardPosition(x: prev.x + self.padding + minWidth, y: prev.y)
        } else {
            return CardPosition(x: self.padding, y: prev.y + self.padding + minHeight)
        }
        
    }
    func updateFromModel() {
        for card in game.cards {
            createButton(card)
        }
    }
   
    func createButton(_ card: Card) {
        let newPosition = NextPosition(self.lastCardPosition)
        self.lastCardPosition = newPosition
        
        let button  = UIButton(frame: CGRect(x: newPosition.x, y: newPosition.y, width: minWidth, height: minHeight))
        button.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.layer.cornerRadius = 5.0
        button.titleLabel?.baselineAdjustment = .alignCenters
        button.contentHorizontalAlignment = .center
        let attribute: [NSAttributedString.Key : Any] = [
            .strokeWidth: colorMode[Int(card.text![3])!],
            .foregroundColor: setStrike(modePosition: Int(card.text![3])!, colorPosition: Int(card.text![1])!),
          //  .font: UIFont.systemFont(ofSize: 50.0)
        ]
        button.setAttributedTitle(NSAttributedString(string: getCardContent(card), attributes: attribute), for: .normal)
        button.addTarget(self, action: #selector(chooseCard(_:)), for: .touchUpInside)
        button.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center

        cardWrapper.addSubview(button)
    }
    private func setStrike( modePosition: Int, colorPosition: Int) -> UIColor {

        if modePosition == 2 {
            return   colorChoices[colorPosition].withAlphaComponent(0.3)

        } else {
            return colorChoices[colorPosition]
        }
       // Int(card.text![3])!
    }
    
    @objc func chooseCard(_ sender: UIButton) {
        sender.backgroundColor = UIColor.red
        print ("hi")
    }
    func getCardContent(_ card: Card) -> String {
        let shape = shapes[Int(card.text!.prefix(1))!]
        let shapeAmount = Int(card.text![0])! + 1
        var text: String = ""
        for i in 1...shapeAmount {
            let space = i == shapeAmount ? "" : " "
            text += shape + space
        }
        return text

    }
}
extension UIView {
    func setDefaultConstraints(wrapperView: UIView){
    self.translatesAutoresizingMaskIntoConstraints = false
        let guide = wrapperView.safeAreaLayoutGuide
    self.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    self.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    self.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    }
}
extension StringProtocol {
    subscript(offset: Int) -> String {
        String(self[index(startIndex, offsetBy: offset)])
    }
}

