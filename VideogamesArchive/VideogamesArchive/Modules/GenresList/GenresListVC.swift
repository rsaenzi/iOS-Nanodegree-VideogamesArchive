//
//  GenresListVC.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import KVNProgress

class GenresListVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KVNProgress.show()
        RequestGetGenres.request { [weak self] response in
            
            KVNProgress.dismiss()
            switch response {
                
            case .success(let output):
                print("RequestGetGenres: Success!")
                Model.shared.genres = output
                
            default:
                self?.showSimpleAlert(title: "Error", message: "Error when trying to fetch all the Genres")
            }
        }
    }
}
