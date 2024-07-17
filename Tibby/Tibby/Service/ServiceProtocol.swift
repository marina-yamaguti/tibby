//
//  ServiceProtocol.swift
//  Tibby
//
//  Created by Sofia Sartori on 04/07/24.
//

import Foundation

// Define a protocol for the Service
protocol ServiceProtocol {
    // Tibby Operations
    func createTibby(id: UUID, ownerId: UUID?, rarity: String, details: String, personality: String, species: String, level: Int, xp: Int, happiness: Int, hunger: Int, sleep: Int, friendship: Int, lastUpdated: Date, isUnlocked: Bool)
    func deleteTibby(tibby: Tibby)
    func getTibbyByID(id: UUID) -> Tibby?
    func getTibbiesByUserID(userID: UUID) -> [Tibby]
    func getAllTibbies() -> [Tibby]
    func updateTibby(tibby: Tibby, id: UUID?, ownerId: UUID?, rarity: String?, details: String?, personality: String?, species: String?, level: Int?, xp: Int?, happiness: Int?, hunger: Int?, sleep: Int?, friendship: Int?, lastUpdated: Date?)

    // Accessory Operations
    func createAccessory(id: UUID, tibbyId: UUID?, name: String, image: String, price: Int)
    func deleteAccessory(accessory: Accessory)
    func addAccessoryToTibby(tibbyId: UUID, accessory: Accessory)
    func removeAccessoryFromTibby(accessory: Accessory)
    func getAllAccessories() -> [Accessory]?
    func getAccessoryByID(ID: UUID) -> Accessory?
    func getAccessoriesByTibbyID(tibbyID: UUID) -> [Accessory]
    func updateAccessory(accessory: Accessory, id: UUID?, tibbyId: UUID?, name: String?, image: String?, price: Int?)

    // User Operations
    func createUser(id: UUID, username: String, email: String?, passwordHash: String?)
    func deleteUser(user: User)
    func getAllUsers() -> [User]
    func getUser() -> User?
    func updateUser(user: User, id: UUID?, username: String?, email: String?, passwordHash: String?)

    // Activity Operations
    func createActivity(id: UUID, name: String, effect: String)
    func deleteActivity(activity: Activity)
    func getAllActivities() -> [Activity]?
    func getActivityByID(id: UUID) -> Activity?
    func updateActivity(activity: Activity, id: UUID?, name: String?, effect: String?)

    // Interaction Operations
    func createInteraction(id: UUID, tibbyId: UUID, activityId: UUID, timestamp: Date)
    func deleteInteraction(interaction: Interaction)
    func getAllInteractions() -> [Interaction]?
    func getInteractionByID(id: UUID) -> Interaction?
    func updateInteraction(interaction: Interaction, id: UUID?, tibbyId: UUID?, activityId: UUID?, timestamp: Date?)
    func applyInteractionToTibby(_ interaction: Interaction)
    
    // Food Operations
    func createFood(id: UUID, userId: UUID?, name: String, image: String, price: Int)
    func deleteFood(food: Food)
    func removeFoodFromUser(food: Food)
    func getAllFoods() -> [Food]
    func getFoodByID(ID: UUID) -> Food?
    func updateFood(food: Food, id: UUID?, name: String?, image: String?, price: Int?)
}
