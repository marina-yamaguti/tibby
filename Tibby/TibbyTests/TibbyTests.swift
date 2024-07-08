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
    
    func testTibbyProtocol() throws {
        //Given
        let serviceTest = Service(modelContext: ModelContext(try ModelContainer(for: Schema.init(), configurations: ModelConfiguration())))
        let tibbyTest = TibbyProtocolTest()
        let tibbyUUID = UUID()
        let accessoryTest = Accessory(id: UUID(), name: "test", image: "test")
        
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
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
        
    }
}
