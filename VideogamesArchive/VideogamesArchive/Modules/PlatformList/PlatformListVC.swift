//
//  PlatformListVC.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import KVNProgress
import Kingfisher

class PlatformListVC: UIViewController {
    
    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        KVNProgress.show()
        RequestGetPlatforms.request { [weak self] response in
            
            KVNProgress.dismiss()
            switch response {
                
            case .success(let output):
                Model.shared.platforms = output
                self?.table.reloadData()
                
            default:
                self?.showSimpleAlert(title: "Error", message: "Error when trying to fetch all the Platforms")
            }
        }
    }
}

extension PlatformListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.platforms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = Model.shared.platforms[indexPath.row]
        let cell: PlatformListCell = tableView.dequeue(indexPath)
        
        if let link = item.logo?.url, let url = URL(string: "https:" + link) {
            cell.platformImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "SpinnerLoading"))
        } else {
            cell.platformImage.image = #imageLiteral(resourceName: "GameEngines")
        }
        
        cell.platformName.text = item.name
        cell.platformURL.text = item.url
//        cell.platformDescription.text = item.summary
        return cell
    }
}

extension PlatformListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let screen: GameGalleryVC = loadViewController()
        navigationController?.pushViewController(screen, animated: true)
    }
}
