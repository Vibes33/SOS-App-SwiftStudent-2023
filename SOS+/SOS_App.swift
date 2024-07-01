//
//  SOS_App.swift
//  SOS+
//
//  Created by Ryan Delépine on 06/07/2023.
//

import SwiftUI

@main
struct AppNameApp: App {
    @StateObject private var sessionManager = SessionManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, PersistenceManager.shared.context)
                .onAppear {
                    sessionManager.startSession()
                }
                .preferredColorScheme(.dark)
        }
    }
}


