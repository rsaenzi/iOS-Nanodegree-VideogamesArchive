//
//  UICollectionView+Load.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/1/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /**
     This function works if the UICollectionViewCell class and the Cell Identifier are the same
     */
    func dequeue<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        
        let identifier = className(some: T.self)
        let rawCell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        guard let cell = rawCell as? T else {
            fatalError("UICollectionViewCell with identifier '\(identifier)' was not found")
        }
        return cell
    }
}

private func className(some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
}
