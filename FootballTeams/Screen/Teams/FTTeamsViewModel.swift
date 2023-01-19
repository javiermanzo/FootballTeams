//
//  FTTeamsViewModel.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import Foundation

class FTTeamsViewModel {
    var competition: FTCompetition?
    
    func request(completion: @escaping (FTResponse) -> Void) {
        FTCompetitionTeamsGetService().request { response in
            switch response {
            case .success(let competition):
                self.competition = competition
                completion(.success)
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
