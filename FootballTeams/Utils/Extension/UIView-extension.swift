//
//  UIView-extension.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import UIKit

extension UIView: FTIdentifierProtocol {
    static internal var nib: UINib {
        return UINib(nibName: self.className, bundle: Bundle.main)
    }
    
    func roundCorners(cornerRadius: CGFloat = 4, clipsToBounds: Bool = true) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipsToBounds
    }
    
    func pulse(bounce: Bool = true, inDuration: TimeInterval = 0.2, outDuration: TimeInterval = 0.1, scale: CGFloat = 0.9, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: inDuration, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: { (comp) in
            if bounce {
                UIView.animate(withDuration: outDuration, animations: {
                    self.transform = .identity
                }, completion: completion)
            } else {
                completion?(comp)
            }
        })
    }
}
