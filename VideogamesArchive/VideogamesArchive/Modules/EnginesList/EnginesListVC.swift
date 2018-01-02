//
//  EnginesListVC.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/1/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class EnginesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        RequestGetGameEngines.request { response in
            switch response {
                
            case .success(let output):
                print("RequestGetGameEngines: Success!")
            default:
                print("RequestGetGameEngines: Error")
            }
        }
    }
}
