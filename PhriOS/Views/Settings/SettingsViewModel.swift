//
//  SettingsViewModel.swift
//  PhriOS
//
//  Created by Bas Buijsen on 10/04/2022.
//

import Foundation
import SwiftUI

extension SettingsView {
    class ViewModel : ObservableObject {
        @Published var adultMode : Bool = false
        @Published var begeleidster : String = ""
        @Published var name : String = ""
        @Published var counter = 0
        @Published var showResetAlert = false
        
        @Published var notificationsEnabled = true
        @Published var notifications : [Date] = [Date(), Date(), Date()]
        @Published var notificationsError = false
        
        let defs = UserDefaults()
        
        init(){
            adultMode = defs.bool(forKey: DEFS_ADULT_MODE)
            begeleidster = defs.string(forKey: DEFS_BEGELEIDSTER) ?? BEGELEIDSTERS["Lisanne Boerboom"]!
            name = defs.string(forKey: DEFS_NAME) ?? ""
            notifications = (defs.array(forKey: DEFS_NOTIFICATIONS) ?? [Date(), Date(), Date()]) as? [Date] ?? [Date(), Date(), Date()]
            notificationsEnabled = defs.bool(forKey: DEFS_NOTIFICATIONS_ENABLED)
        }
        
        func saveSettings() {
            defs.set(adultMode, forKey: DEFS_ADULT_MODE)
            defs.set(begeleidster, forKey: DEFS_BEGELEIDSTER)
            defs.set(name, forKey: DEFS_NAME)
            defs.set(notifications, forKey: DEFS_NOTIFICATIONS)
            defs.set(notificationsEnabled, forKey: DEFS_NOTIFICATIONS_ENABLED)
        }
        
        func reset() {
            defs.removeObject(forKey: DEFS_BEGELEIDSTER)
            defs.removeObject(forKey: DEFS_ADULT_MODE)
            defs.removeObject(forKey: DEFS_NAME)
            defs.removeObject(forKey: DEFS_NOTIFICATIONS)
            defs.removeObject(forKey: DEFS_NOTIFICATIONS_ENABLED)
            removeNotifications()
        }
        
        func saveNotifications() {
            setNotifications(times: notifications)
            notificationsEnabled = true
        }
        
        func switchNotificationsEnabled() {
            if notificationsEnabled {
                saveNotifications()
                notificationsError = true
            } else {
                removeNotifications()
            }
        }
    }
}
