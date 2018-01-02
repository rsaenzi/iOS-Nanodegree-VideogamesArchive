//
//  PlatformListVC.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class PlatformListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        RequestGetPlatforms.request { response in
            switch response {
                
            case .success(let output):
                print("RequestGetPlatforms: Success!")
            default:
                print("RequestGetPlatforms: Error")
            }
        }
    }

}
