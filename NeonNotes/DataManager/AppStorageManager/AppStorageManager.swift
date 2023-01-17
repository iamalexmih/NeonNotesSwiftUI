//
//  File.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 26.12.2022.
//

import SwiftUI



class AppStorageManager {
    
    static let shared = AppStorageManager()
    
    @AppStorage("isFirstLaunchApp") private var isFirstLaunchApp: Bool = true
    
    
    private init() {}
    
    
    
    func saveStatusFirstLaunchApp(isFirstLaunchApp: Bool) {
        self.isFirstLaunchApp = isFirstLaunchApp
    }
    
    
    func loadStatusFirstLaunchApp() -> Bool {
        isFirstLaunchApp
    }
}
