//
//  SettingsManager.swift
//  Thread-safe Singleton
//
//  Created by Алексей Соболевский on 21.11.22.
//
// Resolving race condition by using custom concurrent queue with .barrier on setting value. This solution is
// more performant than the one that uses just a serial queue, because value receving is concurrent.

import Foundation

final public class SettingsManager {
    public static let shared = SettingsManager(settings: [:])

    private let settingsQueue = DispatchQueue(label: "SettingsQueue", attributes: .concurrent)
    private var settings: [String: Any]

    private init(settings: [String: Any]) {
        self.settings = settings
    }

    public func int(forKey key: String) -> Int? {
        var value: Int?

        settingsQueue.sync {
            value = settings[key] as? Int
        }

        return value
    }

    public func set(value: Any, forKey key: String) {
        settingsQueue.async(flags: .barrier) {
            self.settings[key] = value
        }
    }
}
