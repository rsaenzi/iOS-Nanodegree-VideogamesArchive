//
//  EnginesListVC.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/1/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import KVNProgress
import Kingfisher

class EnginesListVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        KVNProgress.show()
        RequestGetGameEngines.request { [weak self] response in
            
            KVNProgress.dismiss()
            switch response {
                
            case .success(let output):
                Model.shared.engines = output
                self?.table.reloadData()
                
            default:
                self?.showSimpleAlert(title: "Error", message: "Error when trying to fetch all the Game Engines")
            }
        }
    }
}

extension EnginesListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.engines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = Model.shared.engines[indexPath.row]
        let cell: EnginesListCell = tableView.dequeue(indexPath)
        
        if let link = item.logo?.url, let url = URL(string: "https:" + link) {
            cell.engineImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "SpinnerLoading"))
        } else {
            cell.engineImage.image = #imageLiteral(resourceName: "GameEngines")
        }
        
        if let companies = item.companiesIds, let platforms = item.platformsIds {
            cell.engineDescription.text = "Used by \(companies.count) companies on \(platforms.count) platforms"
        } else {
            cell.engineDescription.text = ""
        }
        
        cell.engineName.text = item.name
        cell.engineURL.text = item.url
        return cell
    }
}

extension EnginesListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
