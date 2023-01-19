//
//  FTResponse.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import Foundation

public enum FTResponse {
    case success
    case error(FTServiceError?)
}

public enum FTResponseWithResult<T> {
    case success(T)
    case error(FTServiceError?)
}
