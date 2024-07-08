import Foundation
import SwiftData

class Service: ObservableObject, ServiceProtocol {
    
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Tibby Operations
    
    /// Adds a Tibby object to the model context.
    func createTibby(id: UUID, ownerId: UUID?, rarity: String, details: String, personality: String, species: String, level: Int, xp: Int, happiness: Int, hunger: Int, sleep: Int, friendship: Int, lastUpdated: Date, isUnlocked: Bool) {
        let tibby = Tibby(id: id, ownerId: ownerId, rarity: rarity, details: details, personality: personality, species: species, level: level, xp: xp, happiness: happiness, hunger: hunger, sleep: sleep, friendship: friendship, lastUpdated: lastUpdated, isUnlocked: isUnlocked)
        modelContext.insert(tibby)
    }
    
    /// Deletes a Tibby object from the model context.
    func deleteTibby(tibby: Tibby) {
        modelContext.delete(tibby)
    }
    
    /// Retrieves a Tibby object by its ID.
    func getTibbyByID(id: UUID) -> Tibby? {
        do {
            let tibbies = try modelContext.fetch(FetchDescriptor<Tibby>())
            for tibby in tibbies {
                if tibby.id == id {
                    return tibby
                }
            }
        } catch {
            print("Error getting Tibby: \(error)")
        }
        return nil
    }
    
    /// Retrieves all Tibbies associated with a given user ID.
    func getTibbiesByUserID(userID: UUID) -> [Tibby] {
        var userTibbies: [Tibby] = []
        do {
            let tibbies = try modelContext.fetch(FetchDescriptor<Tibby>())
            for tibby in tibbies {
                if tibby.ownerId == userID {
                    userTibbies.append(tibby)
                }
            }
        } catch {
            print("Error getting Tibbies: \(error)")
        }
        return userTibbies
    }
    
    /// Retrieves all Tibbies in the model context.
    func getAllTibbies() -> [Tibby]? {
        do {
            let tibbies = try modelContext.fetch(FetchDescriptor<Tibby>())
            return tibbies
        } catch {
            print("Error getting Tibbies: \(error)")
        }
        return nil
    }
    
    /// Updates the atributes of the given tibby 
    func updateTibby(tibby: Tibby, id: UUID?, ownerId: UUID?, rarity: String?, details: String?, personality: String?, species: String?, level: Int?, xp: Int?, happiness: Int?, hunger: Int?, sleep: Int?, friendship: Int?, lastUpdated: Date?) {
        if let idWP = id {tibby.id = idWP}
        if let ownerIdWP = ownerId {tibby.ownerId = ownerIdWP}
        if let rarityWP = rarity {tibby.rarity = rarityWP}
        if let detailsWP = details {tibby.details = detailsWP}
        if let personalityWP = personality {tibby.personality = personalityWP}
        if let speciesWP = species {tibby.species = speciesWP}
        if let levelWP = level {tibby.level = levelWP}
        if let xpWP = xp {tibby.xp = xpWP}
        if let happinessWP = happiness {tibby.happiness = happinessWP}
        if let hungerWP = hunger {tibby.hunger = hungerWP}
        if let sleepWP = sleep {tibby.sleep = sleepWP}
        if let friendshipWP = friendship {tibby.friendship = friendshipWP}
        if let lastUpdatedWP = lastUpdated {tibby.lastUpdated = lastUpdatedWP}
    }
    
    // MARK: - Accessory Operations
    
    /// Adds an Accessory object to the model context.
    func createAccessory(id: UUID, tibbyId: UUID?, name: String, image: String) {
        var accessory = Accessory(id: id, tibbyId: tibbyId, name: name, image: image)
        modelContext.insert(accessory)
    }
    
    /// Deletes an Accessory object from the model context.
    func deleteAccessory(accessory: Accessory) {
        modelContext.delete(accessory)
    }
    
    /// Adds an Accessory to a Tibby specified by Tibby ID.
    func addAccessoryToTibby(tibbyId: UUID, accessory: Accessory) {
        accessory.tibbyId = tibbyId
    }
    
    /// Removes an Accessory from a Tibby.
    func removeAccessoryFromTibby(accessory: Accessory) {
        accessory.tibbyId = nil
    }
    
    /// Retrieves all Accessories in the model context.
    func getAllAccessories() -> [Accessory]? {
        do {
            let accessories = try modelContext.fetch(FetchDescriptor<Accessory>())
            return accessories
        } catch {
            print("Error getting Accessories: \(error)")
        }
        return nil
    }
    
    /// Retrieves a Accessory object by its ID.
    func getAccessoryByID(ID: UUID) -> Accessory? {
        do {
            let accessories = try modelContext.fetch(FetchDescriptor<Accessory>())
            for accessory in accessories {
                if accessory.id == ID {
                    return accessory
                }
            }
        } catch {
            print("Error getting Accessories: \(error)")
        }
        return nil
    }
    
    /// Retrieves all Accessories associated with a given Tibby ID.
    func getAccessoriesByTibbyID(tibbyID: UUID) -> [Accessory] {
        var tibbyAccessories: [Accessory] = []
        do {
            let accessories = try modelContext.fetch(FetchDescriptor<Accessory>())
            for accessory in accessories {
                if accessory.tibbyId == tibbyID {
                    tibbyAccessories.append(accessory)
                }
            }
        } catch {
            print("Error getting Tibbies: \(error)")
        }
        return tibbyAccessories
    }
    
    /// Updates the atributes of the given accessory
    func updateAccessory(accessory: Accessory, id: UUID?, tibbyId: UUID?, name: String?, image: String?) {
        if let idWP = id {accessory.id = idWP}
        if let tibbyIdWP = tibbyId {accessory.tibbyId = tibbyIdWP}
        if let nameWP = name {accessory.name = nameWP}
        if let imageWP = image {accessory.image = imageWP}
    }
    
    // MARK: - User Operations
    /// Adds a User object to the model context.
    func createUser(id: UUID, username: String, email: String?, passwordHash: String?) {
        var user = User(id: id, username: username, email: email, passwordHash: passwordHash)
        modelContext.insert(user)
    }
    
    /// Deletes a User from the model context.
    func deleteUser(user: User) {
        modelContext.delete(user)
    }
    
    /// Retrieves all Users
    func getAllUsers() -> [User]? {
        do {
            let users = try modelContext.fetch(FetchDescriptor<User>())
            return users
        } catch {
            print("Error getting Users: \(error)")
        }
        return nil
    }
    
    /// Retrieves the first User
    func getUser() -> User? {
        do {
            let users = try modelContext.fetch(FetchDescriptor<User>())
            return users.first
        } catch {
            print("Error getting Users: \(error)")
        }
        return nil
    }
    
    /// Updates the atributes of the given User
    func updateUser(user: User, id: UUID?, username: String?, email: String?, passwordHash: String?) {
        if let idWP = id {user.id = idWP}
        if let usernameWP = username {user.username = usernameWP}
        if let emailWP = email {user.email = emailWP}
        if let passwordHashWP = passwordHash {user.passwordHash = passwordHashWP}
    }
    
    //MARK: - Activity Operations
    
    /// Adds a Activity object to the model context.
    func createActivity(id: UUID, name: String, effect: String) {
        var activity = Activity(id: id, name: name, effect: effect)
        modelContext.insert(activity)
    }
    
    /// Deletes a Activity from the model context.
    func deleteActivity(activity: Activity) {
        modelContext.delete(activity)
    }
    
    /// Retrieves all Activities
    func getAllActivities() -> [Activity]? {
        do {
            let activities = try modelContext.fetch(FetchDescriptor<Activity>())
            return activities
        } catch {
            print("Error getting activities: \(error)")
        }
        return nil
    }
    
    /// Retrieves a Activity based on the given ID
    func getActivityByID(id: UUID) -> Activity? {
        do {
            let activities = try modelContext.fetch(FetchDescriptor<Activity>())
            for activity in activities {
                if activity.id == id {
                    return activity
                }
            }
        } catch {
            print("Error getting activities: \(error)")
        }
        return nil
    }
    
    /// Updates the atributes of the given activity
    func updateActivity(activity: Activity, id: UUID?, name: String?, effect: String?) {
        if let idWP = id {activity.id = idWP}
        if let nameWP = name {activity.name = nameWP}
        if let effectWP = effect {activity.effect = effectWP}
    }
    
    //MARK: - Interaction Operations
    
    /// Adds a Interaction object to the model context.
    func createInteraction(id: UUID, tibbyId: UUID, activityId: UUID, timestamp: Date) {
        var interaction = Interaction(id: id, tibbyId: tibbyId, activityId: activityId, timestamp: timestamp)
        modelContext.insert(interaction)
    }
    
    /// Deletes a Interaction from the model context.
    func deleteInteraction(interaction: Interaction) {
        modelContext.delete(interaction)
    }
    
    /// Retrieves all Interactions
    func getAllInteractions() -> [Interaction]? {
        do {
            let interactions = try modelContext.fetch(FetchDescriptor<Interaction>())
            return interactions
        } catch {
            print("Error getting activities: \(error)")
        }
        return nil
    }
    
    /// Retrieves a Interaction based on the given ID
    func getInteractionByID(id: UUID) -> Interaction? {
        do {
            let interactions = try modelContext.fetch(FetchDescriptor<Interaction>())
            for interaction in interactions {
                if interaction.id == id {
                    return interaction
                }
            }
        } catch {
            print("Error getting activities: \(error)")
        }
        return nil
    }
    
    /// Updates the atributes of the given interaction
    func updateInteraction(interaction: Interaction, id: UUID?, tibbyId: UUID?, activityId: UUID?, timestamp: Date?) {
        if let idWP = id {interaction.id = idWP}
        if let tibbyIdWP = tibbyId {interaction.tibbyId = tibbyIdWP}
        if let activityIdWP = activityId {interaction.activityId = activityIdWP}
    }
}
