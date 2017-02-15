//
//  AppDelegate.swift
//  McTouchBar
//
//  Created by Patrick McCarron on 2/14/17.
//  Copyright © 2017 mccarron. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if #available(OSX 10.12.2, *) {
            NSApplication.shared().isAutomaticCustomizeTouchBarMenuItemEnabled = true
        }
    }
    
}

