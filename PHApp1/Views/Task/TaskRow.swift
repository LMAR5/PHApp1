//
//  TaskRow.swift
//  PHApp1
//
//  Created by Luis Aguilar on 11/19/23.
//

import SwiftUI

//Row view for each task
struct TaskRow: View {
    //List of paremeters to load this view (Quantity: 1)
    //Use @ObservedObject to subscribe to an obwervable object and update any views when changes occur
    @ObservedObject var objtask: Task
    @Binding var selectedTask: Task?
    @Binding var inspectorIsShown: Bool
    let showMoreButton: Bool
    
    init(objtask: Task, 
         selectedTask: Binding<Task?>,
         inspectorIsShown: Binding<Bool>, 
         showMoreButton: Bool = true) {
        self.objtask = objtask
        self._selectedTask = selectedTask
        self._inspectorIsShown = inspectorIsShown
        self.showMoreButton = showMoreButton
    }
    
    var body: some View {
        HStack {
            Image(systemName: objtask.isCompleted ? "largecircle.fill.circle" : "circle")
                .onTapGesture {                    
                    do {
                        try Task.updateTask(isCompleted: !objtask.isCompleted, isHighPriority: objtask.isHighPriority, for: objtask)
                        TaskUpdateManager.shared.update()
                    } catch {
                        print("isCompleted not updated")
                    }
            }
            Image(systemName: objtask.isHighPriority ? "exclamationmark" : "").foregroundColor(.red)
            TextField("New Task", text: $objtask.title)
                .textFieldStyle(.plain).onChange(of: objtask.title) {
                    do {
                        try Task.updateTask(isCompleted: objtask.isCompleted, isHighPriority: objtask.isHighPriority, for: objtask)
                    } catch {
                        print("Title not updated")
                    }
                }
            Button(action: {
                inspectorIsShown = true
                selectedTask = objtask
            }, label: {
                Text("View").foregroundColor(.black)
            }).buttonStyle(.bordered)
        }
    }
    
}

//Code to preview this view
struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(objtask: Task.mockExample,
                selectedTask: .constant(nil),
                inspectorIsShown: .constant(false)).padding()
    }
}
