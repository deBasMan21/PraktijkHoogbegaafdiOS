//
//  NotificationSendLogic.swift
//  PhriOS
//
//  Created by Bas Buijsen on 11/04/2022.
//

import Foundation
import NotificationCenter

func setNotifications(times: [Date]){
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    
    for date in times {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        scheduleNotification(hour: hour, minutes: minutes)
    }
}

func removeNotifications() {
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
}

func scheduleNotification(hour : Int, minutes: Int) {
    //get enviroment
    let defs = UserDefaults()
    let adultMode = defs.bool(forKey: DEFS_ADULT_MODE)
    
    //create notification
    let content = UNMutableNotificationContent()
    content.title = NOTIFICATION_TITLE
    content.body = NOTIFICATION_BODY
    content.badge = 1
    
    //actions
    let adultAction = UNNotificationAction(identifier:"adult",
            title:"Direct invullen",options:[])
    
    let childAction = UNTextInputNotificationAction(identifier:
        "child", title: "Billies invullen (kind)", options: [])
    let parentAction = UNTextInputNotificationAction(identifier:
        "parent", title: "Voor kind invullen (ouder)", options: [])

    //create categories
    let childCategory = UNNotificationCategory(identifier: "child",
         actions: [childAction, parentAction],
        intentIdentifiers: [], options: [])
    
    let adultCategory = UNNotificationCategory(identifier: "adult",
         actions: [adultAction],
        intentIdentifiers: [], options: [])

    //select category for notification
    content.categoryIdentifier = adultMode ? "adult" : "child"
    
    //id
    let requestIdentifier = "Reminder"
    
    //time
    var dateComponents = DateComponents()
    dateComponents.hour = hour
    dateComponents.minute = minutes
    
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
    let request = UNNotificationRequest(identifier: requestIdentifier,
            content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().setNotificationCategories(
                                [childCategory, adultCategory])
    
    UNUserNotificationCenter.current().add(request,
            withCompletionHandler: { (error) in
                // Handle error
        })
}

func requestPermission() {
    let center = UNUserNotificationCenter.current()
    center.getNotificationSettings { settings in
        if settings.authorizationStatus == .authorized {
            setNotifications(times: [Date().timeFromComponents(hour: 10, minute: 00)!, Date().timeFromComponents(hour: 16, minute: 00)!, Date().timeFromComponents(hour: 20, minute: 00)!])
        } else {
            center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    setNotifications(times: [Date().timeFromComponents(hour: 10, minute: 00)!, Date().timeFromComponents(hour: 16, minute: 00)!, Date().timeFromComponents(hour: 20, minute: 00)!])
                } else {
                    print("D'oh")
                }
            }
        }
    }
}
