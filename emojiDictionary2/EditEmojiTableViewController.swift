//
//  EditEmojiTableViewController.swift
//  emojiDictionary2
//
//  Created by Zane Jones on 3/8/23.
//

import UIKit

class EditEmojiTableViewController: UITableViewController {

    var emoji: Emoji?
    
    @IBOutlet var textFieldSymbol: UITextField!
    @IBOutlet var textFieldName: UITextField!
    @IBOutlet var textFieldDescription: UITextField!
    @IBOutlet var textFieldUsage: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    init?(coder: NSCoder, emoji: Emoji?) {
        self.emoji = emoji
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let emoji = emoji {
            textFieldSymbol.text = emoji.symbol
            textFieldName.text = emoji.name
            textFieldDescription.text = emoji.description
            textFieldUsage.text = emoji.usage
            title = "Edit Emoji"
        } else {
            title = "Add Emoji"
            updateSaveButtonState()
        }
    }
    func updateSaveButtonState() {
        
        let nameText = textFieldName.text ?? ""
        let descriptionText = textFieldDescription.text ?? ""
        let usageText = textFieldUsage.text ?? ""
        saveButton.isEnabled = containsSingleEmoji(textFieldSymbol) &&
        !nameText.isEmpty && !descriptionText.isEmpty &&
        !usageText.isEmpty
    }
    func containsSingleEmoji(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count == 1 else {
            return false
        }
        let isCombinedIntoEmoji = text.unicodeScalars.count > 1 &&
           text.unicodeScalars.first?.properties.isEmoji ?? false
        let isEmojiPresentation =
    text.unicodeScalars.first?.properties.isEmojiPresentation ?? false
        return isEmojiPresentation || isCombinedIntoEmoji
    }
    @IBAction func textEdititngChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }
        
        let symbol = textFieldSymbol.text
        let name = textFieldName.text
        let description = textFieldDescription.text
        let usage = textFieldUsage.text
        
        emoji = Emoji(symbol: symbol!, name: name!, description: description!, usage: usage!)
    }
}
