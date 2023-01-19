//
//  FTTeam.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import Foundation

struct FTTeam: Codable {
    let id: Int
    let name: String
    let shortName: String?
    let crest: String?
    let founded: Int?
    let area: FTTeamArea?
    let coach: FTTeamCoach
    let squad: [FTTeamPlayer]
    let runningCompetitions: [FTTeamCompetition]
}

struct FTTeamCoach: Codable {
    let id: Int?
    let name: String?
    let dateOfBirth: String?
    let nationality: String?
}

struct FTTeamPlayer: Codable {
    let id: Int
    let name: String
    let position: String?
    let dateOfBirth: String
    let nationality: String?
}

struct FTTeamArea: Codable {
    let id: Int
    let name: String
    let code: String
    let flag: String?
}

struct FTTeamCompetition: Codable {
    let id: Int
    let name: String
    let type: String
    let emblem: String?
}
