//
//  EmojiTableViewCell.swift
//  emojiDictionary2
//
//  Created by Zane Jones on 3/9/23.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var emoji: Emoji? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        guard let emoji else { return }
        
        symbolLabel.text = emoji.symbol
        nameLabel.text = emoji.name
        descriptionLabel.text = emoji.description
    }
}
