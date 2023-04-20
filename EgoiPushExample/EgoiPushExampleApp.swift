//
//  EgoiPushExampleApp.swift
//  EgoiPushExample
//
//  Created by João Silva on 20/04/2023.
//

import SwiftUI
import EgoiPushLibrary

@main
struct EgoiPushExampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        let _ = EgoiPushLibrary(
            appId: "egoipushlibrary",
            apiKey: "9359df7f635ece99bc0aa934a1f831a2de49e40e"
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
