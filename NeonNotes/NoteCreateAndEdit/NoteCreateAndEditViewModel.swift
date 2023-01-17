//
//  NoteCreateAndEditViewModel.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 22.12.2022.
//

import Foundation



class NoteCreateAndEditViewModel: ObservableObject {
        
    @Published var newTextContent: String = ""
    @Published var editTextContent: String
    @Published var note: NoteEntity?
    @Published var isNewNote: Bool
    @Published var titleNote: String
    
    private var coreDataManager = CoreDataManager.shared
    
    
    init(note: NoteEntity? = nil, isNewNote: Bool) {
        self.editTextContent = note?.textContent ?? "что то пошло не так, просто пустая заметка"
        self.note = note
        self.isNewNote = isNewNote
        
        if note == nil {
            self.titleNote = Date().toString
        } else {
            self.titleNote = note!.title!
        }
    }


    func addNote(mainViewModel: MainViewModel) {
        if !newTextContent.isEmpty {
            let newNote = NoteEntity(context: coreDataManager.viewContext)
            newNote.textContent = newTextContent
            newNote.timestamp = Date()
            if titleNote == ""{
                titleNote = Date().toString
            }
            newNote.title = titleNote
            coreDataManager.save()
            mainViewModel.noteEntitys = coreDataManager.fetchData()
        }
    }


    func updateNote(mainViewModel: MainViewModel) {
        if editTextContent != note?.textContent || titleNote != note?.title {
            note?.textContent = editTextContent
            note?.timestamp = Date()
            if titleNote == ""{
                titleNote = Date().toString
            }
            note?.title = titleNote
            coreDataManager.save()
            mainViewModel.noteEntitys = coreDataManager.fetchData()
        }
    }
    
    
    func changeButtonBackText() -> Bool {
        if editTextContent == note?.textContent && titleNote == note?.title {
            return true
        } else {
            return false
        }
        
    }
}
