//
//  TibbyTests.swift
//  TibbyTests
//
//  Created by Mateus Moura Godinho on 26/06/24.
//

import XCTest
@testable import Tibby
import SpriteKit
import SwiftData

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
   
    class TibbyProtocolTest: TibbyProtocol {
        var tibbyObject: Tibby?
        
        func setTibby(tibbyObject: Tibby, constants: Constants, service: Service) {
            
        }
        
        var tibbySpecie: TibbySpecie?
        
        func setTibbySpecie(tibbySpecie: TibbySpecie) {
            
            
        }
        
        
        var tibby: SKSpriteNode = SKSpriteNode()
        var accessory: SKSpriteNode = SKSpriteNode()
        var tibbyID: UUID?
        
        func addAccessory(_ accessory: Accessory, _ service: Service, tibbyID: UUID?) {
            self.accessory.name = accessory.name
            tibby.addChild(self.accessory)
        }
        
        func removeAccessory(_ service: Service) {
            if let child = self.accessory as? SKSpriteNode {
                child.removeFromParent()
            }
        }
        
        func animateTibby(_ textureList: [String], nodeID: NodeType, timeFrame: TimeInterval) {
            if nodeID == . tibby {
                self.tibby.name = textureList[0] + String(timeFrame)
            }
        }
        
        func setTibbyID(tibbyId: UUID) {
            self.tibbyID = tibbyId
        }
        
    }
    
    class RewardProtocolTets: RewardProtocol {
        func reward(quantity: Int, rewardType: RewardType, user: User? = nil, tibby: Tibby? = nil) {
            switch rewardType {
            case .xp:
                if let tibby = tibby {
                    tibby.xp = quantity
                }
            case .coin:
                if let user = user {
                    user.coins = quantity
                }
            case .gem:
                if let user = user {
                    user.gems = quantity
                }
            }
        }
        
        func levelUp(_ tibby: Tibby) {
            tibby.level += 1
        }
        
        
    }
    
    func testTibbyProtocol() throws {
        //Given
        let serviceTest = Service(modelContext: ModelContext(try ModelContainer(for: Schema.init(), configurations: ModelConfiguration())))
        let tibbyTest = TibbyProtocolTest()
        let tibbyUUID = UUID()
        let accessoryTest = Accessory(id: UUID(), name: "test", image: "test", price: 10)
        
        //When
        tibbyTest.setTibbyID(tibbyId: tibbyUUID)
        tibbyTest.animateTibby(["Tibby"], nodeID: .tibby, timeFrame: 1)
        tibbyTest.addAccessory(accessoryTest, serviceTest, tibbyID: UUID())
        
        //Then
        XCTAssertEqual(tibbyTest.tibbyID, tibbyUUID)
        XCTAssertEqual(tibbyTest.tibby.name, "Tibby1.0")
        XCTAssertEqual(tibbyTest.accessory.name, "test")
        
        //When
        tibbyTest.removeAccessory(serviceTest)
        //Then
        XCTAssertEqual(tibbyTest.tibby.children, [])
    }
    
    func testRewardProtocol() throws {
        //Given
        let rewardTest = RewardProtocolTets()
        var userMock = User(id: UUID(), username: "")
        var tibbyMock = Tibby(id: UUID(), ownerId: UUID(), rarity: "", details: "", personality: "", species: "", level: 1, xp: 0, happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: false, collection: "seaSeries")
        let quantity = 10
        
        //When
        rewardTest.reward(quantity: quantity, rewardType: .xp, tibby: tibbyMock)
        rewardTest.reward(quantity: quantity, rewardType: .coin, user: userMock)
        rewardTest.reward(quantity: quantity, rewardType: .gem, user: userMock)
        rewardTest.levelUp(tibbyMock)
        
        //Then
        
        XCTAssertEqual(tibbyMock.xp, quantity)
        XCTAssertEqual(tibbyMock.level, 2)
        XCTAssertEqual(userMock.coins, quantity)
        XCTAssertEqual(userMock.gems, quantity)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
        
    }
}
