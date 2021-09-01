//
//  BankHolidayTableViewCell.swift
//  ProMobiTechTask
//
//  Created by Rahul Vengurlekar on 31/08/21.
//

import UIKit

class BankHolidayTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblBunting: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
