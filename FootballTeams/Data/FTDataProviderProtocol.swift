//
//  FTDataProviderProtocol.swift
//  FootballTeams
//
//  Created by Javier Manzo on 06/02/2023.
//

import Foundation

protocol FTDataProviderProtocol {
    func requestCompetition(competitionCode: String, completion: @escaping (FTResponseWithResult<FTCompetition>)->())
    func requestTeam(teamId: Int, completion: @escaping (FTResponseWithResult<FTTeam>)->())
}
