//
//  FTTeamGetService.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import Foundation

class FTTeamGetService: FTServiceProtocolWithResult {
    typealias T = FTTeam
    
    var url: String = "\(FTServiceManager.baseUrl)/teams/{TEAM_ID}/"
    
    var httpMethod: FTHttpMethod = .get
    
    var headers: [String : String]?
    
    var queryParams: [String : String]? = nil
    
    var pathParams: [String : String]? = nil
    
    var body: [String : Any]? = nil
    
    var needAuth: Bool = true
    
    init(teamId: Int) {
        self.pathParams = [
            "{TEAM_ID}" : "\(teamId)"
        ]
        
        self.headers = FTServiceManager.getDefaultHeaders()
    }
}
