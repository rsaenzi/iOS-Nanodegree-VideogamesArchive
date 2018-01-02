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
        cell.genreName.text = item.name
        cell.genreURL.text = item.url
        cell.genreGames.text = "Games: \(item.gamesIds.count)"
        return cell
    }
}

extension GenresListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let screen: GameGalleryVC = loadViewController()
        navigationController?.pushViewController(screen, animated: true)
    }
}
