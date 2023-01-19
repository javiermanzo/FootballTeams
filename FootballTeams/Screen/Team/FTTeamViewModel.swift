//
//  FTTeamViewModel.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import Foundation

class FTTeamViewModel {
    let team: FTTeam
    var tableSecionts = [FTTeamSeaction]()
    
    init(team: FTTeam) {
        self.team = team
    }
    
    func setUpSections() {
        self.tableSecionts = [FTTeamSeaction]()
        
        if !self.team.runningCompetitions.isEmpty {
            self.tableSecionts.append(.competitions)
        }
        
        if let _ = self.team.coach.name {
            self.tableSecionts.append(.coach)
        }
        
        if !self.team.squad.isEmpty {
            self.tableSecionts.append(.squad)
        }
    }
}

enum FTTeamSeaction {
    case competitions
    case coach
    case squad
    
    func title() -> String {
        switch self {
        case .competitions:
            return  "Active Competitions"
        case .coach:
            return "Coach"
        case .squad:
            return "Squad"
        }
    }
}
