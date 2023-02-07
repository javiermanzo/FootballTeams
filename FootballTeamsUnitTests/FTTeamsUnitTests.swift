//
//  FootballTeamsUnitTests.swift
//  FootballTeamsUnitTests
//
//  Created by Javier Manzo on 06/02/2023.
//

import XCTest
@testable import FootballTeams

final class FootballTeamsUnitTests: XCTestCase {
    
    func testMockTeamsViewModel() throws {
        try self.testTeamsViewModel(provider: FTMockDataProvider())
    }
    
    func testServiceTeamsViewModel() throws {
        try self.testTeamsViewModel(provider: FTServiceDataProvider())
    }
    
    func testTeamsViewModel(provider: FTDataProviderProtocol) throws {
        let viewModel = FTTeamsViewModel(dataProvider:provider)
        
        let expectation = self.expectation(description: "Test \(FTTeamsViewModel.self) \(provider.self)")
        
        viewModel.request { response in
            switch response {
            case .success:
                XCTAssertNotNil(viewModel.competition)
                expectation.fulfill()
            case .error(let error):
                XCTFail("Expected success, but got error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 4)
    }
}
