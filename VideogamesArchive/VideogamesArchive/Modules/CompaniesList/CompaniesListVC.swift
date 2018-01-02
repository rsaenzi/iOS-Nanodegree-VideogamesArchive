//
//  CompaniesListVC.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class CompaniesListVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RequestGetCompanies.request { response in
            switch response {
                
            case .success(let output):
                print("RequestGetCompanies: Success!")
            default:
                print("RequestGetCompanies: Error")
            }
        }
    }
}
