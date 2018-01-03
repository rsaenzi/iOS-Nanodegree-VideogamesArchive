//
//  Model.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

class Model {
    
    static let shared = Model()
    
    var engines = [GameEngine]()
    var platforms = [GamePlatform]()
    var companies = [GameCompany]()
    var genres = [GameGenre]()
    
    var gameGalleryIds = [Int]()
    var gameGallery = [GameInfo?]()
}
