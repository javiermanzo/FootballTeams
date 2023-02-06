//
//  FTTeamViewModel.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import Foundation

class FTTeamViewModel {
    var team: FTTeam?
    let teamId: Int
    var tableSecionts = [FTTeamSeaction]()
    
    init(teamId: Int) {
        self.teamId = teamId
    }
    
    func setUpSections() {
        guard let team = self.team else { return }
        self.tableSecionts = [FTTeamSeaction]()
        
        if !team.runningCompetitions.isEmpty {
            self.tableSecionts.append(.competitions)
        }
        
        if let _ = team.coach.name {
            self.tableSecionts.append(.coach)
        }
        
        if !team.squad.isEmpty {
            self.tableSecionts.append(.squad)
        }
    }
    
    func request(completion: @escaping (FTResponse) -> Void) {
        FTTeamGetService(teamId: self.teamId).request { response in
            switch response {
            case .success(let team):
                self.team = team
                completion(.success)
            case .error(let error):
                completion(.error(error))
            }
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
