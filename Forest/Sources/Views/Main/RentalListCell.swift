//
//  RentalListCell.swift
//  Forest
//
//  Created by wookeon on 24/06/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class RentalListCell: UITableViewCell {

    
    @IBOutlet weak var rentalState: UILabel!
    @IBOutlet weak var lectureCode: UILabel!
    @IBOutlet weak var rentalDate: UILabel!
    @IBOutlet weak var rentalTime: UILabel!
    @IBOutlet weak var cancleBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
