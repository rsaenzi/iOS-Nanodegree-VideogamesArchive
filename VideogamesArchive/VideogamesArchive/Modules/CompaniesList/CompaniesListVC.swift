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
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KVNProgress.show()
        RequestGetCompanies.request { [weak self] response in
            
            KVNProgress.dismiss()
            switch response {
                
            case .success(let output):
                Model.shared.companies = output
                self?.table.reloadData()
                
            default:
                self?.showSimpleAlert(title: "Error", message: "Error when trying to fetch all the Companies")
            }
        }
    }
}

extension CompaniesListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = Model.shared.companies[indexPath.row]
        let cell: CompaniesListCell = tableView.dequeue(indexPath)
        cell.companyName.text = item.name
        cell.companyURL.text = item.url
        
        var gamesDescription = ""
        if let developed = item.developedGamesIds {
            gamesDescription.append("Games Developed: \(developed.count)\n")
        }
        if let published = item.publishedGamesIds {
            gamesDescription.append("Games Published: \(published.count)")
        }
        cell.companyGames.text = gamesDescription
        return cell
    }
}

extension CompaniesListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = Model.shared.companies[indexPath.row]
        
        let screen: GameGalleryVC = loadViewController()
        screen.gameIdsToLoad = item.developedGamesIds ?? []
        navigationController?.pushViewController(screen, animated: true)
    }
}
