//
//  FTDataProviderManager.swift
//  FootballTeams
//
//  Created by Javier Manzo on 06/02/2023.
//

import Foundation

final class FTDataProviderManager {
    private init() {}
    
    private static var selected = FTDataProviderType.service
    
    static func get() -> FTDataProviderProtocol {
        switch self.selected {
        case .mock:
            return FTMockDataProvider()
        case .service:
            return FTServideDataProvider()
        }
    }
    
    static func set(type: FTDataProviderType) {
        self.selected = type
    }
}

enum FTDataProviderType {
    case mock
    case service
}
