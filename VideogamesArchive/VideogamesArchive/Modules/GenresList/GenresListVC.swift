//
//  GenresListVC.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class GenresListVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RequestGetGenres.request { response in
            switch response {
                
            case .success(let output):
                print("RequestGetGenres: Success!")
            default:
                print("RequestGetGenres: Error")
            }
        }
    }
}
