//
//  GameGalleryVC.swift
//  VideogamesArchive
//
//  Created by Rigoberto Saenz on 1/2/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import KVNProgress
import Kingfisher

class GameGalleryVC: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Here we reset the gallery
        Model.shared.gameGallery = []
        
        KVNProgress.show()
        RequestGetGameInfo.request(gameId: 1942) { [weak self] response in
            
            KVNProgress.dismiss()
            switch response {
                
            case .success(let output):
                print("Success")
                
                // We create the array that will hold all the carousel images
                Model.shared.gameGallery = []
                Model.shared.gameGallery = [OutputGetGameInfo?](repeating: nil, count: output.count)
                
                // TEMP
                Model.shared.gameGallery = output
                // TEMP
                
                self?.collection.reloadData()
                
            default:
                self?.showSimpleAlert(title: "Error", message: "Error when trying to fetch the images info for the carousel")
            }
        }
    }
    
}

extension GameGalleryVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.shared.gameGallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: GameGalleryCell = collectionView.dequeue(indexPath)
        
        // The game was downloaded previously
        if let item = Model.shared.gameGallery[indexPath.row] {
            
            if let cover = item.cover, let url = URL(string: "https:" + cover.url) {
                cell.gameCover.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "SpinnerLoading"))
            } else {
                cell.gameCover.image = #imageLiteral(resourceName: "Platform")
            }
            
            cell.gameName.text = item.name
            cell.gameURL.text = item.url
            cell.gameRating.text = "Rating: \(item.rating ?? 0)"
            cell.gameSummary.text = item.summary
            cell.gameStoryline.text = item.storyline
            
        } else { // Start the request to get the game info
            
            cell.gameCover.image = #imageLiteral(resourceName: "SpinnerLoading")
            cell.gameName.text = nil
            cell.gameURL.text = nil
            cell.gameRating.text = nil
            cell.gameSummary.text = nil
            cell.gameStoryline.text = nil
        }
        
        return cell
    }
}

extension GameGalleryVC: UICollectionViewDelegate {
    
}

extension GameGalleryVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
}
