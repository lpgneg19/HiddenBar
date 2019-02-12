//
//  Util.swift
//  vanillaClone
//
//  Created by Thanh Nguyen on 1/29/19.
//  Copyright © 2019 Thanh Nguyen. All rights reserved.
//

import AppKit
import Foundation
import ServiceManagement

extension Notification.Name {
    static let killLauncher = Notification.Name("killLauncher")
}


class Util {

    
    static func setUpAutoStart(isAutoStart:Bool)
    {
        let launcherAppId = "com.dwarvesv.LauncherApplication"
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == launcherAppId }.isEmpty
        
        SMLoginItemSetEnabled(launcherAppId as CFString, isAutoStart)
        
        if isRunning {
            DistributedNotificationCenter.default().post(name: .killLauncher,
                                                         object: Bundle.main.bundleIdentifier!)
        }
    }
    
    static func setIsAutoStart(_ isAutoStart:Bool){
        UserDefaults.standard.set(isAutoStart, forKey: IS_AUTO_START)
        
    }
    
    static func getIsAutoStart()->Bool{
        let savedValue = UserDefaults.standard.bool(forKey: IS_AUTO_START)
        return savedValue
    }
    
    static func getStateAutoStart() -> NSControl.StateValue{
        if(getIsAutoStart())
        {
            return .on
        }
        return .off
    }
    
    static func setIsAutoHide(_ isAutoHide:Bool){
        UserDefaults.standard.set(isAutoHide, forKey: IS_AUTO_HIDE)
        
    }
    
    static func getIsAutoHide()->Bool{
        let savedValue = UserDefaults.standard.bool(forKey: IS_AUTO_HIDE)
        return savedValue
    }
    
    static func getStateAutoHide() -> NSControl.StateValue{
        if(getIsAutoHide())
        {
            return .on
        }
        return .off
    }
    
    static func setIsKeepInDock(_ isKeepInDock:Bool){
        UserDefaults.standard.set(isKeepInDock, forKey: IS_KEEP_IN_DOCK)
        
    }
    
    static func getIsKeepInDock()->Bool{
        UserDefaults.standard.register(defaults: [IS_KEEP_IN_DOCK : true])
        let savedValue = UserDefaults.standard.bool(forKey: IS_KEEP_IN_DOCK)
        return savedValue
    }
    
    static func getStateKeepInDock() -> NSControl.StateValue{
        if(getIsKeepInDock())
        {
            return .on
        }
        return .off
    }
    
    static func toggleDockIcon(_ state: Bool) -> Bool {
        var result: Bool
        if state {
            result = NSApp.setActivationPolicy(NSApplication.ActivationPolicy.regular)
        }
        else {
            result = NSApp.setActivationPolicy(NSApplication.ActivationPolicy.accessory)
        }
        return result
    }
    
    static func bringToFront(window:NSWindow?) {
        window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}
