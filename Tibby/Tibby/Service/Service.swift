import Foundation
import SwiftData

class Service: ObservableObject {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Tibby Operations
    
    /// Adds a Tibby object to the model context.
    func addTibby(tibby: Tibby) {
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
    
    // MARK: - Accessory Operations
    
    /// Adds an Accessory object to the model context.
    func addAccessory(accessory: Accessory) {
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
    
    /// Adds a User object to the model context.
    func addUser(user: User) {
        modelContext.insert(user)
    }
}
