//
//  FTIdentifierProtocol.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import Foundation

public protocol FTIdentifierProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension FTIdentifierProtocol {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}
