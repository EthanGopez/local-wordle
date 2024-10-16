//
//  GameVC.swift
//  IP13-Wordle
//
//  Created by Gopez, Ethan A on 3/21/24.
// TODO: dark mode

import UIKit

class GameVC: UIViewController {
    
    var currentGame : Wordle!
    let d = Dictionary()
    @IBOutlet var guessField: UITextField!
    @IBOutlet var svCollection: [UIStackView]!
    @IBOutlet var deadLettersLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var deadTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColor(UserDefaults.standard.bool(forKey: "WORDLE-Dark"))
        setGame()
    }
    
    func setGame() {
        for sv in svCollection {
            for label in sv.arrangedSubviews {
                guard let l = label as? LetterTile else {
                    print("error in GameVC: setGame() failed to confirm LetterTile stauses")
                    return
                }
                l.setColor(color: Color.GRAY)
                l.setLetter(letter: "")
            }
        }
        currentGame = Wordle(dict: d)
        deadLettersLabel.text = ""
    }

    @IBAction func guessEntered(_ sender: UITextField) {
        //if (d.getDictionary().contains(<#T##other: Collection##Collection#>))
        print("field's primary ation triggeted")
        guard let str = guessField.text else {
            print("str is wrong")
            return
        }
        print(str.uppercased())
        print(str.count)
        if str.count == 5 && d.getDictionary().contains(str.uppercased()) {
            guessField.text = ""
            takeTurn(word: str.uppercased())
        } else {
            // guess is invalid
            print("reguess")
        }
    }
    
    private func takeTurn(word : String) {
        let results : [Color] = currentGame.takeTurn(word: word)
        deadLettersLabel.text = currentGame.getDeadLetters()
        let sv = svCollection[currentGame.getGameTurn() - 1]
        var i = 0
        for label in sv.arrangedSubviews {
            guard let l = label as? LetterTile else {return}
            l.setColor(color: results[i])
            l.setLetter(letter: String(word[word.index(word.startIndex, offsetBy: i)]))
            i += 1
        }
        if currentGame.gameIsOver() {gameEnded(won: currentGame.gameIsWon())}
    }
    func gameEnded(won: Bool) {
        var title = won ? "You won!" : "You lost..." ; var message = "Answer: "
        let alert = UIAlertController(title: won ? "You won!" : "You lost...", message: "Answer: " + currentGame.currentWord, preferredStyle: UIAlertController.Style.alert)
         alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default, handler: { action in
             self.setGame()
         }))
         self.present(alert, animated: true, completion: nil)
    }
    
    func setColor(_ dark : Bool) {
        if dark {
            deadLettersLabel.textColor = UIColor.white; deadTitleLabel.textColor = UIColor.white
            titleLabel.textColor = UIColor.white; view.backgroundColor = UIColor.black
        }
        else {
            deadLettersLabel.textColor = UIColor.black; deadTitleLabel.textColor = UIColor.black
            titleLabel.textColor = UIColor.black; view.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "settingsSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let s = segue.destination as? SettingsVC {s.vc = self}
    }
}
