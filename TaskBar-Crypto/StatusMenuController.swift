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
        updateCoins()
    }
    
    @IBAction func refreshClicked(_ sender: NSMenuItem) {
        updateCoins()
    }
    
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    
    let coins = ["BTC", "ETH", "TRX", "XRP", "EOS", "LTC", "BSV", "IOST"]
    let currency = "GBP"
    func updateCoins() {
        cryptoAPI.getFullData(for: coins, against: currency) { coins in
            for coin in coins {
                NSLog(String(describing: coin))
                print(self.generateString(for: coin))
            }
            self.updateViewFromModel(with: coins)
        }
    }
    
    func generateString(for coin: Coin) -> NSAttributedString {
        let priceStr = NSMutableAttributedString(string: String(format: "%.2f ", coin.price))
        let attributes: [NSAttributedString.Key: Any] =
            coin.pctChange24hr >= 0 ?
                [.foregroundColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)] : [.foregroundColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)]
        priceStr.append(NSAttributedString(string: "("+String(format: "%.2f", coin.pctChange24hr)+"%)", attributes: attributes))
        return priceStr
    }
    
    @IBOutlet weak var menuItem: NSMenuItem!
    
    private func updateViewFromModel(with coins: [Coin]) {
        //empties the status menu
        statusMenu.removeAllItems()
        // add menu items for each coin
        for coin in coins {
            let coinStr = NSMutableAttributedString(string: coin.name + " ")
            coinStr.append(generateString(for: coin))
            let menuItem = NSMenuItem(title: "", action: nil, keyEquivalent: "")
            menuItem.attributedTitle = coinStr
            statusMenu.addItem(menuItem)
        }
        
        statusMenu.addItem(NSMenuItem.separator())
        let refresh = NSMenuItem(title: "Refresh", action:#selector(self.refreshClicked(_:)),keyEquivalent: "")
        refresh.target = self
        refresh.isEnabled = true
        let quit = NSMenuItem(title: "Quit", action:#selector(NSApplication.terminate(_:)), keyEquivalent: "")
        statusMenu.addItem(refresh)
        statusMenu.addItem(quit)
    }
    
    
}
