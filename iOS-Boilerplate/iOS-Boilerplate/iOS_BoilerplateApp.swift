//
//  iOS_BoilerplateApp.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 12/05/25.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct iOS_BoilerplateApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            RootView()
                .environment(NavigationRouter())
        }
        .modelContainer(sharedModelContainer)
    }
}
