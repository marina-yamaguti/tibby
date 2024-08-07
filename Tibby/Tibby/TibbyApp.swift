//
//  TibbyApp.swift
//  Tibby
//
//  Created by Mateus Moura Godinho on 26/06/24.
//

import SwiftUI
import SwiftData
import UIKit


@main
struct TibbyApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Tibby.self, Accessory.self, User.self, Activity.self, Interaction.self, Food.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            //change screen
            //KitchenExample()
            //CRUDExample()
            SplashScreen()
        }
        .modelContainer(sharedModelContainer)
        .environmentObject(Service(modelContext: sharedModelContainer.mainContext))
        .environmentObject(Constants())
        .environmentObject(HealthManager())
    }
}
