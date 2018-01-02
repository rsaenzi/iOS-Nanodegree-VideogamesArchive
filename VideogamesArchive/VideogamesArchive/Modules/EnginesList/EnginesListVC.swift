//
//  EnginesListVC.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/1/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import KVNProgress

class EnginesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        KVNProgress.show()
        RequestGetGameEngines.request { [weak self] response in
            
            KVNProgress.dismiss()
            switch response {
                
            case .success(let output):
                print("RequestGetGameEngines: Success!")
                Model.shared.engines = output
                
            default:
                self?.showSimpleAlert(title: "Error", message: "Error when trying to fetch all the Game Engines")
            }
        }
    }
}
