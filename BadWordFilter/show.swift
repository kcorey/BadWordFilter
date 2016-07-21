//
//  show.swift
//  BadWordFilter
//
//  Created by Ken Corey on 19/07/2016.
//  Copyright © 2016 Ken Corey. All rights reserved.
//

import Foundation

func show(handle:NSFileHandle, str:String) {
    
    if let data = str.dataUsingEncoding(NSUTF8StringEncoding) {
        
        handle.writeData(data)
    }
}

func writeToStdOut(str: String) {
    
    show(NSFileHandle.fileHandleWithStandardOutput(),str: str)
}

func writeToStdError(str: String) {
    
    show(NSFileHandle.fileHandleWithStandardError(),str: str)
}

