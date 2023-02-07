//
//  FTServiceDataProvider.swift
//  FootballTeams
//
//  Created by Javier Manzo on 06/02/2023.
//

import Foundation

class FTServideDataProvider: FTDataProviderProtocol {
    func requestCompetition(competitionCode: String, completion: @escaping (FTResponseWithResult<FTCompetition>) -> ()) {
        FTCompetitionTeamsGetService(competitionCode: competitionCode).request(completion: completion)
    }
    
    func requestTeam(teamId: Int, completion: @escaping (FTResponseWithResult<FTTeam>) -> ()) {
        FTTeamGetService(teamId: teamId).request(completion: completion)
    }
}
