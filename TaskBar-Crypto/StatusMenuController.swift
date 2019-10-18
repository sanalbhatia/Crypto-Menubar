//
//  StatusMenuController.swift
//  TaskBar-Crypto
//
//  Created by Sanal Bhatia on 18/09/2019.
//  Copyright © 2019 Sanal Bhatia. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    let cryptoAPI = CryptoAPI()
    
    override func awakeFromNib() {
        statusItem.menu = statusMenu
        guard let button = statusItem.button else {
            print("Menu bar full.")
            NSApp.terminate(nil)
            return
        }
        button.title = "🗿"
    }
    
    @IBAction func refreshClicked(_ sender: NSMenuItem) {
        cryptoAPI.getRate(for: "BTC", against: "USD")
    }
    
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
}
