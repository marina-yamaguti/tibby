//
//  ServiceProtocol.swift
//  Tibby
//
//  Created by Sofia Sartori on 04/07/24.
//

import Foundation

/// `ServiceProtocol` defines a set of operations for managing the various entities within the Tibby app.
/// This protocol abstracts the functionality for creating, updating, retrieving, and deleting entities such as Tibby, Accessory, User, Activity, Interaction, and Food.
protocol ServiceProtocol {
    
    // MARK: - Tibby Operations
    
    /// Creates a new Tibby with the specified attributes.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the Tibby.
    ///   - ownerId: The unique identifier of the Tibby's owner (if any).
    ///   - name: The name of the Tibby.
    ///   - rarity: The rarity level of the Tibby.
    ///   - details: Detailed information about the Tibby.
    ///   - personality: The personality traits of the Tibby.
    ///   - species: The species to which the Tibby belongs.
    ///   - happiness: The happiness level of the Tibby.
    ///   - hunger: The hunger level of the Tibby.
    ///   - sleep: The sleep level of the Tibby.
    ///   - friendship: The friendship level with the Tibby.
    ///   - lastUpdated: The date when the Tibby was last updated.
    ///   - isUnlocked: A Boolean value indicating whether the Tibby is unlocked.
    ///   - collection: The collection to which the Tibby belongs.
    func createTibby(id: UUID, ownerId: UUID?, name: String, rarity: String, details: String, personality: String, species: String, happiness: Int, hunger: Int, sleep: Int, friendship: Int, lastUpdated: Date, isUnlocked: Bool, collection: String)
    
    /// Deletes the specified Tibby.
    ///
    /// - Parameter tibby: The Tibby object to delete.
    func deleteTibby(tibby: Tibby)
    
    /// Retrieves a Tibby by its unique identifier.
    ///
    /// - Parameter id: The unique identifier of the Tibby.
    /// - Returns: The Tibby object if found, otherwise `nil`.
    func getTibbyByID(id: UUID) -> Tibby?
    
    /// Retrieves all Tibbies owned by a specific user.
    ///
    /// - Parameter userID: The unique identifier of the user.
    /// - Returns: An array of Tibbies owned by the user.
    func getTibbiesByUserID(userID: UUID) -> [Tibby]
    
    /// Retrieves all Tibbies in the system.
    ///
    /// - Returns: An array of all Tibbies.
    func getAllTibbies() -> [Tibby]
    
    /// Updates the specified Tibby with new attributes.
    ///
    /// - Parameters:
    ///   - tibby: The Tibby object to update.
    ///   - id: The new unique identifier for the Tibby (optional).
    ///   - ownerId: The new unique identifier of the Tibby's owner (optional).
    ///   - rarity: The new rarity level of the Tibby (optional).
    ///   - details: The new detailed information about the Tibby (optional).
    ///   - personality: The new personality traits of the Tibby (optional).
    ///   - species: The new species of the Tibby (optional).
    ///   - happiness: The new happiness level of the Tibby (optional).
    ///   - hunger: The new hunger level of the Tibby (optional).
    ///   - sleep: The new sleep level of the Tibby (optional).
    ///   - friendship: The new friendship level of the Tibby (optional).
    ///   - lastUpdated: The new last updated date for the Tibby (optional).
    func updateTibby(tibby: Tibby, id: UUID?, ownerId: UUID?, rarity: String?, details: String?, personality: String?, species: String?, happiness: Int?, hunger: Int?, sleep: Int?, friendship: Int?, lastUpdated: Date?)
    
    // MARK: - Accessory Operations
    
    /// Creates a new Accessory with the specified attributes.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the Accessory.
    ///   - tibbyId: The unique identifier of the Tibby to which the Accessory belongs (optional).
    ///   - name: The name of the Accessory.
    ///   - image: The image representing the Accessory.
    ///   - price: The price of the Accessory.
    ///   - category: The category of the Accessory.
    func createAccessory(id: UUID, tibbyId: UUID?, name: String, image: String, price: Int, category: String)
    
    /// Deletes the specified Accessory.
    ///
    /// - Parameter accessory: The Accessory object to delete.
    func deleteAccessory(accessory: Accessory)
    
    /// Adds an Accessory to a specific Tibby.
    ///
    /// - Parameters:
    ///   - tibbyId: The unique identifier of the Tibby.
    ///   - accessory: The Accessory object to add.
    func addAccessoryToTibby(tibbyId: UUID, accessory: Accessory)
    
    /// Removes an Accessory from a Tibby.
    ///
    /// - Parameter accessory: The Accessory object to remove.
    func removeAccessoryFromTibby(accessory: Accessory)
    
    /// Retrieves all Accessories.
    ///
    /// - Returns: An array of all Accessories, or `nil` if none are found.
    func getAllAccessories() -> [Accessory]?
    
    /// Retrieves an Accessory by its unique identifier.
    ///
    /// - Parameter ID: The unique identifier of the Accessory.
    /// - Returns: The Accessory object if found, otherwise `nil`.
    func getAccessoryByID(ID: UUID) -> Accessory?
    
    /// Retrieves all Accessories associated with a specific Tibby.
    ///
    /// - Parameter tibbyID: The unique identifier of the Tibby.
    /// - Returns: An array of Accessories associated with the Tibby.
    func getAccessoriesByTibbyID(tibbyID: UUID) -> [Accessory]
    
    /// Updates the specified Accessory with new attributes.
    ///
    /// - Parameters:
    ///   - accessory: The Accessory object to update.
    ///   - id: The new unique identifier for the Accessory (optional).
    ///   - tibbyId: The new unique identifier of the Tibby to which the Accessory belongs (optional).
    ///   - name: The new name of the Accessory (optional).
    ///   - image: The new image of the Accessory (optional).
    ///   - price: The new price of the Accessory (optional).
    func updateAccessory(accessory: Accessory, id: UUID?, tibbyId: UUID?, name: String?, image: String?, price: Int?)
    
    // MARK: - User Operations
    
    /// Creates a new User with the specified attributes.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the User.
    ///   - username: The username of the User.
    ///   - email: The email address of the User (optional).
    ///   - passwordHash: The hashed password of the User (optional).
    func createUser(id: UUID, username: String, email: String?, passwordHash: String?, level: Int, xp: Int)
    
    /// Deletes the specified User.
    ///
    /// - Parameter user: The User object to delete.
    func deleteUser(user: User)
    
    /// Retrieves all Users.
    ///
    /// - Returns: An array of all Users.
    func getAllUsers() -> [User]
    
    /// Retrieves the currently authenticated User.
    ///
    /// - Returns: The User object if found, otherwise `nil`.
    func getUser() -> User?
    
    /// Updates the specified User with new attributes.
    ///
    /// - Parameters:
    ///   - user: The User object to update.
    ///   - id: The new unique identifier for the User (optional).
    ///   - username: The new username of the User (optional).
    ///   - email: The new email address of the User (optional).
    ///   - passwordHash: The new hashed password of the User (optional).
    func updateUser(user: User, id: UUID?, username: String?, email: String?, passwordHash: String?)
    
    // MARK: - Activity Operations
    
    /// Creates a new Activity with the specified attributes.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the Activity.
    ///   - name: The name of the Activity.
    ///   - effect: The effect the Activity has on Tibby.
    func createActivity(id: UUID, name: String, effect: String)
    
    /// Deletes the specified Activity.
    ///
    /// - Parameter activity: The Activity object to delete.
    func deleteActivity(activity: Activity)
    
    /// Retrieves all Activities.
    ///
    /// - Returns: An array of all Activities, or `nil` if none are found.
    func getAllActivities() -> [Activity]?
}
