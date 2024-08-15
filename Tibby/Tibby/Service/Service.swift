import Foundation
import SwiftData

class Service: ObservableObject, ServiceProtocol {
    
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Tibby Operations
    
    /// Adds a Tibby object to the model context.
    func createTibby(id: UUID, ownerId: UUID? = nil, name: String, rarity: String, details: String, personality: String, species: String, level: Int, xp: Int, happiness: Int, hunger: Int, sleep: Int, friendship: Int, lastUpdated: Date, isUnlocked: Bool, collection: String) {
        
        let newTibby = Tibby(id: id, ownerId: ownerId, name: name, rarity: rarity, details: details, personality: personality, species: species, level: level, xp: xp, happiness: happiness, hunger: hunger, sleep: sleep, friendship: friendship, lastUpdated: lastUpdated, isUnlocked: isUnlocked, collection: collection)
        
        do {
            let tibbies = try modelContext.fetch(FetchDescriptor<Tibby>())
            for tibby in tibbies {
                if tibby.species == newTibby.species {
                    return
                }
            }
        } catch {
            print("Error getting Tibby: \(error)")
        }
        
        modelContext.insert(newTibby)
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
    
    /// Retrieves a Tibby object by its species.
    func getTibbyBySpecies(species: String) -> Tibby? {
        do {
            let tibbies = try modelContext.fetch(FetchDescriptor<Tibby>())
            for tibby in tibbies {
                if tibby.species == species {
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
    func getAllTibbies() -> [Tibby] {
        var tibbies: [Tibby] = []
        do {
            tibbies = try modelContext.fetch(FetchDescriptor<Tibby>())
        } catch {
            print("Error getting Tibbies: \(error)")
        }
        return tibbies
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
    func createAccessory(id: UUID, tibbyId: UUID? = nil, name: String, image: String, price: Int, category: String) {
        let newAccessory = Accessory(id: id, tibbyId: tibbyId, name: name, image: image, price: price, category: category)
        do {
            let accessories = try modelContext.fetch(FetchDescriptor<Accessory>())
            for accessory in accessories {
                if accessory.name == newAccessory.name {
                    return
                }
            }
        } catch {
            print("Error getting Tibby: \(error)")
        }
        
        modelContext.insert(newAccessory)
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
        let newActivity = Activity(id: id, name: name, effect: effect)
        
        do {
            let activities = try modelContext.fetch(FetchDescriptor<Activity>())
            for activity in activities {
                if activity.name == newActivity.name {
                    return
                }
            }
        } catch {
            print("Error getting Tibby: \(error)")
        }
        
        modelContext.insert(newActivity)
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
            print("Error getting activity: \(error)")
        }
        return nil
    }
    
    /// Retrieves a Activity based on the given Name
    func getActivityByName(name: String) -> Activity? {
        do {
            let activities = try modelContext.fetch(FetchDescriptor<Activity>())
            for activity in activities {
                if activity.name == name {
                    return activity
                }
            }
        } catch {
            print("Error getting activity: \(error)")
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
    func createInteraction(id: UUID, tibbyId: UUID, activityId: UUID, timestamp: Date) -> Interaction {
        let interaction = Interaction(id: id, tibbyId: tibbyId, activityId: activityId, timestamp: timestamp)
        modelContext.insert(interaction)
        return interaction
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
    func applyInteractionToTibby(interaction: Interaction, tibby: Tibby) {
        guard let activity = self.getActivityByID(id: interaction.activityId) else { return }
//        guard let tibby = self.getTibbyByID(id: interaction.tibbyId) else { return }
        
        guard let effectData = activity.effect.data(using: .utf8),
              let effect = try? JSONSerialization.jsonObject(with: effectData, options: []) as? [String: Int] else {
            print("error deserializing the effect")
            return
        }
        print(effect)
        if let happinessEffect = effect["happiness"]{
            if tibby.happiness < 100 {
                tibby.happiness += happinessEffect
                if tibby.happiness > 100 {
                    tibby.happiness = 100
                }
            }
        }
        if let hungerEffect = effect["hunger"] {
            if tibby.hunger < 100 {
                tibby.hunger += hungerEffect
                if tibby.hunger > 100 {
                    tibby.hunger = 100
                }
            }
        }
        if let sleepEffect = effect["sleep"] {
            if tibby.sleep < 100 {
                tibby.sleep += sleepEffect
                if tibby.sleep > 100 {
                    tibby.sleep = 100
                }
            }
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
        let newFood = Food(id: id, name: name, image: image, price: price)
        
        do {
            let foods = try modelContext.fetch(FetchDescriptor<Food>())
            for food in foods {
                if food.name == newFood.name {
                    return
                }
            }
        } catch {
            print("Error getting Tibby: \(error)")
        }
        
        modelContext.insert(newFood)
    }
    
    func deleteFood(food: Food) {
        modelContext.delete(food)
    }
    
    func addFoodToUser(food: Food) {
        if let user = self.getUser() {
            if var quantity = user.foodInventory[food.id] {
                quantity += 1
                user.foodInventory.updateValue(quantity, forKey: food.id)
                return
            }
            user.foodInventory[food.id] = 1
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
    
    //MARK: - Data Setup (creating all pre existing instances
    func setupData() {
        //User
        /// change this to do the setup in the onboarding
        if getUser() == nil {
            self.createUser(id: UUID(), username: "Sofia")
        }
        //Tibbies
        self.createTibby(id: UUID(), ownerId: nil, name: "Shark", rarity: "Common", details: "", personality: "", species: "shark", level: 1, xp: 0, happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: true, collection: "Sea Series")
        self.createTibby(id: UUID(), ownerId: nil, name: "Thor", rarity: "Common", details: "", personality: "", species: "yellowShark", level: 1, xp: 0, happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: true, collection: "Sea Series")
        self.createTibby(id: UUID(), ownerId: nil, name: "Roger",rarity: "Common", details: "", personality: "", species: "dolphin", level: 1, xp: 0, happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: true, collection: "Sea Series")
//        self.createTibby(id: UUID(), ownerId: nil, name: "Nilse", rarity: "Common", details: "", personality: "", species: "dog", level: 1, xp: 0, happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: true, collection: "House Series")
        
        //Accessories
        self.createAccessory(id: UUID(), tibbyId: nil, name: "Hat", image: "hat", price: 10, category: "Head")
        self.createAccessory(id: UUID(), tibbyId: nil, name: "Glasses", image: "heart-glasses", price: 10, category: "Head")
        self.createAccessory(id: UUID(), tibbyId: nil, name: "Tie", image: "tie", price: 10, category: "Body")
        
        //Food
        self.createFood(id: UUID(), name: "Niguiri", image: "niguiri", price: 10)
        self.createFood(id: UUID(), name: "Uramaki", image: "uramaki", price: 10)
        
        //Activties
        self.createActivity(id: UUID(), name: "Eat", effect: "{\"hunger\": 25}")
        self.createActivity(id: UUID(), name: "Pet", effect: "{\"happiness\": 25}")
        self.createActivity(id: UUID(), name: "Sleep", effect: "{\"sleep\": 100}")
        
        if self.getFoodsFromUser().isEmpty {
            for food in self.getAllFoods() {
                self.addFoodToUser(food: food)
            }
        }
        print("setup done")
    }
}
