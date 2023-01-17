//
//  ContentView.swift
//  notesSwiftUI
//
//  Created by Алексей Попроцкий on 21.12.2022.
//

import SwiftUI
import CoreData

struct MainView: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 15) {
                    Text("Neon Notes")
                        .font(.title.bold())
                        .foregroundColor(.palette.child.opacity(0.6))
                        .shadow(color: .palette.child, radius: 3)
                
                    notesScrollView
                }
                buttonAddNote
            }
            .sheet(isPresented: $mainViewModel.isNewNote) {
                NoteCreateAndEditView(viewModel:
                                        NoteCreateAndEditViewModel(isNewNote:
                                                                    mainViewModel.isNewNote),
                                      editTextContent: "")
            }
            .background(Color.palette.parent.edgesIgnoringSafeArea(.all))
        }
    }
}



extension MainView {
    private var buttonAddNote: some View {
        Button (action: mainViewModel.addNote) {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 45))
                .foregroundColor(.palette.child)
                .shadow(color: .palette.child, radius: 3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding()
        .padding(.trailing, 20)
    }
    
    
    private var notesScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                ForEach(mainViewModel.noteEntitys) { note in
                    NavigationLink {
                        NoteCreateAndEditView(
                            viewModel: NoteCreateAndEditViewModel(note: note,
                                                                  isNewNote: mainViewModel.isNewNote),
                            editTextContent: note.textContent ?? "")
                    } label: {
                        NoteCellView(note: note)
                            .swipeDeleteCustomModifier {
                                mainViewModel.deleteNote(note: note)
                            }
                    }
                }
                .listRowBackground(Color.palette.child)
            }
            .padding(.top, 20)
            .padding(.horizontal)
        }
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MainViewModel())
    }
}
