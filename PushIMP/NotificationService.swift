//
//  NotificationService.swift
//  PushIMP
//
//  Created by Biswadeep Mondal on 18/03/23.
//

import UserNotifications
import CTNotificationService
import CleverTapSDK
class NotificationService: CTNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        
        CleverTap.setDebugLevel(3)
               CleverTap.sharedInstance()?.recordEvent("NotificationServiceEvent")
       //CleverTap.profileGetID(<#T##self: CleverTap##CleverTap#>)
        CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: request.content.userInfo)
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
//        if let bestAttemptContent = bestAttemptContent {
//            // Modify the notification content here...
//            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
//
//            contentHandler(bestAttemptContent)
//        }
        super.didReceive(request, withContentHandler: contentHandler)
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
