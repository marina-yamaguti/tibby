import Foundation
import SwiftData

/// `Service` is a class that conforms to the `ServiceProtocol` and provides implementation for various operations related to managing Tibbies, Accessories, Users, Activities, Interactions, and Food within the app.
class Service: ObservableObject, ServiceProtocol {    
    
    /// The context in which the model objects are managed.
    var modelContext: ModelContext
    
    /// Initializes the `Service` with the given model context.
    ///
    /// - Parameter modelContext: The context used to manage the model objects.
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Tibby Operations
    
    /// Adds a Tibby object to the model context.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the Tibby.
    ///   - ownerId: The unique identifier of the Tibby's owner (optional).
    ///   - name: The name of the Tibby.
    ///   - rarity: The rarity level of the Tibby.
    ///   - details: Detailed information about the Tibby.
    ///   - personality: The personality traits of the Tibby.
    ///   - species: The species to which the Tibby belongs.
    ///   - level: The current level of the Tibby.
    ///   - xp: The experience points of the Tibby.
    ///   - happiness: The happiness level of the Tibby.
    ///   - hunger: The hunger level of the Tibby.
    ///   - sleep: The sleep level of the Tibby.
    ///   - friendship: The friendship level with the Tibby.
    ///   - lastUpdated: The date when the Tibby was last updated.
    ///   - isUnlocked: A Boolean value indicating whether the Tibby is unlocked.
    ///   - collection: The collection to which the Tibby belongs.
    func createTibby(id: UUID, ownerId: UUID? = nil, name: String, rarity: String, details: String, personality: String, species: String, happiness: Int, hunger: Int, sleep: Int, friendship: Int, lastUpdated: Date, isUnlocked: Bool, collection: String) {
        let newTibby = Tibby(id: id, ownerId: ownerId, name: name, rarity: rarity, details: details, personality: personality, species: species, happiness: happiness, hunger: hunger, sleep: sleep, friendship: friendship, lastUpdated: lastUpdated, isUnlocked: isUnlocked, collection: collection)
        
        do {
            let tibbies = try modelContext.fetch(FetchDescriptor<Tibby>())
            for tibby in tibbies {
                if tibby.species == newTibby.species {
                    return
                }
            }
        } catch {
            print("Error fetching Tibbies: \(error)")
        }
        
        modelContext.insert(newTibby)
    }
    
    /// Deletes a Tibby object from the model context.
    ///
    /// - Parameter tibby: The Tibby object to delete.
    func deleteTibby(tibby: Tibby) {
        modelContext.delete(tibby)
    }
    
    /// Retrieves a Tibby object by its ID.
    ///
    /// - Parameter id: The unique identifier of the Tibby.
    /// - Returns: The Tibby object if found, otherwise `nil`.
    func getTibbyByID(id: UUID) -> Tibby? {
        do {
            let tibbies = try modelContext.fetch(FetchDescriptor<Tibby>())
            return tibbies.first { $0.id == id }
        } catch {
            print("Error fetching Tibby by ID: \(error)")
        }
        return nil
    }
    
    func getCurrentTibby() -> Tibby? {
        var tibby: Tibby? = nil
        if let user = self.getUser() {
            if let currentTibbyID = user.currentTibbyID {
                return getTibbyByID(id: currentTibbyID)
            } else {
                print("error getting current tibby's ID: \(user.currentTibbyID ?? UUID())")
            }
        } else {
            print("error getting user")
        }
        return tibby
    }
    
    func setCurrentTibby(tibbyID: UUID) {
        if let user = self.getUser() {
            user.currentTibbyID = tibbyID
            print("current tibby setted succefully")
        } else {
            print("error getting user")
        }
    }
    
    /// Retrieves a Tibby object by its species.
    ///
    /// - Parameter species: The species of the Tibby.
    /// - Returns: The Tibby object if found, otherwise `nil`.
    func getTibbyBySpecies(species: String) -> Tibby? {
        do {
            let tibbies = try modelContext.fetch(FetchDescriptor<Tibby>())
            return tibbies.first { $0.species == species }
        } catch {
            print("Error fetching Tibby by species: \(error)")
        }
        return nil
    }
    
    /// Retrieves all Tibbies associated with a given user ID.
    ///
    /// - Parameter userID: The unique identifier of the user.
    /// - Returns: An array of Tibbies owned by the user.
    func getTibbiesByUserID(userID: UUID) -> [Tibby] {
        do {
            let tibbies = try modelContext.fetch(FetchDescriptor<Tibby>())
            return tibbies.filter { $0.ownerId == userID }
        } catch {
            print("Error fetching Tibbies by user ID: \(error)")
        }
        return []
    }
    
    /// Adds a tibby to the list of favorite tibbies (only if the list doesnt alreay have 3 tibbies)
    func addFavoriteTibby(tibby: Tibby) -> Bool {
        if let user = self.getUser() {
            if user.favoriteTibbies.count <= 3 {
                user.favoriteTibbies.append(tibby.id)
                return true
            }
        }
        return false
    }
    
    func removeFavoriteTibby(id: UUID) {
        if let user = self.getUser() {
            user.favoriteTibbies.removeAll { $0 == id }
        }
    }
    
    func getFavoriteTibbies() -> [Tibby] {
        var favoriteTibbies: [Tibby] = []
        if let user = self.getUser() {
            for id in user.favoriteTibbies {
                if let tibby = self.getTibbyByID(id: id) {
                    favoriteTibbies.append(tibby)
                }
            }
        }
        
        return favoriteTibbies
    }
    
    /// Retrieves all Tibbies in the model context.
    ///
    /// - Returns: An array of all Tibbies.
    func getAllTibbies() -> [Tibby] {
        do {
            return try modelContext.fetch(FetchDescriptor<Tibby>())
        } catch {
            print("Error fetching all Tibbies: \(error)")
        }
        return []
    }
    
    /// Updates the attributes of the given Tibby.
    ///
    /// - Parameters: Various optional parameters to update the corresponding properties of the Tibby.
    func updateTibby(tibby: Tibby, id: UUID? = nil, ownerId: UUID? = nil, rarity: String? = nil, details: String? = nil, personality: String? = nil, species: String? = nil, happiness: Int? = nil, hunger: Int? = nil, sleep: Int? = nil, friendship: Int? = nil, lastUpdated: Date? = nil) {
        if let id = id { tibby.id = id }
        if let ownerId = ownerId { tibby.ownerId = ownerId }
        if let rarity = rarity { tibby.rarity = rarity }
        if let details = details { tibby.details = details }
        if let personality = personality { tibby.personality = personality }
        if let species = species { tibby.species = species }
        if let happiness = happiness { tibby.happiness = happiness }
        if let hunger = hunger { tibby.hunger = hunger }
        if let sleep = sleep { tibby.sleep = sleep }
        if let friendship = friendship { tibby.friendship = friendship }
        if let lastUpdated = lastUpdated { tibby.lastUpdated = lastUpdated }
    }
    
    // MARK: - Accessory Operations
    
    /// Adds an Accessory object to the model context.
    ///
    /// - Parameters: Various parameters for creating a new Accessory.
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
            print("Error fetching Accessories: \(error)")
        }
        
        modelContext.insert(newAccessory)
    }
    
    /// Deletes an Accessory object from the model context.
    ///
    /// - Parameter accessory: The Accessory object to delete.
    func deleteAccessory(accessory: Accessory) {
        modelContext.delete(accessory)
    }
    
    /// Adds an Accessory to a Tibby specified by Tibby ID.
    ///
    /// - Parameters:
    ///   - tibbyId: The unique identifier of the Tibby.
    ///   - accessory: The Accessory object to add.
    func addAccessoryToTibby(tibbyId: UUID, accessory: Accessory) {
        accessory.tibbyId = tibbyId
        if let tibby = self.getTibbyByID(id: tibbyId) {
            tibby.currentAccessoryId = accessory.id
        }
    }
    
    /// Removes an Accessory from a Tibby.
    ///
    /// - Parameter accessory: The Accessory object to remove.
    func removeAccessoryFromTibby(accessory: Accessory) {
        if let id = accessory.tibbyId {
            if let tibby = self.getTibbyByID(id: id) {
                tibby.currentAccessoryId = nil
            }
            accessory.tibbyId = nil
        }
        
    }
    
    /// Retrieves all Accessories in the model context.
    ///
    /// - Returns: An array of all Accessories, or `nil` if none are found.
    func getAllAccessories() -> [Accessory]? {
        do {
            return try modelContext.fetch(FetchDescriptor<Accessory>())
        } catch {
            print("Error fetching Accessories: \(error)")
        }
        return nil
    }
    
    /// Retrieves an Accessory object by its ID.
    ///
    /// - Parameter ID: The unique identifier of the Accessory.
    /// - Returns: The Accessory object if found, otherwise `nil`.
    func getAccessoryByID(ID: UUID) -> Accessory? {
        do {
            let accessories = try modelContext.fetch(FetchDescriptor<Accessory>())
            return accessories.first { $0.id == ID }
        } catch {
            print("Error fetching Accessory by ID: \(error)")
        }
        return nil
    }
    
    /// Retrieves all Accessories associated with a given Tibby ID.
    ///
    /// - Parameter tibbyID: The unique identifier of the Tibby.
    /// - Returns: An array of Accessories associated with the Tibby.
    func getAccessoriesByTibbyID(tibbyID: UUID) -> [Accessory] {
        do {
            let accessories = try modelContext.fetch(FetchDescriptor<Accessory>())
            return accessories.filter { $0.tibbyId == tibbyID }
        } catch {
            print("Error fetching Accessories by Tibby ID: \(error)")
        }
        return []
    }
    
    /// Updates the attributes of the given Accessory.
    ///
    /// - Parameters: Various optional parameters to update the corresponding properties of the Accessory.
    func updateAccessory(accessory: Accessory, id: UUID? = nil, tibbyId: UUID? = nil, name: String? = nil, image: String? = nil, price: Int? = nil) {
        if let id = id { accessory.id = id }
        if let tibbyId = tibbyId { accessory.tibbyId = tibbyId }
        if let name = name { accessory.name = name }
        if let image = image { accessory.image = image }
        if let price = price { accessory.price = price }
    }
    
    // MARK: - User Operations
    
    /// Adds a User object to the model context.
    ///
    /// - Parameters: Various parameters for creating a new User.
    func createUser(id: UUID, username: String, email: String? = nil, passwordHash: String? = nil, level: Int, xp: Int) {
        let user = User(id: id, username: username, email: email, passwordHash: passwordHash, level: level, xp: xp)
        modelContext.insert(user)
    }
    
    /// Deletes a User from the model context.
    ///
    /// - Parameter user: The User object to delete.
    func deleteUser(user: User) {
        modelContext.delete(user)
    }
    
    /// Retrieves all Users.
    ///
    /// - Returns: An array of all Users.
    func getAllUsers() -> [User] {
        do {
            return try modelContext.fetch(FetchDescriptor<User>())
        } catch {
            print("Error fetching Users: \(error)")
        }
        return []
    }
    
    /// Retrieves the first User.
    ///
    /// - Returns: The first User object if found, otherwise `nil`.
    func getUser() -> User? {
        do {
            let users = try modelContext.fetch(FetchDescriptor<User>())
            return users.first
        } catch {
            print("Error fetching User: \(error)")
        }
        return nil
    }
    
    /// Updates the attributes of the given User.
    ///
    /// - Parameters: Various optional parameters to update the corresponding properties of the User.
    func updateUser(user: User, id: UUID? = nil, username: String? = nil, email: String? = nil, passwordHash: String? = nil) {
        if let id = id { user.id = id }
        if let username = username { user.username = username }
        if let email = email { user.email = email }
        if let passwordHash = passwordHash { user.passwordHash = passwordHash }
    }
    
    /// Retrieves all the IDs of the foods from the user with their quantities.
    ///
    /// - Returns: A dictionary mapping food IDs to their quantities.
    func getFoodsIDsFromUser() -> [UUID : Int] {
        return getUser()?.foodInventory ?? [:]
    }
    
    /// Retrieves all foods from the user with their quantities.
    ///
    /// - Returns: A dictionary mapping `Food` objects to their quantities.
    func getFoodsFromUser() -> [Food : Int] {
        var foods: [Food : Int] = [:]
        let foodIDs = self.getFoodsIDsFromUser()
        
        for (foodID, count) in foodIDs {
            guard let food = self.getFoodByID(ID: foodID) else {
                print("Error: No food matching the ID \(foodID)")
                continue
            }
            foods[food] = count
        }
        return foods
    }
    
    // MARK: - Activity Operations
    
    /// Adds an Activity object to the model context.
    ///
    /// - Parameters: Various parameters for creating a new Activity.
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
            print("Error fetching Activities: \(error)")
        }
        
        modelContext.insert(newActivity)
    }
    
    /// Deletes an Activity from the model context.
    ///
    /// - Parameter activity: The Activity object to delete.
    func deleteActivity(activity: Activity) {
        modelContext.delete(activity)
    }
    
    /// Retrieves all Activities.
    ///
    /// - Returns: An array of all Activities, or `nil` if none are found.
    func getAllActivities() -> [Activity]? {
        do {
            return try modelContext.fetch(FetchDescriptor<Activity>())
        } catch {
            print("Error fetching Activities: \(error)")
        }
        return nil
    }
    
    /// Retrieves an Activity based on the given ID.
    ///
    /// - Parameter id: The unique identifier of the Activity.
    /// - Returns: The Activity object if found, otherwise `nil`.
    func getActivityByID(id: UUID) -> Activity? {
        do {
            let activities = try modelContext.fetch(FetchDescriptor<Activity>())
            return activities.first { $0.id == id }
        } catch {
            print("Error fetching Activity by ID: \(error)")
        }
        return nil
    }
    
    /// Retrieves an Activity based on the given name.
    ///
    /// - Parameter name: The name of the Activity.
    /// - Returns: The Activity object if found, otherwise `nil`.
    func getActivityByName(name: String) -> Activity? {
        do {
            let activities = try modelContext.fetch(FetchDescriptor<Activity>())
            return activities.first { $0.name == name }
        } catch {
            print("Error fetching Activity by name: \(error)")
        }
        return nil
    }
    
    /// Updates the attributes of the given Activity.
    ///
    /// - Parameters: Various optional parameters to update the corresponding properties of the Activity.
    func updateActivity(activity: Activity, id: UUID? = nil, name: String? = nil, effect: String? = nil) {
        if let id = id { activity.id = id }
        if let name = name { activity.name = name }
        if let effect = effect { activity.effect = effect }
    }
    
    // MARK: - Interaction Operations
    
    /// Adds an Interaction object to the model context.
    ///
    /// - Parameters: Various parameters for creating a new Interaction.
    /// - Returns: The newly created Interaction object.
    func createInteraction(id: UUID, tibbyId: UUID, activityId: UUID, timestamp: Date) -> Interaction {
        let interaction = Interaction(id: id, tibbyId: tibbyId, activityId: activityId, timestamp: timestamp)
        modelContext.insert(interaction)
        return interaction
    }
    
    /// Deletes an Interaction from the model context.
    ///
    /// - Parameter interaction: The Interaction object to delete.
    func deleteInteraction(interaction: Interaction) {
        modelContext.delete(interaction)
    }
    
    /// Retrieves all Interactions.
    ///
    /// - Returns: An array of all Interactions, or `nil` if none are found.
    func getAllInteractions() -> [Interaction]? {
        do {
            return try modelContext.fetch(FetchDescriptor<Interaction>())
        } catch {
            print("Error fetching Interactions: \(error)")
        }
        return nil
    }
    
    /// Retrieves an Interaction based on the given ID.
    ///
    /// - Parameter id: The unique identifier of the Interaction.
    /// - Returns: The Interaction object if found, otherwise `nil`.
    func getInteractionByID(id: UUID) -> Interaction? {
        do {
            let interactions = try modelContext.fetch(FetchDescriptor<Interaction>())
            return interactions.first { $0.id == id }
        } catch {
            print("Error fetching Interaction by ID: \(error)")
        }
        return nil
    }
    
    /// Updates the attributes of the given Interaction.
    ///
    /// - Parameters: Various optional parameters to update the corresponding properties of the Interaction.
    func updateInteraction(interaction: Interaction, id: UUID? = nil, tibbyId: UUID? = nil, activityId: UUID? = nil, timestamp: Date? = nil) {
        if let id = id { interaction.id = id }
        if let tibbyId = tibbyId { interaction.tibbyId = tibbyId }
        if let activityId = activityId { interaction.activityId = activityId }
        if let timestamp = timestamp { interaction.timestamp = timestamp }
    }
    
    /// Applies the effects of an Interaction to the corresponding Tibby.
    ///
    /// - Parameters:
    ///   - interaction: The Interaction object containing the effects to apply.
    ///   - tibby: The Tibby object to which the effects will be applied.
    func applyInteractionToTibby(interaction: Interaction, tibby: Tibby) {
        guard let activity = getActivityByID(id: interaction.activityId),
              let effectData = activity.effect.data(using: .utf8),
              let effect = try? JSONSerialization.jsonObject(with: effectData, options: []) as? [String: Int] else {
            print("Error deserializing the effect")
            return
        }
        
        if let happinessEffect = effect["happiness"] {
            tibby.happiness = min(tibby.happiness + happinessEffect, 100)
        }
        if let hungerEffect = effect["hunger"] {
            tibby.hunger = min(tibby.hunger + hungerEffect, 100)
        }
        if let sleepEffect = effect["sleep"] {
            tibby.sleep = min(tibby.sleep + sleepEffect, 100)
        }
        if let friendshipEffect = effect["friendship"] {
            tibby.friendship += friendshipEffect
        }
    }
    
    // MARK: - Food Operations
    
    /// Adds a Food object to the model context.
    ///
    /// - Parameters: Various parameters for creating a new Food.
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
            print("Error fetching Foods: \(error)")
        }
        
        modelContext.insert(newFood)
    }
    
    /// Deletes a Food object from the model context.
    ///
    /// - Parameter food: The Food object to delete.
    func deleteFood(food: Food) {
        modelContext.delete(food)
    }
    
    /// Adds a Food item to the user's inventory.
    ///
    /// - Parameter food: The Food object to add.
    func addFoodToUser(food: Food) {
        if let user = getUser() {
            user.foodInventory[food.id, default: 0] += 1
        } else {
            print("Error: No user available to add food")
        }
    }
    
    /// Removes a Food item from the user's inventory.
    ///
    /// - Parameter food: The Food object to remove.
    func removeFoodFromUser(food: Food) {
        if let user = getUser(), var quantity = user.foodInventory[food.id] {
            quantity -= 1
            if quantity > 0 {
                user.foodInventory[food.id] = quantity
            } else {
                user.foodInventory.removeValue(forKey: food.id)
            }
        }
    }
    
    /// Retrieves all Foods in the model context.
    ///
    /// - Returns: An array of all Foods.
    func getAllFoods() -> [Food] {
        do {
            return try modelContext.fetch(FetchDescriptor<Food>())
        } catch {
            print("Error fetching Foods: \(error)")
        }
        return []
    }
    
    /// Retrieves a Food object by its ID.
    ///
    /// - Parameter ID: The unique identifier of the Food.
    /// - Returns: The Food object if found, otherwise `nil`.
    func getFoodByID(ID: UUID) -> Food? {
        do {
            let foods = try modelContext.fetch(FetchDescriptor<Food>())
            return foods.first { $0.id == ID }
        } catch {
            print("Error fetching Food by ID: \(error)")
        }
        return nil
    }
    
    /// Updates the attributes of the given Food.
    ///
    /// - Parameters: Various optional parameters to update the corresponding properties of the Food.
    func updateFood(food: Food, id: UUID? = nil, name: String? = nil, image: String? = nil, price: Int? = nil) {
        if let id = id { food.id = id }
        if let name = name { food.name = name }
        if let image = image { food.image = image }
        if let price = price { food.price = price }
    }
    
    func createMission(id: UUID, name: String, valueTotal: Int, rewardValue: Int, rewardType: Int, xpValue: Int, xpType: Int, missionType: String, valueDone: Int, frequencyTime: String, progress: String) {
        var newMission = Mission(id: id, name: name, valueTotal: valueTotal, rewardValue: rewardValue, rewardType: rewardType, xpValue: xpValue, xpType: xpType, missionType: missionType, valueDone: valueDone, frequencyTime: frequencyTime, progress: progress)
        do {
            let missions = try modelContext.fetch(FetchDescriptor<Mission>())
        } catch {
            print("Error fetching Tibbies: \(error)")
        }
        
        modelContext.insert(newMission)
    }
    
    func getAllMissions() -> [Mission] {
        do {
            return try modelContext.fetch(FetchDescriptor<Mission>())
        } catch {
            print("Error fetching all Missions: \(error)")
        }
        return []
    }
    
    func getMissionByFrequencyTime(frequencyTime: DateType) -> [MissionProtocol] {
        var missions: [MissionProtocol] = []
        for m in self.getAllMissions() {
            var progress: MissionProgress = .inProgress
            switch m.progress {
            case "inProgress": progress = .inProgress
            case "claim": progress = .claim
            case "done": progress = .done
            default: progress = .inProgress
            }
            switch frequencyTime {
            case .day:
                if m.frequencyTime == "Day" {
                    var missionReturn: MissionDay = MissionDay(id: m.id, description: m.name, valueTotal: m.valueTotal, reward: Reward(rewardValue: m.rewardValue, rewardType: RewardType(rawValue: m.rewardType)!), xp: Reward(rewardValue: m.xpValue, rewardType: RewardType(rawValue: m.xpType)!), missionType: MissionType(rawValue: m.missionType)!, valueDone: m.valueDone, progress: progress)
                    missions.append(missionReturn)
                }
            case .week:
                if m.frequencyTime == "Week" {
                    var missionReturn: MissionWeek = MissionWeek(id: m.id, description: m.name, valueTotal: m.valueTotal, reward: Reward(rewardValue: m.rewardValue, rewardType: RewardType(rawValue: m.rewardType)!), xp: Reward(rewardValue: m.rewardValue, rewardType: RewardType(rawValue: m.rewardType)!), missionType: MissionType(rawValue: m.missionType)!, valueDone: m.valueDone, progress: progress)
                    missions.append(missionReturn)
                }
            }
        }
        return missions
    }
    
    func removeMissionsByFrequencyTime(frequencyTime: DateType) {
        for m in self.getAllMissions() {
            switch frequencyTime {
            case .day:
                if m.frequencyTime == "Day" {
                    modelContext.delete(m)
                }
            case .week:
                if m.frequencyTime == "Week" {
                    modelContext.delete(m)
                }
            }
        }
    }
    
    func updateMissionsByFrequencyTime(frequencyTime: DateType, missions: [MissionProtocol]) {
        self.removeMissionsByFrequencyTime(frequencyTime: frequencyTime)
        for m in missions {
            var progress: String = "inProgress"
            switch m.progress {
            case .inProgress: progress = "inProgress"
            case .claim: progress = "claim"
            case .done: progress = "done"
            }
            createMission(id: m.id, name: m.description, valueTotal: m.valueTotal, rewardValue: m.reward.rewardValue, rewardType: m.reward.rewardType.rawValue, xpValue: m.xp.rewardValue, xpType: m.xp.rewardType.rawValue, missionType: m.missionType.rawValue, valueDone: m.valueDone, frequencyTime: m.frequencyTime.rawValue, progress: progress)
        }
    }
    
    // MARK: - Data Setup
    
    /// Sets up initial data for the application.
    /// This method creates initial instances of User, Tibby, Accessory, Food, and Activity.
    func setupData() {
        // User Setup
        if getUser() == nil {
            createUser(id: UUID(), username: "", level: 1, xp: 0)
        }
        
        // Tibbies Setup
        //Sea Series
        createTibby(id: UUID(), name: "Troy", rarity: "Common", details: "Despite his fearsome appearance, Shark loves making new friends and exploring the underwater world. With sharp fins and a swift tail, he can glide through the ocean with grace and agility.", personality: "", species: "shark", happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: false, collection: "Sea Series")
        createTibby(id: UUID(), name: "Thor", rarity: "Epic", details: "The Yellow Shark, the Guardian of the Seas, lives in the deepest part of the ocean, where few have access. Although its appearance is a little scary, it is very friendly and protects every corner of the sea. Its coloration is due to the light it emits to illuminate its path in the deep, dark oceans.", personality: "", species: "yellowShark", happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: false, collection: "Sea Series")
        createTibby(id: UUID(), name: "Roger", rarity: "Common", details: "The Pink Dolphin is a charming smart and social marine creature, known for its playful spirit and ability to glide through the ocean, often seen riding waves and leaping into the air. Their ability to connect with humans, their curiosity, and their joyful leaps out of the water make them fascinating and endearing creatures", personality: "", species: "dolphin", happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: false, collection: "Sea Series")
        createTibby(id: UUID(), name: "Charlotte", rarity: "Rare", details: "The Axolotl is a magical water creature known for its cute smile and soft, feather-like gills. It stays looking young forever and swims gracefully in its peaceful underwater home. With its special power of regeneration and its enchanting presence, the Axolotl brings a sense of wonder and ancient magic to those who see it.", personality: "", species: "axolotl", happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: false, collection: "Sea Series")
        
        //House Series
        createTibby(id: UUID(), name: "Raven", rarity: "Common", details: "The Black Cat is a charming and elegant companion for the home, with sleek fur and bright eyes. Her mysterious charm and calming presence bring a touch of magic to any household. With her quiet confidence, she makes every space feel uniquely special.", personality: "", species: "tuxedoCat", happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: false, collection: "House Series")
        createTibby(id: UUID(), name: "Muffins", rarity: "Common", details: "The Bunny is an adorable companion who loves comfort and coziness. She enjoys finding the warmest spots in the house to curl up and enjoy a moment of peace. Her soft fur and gentle behavior make her the perfect friend to share quiet afternoons and fun adventures with.", personality: "", species: "bunny", happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: false, collection: "House Series")
        createTibby(id: UUID(), name: "Milo", rarity: "Rare", details: "The Corgi is a bundle of energy and joy, with his classic short legs and fluffy tail that make him irresistibly adorable. He has a special connection with the unseen, sensing when something is wrong or when someone is sad. With his magical intuition, Corgi fills your home with warmth and a sense of comfort.", personality: "", species: "corgi", happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: false, collection: "House Series")
        createTibby(id: UUID(), name: "Peanut", rarity: "Epic", details: "The Dog is an adorable little dog with an epic heart! Small in size but big in charm, known as the Guardian of Living Beings, she is always ready to help those in need when they call her name. Peanut's loyalty and playful spirit make her a truly epic companion.", personality: "", species: "dog", happiness: 0, hunger: 0, sleep: 0, friendship: 0, lastUpdated: Date(), isUnlocked: false, collection: "House Series")
        


        
        // Accessories Setup
        createAccessory(id: UUID(), name: "SpyHat", image: "SpyHat", price: 10, category: "Head")
        createAccessory(id: UUID(), name: "Glasses", image: "Glasses", price: 10, category: "Head")
        createAccessory(id: UUID(), name: "Tie", image: "Tie", price: 10, category: "Body")
        
        // Food Setup
        createFood(id: UUID(), name: "Niguiri", image: "niguiri", price: 10)
        createFood(id: UUID(), name: "Uramaki", image: "uramaki", price: 10)
        
        // Activities Setup
        createActivity(id: UUID(), name: "Eat", effect: "{\"hunger\": 25}")
        createActivity(id: UUID(), name: "Pet", effect: "{\"happiness\": 25}")
        createActivity(id: UUID(), name: "Sleep", effect: "{\"sleep\": 1}")
        
        // Initial Food Inventory Setup
        if getFoodsFromUser().isEmpty {
            for food in getAllFoods() {
                addFoodToUser(food: food)
            }
        }
        
        print("Setup completed")
    }
}
