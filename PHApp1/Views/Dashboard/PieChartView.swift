//
//  PieChartView.swift
//  PHApp1
//
//  Created by Luis Aguilar on 12/5/23.
//

import SwiftUI
import Charts

struct PieChartView: View {
    
    @FetchRequest(fetchRequest: TaskList.fetch(), animation: .default)
    var tasklists
    
    var body: some View {
        VStack {
            Text("Number of tasks by list").bold()
            Chart(tasklists, id: \.title) { dataItem in
                SectorMark(
                    angle: .value("List", dataItem.childTasks.count),
                    innerRadius: .ratio(0.5),
                    angularInset: 1.5
                )
                .cornerRadius(5.0)
                .foregroundStyle(by: .value("Title", dataItem.title))
                .annotation(position: .overlay) {
                    Text(String(dataItem.childTasks.count))
                }
                
            }.frame(height: 200)            
        }
    }
}

#Preview {
    PieChartView()
}
