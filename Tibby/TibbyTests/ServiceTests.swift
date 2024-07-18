//
//  ServiceTests.swift
//  TibbyTests
//
//  Created by Sofia Sartori on 04/07/24.
//

import Foundation

import XCTest
import SwiftData
@testable import Tibby

// Mock Model Context
class MockModelContext {
    private var objects: [Any] = []
    
    func insert<T>(_ object: T) {
        objects.append(object)
    }
    
    func delete<T>(_ object: T) {
        if let index = objects.firstIndex(where: { ($0 as! T) as AnyObject === object as AnyObject }) {
            objects.remove(at: index)
        }
    }
    
    func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> [T] {
        return objects.compactMap { $0 as? T }
    }
}

// Mock Service
class MockService: ServiceProtocol {
    
    func getActivityByName(name: String) -> Activity? {
        <#code#>
    }
    
    private var tibbies: [Tibby] = []
    private var accessories: [Accessory] = []
    private var users: [User] = []
    private var activities: [Activity] = []
    private var interactions: [Interaction] = []
    private var foods: [Food] = []
    
    func getAllUsers() -> [User] {
        return users
    }
    // Tibby Operations
    func createTibby(id: UUID, ownerId: UUID?, rarity: String, details: String, personality: String, species: String, level: Int, xp: Int, happiness: Int, hunger: Int, sleep: Int, friendship: Int, lastUpdated: Date, isUnlocked: Bool) {
        let tibby = Tibby(id: id, ownerId: ownerId, rarity: rarity, details: details, personality: personality, species: species, level: level, xp: xp, happiness: happiness, hunger: hunger, sleep: sleep, friendship: friendship, lastUpdated: lastUpdated, isUnlocked: isUnlocked)
        tibbies.append(tibby)
    }
    
    func deleteTibby(tibby: Tibby) {
        tibbies.removeAll { $0.id == tibby.id }
    }
    
    func getTibbyByID(id: UUID) -> Tibby? {
        return tibbies.first { $0.id == id }
    }
    
    func getTibbiesByUserID(userID: UUID) -> [Tibby] {
        return tibbies.filter { $0.ownerId == userID }
    }
    
    func getAllTibbies() -> [Tibby] {
        return tibbies
    }
    
    func updateTibby(tibby: Tibby, id: UUID?, ownerId: UUID?, rarity: String?, details: String?, personality: String?, species: String?, level: Int?, xp: Int?, happiness: Int?, hunger: Int?, sleep: Int?, friendship: Int?, lastUpdated: Date?) {
        if let idWP = id { tibby.id = idWP }
        if let ownerIdWP = ownerId { tibby.ownerId = ownerIdWP }
        if let rarityWP = rarity { tibby.rarity = rarityWP }
        if let detailsWP = details { tibby.details = detailsWP }
        if let personalityWP = personality { tibby.personality = personalityWP }
        if let speciesWP = species { tibby.species = speciesWP }
        if let levelWP = level { tibby.level = levelWP }
        if let xpWP = xp { tibby.xp = xpWP }
        if let happinessWP = happiness { tibby.happiness = happinessWP }
        if let hungerWP = hunger { tibby.hunger = hungerWP }
        if let sleepWP = sleep { tibby.sleep = sleepWP }
        if let friendshipWP = friendship { tibby.friendship = friendshipWP }
        if let lastUpdatedWP = lastUpdated { tibby.lastUpdated = lastUpdatedWP }
    }
    
    // Accessory Operations
    func createAccessory(id: UUID, tibbyId: UUID?, name: String, image: String, price: Int) {
        let accessory = Accessory(id: id, tibbyId: tibbyId, name: name, image: image, price: price)
        accessories.append(accessory)
    }
    
    func deleteAccessory(accessory: Accessory) {
        accessories.removeAll { $0.id == accessory.id }
    }
    
    func addAccessoryToTibby(tibbyId: UUID, accessory: Accessory) {
        if let index = accessories.firstIndex(where: { $0.id == accessory.id }) {
            accessories[index].tibbyId = tibbyId
        }
    }
    
    func removeAccessoryFromTibby(accessory: Accessory) {
        if let index = accessories.firstIndex(where: { $0.id == accessory.id }) {
            accessories[index].tibbyId = nil
        }
    }
    
    func getAllAccessories() -> [Accessory]? {
        return accessories
    }
    
    func getAccessoryByID(ID: UUID) -> Accessory? {
        return accessories.first { $0.id == ID }
    }
    
    func getAccessoriesByTibbyID(tibbyID: UUID) -> [Accessory] {
        return accessories.filter { $0.tibbyId == tibbyID }
    }
    
    func updateAccessory(accessory: Accessory, id: UUID?, tibbyId: UUID?, name: String?, image: String?, price: Int?) {
        if let idWP = id { accessory.id = idWP }
        if let tibbyIdWP = tibbyId { accessory.tibbyId = tibbyIdWP }
        if let nameWP = name { accessory.name = nameWP }
        if let imageWP = image { accessory.image = imageWP }
        if let priceWP = price { accessory.price = priceWP }
    }

    // User Operations
    func createUser(id: UUID, username: String, email: String?, passwordHash: String?) {
        let user = User(id: id, username: username, email: email, passwordHash: passwordHash)
        users.append(user)
    }
    
    func deleteUser(user: User) {
        users.removeAll { $0.id == user.id }
    }
    
    func getAllUsers() -> [User]? {
        return users
    }
    
    func getUser() -> User? {
        return users.first
    }
    
    func updateUser(user: User, id: UUID?, username: String?, email: String?, passwordHash: String?) {
        if let idWP = id { user.id = idWP }
        if let usernameWP = username { user.username = usernameWP }
        if let emailWP = email { user.email = emailWP }
        if let passwordHashWP = passwordHash { user.passwordHash = passwordHashWP }
    }

    // Activity Operations
    func createActivity(id: UUID, name: String, effect: String) {
        let activity = Activity(id: id, name: name, effect: effect)
        activities.append(activity)
    }
    
    func deleteActivity(activity: Activity) {
        activities.removeAll { $0.id == activity.id }
    }
    
    func getAllActivities() -> [Activity]? {
        return activities
    }
    
    func getActivityByID(id: UUID) -> Activity? {
        return activities.first { $0.id == id }
    }
    
    func updateActivity(activity: Activity, id: UUID?, name: String?, effect: String?) {
        if let idWP = id { activity.id = idWP }
        if let nameWP = name { activity.name = nameWP }
        if let effectWP = effect { activity.effect = effectWP }
    }

    // Interaction Operations
    func createInteraction(id: UUID, tibbyId: UUID, activityId: UUID, timestamp: Date) -> Interaction {
        let interaction = Interaction(id: id, tibbyId: tibbyId, activityId: activityId, timestamp: timestamp)
        interactions.append(interaction)
    }
    
    func deleteInteraction(interaction: Interaction) {
        interactions.removeAll { $0.id == interaction.id }
    }
    
    func getAllInteractions() -> [Interaction]? {
        return interactions
    }
    
    func getInteractionByID(id: UUID) -> Interaction? {
        return interactions.first { $0.id == id }
    }
    
    func updateInteraction(interaction: Interaction, id: UUID?, tibbyId: UUID?, activityId: UUID?, timestamp: Date?) {
        if let idWP = id { interaction.id = idWP }
        if let tibbyIdWP = tibbyId { interaction.tibbyId = tibbyIdWP }
        if let activityIdWP = activityId { interaction.activityId = activityIdWP }
        if let timestampWP = timestamp { interaction.timestamp = timestampWP }
    }
    func applyInteractionToTibby(interaction: Interaction) {
        guard let activity = self.getActivityByID(id: interaction.activityId) else {return}
        guard let tibby = self.getTibbyByID(id: interaction.tibbyId) else {return}
        
        guard let effectData = activity.effect.data(using: .utf8),
              let effect = try? JSONSerialization.jsonObject(with: effectData, options: []) as? [String: Int] else {
            return
        }
        if let happinessEffect = effect["happiness"] {
            tibby.happiness += happinessEffect
        }
        if let hungerEffect = effect["hunger"] {
            tibby.hunger += hungerEffect
        }
        if let sleepEffect = effect["sleep"] {
            tibby.sleep += sleepEffect
        }
        if let xpEffect = effect["xp"] {
            tibby.xp += xpEffect
        }
        if let friendshipEffect = effect["friendship"] {
            tibby.friendship += friendshipEffect
        }
        return
    }
    func createFood(id: UUID, userId: UUID?, name: String, image: String, price: Int) {
        let food = Food(id: id, name: name, image: image, price: price)
        self.foods.append(food)
    }
    func deleteFood(food: Food) {
        foods.removeAll { $0.id == food.id }
    }
    func addFoodToUser(userId: UUID, food: Food) {
        
    }
    func removeFoodFromUser(food: Food) {
        foods.removeAll { $0.id == food.id }
    }
    func getAllFoods() -> [Food] {
        return foods
    }
    func getFoodByID(ID: UUID) -> Food? {
        return foods.first { $0.id == ID }
    }

    func updateFood(food: Food, id: UUID?, name: String?, image: String?, price: Int?) {
        if let idWP = id { food.id = idWP }
        if let nameWP = name { food.name = nameWP }
        if let imageWP = image { food.image = imageWP }
        if let priceWP = price { food.price = priceWP }
    }
}

final class ServiceTests: XCTestCase {
    var mockService: MockService!

    override func setUp() {
        super.setUp()
        mockService = MockService()
    }

    override func tearDown() {
        mockService = nil
        super.tearDown()
    }

    // MARK: - Tibby Tests

    func testCreateTibby() {
        let id = UUID()
        mockService.createTibby(id: id, ownerId: nil, rarity: "Common", details: "Test details", personality: "Friendly", species: "Test species", level: 1, xp: 0, happiness: 100, hunger: 0, sleep: 100, friendship: 50, lastUpdated: Date(), isUnlocked: true)
        let tibby = mockService.getTibbyByID(id: id)
        XCTAssertNotNil(tibby)
        XCTAssertEqual(tibby?.id, id)
    }

    func testDeleteTibby() {
        let id = UUID()
        mockService.createTibby(id: id, ownerId: nil, rarity: "Common", details: "Test details", personality: "Friendly", species: "Test species", level: 1, xp: 0, happiness: 100, hunger: 0, sleep: 100, friendship: 50, lastUpdated: Date(), isUnlocked: true)
        let tibby = mockService.getTibbyByID(id: id)
        XCTAssertNotNil(tibby)
        mockService.deleteTibby(tibby: tibby!)
        XCTAssertNil(mockService.getTibbyByID(id: id))
    }

    func testGetTibbiesByUserID() {
        let ownerId = UUID()
        mockService.createTibby(id: UUID(), ownerId: ownerId, rarity: "Common", details: "Test details", personality: "Friendly", species: "Test species", level: 1, xp: 0, happiness: 100, hunger: 0, sleep: 100, friendship: 50, lastUpdated: Date(), isUnlocked: true)
        let tibbies = mockService.getTibbiesByUserID(userID: ownerId)
        XCTAssertEqual(tibbies.count, 1)
    }

    func testUpdateTibby() {
        let id = UUID()
        mockService.createTibby(id: id, ownerId: nil, rarity: "Common", details: "Test details", personality: "Friendly", species: "Test species", level: 1, xp: 0, happiness: 100, hunger: 0, sleep: 100, friendship: 50, lastUpdated: Date(), isUnlocked: true)
        let tibby = mockService.getTibbyByID(id: id)
        mockService.updateTibby(tibby: tibby!, id: nil, ownerId: nil, rarity: "Rare", details: nil, personality: nil, species: nil, level: nil, xp: nil, happiness: nil, hunger: nil, sleep: nil, friendship: nil, lastUpdated: nil)
        XCTAssertEqual(mockService.getTibbyByID(id: id)?.rarity, "Rare")
    }

    // MARK: - Accessory Tests

    func testCreateAccessory() {
        let id = UUID()
        mockService.createAccessory(id: id, tibbyId: nil, name: "Hat", image: "hat.png", price: 10)
        let accessory = mockService.getAccessoryByID(ID: id)
        XCTAssertNotNil(accessory)
        XCTAssertEqual(accessory?.id, id)
    }

    func testDeleteAccessory() {
        let id = UUID()
        mockService.createAccessory(id: id, tibbyId: nil, name: "Hat", image: "hat.png", price: 10)
        let accessory = mockService.getAccessoryByID(ID: id)
        XCTAssertNotNil(accessory)
        mockService.deleteAccessory(accessory: accessory!)
        XCTAssertNil(mockService.getAccessoryByID(ID: id))
    }

    func testGetAccessoriesByTibbyID() {
        let tibbyId = UUID()
        mockService.createAccessory(id: UUID(), tibbyId: tibbyId, name: "Hat", image: "hat.png", price: 10)
        let accessories = mockService.getAccessoriesByTibbyID(tibbyID: tibbyId)
        XCTAssertEqual(accessories.count, 1)
    }

    func testUpdateAccessory() {
        let id = UUID()
        mockService.createAccessory(id: id, tibbyId: nil, name: "Hat", image: "hat.png", price: 10)
        let accessory = mockService.getAccessoryByID(ID: id)
        mockService.updateAccessory(accessory: accessory!, id: nil, tibbyId: nil, name: "Cap", image: nil, price: 10)
        XCTAssertEqual(mockService.getAccessoryByID(ID: id)?.name, "Cap")
    }

    // MARK: - User Tests

    func testCreateUser() {
        let id = UUID()
        mockService.createUser(id: id, username: "testUser", email: "test@example.com", passwordHash: "password123")
        let user = mockService.getUser()
        XCTAssertNotNil(user)
        XCTAssertEqual(user?.id, id)
    }

    func testDeleteUser() {
        let id = UUID()
        mockService.createUser(id: id, username: "testUser", email: "test@example.com", passwordHash: "password123")
        let user = mockService.getUser()
        XCTAssertNotNil(user)
        mockService.deleteUser(user: user!)
        XCTAssertNil(mockService.getUser())
    }

    func testUpdateUser() {
        let id = UUID()
        mockService.createUser(id: id, username: "testUser", email: "test@example.com", passwordHash: "password123")
        let user = mockService.getUser()
        mockService.updateUser(user: user!, id: nil, username: "updatedUser", email: nil, passwordHash: nil)
        XCTAssertEqual(mockService.getUser()?.username, "updatedUser")
    }

    // MARK: - Activity Tests

    func testCreateActivity() {
        let id = UUID()
        mockService.createActivity(id: id, name: "Running", effect: "Increase stamina")
        let activity = mockService.getActivityByID(id: id)
        XCTAssertNotNil(activity)
        XCTAssertEqual(activity?.id, id)
    }

    func testDeleteActivity() {
        let id = UUID()
        mockService.createActivity(id: id, name: "Running", effect: "Increase stamina")
        let activity = mockService.getActivityByID(id: id)
        XCTAssertNotNil(activity)
        mockService.deleteActivity(activity: activity!)
        XCTAssertNil(mockService.getActivityByID(id: id))
    }

    func testUpdateActivity() {
        let id = UUID()
        mockService.createActivity(id: id, name: "Running", effect: "Increase stamina")
        let activity = mockService.getActivityByID(id: id)
        mockService.updateActivity(activity: activity!, id: nil, name: "Jogging", effect: nil)
        XCTAssertEqual(mockService.getActivityByID(id: id)?.name, "Jogging")
    }

    // MARK: - Interaction Tests

    func testCreateInteraction() {
        let id = UUID()
        let tibbyId = UUID()
        let activityId = UUID()
        mockService.createInteraction(id: id, tibbyId: tibbyId, activityId: activityId, timestamp: Date())
        let interaction = mockService.getInteractionByID(id: id)
        XCTAssertNotNil(interaction)
        XCTAssertEqual(interaction?.id, id)
    }

    func testDeleteInteraction() {
        let id = UUID()
        let tibbyId = UUID()
        let activityId = UUID()
        mockService.createInteraction(id: id, tibbyId: tibbyId, activityId: activityId, timestamp: Date())
        let interaction = mockService.getInteractionByID(id: id)
        XCTAssertNotNil(interaction)
        mockService.deleteInteraction(interaction: interaction!)
        XCTAssertNil(mockService.getInteractionByID(id: id))
    }

    func testUpdateInteraction() {
        let id = UUID()
        let tibbyId = UUID()
        let activityId = UUID()
        mockService.createInteraction(id: id, tibbyId: tibbyId, activityId: activityId, timestamp: Date())
        let interaction = mockService.getInteractionByID(id: id)
        mockService.updateInteraction(interaction: interaction!, id: nil, tibbyId: nil, activityId: nil, timestamp: Date().addingTimeInterval(60))
        XCTAssertNotNil(mockService.getInteractionByID(id: id))
    }
    
    func testApplyInteractionToTibby() {
           // Setup initial data
           let tibbyId = UUID()
           let activityId = UUID()
           let interactionId = UUID()

           // Create a Tibby
           mockService.createTibby(id: tibbyId, ownerId: nil, rarity: "Common", details: "Test details", personality: "Friendly", species: "Test species", level: 1, xp: 0, happiness: 50, hunger: 50, sleep: 50, friendship: 50, lastUpdated: Date(), isUnlocked: true)
           // Create an Activity with effects
           let effect = "{\"happiness\": 10, \"hunger\": -5, \"sleep\": 5, \"xp\": 20, \"friendship\": 15}"
           mockService.createActivity(id: activityId, name: "Playing", effect: effect)
           // Create an Interaction
           mockService.createInteraction(id: interactionId, tibbyId: tibbyId, activityId: activityId, timestamp: Date())

           // Retrieve the created interaction
           guard let interaction = mockService.getInteractionByID(id: interactionId) else {
               XCTFail("Interaction not created")
               return
           }

           // Apply the interaction effects
        mockService.applyInteractionToTibby(interaction: interaction)

           // Retrieve the Tibby to check the effects
           guard let tibby = mockService.getTibbyByID(id: tibbyId) else {
               XCTFail("Tibby not found")
               return
           }

           // Assertions
           XCTAssertEqual(tibby.happiness, 60)
           XCTAssertEqual(tibby.hunger, 45)
           XCTAssertEqual(tibby.sleep, 55)
           XCTAssertEqual(tibby.xp, 20)
           XCTAssertEqual(tibby.friendship, 65)
       }
}
