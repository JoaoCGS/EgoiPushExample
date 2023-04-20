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
            appId: "",
            apiKey: ""
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
