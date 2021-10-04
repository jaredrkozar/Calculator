//
//  ExtensionDelegate.swift
//  Calculator (Watch( Extension
//
//  Created by Jared Kozar on 9/16/21.
//

import WatchKit
import Communicator

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        NSHomeDirectory()
        colorObservations()
        roundingObservations()
        
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

}

private extension ExtensionDelegate {
    
    func colorObservations() {
        
        ImmediateMessage.observe { immediateMessage in

            let content = immediateMessage.content
                  
            if content["regularColor"] != nil {
                let regularcolorasstring = UIColorFromString(string: content["regularColor"] as! String)
                let operatorcolorasstring = UIColorFromString(string: content["operatorColor"] as! String)
                
                UserDefaults.standard.set(regularcolorasstring, forKey: "regularColor")
                UserDefaults.standard.set(operatorcolorasstring, forKey: "operatorColor")
                
                
            }
            let matchtint = content["matchPhoneTintStatus"]
            
            UserDefaults.standard.set(matchtint, forKey: "matchPhoneTint")
            
            NotificationCenter.default.post(name: Notification.Name("MessageReceived"), object: nil)
        }
    }
    
    func roundingObservations() {
        
        ImmediateMessage.observe { immediateMessage in

            let content = immediateMessage.content
                  
            if content["roundingPlaces"] != nil {
                UserDefaults.standard.set(content["roundingPlaces"], forKey: "roundingPlaces")
            
            }
            
            NotificationCenter.default.post(name: Notification.Name("RoundingMessageReceived"), object: nil)
        }
    }
}
