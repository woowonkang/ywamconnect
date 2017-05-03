//
//  MealScheduleCell.swift
//  ywamconnect
//
//  Created by Woowon Kang on 4/18/17.
//  Copyright © 2017 Woowon Kang. All rights reserved.
//

import UIKit

class MealScheduleCell: UITableViewCell {
    @IBOutlet weak var mealtype: UILabel!
    @IBOutlet weak var mealmenu: UILabel!
    @IBOutlet weak var postedby: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
