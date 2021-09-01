//
//  ProfileInfoTableViewCell.swift
//  ProMobiTechTask
//
//  Created by Rahul Vengurlekar on 01/09/21.
//

import UIKit

class ProfileInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblInfoType: UILabel!
    @IBOutlet weak var lblActualInfo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
