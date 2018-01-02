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
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KVNProgress.show()
        RequestGetGenres.request { [weak self] response in
            
            KVNProgress.dismiss()
            switch response {
                
            case .success(let output):
                Model.shared.genres = output
                self?.table.reloadData()
                
            default:
                self?.showSimpleAlert(title: "Error", message: "Error when trying to fetch all the Genres")
            }
        }
    }
}

extension GenresListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = Model.shared.genres[indexPath.row]
        let cell: GenresListCell = tableView.dequeue(indexPath)
        
//        if let link = item.logo?.url, let url = URL(string: "https:" + link) {
//            cell.platformImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "SpinnerLoading"))
//        } else {
//            cell.platformImage.image = #imageLiteral(resourceName: "GameEngines")
//        }
//        
//        cell.platformName.text = item.name
//        cell.platformURL.text = item.url
//        cell.platformDescription.text = item.summary
        return cell
    }
}

extension GenresListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
