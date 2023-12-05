//
//  TableView.swift
//  PHApp1
//
//  Created by Luis Aguilar on 12/5/23.
//

import SwiftUI

struct TableView: View {
    
    @FetchRequest(fetchRequest: TaskList.fetch(), animation: .default)
    var tasklists
    
    var body: some View {
        List {
            Text("Total of tasks by list").bold()
            Grid {
                GridRow {
                    Text("List title")
                    Text("# of tasks")
                    Text("Completed")
                }.bold()
                Divider()
                ForEach(tasklists) { tlist in
                    GridRow {
                        Text(tlist.title)
                        Text(tlist.childTasks.count, format: .number)
                        //Calculate % of completed tasks
                        //Bug: Not updating when a task is being updated
                        Text("\(Float(tlist.childTasks.filter({ $0.isCompleted == true }).count)/Float(tlist.childTasks.count) * 100, specifier: "%.0f")%")
                    }
                    if tlist != tasklists.last {
                        Divider()
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)        
    }
}

#Preview {
    TableView()
}
