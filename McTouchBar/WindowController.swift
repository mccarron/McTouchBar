//
//  WindowController.swift
//  McTouchBar
//
//  Created by Patrick McCarron on 2/14/17.
//  Copyright © 2017 mccarron. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        if let controller = contentViewController as? ViewController {
            return controller.makeTouchBar()
        }
        //Handle other view controller touch bars here
        return nil
    }

}
