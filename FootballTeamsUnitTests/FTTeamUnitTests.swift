//
//  FTTeamUnitTests.swift
//  FootballTeamsUnitTests
//
//  Created by Javier Manzo on 07/02/2023.
//

import XCTest
@testable import FootballTeams

final class FTTeamUnitTests: XCTestCase {
    
    func testMockTeamViewModel() throws {
        try self.testTeamViewModel(provider: FTMockDataProvider())
    }
    
    func testServiceTeamViewModel() throws {
        try self.testTeamViewModel(provider: FTServiceDataProvider())
    }
    
    func testTeamViewModel(provider: FTDataProviderProtocol) throws {
        let viewModel = FTTeamViewModel(teamId: 4, dataProvider: FTServiceDataProvider())
        
        let expectation = self.expectation(description: "Test \(FTTeamViewModel.self) \(provider.self)")
        
        viewModel.request { response in
            switch response {
            case .success:
                XCTAssertNotNil(viewModel.team)
                expectation.fulfill()
            case .error(let error):
                XCTFail("Expected success, but got error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 4)
    }
}
