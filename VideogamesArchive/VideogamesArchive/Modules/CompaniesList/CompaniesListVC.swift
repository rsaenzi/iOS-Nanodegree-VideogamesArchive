//
//  CompaniesListVC.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import KVNProgress

class CompaniesListVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KVNProgress.show()
        RequestGetCompanies.request { [weak self] response in
            
            KVNProgress.dismiss()
            switch response {
                
            case .success(let output):
                print("RequestGetCompanies: Success!")
                Model.shared.companies = output
                
            default:
                self?.showSimpleAlert(title: "Error", message: "Error when trying to fetch all the Companies")
            }
        }
    }
}
