//
//  UIColor-extension.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import UIKit

extension UIColor {
    convenience internal init?(color: FTColor) {
        self.init(named: color.rawValue)
    }
}
