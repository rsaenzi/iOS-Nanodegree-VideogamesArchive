//
//  GameGalleryCell.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class GameGalleryCell: UICollectionViewCell {
    @IBOutlet weak var gameCover: UIImageView!
    @IBOutlet weak var gameIcon1: UIImageView!
    @IBOutlet weak var gameIcon2: UIImageView!
    @IBOutlet weak var gameIcon3: UIImageView!
    @IBOutlet weak var gameIcon4: UIImageView!
    
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameURL: UILabel!
    @IBOutlet weak var gameSummary: UILabel!
    @IBOutlet weak var gameRating: UILabel!
    
    @IBOutlet weak var gameWaiting: UIActivityIndicatorView!
}
