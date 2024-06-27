//
//  TibbyTests.swift
//  TibbyTests
//
//  Created by Mateus Moura Godinho on 26/06/24.
//

import XCTest
@testable import Tibby

final class TibbyTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    /// This test case verifies that the Tibby class initializes correctly with the provided parameters and that all properties have the expected values.
    func testTibbyInitialization() throws {
        // Given
        let id = UUID()
        let ownerId = UUID()
        let details = "A cute and fluffy virtual pet."
        let personality = "Friendly"
        let species = "Cat"
        let level = 1
        let xp = 0
        let happiness = 100
        let hunger = 0
        let sleep = 100
        let friendship = 100
        let lastUpdated = Date()
        
        // When
        let tibby = Tibby(id: id, ownerId: ownerId, details: details, personality: personality, species: species, level: level, xp: xp, happiness: happiness, hunger: hunger, sleep: sleep, friendship: friendship, lastUpdated: lastUpdated)
        
        // Then
        XCTAssertEqual(tibby.id, id)
        XCTAssertEqual(tibby.ownerId, ownerId)
        XCTAssertEqual(tibby.details, details)
        XCTAssertEqual(tibby.personality, personality)
        XCTAssertEqual(tibby.species, species)
        XCTAssertEqual(tibby.level, level)
        XCTAssertEqual(tibby.xp, xp)
        XCTAssertEqual(tibby.happiness, happiness)
        XCTAssertEqual(tibby.hunger, hunger)
        XCTAssertEqual(tibby.sleep, sleep)
        XCTAssertEqual(tibby.friendship, friendship)
        XCTAssertEqual(tibby.lastUpdated, lastUpdated)
    }
    
    func testUserInitialization() throws {
        // Given
        let id = UUID()
        let username = "testUser"
        let email = "test@example.com"
        let passwordHash = "hashedPassword"
        
        // When
        let user = User(id: id, username: username, email: email, passwordHash: passwordHash)
        
        // Then
        XCTAssertEqual(user.id, id)
        XCTAssertEqual(user.username, username)
        XCTAssertEqual(user.email, email)
        XCTAssertEqual(user.passwordHash, passwordHash)
    }
    
    func testUserInitializationWithoutOptionalParameters() throws {
        // Given
        let id = UUID()
        let username = "testUser"
        
        // When
        let user = User(id: id, username: username)
        
        // Then
        XCTAssertEqual(user.id, id)
        XCTAssertEqual(user.username, username)
        XCTAssertNil(user.email)
        XCTAssertNil(user.passwordHash)
    }
    
    func testAccessoryInitialization() throws {
        // Given
        let id = UUID()
        let tibbyId = UUID()
        let name = "Hat"
        let image = "hat.png"
        
        // When
        let accessory = Accessory(id: id, tibbyId: tibbyId, name: name, image: image)
        
        // Then
        XCTAssertEqual(accessory.id, id)
        XCTAssertEqual(accessory.tibbyId, tibbyId)
        XCTAssertEqual(accessory.name, name)
        XCTAssertEqual(accessory.image, image)
    }
    
    func testAccessoryInitializationWithoutOptionalParameter() throws {
        // Given
        let id = UUID()
        let name = "Scarf"
        let image = "scarf.png"
        
        // When
        let accessory = Accessory(id: id, name: name, image: image)
        
        // Then
        XCTAssertEqual(accessory.id, id)
        XCTAssertNil(accessory.tibbyId)
        XCTAssertEqual(accessory.name, name)
        XCTAssertEqual(accessory.image, image)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
