//
//  TaskListView.swift
//  PHApp1
//
//  Created by Luis Aguilar on 11/20/23.
//

import SwiftUI
import CoreData

//View to list each "TaskRow" view
struct TaskListView: View {    
    //Parameters for TaskListView view.
    let title: String
    @FetchRequest(fetchRequest: Task.fetch(), animation: .default) 
    var tasks
    @Environment(\.managedObjectContext)
    var context
    @State
    private var selectedTask: Task? = nil
    @State
    private var showInspector: Bool = false
    
    init(title: String) {
        self.title = title
        let request = Task.fetch()
        request.predicate = nil
        
        self._tasks = FetchRequest(fetchRequest: request, animation: .default)
    }
    
    var body: some View {
        List(tasks) { task in
            TaskRow(objtask: task,
                    selectedTask: $selectedTask, inspectorIsShown: $showInspector)
        }
        .navigationTitle(title)
        .toolbar {
            ToolbarItemGroup {
                Button {
                    //To do: Update task in CD
                    let task = Task(title: "New", dueDate: Date(), context: context)
                    PersistenceController.shared.save()
                } label: {
                    Label("Add New Task", systemImage: "plus")
                }
            }
        }.inspector(isPresented: $showInspector){
            if let selectedTask {
                ViewTask(task: selectedTask)
            }
        }
    }
}


//Code to preview this view with sample data
struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(title: "All").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
