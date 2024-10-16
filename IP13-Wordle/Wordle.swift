//
//  Wordle.swift
//  IP13-Wordle
//
//  Created by Gopez, Ethan A on 3/21/24.
//  Serves as model for one round of the game
//

import Foundation

public class Wordle {
    var d : Dictionary
    var currentWord : String
    var currentWordLetters : [Character : Int]
    var turnCount : Int
    var gameWon : Bool
    var deadLetters : Set<Character>
    
    init(dict : Dictionary) {
        self.d = dict
        self.currentWord = d.getWord()
        
        currentWordLetters = [:]
        
        for i in 0..<5 {
            var wChar = currentWord[currentWord.index(currentWord.startIndex, offsetBy: i)]
            if let count = currentWordLetters[wChar] {
                currentWordLetters[wChar] = count + 1
                
            } else {
                currentWordLetters[wChar] = 1
            }
                
        }
        print(currentWordLetters)
        
        
        self.turnCount = 0
        self.gameWon = false
        self.deadLetters = []
    }
    
    //Pre-condition: Guess is valid 5 letter word in the dictionary
    func takeTurn(word : String) -> [Color]{
        var won = true
        
        var temp : [Color] = [Color.GRAY, Color.GRAY, Color.GRAY, Color.GRAY, Color.GRAY]
        var usedLetters : [Character : Int] = [:]
        //checking for all green letters first
        for i in 0..<5 {
            var wChar = word[word.index(word.startIndex, offsetBy: i)]
            if wChar == currentWord[currentWord.index(currentWord.startIndex, offsetBy: i)] {
                temp[i] = Color.GREEN
                if let count = usedLetters[wChar] {
                    usedLetters[wChar] = count + 1
                } else {
                    usedLetters[wChar] = 1
                }
            }
        }
        
        //NOW checking for yellow letters
        for i in 0..<5 {
            if temp[i] == Color.GREEN {
                continue
            }
            won = false
            var wChar = word[word.index(word.startIndex, offsetBy: i)]
            if currentWord.contains(String(wChar)) {
                if let count = usedLetters[wChar] {
                    //letter already exists, so gray
                    usedLetters[wChar] = count + 1
                } else {
                    //letter not added, so yellow
                    usedLetters[wChar] = 1
                }
                
                if usedLetters[wChar]! <= currentWordLetters[wChar]! {
                    temp[i] = Color.YELLOW
                }
            }
            else {
                deadLetters.insert(wChar)
            }
        }
        print(temp)
        gameWon = !(temp.contains(Color.GRAY) || temp.contains(Color.YELLOW))
        turnCount += 1
        return temp
    }
    
    func getDeadLetters() -> String {
        var temp : String = ""
        for wChar in deadLetters {
            temp.append(String(wChar))
            temp.append(" ")
        }
        
        return temp
    }
    
    func gameIsOver() -> Bool {
        return turnCount >= 6 || gameWon
    }
    
    func gameIsWon() -> Bool {
        return gameWon
    }
    
    func getGameTurn() -> Int {
        return turnCount
    }
    
    
}
