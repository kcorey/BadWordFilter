//
//  TrieTests.swift
//  BadWordFilter
//
//  Created by Ken Corey on 19/07/2016.
//  Copyright © 2016 Ken Corey. All rights reserved.
//

import XCTest

class TrieTests: XCTestCase {

    func testTrieNode() {
        
        let node = TrieNode.init()
        
        XCTAssertNotNil(node)
        XCTAssertEqual(node.children.count, 0)
    }
    
    func testTrieNodeOneChild() {
        
        let nodeParent = TrieNode.init()
        let nodeChild = TrieNode.init()
        
        XCTAssertNotNil(nodeParent)
        XCTAssertNotNil(nodeChild)
        
        nodeParent.children.append(nodeChild)
        
        XCTAssertEqual(nodeParent.children.count, 1)
    }
    
    func testLoad3Words2Nodes() {
        
        let trie:Trie = Trie.init()
        
        trie.addWord("Testing")
        trie.addWord("Test")
        trie.addWord("Foo")

        XCTAssertNotNil(trie)
        XCTAssertEqual(trie.root.children.count, 2)
    }
    
    func testLoadBadWords() {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource("badwords", ofType: "txt")!
        let url = NSURL.fileURLWithPath(path)
        let trie:Trie = Trie.init()
        
        do {
            
            let lines = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
            
            trie.addAllWords(lines as String)
            
            XCTAssertNotNil(trie)
            XCTAssertEqual(trie.root.children.count, 6)
        } catch  {
            
            writeToStdOut("Ack!  Couldn't load the contents of \(url.absoluteString)")
            XCTAssert(false)
        }
    }
    
    func testLoadBadWordsAndSearch() {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource("badwords", ofType: "txt")!
        let url = NSURL.fileURLWithPath(path)
        let trie:Trie = Trie.init()
        
        do {
            
            let lines = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
            
            trie.addAllWords(lines as String)
            
            XCTAssertNotNil(trie)
            XCTAssertEqual(trie.root.children.count, 6)
            
            let thatWord = trie.findWord("that")
            XCTAssertEqual(thatWord.count, 1)
            
            let fooWord = trie.findWord("foo")
            XCTAssertEqual(fooWord.count,0)
            
            let aMissingWord = trie.findWord("missing")
            XCTAssertEqual(aMissingWord.count,0)
        } catch  {
            
            writeToStdOut("Ack!  Couldn't load the contents of \(url.absoluteString)")
            XCTAssert(false)
        }
    }
    
    func testLoadBadWordsAndReplace() {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource("badwords", ofType: "txt")!
        let url = NSURL.fileURLWithPath(path)
        let trie:Trie = Trie.init()
        
        do {
            
            let lines = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
            
            trie.addAllWords(lines as String)

            XCTAssertEqual(trie.maxWordLength, 7)
        } catch  {
            
            writeToStdOut("Ack!  Couldn't load the contents of \(url.absoluteString)")
            XCTAssert(false)
        }
    }
    
    func testLoadFindWord() {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource("badwords", ofType: "txt")!
        let url = NSURL.fileURLWithPath(path)
        let trie:Trie = Trie.init()
        
        do {
            
            let lines = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
            
            trie.addAllWords(lines as String)
            
            let fiWord = trie.findWord("f i ")
            XCTAssertEqual(fiWord.count, 0)
            
            let fileWord = trie.findWord("f i l e")
            XCTAssertEqual(fileWord.count, 1)

            XCTAssertEqual(trie.maxWordLength, 7)
        } catch  {
            
            writeToStdOut("Ack!  Couldn't load the contents of \(url.absoluteString)")
            XCTAssert(false)
        }
    }
    
    func testLoadCensorAWord() {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource("badwords", ofType: "txt")!
        let url = NSURL.fileURLWithPath(path)
        let trie:Trie = Trie.init()
        
        let orgCleanString = "fool's"
        let orgDirtyString = "Another"
        let censoredDirtyString = "A******"
        
        do {
            
            let lines = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
            
            trie.addAllWords(lines as String)

            let cleanString = trie.censorWord(orgCleanString)
            
            let dirtyString = trie.censorWord(orgDirtyString)
            
            XCTAssertEqual(orgCleanString, cleanString)
            XCTAssertEqual(censoredDirtyString, dirtyString)
            
            XCTAssertEqual(trie.maxWordLength, 7)
        } catch  {
            
            writeToStdOut("Ack!  Couldn't load the contents of \(url.absoluteString)")
            XCTAssert(false)
        }
    }
    
    func testCensorSentence() {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource("badwords", ofType: "txt")!
        let url = NSURL.fileURLWithPath(path)
        let trie:Trie = Trie.init()
        
        let orgCleanString = "A fool's errand is never done."
        let orgDirtyString = "Another fool's errand has six nodes."
        let censoredDirtyString = "A****** fool's errand h** s** n****."
        
        do {
            
            let lines = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
            
            trie.addAllWords(lines as String)
            
            let cleanString = trie.censor(orgCleanString)
            
            let dirtyString = trie.censor(orgDirtyString)
            
            XCTAssertEqual(orgCleanString, cleanString)
            XCTAssertEqual(censoredDirtyString, dirtyString)
            
            XCTAssertEqual(trie.maxWordLength, 7)
        } catch  {
            
            writeToStdOut("Ack!  Couldn't load the contents of \(url.absoluteString)")
            XCTAssert(false)
        }
    }
}
