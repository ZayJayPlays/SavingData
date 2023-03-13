//
//  EmojiTableViewController.swift
//  emojiDictionary2
//
//  Created by Brayden Lemke on 3/7/23.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    public var emojis: [Emoji] = [] {
        didSet {
            Emoji.saveToFile(emoji: emojis)
        }
    }
    
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Emoji.loadFromFile() != [] {
            emojis += (Emoji.loadFromFile()!)
        } else { emojis +=  startingEmojis}
    }

    @IBSegueAction func addEditEmoji(_ coder: NSCoder, sender: Any?) -> EditEmojiTableViewController? {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            
            let emojiToEdit = emojis[indexPath.row]
            return EditEmojiTableViewController(coder: coder, emoji: emojiToEdit)
        } else {
            return EditEmojiTableViewController(coder: coder, emoji: nil)
        }
        
    }
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind", let sourceViewController = segue.source as? EditEmojiTableViewController, let emoji = sourceViewController.emoji else {return}
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: emojis.count, section: 0)
            emojis.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        
        let emoji = emojis[indexPath.row]
        cell.emoji = emoji

        cell.showsReorderControl = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let emoji = emojis[indexPath.row]
        print("\(emoji.symbol) - \(indexPath)")
    }
    
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emojis.remove(at: sourceIndexPath.row)
        emojis.insert(movedEmoji, at: destinationIndexPath.row)
    }
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

let startingEmojis: [Emoji] = [Emoji(symbol: "😀", name: "Grinning Face",
         description: "A typical smiley face.", usage: "happiness"),
         Emoji(symbol: "😕", name: "Confused Face",
         description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
         Emoji(symbol: "😍", name: "Heart Eyes",
         description: "A smiley face with hearts for eyes.",
         usage: "love of something; attractive"),
         Emoji(symbol: "🧑‍💻", name: "Developer",
         description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software, programming"),
         Emoji(symbol: "🐢", name: "Turtle", description:
         "A cute turtle.", usage: "something slow"),
         Emoji(symbol: "🐘", name: "Elephant", description:
         "A gray elephant.", usage: "good memory"),
         Emoji(symbol: "🍝", name: "Spaghetti",
         description: "A plate of spaghetti.", usage: "spaghetti"),
         Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
         Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
         Emoji(symbol: "📚", name: "Stack of Books",
         description: "Three colored books stacked on each other.",
         usage: "homework, studying"),
         Emoji(symbol: "💔", name: "Broken Heart",
         description: "A red, broken heart.", usage: "extreme sadness"), Emoji(symbol: "💤", name: "Snore",
         description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
         Emoji(symbol: "🏁", name: "Checkered Flag",
         description: "A black-and-white checkered flag.", usage:
         "completion")]

