//
//  FTServiceProvider.swift
//  FootballTeams
//
//  Created by Javier Manzo on 13/02/2023.
//

import Foundation

class FTServiceProvider: FTAuthProviderProtocol {
    
    init() {
        FTServiceManager.authProvider = self
    }
    
    func getCredentialsHeader() -> [String : String] {
        let header = ["X-Auth-Token": FTConfiguration.apikey]
        return header
    }
}
