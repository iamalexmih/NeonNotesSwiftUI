//
//  ColorTheme+Ext.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 23.12.2022.
//

import SwiftUI


extension Color {
    static let palette = Pallette()
}



struct Pallette {
    let child: Color = Color("child")
    let parent: Color = Color("parent")
}
