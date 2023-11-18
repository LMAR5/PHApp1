//
//  PHApp1App.swift
//  PHApp1
//
//  Created by Luis Aguilar on 11/18/23.
//

import SwiftUI

@main
struct PHApp1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
