//
//  Chart.swift
//  PHApp1
//
//  Created by Luis Aguilar on 12/3/23.
//

import SwiftUI
import Charts

struct BarChartView: View {
    
    @FetchRequest(fetchRequest: Task.fetchTasksHighPriority(), animation: .default)
    var highTasks
    
    @FetchRequest(fetchRequest: Task.fetchTasksLowPriority(), animation: .default)
    var lowTasks
    
    var body: some View {
        VStack {
            Text("Number of tasks by priority").bold()
            Chart {
                BarMark(
                    x: .value("Priority", "High"),
                    y: .value("Number", highTasks.count)
                ).foregroundStyle(.linearGradient(Gradient(colors: [.red, .orange]), startPoint: .top, endPoint: .bottom))
                BarMark(
                    x: .value("Priority", "Low"),
                    y: .value("Number", lowTasks.count)
                )
                .foregroundStyle(.linearGradient(Gradient(colors: [.red, .orange]), startPoint: .top, endPoint: .bottom))
                
            }
            .aspectRatio(1, contentMode: .fit)
            .padding()
        }
    }
}

#Preview {
    BarChartView()
}
