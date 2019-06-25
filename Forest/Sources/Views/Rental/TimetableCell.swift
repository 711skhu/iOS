//
//  TimetableCell.swift
//  Forest
//
//  Created by wookeon on 25/06/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class TimetableCell: UITableViewCell {
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var check: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
