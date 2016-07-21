//
//  Trie.swift
//  BadWordFilter
//
//  Created by Ken Corey on 19/07/2016.
//  Copyright © 2016 Ken Corey. All rights reserved.
//

import Foundation

class Trie {
    
    var nodes:Array<TrieNode> = []
    
    var root:TrieNode = TrieNode.init()
    
    var maxWordLength = 0
    
    func addAllWords(lines:String) {
        
        let words:[String] = lines.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
        
        for aWord in words {
            
            addWord(aWord)
        }
    }
    
    func addWord(keyword: String) {
        
        guard keyword.length > 0 else {
            
            return
        }
        
        var current: TrieNode = root
        
        while (keyword.length != current.level) {
            
            var childToUse: TrieNode!
            let searchKey: String = keyword.substringToIndex(current.level + 1)
            
            //iterate through the node children
            for child in current.children {
                
                if (child.key == searchKey) {
                    
                    childToUse = child
                    break
                }
            }
            
            
            //create a new node
            if  (childToUse == nil) {
                
                childToUse = TrieNode()
                childToUse.key = searchKey
                childToUse.level = current.level + 1
                current.children.append(childToUse)
                maxWordLength = max(childToUse.level, maxWordLength)
            }
            
            current = childToUse
            
        } //end while
        
        //final end of word check
        if (keyword.length == current.level) {
            
            current.isFinal = true
            print("end of word reached!")
            return
        }
    }
    
    //find all words based on the prefix
    
    func findWord(searchword: String) -> Array<String>! {
        
        var current: TrieNode = root
        var wordList: Array<String> = Array<String>()
        let keyword = searchword.lowercaseString
        
        guard keyword.length > 0 else {
            
            return wordList
        }
        
        while (keyword.length != current.level) {
            
            var childToUse: TrieNode!
            let searchKey: String = keyword.substringToIndex(current.level + 1)
            
            //iterate through any children
            for child in current.children {
                
                if (child.key == searchKey) {
                    
                    childToUse = child
                    current = childToUse
                    break
                }
            }
            
            if childToUse == nil {
                
                return wordList
            }
        }
        
        //retrieve the keyword and any decendants
        if ((current.key == keyword) && (current.isFinal)) {
            
            wordList.append(current.key)
        }
        
        //include only children that are words
        for child in current.children {
            
            if (child.isFinal == true) {
                
                wordList.append(child.key)
            }
        }
        
        return wordList
    }
    
    func censorWord(word:String) -> String {
        
        let lowerWord = word.lowercaseString
        let search = findWord(lowerWord)
        
        if search.count > 0 {
                        
            return word.substringToIndex(1) + String(count: word.length - 1, repeatedValue: "*" as Character)
        }
        else {
            
            return word;
        }
    }
    
    // The basic algorithm is:
    // start at the length of the longest word in the trie (or the count of the letter left)
    // Get that many letters from the remaining text.  
    // If that's a word to censor, censor it, and remove it from the letters to process
    // If that's not, then look at one letter less, and try again.
    // If the search string is one character long, and a naughty word hasn't been found, 
    //      then add that character and continue on.
    func censor(sentence:String) -> String {
        
        var result = ""
        var word:String = ""
        var stringLength = maxWordLength
        var found = false
        var remainingWords = sentence
        
        while remainingWords.length > 0 {
            
            stringLength = min(maxWordLength, remainingWords.length)
            
            found = false
            
            while !found && stringLength > 0 {
                
                word = remainingWords.substringToIndex(stringLength)
                
                let search = findWord(word)
                
                if search.count > 0 {
                    
                    let outputWord = censorWord(word)
                    result = result + outputWord
                    
                    remainingWords = remainingWords.substringFromIndex(remainingWords.startIndex.advancedBy(outputWord.length))
                    found = true
                }
                else {
                    
                    stringLength -= 1
                }
            }
            
            if (!found) {
                
                // Didn't find it, append the last letter of the search, and try the next.
                result += word
                remainingWords = remainingWords.substringFromIndex(remainingWords.startIndex.advancedBy(word.length))
            }
        }
        
        return result
    }
}