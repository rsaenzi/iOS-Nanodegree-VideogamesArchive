//
//  Model.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

class Model {
    
    static let shared = Model()
    
    var engines = [OutputGetGameEngines]()
    var platforms = [OutputGetPlatforms]()
    var companies = [OutputGetCompanies]()
    var genres = [OutputGetGenres]()
    
    var gameGalleryIds = [Int]()
    var gameGallery = [OutputGetGameInfo?]()
}
