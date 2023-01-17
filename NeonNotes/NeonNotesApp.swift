//
//  NeonNotesApp.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import SwiftUI

@main
struct NeonNotesApp: App {
    @StateObject var viewModel = MainViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
                .preferredColorScheme(.dark)
        }
    }
}
