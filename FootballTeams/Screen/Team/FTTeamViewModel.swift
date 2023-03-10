//
//  FTTeamViewModel.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import Foundation
import Harbor

class FTTeamViewModel {
    var team: FTTeam?
    let teamId: Int
    var tableSecionts = [FTTeamSeaction]()
    let dataProvider: FTDataProviderProtocol
    
    init(teamId: Int, dataProvider: FTDataProviderProtocol) {
        self.teamId = teamId
        self.dataProvider = dataProvider
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
    
    func request(completion: @escaping (HResponse) -> Void) {
        self.dataProvider.requestTeam(teamId: teamId) { [weak self] response in
            switch response {
            case .success(let team):
                self?.team = team
                completion(.success)
            case .cancelled:
                completion(.cancelled)
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
