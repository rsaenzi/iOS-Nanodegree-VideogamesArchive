//
//  EnginesListCell.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class EnginesListCell: UITableViewCell {
    @IBOutlet weak var engineImage: UIImageView!
    @IBOutlet weak var engineWaitingIcon: UIActivityIndicatorView!
    @IBOutlet weak var engineName: UILabel!
    @IBOutlet weak var engineURL: UIButton!
    @IBOutlet weak var engineDescription: UILabel!
}
