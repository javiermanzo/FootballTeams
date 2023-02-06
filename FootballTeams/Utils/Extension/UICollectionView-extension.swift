//
//  UICollectionView-extension.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import UIKit

extension UICollectionView {
    
    func registerCellNib<T: UICollectionViewCell>(_: T.Type) {
        self.register(T.nib, forCellWithReuseIdentifier: T.className)
    }
    
    func registerCellClass<T: UICollectionViewCell>(_: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_: T.Type, cellForItemAt indexPath: IndexPath) -> T? {
        let cell = self.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T
        return cell
    }
}


