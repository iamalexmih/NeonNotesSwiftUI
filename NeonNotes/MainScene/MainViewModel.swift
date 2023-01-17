//
//  MainViewModel.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 22.12.2022.
//

import Foundation


class MainViewModel: ObservableObject {
    
    private var coreDataManager = CoreDataManager.shared
    
    @Published var noteEntitys: [NoteEntity] = []
    @Published var isNewNote: Bool = false
    private var isFirstLaunchApp: Bool
    
    init() {
        isFirstLaunchApp = AppStorageManager.shared.loadStatusFirstLaunchApp()
        if isFirstLaunchApp {
            defaultListNotes()
            isFirstLaunchApp.toggle()
            AppStorageManager.shared.saveStatusFirstLaunchApp(isFirstLaunchApp: isFirstLaunchApp)
            coreDataManager.save()
        } else {
            updateData()
        }
    }
    
    func addNote() {
        isNewNote.toggle()
    }
    
    
    func updateData() {
        noteEntitys = coreDataManager.fetchData()
    }
    
    
    func deleteNote(note: NoteEntity) {
        coreDataManager.viewContext.delete(note)
        coreDataManager.save()
        updateData()
    }
    
    
    func defaultListNotes() {
        let defaultNote = NoteEntity(context: coreDataManager.viewContext)
        defaultNote.textContent = "👋 Hello user. This is an example of a note. Swipe left to delete a note."
        defaultNote.timestamp = Date()
        defaultNote.title = Date().toString
        noteEntitys = [defaultNote]
    }
}

