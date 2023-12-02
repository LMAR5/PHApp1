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
            Toggle(task.isCompleted ? "Completed": "Pending", isOn: $task.isCompleted)
            Toggle(task.isHighPriority ? "Important" :"Not important", isOn: $task.isHighPriority)
            DatePicker("Due Date", selection: $task.dueDate)
        }.listStyle(.sidebar)
    }
}

//Code to preview this view
struct View_Previews: PreviewProvider {
    static var previews: some View {
        ViewTask(task: Task.mockExample).padding()
    }
}
