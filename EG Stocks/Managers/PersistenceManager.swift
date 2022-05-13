//
//  PersistenceManager.swift
//  EG Stocks
//
//  Created by Bekzat Kalybayev on 23.02.2022.
//

import Foundation

/// Object to manage saved cashes
final class PersistenceManager {
    /// Singleton
    static let shared = PersistenceManager()
    
    /// Reference to user defaults
    private let userDefaults: UserDefaults = .standard
    
    /// Constants
    private struct Constants {
        static let onboardedKey = "hasOnboarded"
        static let watchlistKey = "watchlist"
    }
    
    /// Private constructor
    private init() {}
    
    //MARK: - Public
    
    /// Gets user watchlist
    public var watchlist: [String] {
        if !hasOnboarded {
            userDefaults.set(true, forKey: Constants.onboardedKey)
            setUpDefaults()
        }
        return userDefaults.stringArray(forKey: Constants.watchlistKey) ?? []
    }
    
    /// Check if watchlist contains item
    /// - Parameter symbol: Symbol to check
    /// - Returns: Boolean
    public func watchlistContains(symbol: String) -> Bool {
        return watchlist.contains(symbol)
    }
    
    /// Add a symbol to watchlist
    /// - Parameters:
    ///   - symbol: Symbol to add
    ///   - companyName: Company name for symbol being added
    public func addToWatchlist(symbol: String, companyName: String) {
        var current = watchlist
        current.append(symbol)
        userDefaults.set(current, forKey: Constants.watchlistKey)
        userDefaults.set(companyName, forKey: symbol)
        
        NotificationCenter.default.post(name: .didAddToWatchList, object: nil)
    }
    
    /// Remove item from watchlist
    /// - Parameter symbol: Symbol to remove
    public func removeFromWatchlist(symbol: String) {
        var newList = [String]()
        
        // To clear out company name
        userDefaults.set(nil, forKey: symbol)
        
        for item in watchlist where item != symbol {
            newList.append(item)
        }
        userDefaults.set(newList, forKey: Constants.watchlistKey)
    }
    
    //MARK: - Private
    
    /// Check if user has been onboarded
    private var hasOnboarded: Bool {
        return userDefaults.bool(forKey: Constants.onboardedKey)
    }
    
    /// Set up default watchlist items
    private func setUpDefaults() {
        let map: [String: String] = [
            "AAPL": "Apple Inc.",
            "GOOG": "Alphabet Inc.",
            "SNAP": "Snap Inc.",
            "AMZN": "Amazon.com, Inc.",
            "WORK": "Slack Technologies",
            "NKE": "Nike, Inc.",
            "FB": "Meta Platforms, Inc.",
            "NFLX": "Netflix, Inc.",
            "PINS": "Pinterest, Inc.",
            "TSLA": "Tasla, Inc."
        ]
        
        let symbols = map.keys.map { $0 }
        userDefaults.setValue(symbols, forKey: Constants.watchlistKey)
        
        for (symbol, name) in map {
            userDefaults.setValue(name, forKey: symbol)
        }
    }
}
