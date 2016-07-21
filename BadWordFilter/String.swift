//
//  String.swift
//  BadWordFilter
//
//  Created by Ken Corey on 19/07/2016.
//  Copyright © 2016 Ken Corey. All rights reserved.
//

import Foundation

//extend the native String class

extension String {
    
    //compute the length
    var length: Int {
        return self.characters.count
    }
    
    //returns characters up to a specified index
    func substringToIndex(to: Int) -> String {
        var end = min(to,self.length)
        return self.substringToIndex(self.startIndex.advancedBy(end))
    }
}