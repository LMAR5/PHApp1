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
    
    init(objtask: Task) {
        self.objtask = objtask
    }
    
    var body: some View {
        HStack {
            Image(systemName: objtask.isCompleted ? "largecircle.fill.circle" : "circle")
                .onTapGesture {
                    objtask.isCompleted.toggle()
            }
            TextField("New Task", text: $objtask.title)
                .textFieldStyle(.plain)
            Button(action: {
                
            }, label: {
                Text("View").foregroundColor(.black)
            }).buttonStyle(.bordered)
        }
    }
    
}

//Code to preview this view
struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(objtask: Task.mockExample).padding()
    }
}
