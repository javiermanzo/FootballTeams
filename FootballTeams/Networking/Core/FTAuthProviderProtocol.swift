//
//  FTAuthProviderProtocol.swift
//  FootballTeams
//
//  Created by Javier Manzo on 13/02/2023.
//

import Foundation

protocol FTAuthProviderProtocol {
    func getCredentialsHeader() -> [String: String]
}
