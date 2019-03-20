//
//  TableViewCell.swift
//  SO Question: TableVCell with varying height
//
//  Created by BugDev Studios on 20/03/2019.
//  Copyright © 2019 BugDev Studios. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblSubtitle: UILabel!
  @IBOutlet weak var imageViewPicture: UIImageView!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
