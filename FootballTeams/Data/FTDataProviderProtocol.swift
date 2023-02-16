//
//  FTDataProviderProtocol.swift
//  FootballTeams
//
//  Created by Javier Manzo on 06/02/2023.
//

import Foundation
import Harbor

protocol FTDataProviderProtocol {
    func requestCompetition(competitionCode: String, completion: @escaping (HResponseWithResult<FTCompetition>)->())
    func requestTeam(teamId: Int, completion: @escaping (HResponseWithResult<FTTeam>)->())
}
