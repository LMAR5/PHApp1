//
//  TaskModel.swift
//  PHApp1
//
//  Created by Luis Aguilar on 11/18/23.
//

import Foundation

struct TaskModel: Identifiable, Hashable {
    
    let id = UUID()
    var title: String
    var category: String
    var isCompleted: Bool
    var dueDate: Date
    var details: String?
    
    init(title: String, category: String, isCompleted: Bool = false, dueDate: Date = Date(), details: String? = nil) {
        self.title = title
        self.category = category
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.details = details
    }
    
    static func mockSampleData() -> [TaskModel] {
        [
            TaskModel(title: "Take out the dog", category: "Family"),
            TaskModel(title: "Study for calculus exam", category: "Study"),
            TaskModel(title: "Design mobile app mockups", category: "Study"),
            TaskModel(title: "Go out for a run", category: "Exercise"),
            TaskModel(title: "Review Sales report", category: "Work")
        ]
    }
}
