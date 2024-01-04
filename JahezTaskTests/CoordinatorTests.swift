//
//  CoordinatorTests.swift
//  JahezTaskTests
//
//  Created by Eslam Salem on 03/01/2024.
//

import XCTest
@testable import JahezTask

class CoordinatorTests: XCTestCase {
    
    func testPushAndPop() {
        let coordinator = Coordinator()
        
        coordinator.push(.homeScreen)
        coordinator.push(.movieDetails(movieID: 1))
        
        let initialCount = coordinator.path.count
        
        XCTAssertEqual(coordinator.path.count, 2)
        
        coordinator.pop()
        
        XCTAssertEqual(coordinator.path.count, initialCount - 1)
    }
}
