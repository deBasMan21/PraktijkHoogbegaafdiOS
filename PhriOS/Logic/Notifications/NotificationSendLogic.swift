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
        scheduleNotification(date: date)
    }
}

func removeNotifications() {
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
}

func scheduleNotification(date : Date) {
    let content = UNMutableNotificationContent()
    content.title = NOTIFICATION_TITLE
    content.body = NOTIFICATION_BODY

    let triggerInputForHourlyRepeat = Calendar.current.dateComponents([.hour, .minute], from: date)
    let trigger = UNCalendarNotificationTrigger.init(dateMatching: triggerInputForHourlyRepeat, repeats: true)

    let request = UNNotificationRequest(identifier: UUID().description, content: content, trigger: trigger)
    let unc = UNUserNotificationCenter.current()
    unc.add(request, withCompletionHandler: { (error) in
        if let error = error {
            print(error)
        }
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
