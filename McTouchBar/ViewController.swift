//
//  ViewController.swift
//  McTouchBar
//
//  Created by Patrick McCarron on 2/14/17.
//  Copyright © 2017 mccarron. All rights reserved.
//

import Cocoa

fileprivate extension NSTouchBarCustomizationIdentifier {
    static let touchBar = NSTouchBarCustomizationIdentifier("com.mccarron.touchBar")
}

fileprivate extension NSTouchBarItemIdentifier {
    static let sharingPicker = NSTouchBarItemIdentifier("com.mccarron.sharing")
    static let button = NSTouchBarItemIdentifier("com.mccarron.button")
    static let sizeSlider = NSTouchBarItemIdentifier("com.mccarron.slider")
}

class ViewController: NSViewController {

    @IBOutlet var textField: NSTextField!
    let defaultSize: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetTextField()
    }
    
    func resetTextField() {
        textField.font = NSFont(name: "Helvetica", size: CGFloat(defaultSize))
    }

    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        let mainBar = NSTouchBar()
        mainBar.delegate = self
        mainBar.customizationIdentifier = .touchBar
        
        // Default Bar Items
        mainBar.defaultItemIdentifiers = [.button, .sizeSlider]
        
        // Items you allow to be chosen for customization
        mainBar.customizationAllowedItemIdentifiers = [.sharingPicker]
        
        // This item will be centered
        mainBar.principalItemIdentifier = .sizeSlider
        
        return mainBar
    }
    
    @IBAction func changeFontSize(_ sender: NSSlider) {
        guard let font = textField.font else { return }
        textField.font = NSFontManager.shared().convert(font, toSize: CGFloat(sender.floatValue))
    }
    
    @IBAction func reset(_ sender: NSSlider) {
        resetTextField()
    }
}

extension ViewController: NSTouchBarDelegate {
    
    @available(OSX 10.12.2, *)
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        
        switch identifier {
            
        case NSTouchBarItemIdentifier.sharingPicker:
            let sharingItem = NSSharingServicePickerTouchBarItem(identifier: identifier)
            return sharingItem
            
        case NSTouchBarItemIdentifier.button:
            let buttonItem = NSCustomTouchBarItem(identifier: identifier)
            let button = NSButton(title: "Reset", target: self, action: #selector(reset))
            buttonItem.view = button
            return buttonItem
            
        case NSTouchBarItemIdentifier.sizeSlider:
            let sliderItem = NSSliderTouchBarItem(identifier: identifier)
            sliderItem.label = "Size"
            let slider = sliderItem.slider
            slider.target = self
            slider.action = #selector(changeFontSize)
            slider.minValue = 1.0
            slider.maxValue = 250.0
            slider.integerValue = defaultSize
            return sliderItem
            
        default:
            return nil
            
        }
    }
}

