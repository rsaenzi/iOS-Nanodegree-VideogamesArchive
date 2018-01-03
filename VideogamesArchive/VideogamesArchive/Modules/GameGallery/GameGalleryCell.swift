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
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameURL: UILabel!
    @IBOutlet weak var gameSummary: UILabel!
    @IBOutlet weak var gameStoryline: UILabel!
    @IBOutlet weak var gameRating: UILabel!
}
