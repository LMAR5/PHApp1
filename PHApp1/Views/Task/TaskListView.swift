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
    let tasklist: TaskList?
    
    
    init(title: String, selection: TaskSection?) {
        self.title = title
        let request = Task.fetch()
        switch selection {
            case .all:
                request.predicate = nil
            case .done:
                request.predicate = NSPredicate(format: "isCompleted == true")
            case .pending:
                request.predicate = NSPredicate(format: "isCompleted == false")
            case .highpriority:
                request.predicate = NSPredicate(format: "isHighPriority == true")
            case .list(let input_list):
                request.predicate = NSPredicate(format: "parentList == %@", input_list as CVarArg)
            case nil:
                request.predicate = NSPredicate.none
        }
        
        switch selection {
        case .all, .done, .pending, .highpriority:
                tasklist = nil
            case .list(let input_list):
                self.tasklist = input_list
            case nil:
                tasklist = nil
        }
        
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
                    task.parentList = tasklist
                    PersistenceController.shared.save()
                } label: {
                    Label("Add New Task", systemImage: "plus")
                }                
            }
        }.inspector(isPresented: $showInspector){
            if let selectedTask {
                ViewTask(task: selectedTask)
            } else {
                ContentUnavailableView("Please select a task", systemImage: "circle.inset.filled")
            }
        }
    }
}


//Code to preview this view with sample data
struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(title: "All", selection: .all).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
