import SwiftUI
import UserNotifications

// MARK: Model Holds all Notification Data
struct NotificationValue: Identifiable{
    var id: String = UUID().uuidString
    var content: UNNotificationContent
    var dateCreated: Date = Date()
    var showNotification: Bool = false
}
