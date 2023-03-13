//
//  Emoji.swift
//  emojiDictionary2
//
//  Created by Brayden Lemke on 3/7/23.
//

import Foundation

struct Emoji : Equatable, Codable {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static func saveToFile(emoji: [Emoji]) {
        let encodedEmojis = try? propertyListEncoder.encode(emoji)
        try? encodedEmojis?.write(to: archiveURL)
    }
    static func loadFromFile() -> [Emoji]? {
        var output = [Emoji]()
        if let retrievedEmojiData = try? Data(contentsOf: archiveURL),
           let decodedEmojis = try? propertyListDecoder.decode([Emoji].self, from: retrievedEmojiData) {
            output = decodedEmojis
        }
        return output
    }
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
    
    static func sampleEmojis() -> [Emoji] {
        EmojiTableViewController().emojis
    }
}

let propertyListEncoder = PropertyListEncoder()
let propertyListDecoder = PropertyListDecoder()



