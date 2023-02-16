//
//  FTCompetitionTeamsGetService.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import Foundation
import Harbor

class FTCompetitionTeamsGetService: HServiceProtocolWithResult {
    
    typealias T = FTCompetition
    
    var url: String = "\(FTConfiguration.baseUrl)/competitions/{COMPETITION_CODE}/teams"
    
    var httpMethod: HHttpMethod = .get
    
    var headers: [String : String]?
    
    var queryParameters: [String : String]? = nil
    
    var pathParameters: [String : String]? = nil
    
    var body: [String : Any]? = nil
    
    var needAuth: Bool = true
    
    var timeout: TimeInterval = 5
    
    init(competitionCode: String = "CL") {
        self.pathParameters = [
            "COMPETITION_CODE" : "\(competitionCode)"
        ]
        
        self.headers = FTServiceProvider.getDefaultHeaders()
    }
}
