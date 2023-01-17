//
//  NoteCreateAndEditView.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import SwiftUI

struct NoteCreateAndEditView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var viewModel: NoteCreateAndEditViewModel
    @State var editTextContent: String
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        VStack {
            textTitleScene(viewModel.isNewNote)
            titleNoteTextField(text: $viewModel.titleNote, focusedField: $focusedField)
            
            TextEditor(text: viewModel.isNewNote ?
                       $viewModel.newTextContent : $viewModel.editTextContent)
                .focused($focusedField, equals: .textEditor)
                .tint(.palette.child.opacity(0.8))
                .foregroundColor(.palette.child.opacity(0.9))
        }

        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                buttonBack
                    .foregroundColor(.palette.child.opacity(0.7))
                    .shadow(color: .palette.child.opacity(0.6), radius: 1)
                    .animation(.easeInOut)
            }
            ToolbarItem(placement: .keyboard) {
                Button {
                    focusedField = nil
            } label: {
                Text("hide keyboard")
                    .foregroundColor(.palette.child.opacity(0.5))
                }   
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .onDisappear {
            if editTextContent.isEmpty {
                viewModel.addNote(mainViewModel: mainViewModel)
            } else {
                viewModel.updateNote(mainViewModel: mainViewModel)
            }
        }
    }
}

// MARK: - Helpers

extension NoteCreateAndEditView {
    private var buttonBack: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "arrow.left")
                    .shadow(color: .palette.child, radius: 3)
                if viewModel.changeButtonBackText() {
                    Text("Back")
                        .shadow(color: .palette.child, radius: 3)
                } else {
                    Text("Save and Back")
                        .shadow(color: .palette.child, radius: 3)
                }
            }
        }
    }
    
    
    private var buttonCloseNewNote: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.down")
                .font(.system(size: 30))
                .shadow(color: .palette.child, radius: 3)
        }
    }
    
    
    @ViewBuilder private func textTitleScene(_ isNewNote: Bool)  -> some View {
        let textNewNote = "Create New Note"
        let textEditNote = "Edit Note"
        
        HStack {
            Text(isNewNote ? textNewNote : textEditNote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title.bold())
                .padding(.leading, 24)
                .foregroundColor(.palette.child.opacity(0.8))
                .shadow(color: .palette.child, radius: 3)
            if viewModel.isNewNote {
                buttonCloseNewNote
                    .foregroundColor(.palette.child)
            }
        }
    }
    
    
    private func titleNoteTextField(text: Binding<String>,
                                    focusedField: FocusState<FocusField?>.Binding)  -> some View  {
        TextField("название заметки", text: text)
            .focused(focusedField, equals: .titleTextField)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .font(.title2.bold())
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .background(Color.palette.child.opacity(0.13))
            .cornerRadius(10)
            .foregroundColor(.palette.child.opacity(0.8))
            .shadow(color: .palette.child, radius: 3)
    }
}




struct NoteCreateAndEditView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCreateAndEditView(viewModel: NoteCreateAndEditViewModel(isNewNote: true),
                              editTextContent: "")
        .environmentObject(MainViewModel())
    }
}
