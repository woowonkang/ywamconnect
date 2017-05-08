//
//  ScheduleCell.swift
//  ywamconnect
//
//  Created by Woowon Kang on 5/4/17.
//  Copyright © 2017 Woowon Kang. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {
    
    @IBOutlet weak var activity: UILabel!
    @IBOutlet weak var timeinfo: UILabel!
    @IBOutlet weak var daystring: UILabel!
    @IBOutlet weak var dateinfo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
