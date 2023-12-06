//
//  ViewTask.swift
//  PHApp1
//
//  Created by Luis Aguilar on 12/1/23.
//

import SwiftUI

struct ViewTask: View {
    
    @Environment(\.managedObjectContext) var context
    @ObservedObject var task: Task
    
    var body: some View {
        List{
            Text(task.title).font(.title2).bold()
            Toggle(task.isCompleted ? "Completed": "Pending", isOn: $task.isCompleted).onTapGesture {
                do {
                    try Task.updateTask(isCompleted: !task.isCompleted, isHighPriority: task.isHighPriority, for: task)
                    TaskUpdateManager.shared.update()
                } catch {
                    print("isCompleted not updated")
                }
            }
            Toggle(task.isHighPriority ? "High priority" :"Low priority", isOn: $task.isHighPriority).onTapGesture {
                do {
                    try Task.updateTask(isCompleted: task.isCompleted, isHighPriority: !task.isHighPriority, for: task)
                } catch {
                    print("isHighPriority not updated")
                }
            }
            DatePicker("Due Date", selection: $task.dueDate).onChange(of: task.dueDate) {
                do {
                    try Task.updateTask(isCompleted: task.isCompleted, isHighPriority: task.isHighPriority, for: task)
                } catch {
                    print("dueDate not updated")
                }
            }
        }
        .listStyle(.sidebar)        
    }
}

//Code to preview this view
struct View_Previews: PreviewProvider {
    static var previews: some View {
        ViewTask(task: Task.mockExample).padding()
    }
}
