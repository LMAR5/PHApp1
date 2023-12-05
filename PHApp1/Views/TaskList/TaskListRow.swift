//
//  TaskListRow.swift
//  PHApp1
//
//  Created by Luis Aguilar on 11/19/23.
//

import SwiftUI

struct TaskListRow: View {
    //List of paremeters to load this view (Quantity: 1)
    //Only one paremeter to load this view
    @ObservedObject var taskList: TaskList
    
    var body: some View {
        HStack {
            Image(systemName: "list.bullet")
            TextField("New list", text: $taskList.title).onChange(of: taskList.title) {
                do {
                    try TaskList.updateTaskList(for: taskList)
                } catch {
                    print("Title not updated")
                }
            }
        }
    }
}

//Code to preview this view
struct TaskListRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskListRow(taskList: TaskList.mockExample).padding()
    }
}
