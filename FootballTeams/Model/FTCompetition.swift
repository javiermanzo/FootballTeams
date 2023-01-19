//
//  FTCompetition.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import Foundation

struct FTCompetition: Codable {
    let count: Int
    let competition: FTCompetitionDetails
    let teams: [FTTeam]
}

struct FTCompetitionDetails: Codable {
    let id: Int
    let name: String
    let code: String
    let type: String
    let emblem: String
}
