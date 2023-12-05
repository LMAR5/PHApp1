//
//  CircularProgressView.swift
//  PHApp1
//
//  Created by Luis Aguilar on 12/3/23.
//

import SwiftUI

struct CircularProgressView: View {
    
    @FetchRequest(fetchRequest: Task.fetch(), animation: .default)
    var allTasks
    
    @FetchRequest(fetchRequest: Task.fetchCompletedTasks(), animation: .default)
    var completedTasks
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                VStack {
                    Text("Completed tasks").bold()
                    Text("\(completedTasks.count)").bold()
                    Text("(\(Float(completedTasks.count)/Float(allTasks.count) * 100, specifier: "%.0f")%)").bold()
                    
                }
                //Progres circle at the back
                Circle().stroke(Color.pink.opacity(0.5), lineWidth: 30)
                //Progress circle
                Circle()
                    .trim(from: 0, to:CGFloat(Float(completedTasks.count)/Float(allTasks.count)))
                    .stroke(
                        Color.pink,
                        style: StrokeStyle(lineWidth: 30, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: CGFloat(Float(completedTasks.count)/Float(allTasks.count)))
            }.frame(width: 200, height: 200)
            Spacer()
        }
    }
}


#Preview {
    CircularProgressView()
}
