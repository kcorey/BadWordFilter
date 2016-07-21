//
//  TrieNode.swift
//  BadWordFilter
//
//  Created by Ken Corey on 19/07/2016.
//  Copyright © 2016 Ken Corey. All rights reserved.
//

import Foundation

public class TrieNode {
    
    var key: String!
    var children: Array<TrieNode>
    var isFinal: Bool
    var level: Int
    
    init() {
        
        self.children = Array<TrieNode>()
        self.isFinal = false
        self.level = 0
    }
}