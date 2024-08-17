//
//  RealSpotifyApp.swift
//  RealSpotify
//
//  Created by 龙龙 on 2024/8/17.
//

import SwiftUI

@main
struct RealSpotifyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
