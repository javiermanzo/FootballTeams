//
//  FTTeamsViewModel.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import Foundation

class FTTeamsViewModel {
    let dataProvider: FTDataProviderProtocol
    var competition: FTCompetition?
    
    init(dataProvider: FTDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func request(completion: @escaping (FTResponse) -> Void) {
        self.dataProvider.requestCompetition(competitionCode: "CL") { [weak self] response in
            switch response {
            case .success(let competition):
                self?.competition = competition
                completion(.success)
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
