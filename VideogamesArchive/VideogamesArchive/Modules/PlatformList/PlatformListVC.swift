//
//  PlatformListVC.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import KVNProgress

class PlatformListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        KVNProgress.show()
        RequestGetPlatforms.request { [weak self] response in
            
            KVNProgress.dismiss()
            switch response {
                
            case .success(let output):
                print("RequestGetPlatforms: Success!")
                Model.shared.platforms = output
                
            default:
                self?.showSimpleAlert(title: "Error", message: "Error when trying to fetch all the Platforms")
            }
        }
    }
}
