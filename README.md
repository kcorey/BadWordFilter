The Bad Word Kata
=================

This kata is from Reddit:
https://www.reddit.com/r/dailyprogrammer/comments/106gse/9202012_challenge_100_intermediate_bad_word_filter/

I'll copy a bit below just for completeness:
----------------------------------
Write a program called 'censor' that takes in one argument on the command line. This argument is the filename of a newline-separated wordlist of profanity such as
http://urbanoalvarez.es/blog/2008/04/04/bad-words-list/ or
http://www.bannedwordlist.com/SwearWordResources.htm
The program should then read a text from standard in, and print it out again, but replacing every instance of a word in the wordlist with a 'censored' version. The censored version of a word has the same first character as the word, and the rest of the characters are replaced with '*'.
For example, the 'censored' version of 'peter' would be 'p****'
Example:
>echo 'You jerkface!' | censor badwords.txt
You j***face!
----------------------------------

Humans being what they are, we have a wealth of curse words.  The two referenced above no longer are valid.

At the time of writing, this link was valid:
http://www.bannedwordlist.com/lists/swearWords.txt

And here's another link:
https://laughingsquid.com/the-full-list-of-bad-words-banned-by-google/


My approach to this was to realise that there'd be a *lot* of text matching.  Having read about Tries before, I thought this might be a really good chance to play with them.

Wayne's Trie implementation was taken verbatim, more or less...with a couple exceptions:
1) findWord cannot return a nil now.  If no words were found, it returns an empty length array.
2) censorWord and censor functions were added.
3) The formatting has changed a bit to reflect the current style where I work.

The censorWord function will search for the given word, and if it's a "dirty" word because it's in the list, it's censored.

The censor function steps through the whole text.
The basic algorithm is:
1. start at the length of the longest word in the trie (or the count of the letter left)
2. Get that many letters from the remaining text.
3. If that's a word to censor, censor it, and remove it from the letters to process
4. If that's not, then look at one letter less, and try again.
5. If the search string is one character long, and a naughty word hasn't been found,
    then add that character and continue on.

In this way, you can have curse words that have embedded spaces, punctuation, newlines, whatever in them.  It should even handle unicode characters if your censorring needs are a bit more exotic.

Limitations:
1. Wayne's trie implementation is very straightforward.  It could be improved speed-wise, I feel, by inserting in alphabetical order in a given noe, and then implementing a binary search when searching the children of a given node.

2. a trie structure is a fairly compact way to represent a repository of words...this implementation is a little free with memory. 'final' is a bit...not sure it's necessary to store the level, and it might be advantageous to store a character as opposed to a string.  In the spirit of readablity, all of this is ignored.

3. Both the censor and censorWord functions rather fell out fully formed instead of growing towards them using TDD. I had a little time to consider the algorithm, so I knew what I was aiming for before I started typing. I feel this was a mistake as the censor function is quite long, and not particularly readable.  I'll likely revisit this and do it in stages using TDD.

// Note, used the concepts from these web pages:
// http://crunchybagel.com/building-command-line-tools-with-swift/
// http://waynewbishop.com/swift/tries/
