import Foundation
import SwiftData

class Service: ObservableObject, ServiceProtocol {
    
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Tibby Operations
    
    /// Adds a Tibby object to the model context.
    func createTibby(id: UUID, ownerId: UUID? = nil, rarity: String, details: String, personality: String, species: String, level: Int, xp: Int, happiness: Int, hunger: Int, sleep: Int, friendship: Int, lastUpdated: Date, isUnlocked: Bool) {
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
    func updateTibby(tibby: Tibby, id: UUID? = nil, ownerId: UUID? = nil, rarity: String? = nil, details: String? = nil, personality: String? = nil, species: String? = nil, level: Int? = nil, xp: Int? = nil, happiness: Int? = nil, hunger: Int? = nil, sleep: Int? = nil, friendship: Int? = nil, lastUpdated: Date? = nil) {
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
    func createAccessory(id: UUID, tibbyId: UUID? = nil, name: String, image: String, price: Int) {
        let accessory = Accessory(id: id, tibbyId: tibbyId, name: name, image: image, price: price)
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
    func updateAccessory(accessory: Accessory, id: UUID? = nil, tibbyId: UUID? = nil, name: String? = nil, image: String? = nil, price: Int? = nil) {
        if let idWP = id {accessory.id = idWP}
        if let tibbyIdWP = tibbyId {accessory.tibbyId = tibbyIdWP}
        if let nameWP = name {accessory.name = nameWP}
        if let imageWP = image {accessory.image = imageWP}
        if let priceWP = price {accessory.price = priceWP}
    }
    
    // MARK: - User Operations
    /// Adds a User object to the model context.
    func createUser(id: UUID, username: String, email: String? = nil, passwordHash: String? = nil) {
        let user = User(id: id, username: username, email: email, passwordHash: passwordHash)
        modelContext.insert(user)
    }
    
    /// Deletes a User from the model context.
    func deleteUser(user: User) {
        modelContext.delete(user)
    }
    
    /// Retrieves all Users
    func getAllUsers() -> [User] {
        var users: [User] = []
        do {
            users = try modelContext.fetch(FetchDescriptor<User>())
        } catch {
            print("Error getting Users: \(error)")
        }
        return users
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
    func updateUser(user: User, id: UUID? = nil, username: String? = nil, email: String? = nil, passwordHash: String? = nil) {
        if let idWP = id {user.id = idWP}
        if let usernameWP = username {user.username = usernameWP}
        if let emailWP = email {user.email = emailWP}
        if let passwordHashWP = passwordHash {user.passwordHash = passwordHashWP}
    }
    
    /// Retrieves all the ids of the foods from the user with its quantities
    func getFoodsIDsFromUser() -> [UUID : Int] {
        if let user = self.getUser() {
            return user.foodInventory
        }
        return [:]
    }
    
    func getFoodsFromUser() -> [Food : Int] {
        var foods: [Food : Int] = [:]
        let foodIDs = self.getFoodsIDsFromUser()
        
        for (fID, count) in foodIDs {
            guard let food = self.getFoodByID(ID: fID) else {
                print("error: no food matching")
                continue
            }
            
            if let currentQuantity = foods[food] {
                foods[food] = currentQuantity + count
            } else {
                foods[food] = count
            }
        }
        return foods
    }
    
    //MARK: - Activity Operations
    
    /// Adds a Activity object to the model context.
    func createActivity(id: UUID, name: String, effect: String) {
        let activity = Activity(id: id, name: name, effect: effect)
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
    func updateActivity(activity: Activity, id: UUID? = nil, name: String? = nil, effect: String? = nil) {
        if let idWP = id {activity.id = idWP}
        if let nameWP = name {activity.name = nameWP}
        if let effectWP = effect {activity.effect = effectWP}
    }
    
    //MARK: - Interaction Operations
    
    /// Adds a Interaction object to the model context.
    func createInteraction(id: UUID, tibbyId: UUID, activityId: UUID, timestamp: Date) {
        let interaction = Interaction(id: id, tibbyId: tibbyId, activityId: activityId, timestamp: timestamp)
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
    func updateInteraction(interaction: Interaction, id: UUID? = nil, tibbyId: UUID? = nil, activityId: UUID? = nil, timestamp: Date? = nil) {
        if let idWP = id {interaction.id = idWP}
        if let tibbyIdWP = tibbyId {interaction.tibbyId = tibbyIdWP}
        if let activityIdWP = activityId {interaction.activityId = activityIdWP}
    }
    
    /// Applies the interaction Effects into the right Tibby
    func applyInteractionToTibby(_ interaction: Interaction) {
        guard let activity = self.getActivityByID(id: interaction.activityId) else { return }
        guard let tibby = self.getTibbyByID(id: interaction.tibbyId) else { return }
        
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
    
    //MARK: - Food Operations
    
    func createFood(id: UUID, userId: UUID? = nil, name: String, image: String, price: Int) {
        let food = Food(id: id, name: name, image: image, price: price)
        modelContext.insert(food)
    }
    
    func deleteFood(food: Food) {
        modelContext.delete(food)
    }
    
    func addFoodToUser(food: Food) {
        if let user = self.getUser() {
            if var quantity = user.foodInventory[food.id] {
                quantity += 1
                user.foodInventory.updateValue(quantity, forKey: food.id)
                print("user: \(user.username)")
                print("food: \(food.name)")
                print("quantity: \(user.foodInventory[food.id])")
                return
            }
            user.foodInventory[food.id] = 1
            print("user: \(user.username)")
            print("food: \(food.name)")
            
            return
        } else {
            print("error: no user available to add a food")
        }
    }
    
    func removeFoodFromUser(food: Food) {
        if let user = self.getUser() {
            if var quantity = user.foodInventory[food.id] {
                quantity -= 1
                if quantity >= 0 {
                    user.foodInventory.updateValue(quantity, forKey: food.id)
                } else {
                    user.foodInventory.removeValue(forKey: food.id)
                }
                return
            }
        }
    }
    
    func getAllFoods() -> [Food] {
        var foods: [Food] = []
        
        do {
            foods = try modelContext.fetch(FetchDescriptor<Food>())
        } catch {
            print("Error getting Foods: \(error)")
        }
        return foods
    }
    
    func getFoodByID(ID: UUID) -> Food? {
        do {
            let foods = try modelContext.fetch(FetchDescriptor<Food>())
            for food in foods {
                if food.id == ID {
                    return food
                }
            }
        } catch {
            print("Error getting Foods: \(error)")
        }
        return nil
    }
    
    func updateFood(food: Food, id: UUID? = nil, name: String? = nil, image: String? = nil, price: Int? = nil) {
        if let idWP = id {food.id = idWP}
        if let nameWP = name {food.name = nameWP}
        if let imageWP = image {food.image = imageWP}
        if let priceWP = price {food.price = priceWP}
    }
}