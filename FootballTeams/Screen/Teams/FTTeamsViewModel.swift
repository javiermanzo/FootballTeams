//
//  FTTeamsViewModel.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import Foundation
import Harbor

class FTTeamsViewModel {
    let dataProvider: FTDataProviderProtocol
    var competition: FTCompetition?
    
    init(dataProvider: FTDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func request(completion: @escaping (HResponse) -> Void) {
        self.dataProvider.requestCompetition(competitionCode: "CL") { [weak self] response in
            switch response {
            case .success(let competition):
                self?.competition = competition
                completion(.success)
            case .cancelled:
                completion(.cancelled)
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
