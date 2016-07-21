//
//  main.swift
//  BadWordTester
//
//  Created by Ken Corey on 19/07/2016.
//  Copyright © 2016 Ken Corey. All rights reserved.
//

import Foundation

if Process.arguments.count < 2 {
    
    writeToStdError("Not enough arguments.\n<name> <file to read>\n");
    exit(EXIT_FAILURE)
}

let path = Process.arguments[1]
let url = NSURL.fileURLWithPath(path)
var error:NSError?

// Check if the file exists, exit if not
if !url.checkResourceIsReachableAndReturnError(&error) {
    
    writeToStdError("File \(url) is not reachable.\n");
    exit(EXIT_FAILURE)
}




writeToStdOut("Success!\n");

// Finally, exit
exit(EXIT_SUCCESS)

