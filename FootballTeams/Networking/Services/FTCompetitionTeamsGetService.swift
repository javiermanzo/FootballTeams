//
//  FTCompetitionTeamsGetService.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import Foundation

class FTCompetitionTeamsGetService: FTServiceProtocolWithResult {
    typealias T = FTCompetition
    
    var url: String = "\(FTServiceManager.baseUrl)/competitions/{COMPETITION_CODE}/teams"
    
    var httpMethod: FTHttpMethod = .get
    
    var headers: [String : String]?
    
    var queryParams: [String : String]? = nil
    
    var pathParams: [String : String]? = nil
    
    var body: [String : Any]? = nil
    
    var needAuth: Bool = true
    
    init(competitionCode: String = "CL") {
        self.pathParams = [
            "COMPETITION_CODE" : "\(competitionCode)"
        ]
        
        self.headers = FTServiceManager.getDefaultHeaders()
    }
}
