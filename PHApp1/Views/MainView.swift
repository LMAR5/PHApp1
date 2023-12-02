//
//  MainView.swift
//  PHApp1
//
//  Created by Luis Aguilar on 11/19/23.
//

import SwiftUI
import CoreData

struct MainView: View {
        
    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: TaskList.fetch(), animation: .default)
    var taskLists: FetchedResults<TaskList>
    @Binding var selection: TaskSection?
    
    var body: some View {
        List(selection: $selection) {
            Section("Main") {
                ForEach(TaskSection.allCases) { selection in
                    Label(selection.displayName, systemImage: selection.iconName).tag(selection)
                }
            }
            Section("My Lists") {
                ForEach(taskLists) { list in
                    TaskListRow(taskList: list)
                        .tag(TaskSection.list(list))
                        .contextMenu {
                            Button("Delete", role: .destructive) {
                                TaskList.deleteList(tasklist: list)
                            }
                        }
                }.onDelete { indexSet in
                    guard let index = indexSet.first else {
                        return
                    }
                    TaskList.deleteList(tasklist: taskLists[index])
                }
            }
        }.safeAreaInset(edge: .bottom) {
            Button(action: {
                let newList = TaskList(title: "New list", context: context)
            }, label: {
                Label("Add List", systemImage: "plus").padding(.leading)
            })
            .buttonStyle(.borderless)
            .foregroundColor(.accentColor)
            .padding().frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

//Code to preview this view
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selection: .constant(.all))
            .listStyle(.sidebar).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
