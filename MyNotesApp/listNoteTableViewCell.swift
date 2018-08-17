//
//  listNoteTableViewCell.swift
//  MyNotesApp
//
//  Created by tolga iskender on 17.08.2018.
//  Copyright © 2018 tolga iskender. All rights reserved.
//

import UIKit

class listNoteTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var des: UITextView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewCell.layer.cornerRadius = 10
        viewCell.layer.bounds = CGRect(x: 0.5, y: 0.5, width: 0.5, height: 0.5)
        viewCell.layer.shadowOpacity = 1
        viewCell.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        editButton.layer.cornerRadius = 5
        deleteButton.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setNotes(note:MyNotes) {
        title.text = note.title
        des.text = note.details
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM/dd/yy h:mn a"
        let date = dateFormat.string(from: note.date! )
        dateLabel.text = date
    }

}
