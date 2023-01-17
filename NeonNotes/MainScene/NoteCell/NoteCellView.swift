//
//  NoteCellView.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import SwiftUI

struct NoteCellView: View {
    
    @StateObject var note: NoteEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.title ?? Date().toString)
                .font(.headline.bold())
                .foregroundColor(.palette.child.opacity(0.8))
            Text(note.textContent ?? "empty note")
                .font(.callout)
                .multilineTextAlignment(.leading)
                .foregroundColor(.palette.child.opacity(0.9))
            HStack {
                Spacer()
                Text(note.timestamp?.toString ?? Date().toString)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.3))
            }
        }
        .padding(8)
        .frame(width: Size.widthCell, height: Size.heightCell)
        .background(Color.palette.child.opacity(0.2))
        .shadow(color: .palette.child.opacity(0.6), radius: 1)
        .cornerRadius(15)
        
    }
}
