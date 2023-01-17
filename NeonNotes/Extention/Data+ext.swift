//
//  Data+ext.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 23.12.2022.
//

import Foundation


extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy, HH:mm"
        return dateFormatter.string(from: self)
    }
}
