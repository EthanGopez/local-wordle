//
//  Dictionary.swift
//  IP13-Wordle
//
//  Created by Gopez, Ethan A on 3/25/24.
//

import Foundation

struct Dictionary {
    var dictionary : [String]
    
    init() {
        let fileName = "dictionary"
        let url = Bundle.main.url(forResource: fileName, withExtension: "txt")
        let contents = try! String(contentsOf: url!)
        let lines = contents.split(separator: "\n")
        
        
        dictionary = []
        for s in lines {
            if String(s).count == 5 {
                dictionary.append(String(s))
            }
        }
        print(dictionary)
    }
    
    func getDictionary() -> [String]{
        return dictionary
    }
    
    func getWord() -> String {
       return dictionary[Int.random(in: 0..<dictionary.count)]
    }
}
