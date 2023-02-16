//
//  FTTeamGetService.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import Foundation
import Harbor

class FTTeamGetService: HServiceProtocolWithResult {
    
    typealias T = FTTeam
    
    var url: String = "\(FTConfiguration.baseUrl)/teams/{TEAM_ID}/"
    
    var httpMethod: HHttpMethod = .get
    
    var headers: [String : String]?
    
    var queryParameters: [String : String]? = nil
    
    var pathParameters: [String : String]? = nil
    
    var body: [String : Any]? = nil
    
    var needAuth: Bool = true
    
    var timeout: TimeInterval = 5
    
    init(teamId: Int) {
        self.pathParameters = [
            "TEAM_ID" : "\(teamId)"
        ]
        
        self.headers = FTServiceProvider.getDefaultHeaders()
    }
}
