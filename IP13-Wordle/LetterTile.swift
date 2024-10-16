//
//  LetterTile.swift
//  IP13-Wordle
//
//  Created by Gopez, Ethan A on 3/21/24.
//

import UIKit

class LetterTile: UILabel {
    
    var used : Bool
    var color : Color
    
    required init?(coder: NSCoder) {
        used = false
        color = Color.GRAY
        super.init(coder: coder)
        super.text = ""
    }
    
    public func setColor(color : Color) {
        if (color == Color.GRAY) {
            super.backgroundColor = UIColor.lightGray
        }
        else if (color == Color.YELLOW) {
            super.backgroundColor = UIColor.yellow
        }
        else {
            super.backgroundColor = UIColor.green
        }
    }
    
    public func setLetter(letter:String) {
        super.text = letter
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


