//
//  UITableView-extension.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import UIKit

public extension UITableView {
    func registerCellClass<T: UITableViewCell>(_: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.className)
    }
    
    func registerCellNib<T: UITableViewCell>(_: T.Type) {
        self.register(T.nib, forCellReuseIdentifier: T.className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_: T.Type) -> T? {
        if let cell = self.dequeueReusableCell(withIdentifier: T.className) as? T {
            return cell
        }
        return nil
    }
    
    func clearExtraSeparators() {
        self.tableFooterView = UIView()
    }
}
