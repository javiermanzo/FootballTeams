//
//  FTServiceDataProvider.swift
//  FootballTeams
//
//  Created by Javier Manzo on 06/02/2023.
//

import Foundation
import Harbor

class FTServiceDataProvider: FTDataProviderProtocol {
    func requestCompetition(competitionCode: String, completion: @escaping (HResponseWithResult<FTCompetition>) -> ()) {
        Task {
            let response = await FTCompetitionTeamsGetService(competitionCode: competitionCode).request()
            completion(response)
        }
    }
    
    func requestTeam(teamId: Int, completion: @escaping (HResponseWithResult<FTTeam>) -> ()) {
        Task {
            let response = await FTTeamGetService(teamId: teamId).request()
            completion(response)
        }
    }
}
