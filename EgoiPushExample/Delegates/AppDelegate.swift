//
//  AppDelegate.swift
//  EgoiPushExample
//
//  Created by João Silva on 20/04/2023.
//

import Firebase
import EgoiPushLibrary
import UIKit
import CoreLocation

class AppDelegate: NSObject, UIApplicationDelegate {
    private let userDefaults: UserDefaults = UserDefaults.standard
    
    /// This is the entrypoint of the app. We request the notifications permission here.
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { _, _ in }
        
        application.registerForRemoteNotifications()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        return true
    }
    
    /// Callback responsible for handling the new/updated APNs tokens. In this case, we assign the token to the FirebaseMessaging instance.
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    
    /// Callback responsible for handling the received remote notifications.
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        NotificationHandler.processNotification(userInfo) { result in
            completionHandler(result)
        }
    }
}

/// Extension of the delegate responsible for handling Firebase related code.
extension AppDelegate: MessagingDelegate {
    
    /// Callback responsible for receiving new/updated Firebase tokens
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        guard let token = fcmToken else {
            return
        }
        
        print("Token: \(token)")
        
        userDefaults.set(token, forKey: UserDefaultsProperties.TOKEN)
    }
}

/// Extension of the delegate responsible for handling UserNotificationCenterDelegate code.
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    /// Callback responsible for handling the notification behaviour when the app is opened. In this case, it will show the notification's banner and play a sound.
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([UNNotificationPresentationOptions.banner, UNNotificationPresentationOptions.sound])
    }
    
    /// Callback responsible for handling the interactions of the user with the notification.
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        NotificationHandler.handleNotificationInteraction(response, completionHandler)
    }
}
