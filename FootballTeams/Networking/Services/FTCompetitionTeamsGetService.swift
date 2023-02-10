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
    
    var queryParameters: [String : String]? = nil
    
    var pathParameters: [String : String]? = nil
    
    var body: [String : Any]? = nil
    
    var needAuth: Bool = true
    
    var timeout: TimeInterval = 5
    
    var task: URLSessionTask?
    
    init(competitionCode: String = "CL") {
        self.pathParameters = [
            "COMPETITION_CODE" : "\(competitionCode)"
        ]
        
        self.headers = FTServiceManager.getDefaultHeaders()
    }
}
