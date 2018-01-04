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
    
    var gameIdsToLoad = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Here we reset the gallery
        Model.shared.gameGalleryIds = []
        Model.shared.gameGallery = []
        
        // We create the array that will hold all the carousel images
        Model.shared.gameGalleryIds = self.gameIdsToLoad
        Model.shared.gameGallery = [GameInfo?](repeating: nil, count: self.gameIdsToLoad.count)
        self.collection.reloadData()
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
            populate(cell, using: item)
            
        } else { // Start the request to get the game info
            
            // Get the game id to fetch
            let gameIdToFetch = Model.shared.gameGalleryIds[indexPath.row]
            
            // First we ask if the item is already persisted
            if let persistedItem = Storage.shared.getGameInfo(id: gameIdToFetch) {
                
                // Save the data inside the model
                Model.shared.gameGallery[indexPath.row] = persistedItem
                
                // Updates the cell
                self.populate(cell, using: persistedItem)
                
            } else {
                
                // Set the default state of the cell, while its data is downloading
                reset(cell)
                
                // Start a request to fetch the Game data
                RequestGetGameInfo.request(gameId: gameIdToFetch) { [weak self] response in
                    guard let `self` = self else { return }
                    
                    switch response {
                    case .success(let output):
                        
                        if let downloadedItem = output.first {
                            
                            // Persist the downloaded game item
                            Storage.shared.save(gameInfo: downloadedItem)
                            
                            // Save the data inside the model
                            Model.shared.gameGallery[indexPath.row] = downloadedItem
                            
                            // Updates the cell
                            self.populate(cell, using: downloadedItem)
                        }
                        
                    default:
                        break
                    }
                }
            }
        }
        
        return cell
    }
    
    private func populate(_ cell: GameGalleryCell, using item: GameInfo) {
        
        if let cover = item.cover, let coverURL = getCoverURL(from: cover.url) {
            cell.gameCover.kf.setImage(with: coverURL)
        } else {
            cell.gameCover.image = #imageLiteral(resourceName: "Platform")
        }
        
        if let icons = item.screenshots {
            for (imageIndex, imageURL) in icons.enumerated() {
                
                if let url = getCoverURL(from: imageURL.url) {
                    switch imageIndex {
                        
                    case 0:
                        cell.gameIcon1.kf.setImage(with: url)
                    case 1:
                        cell.gameIcon2.kf.setImage(with: url)
                    case 2:
                        cell.gameIcon3.kf.setImage(with: url)
                    case 3:
                        cell.gameIcon4.kf.setImage(with: url)
                    default:
                        break
                    }
                    
                } else {
                    switch imageIndex {
                        
                    case 0:
                        cell.gameIcon1.image = #imageLiteral(resourceName: "Platform")
                    case 1:
                        cell.gameIcon2.image = #imageLiteral(resourceName: "Platform")
                    case 2:
                        cell.gameIcon3.image = #imageLiteral(resourceName: "Platform")
                    case 3:
                        cell.gameIcon4.image = #imageLiteral(resourceName: "Platform")
                    default:
                        break
                    }
                }
            }
            
        } else {
            cell.gameIcon1.image = #imageLiteral(resourceName: "Platform")
            cell.gameIcon2.image = #imageLiteral(resourceName: "Platform")
            cell.gameIcon3.image = #imageLiteral(resourceName: "Platform")
            cell.gameIcon4.image = #imageLiteral(resourceName: "Platform")
        }
        
        cell.gameName.text = item.name
        cell.gameURL.text = item.url
        cell.gameRating.text = "Rating: \(item.rating ?? 0)"
        
        var gameDescription = ""
        if let storyline = item.storyline {
            gameDescription = storyline
        }
        if let summary = item.summary {
            gameDescription = summary
        }
        cell.gameSummary.text = gameDescription
        
        cell.gameWaiting.stopAnimating()
        cell.gameWaiting.isHidden = true
    }
    
    private func reset(_ cell: GameGalleryCell) {
        cell.gameCover.image = nil
        cell.gameIcon1.image = nil
        cell.gameIcon2.image = nil
        cell.gameIcon3.image = nil
        cell.gameIcon4.image = nil
        
        cell.gameName.text = nil
        cell.gameURL.text = nil
        cell.gameRating.text = nil
        cell.gameSummary.text = nil
        
        cell.gameWaiting.startAnimating()
        cell.gameWaiting.isHidden = false
    }
    
    private func getCoverURL(from imageLink: String) -> URL? {

        var link = imageLink
        if imageLink.hasPrefix("https:") == false {
            link = "https:" + link
        }
        
        guard let url = URL(string: link) else {
            return nil
        }
        
        return url
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
