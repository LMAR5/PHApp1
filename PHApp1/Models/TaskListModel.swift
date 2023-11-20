//
//  TaskListModel.swift
//  PHApp1
//
//  Created by Luis Aguilar on 11/18/23.
//

import Foundation

struct TaskListModel: Identifiable, Hashable {
    let id = UUID()
    var title: String
    let createdDate: Date
    var tasks: [TaskModel]
    
    init(title: String, tasks: [TaskModel] = []) {
        self.title = title
        self.createdDate = Date()
        self.tasks = tasks
    }
    
    static func mockSampleData() -> TaskListModel {
        let task1 = TaskModel(title: "Develop Figma prototype", category: "Study")
        let task2 = TaskModel(title: "Develop React frontend", category: "Study")
        let task3 = TaskModel(title: "Develop NodeJS backend", category: "Study")
        let task4 = TaskModel(title: "Design MySQL DB Schema", category: "Study")
        
        var list = TaskListModel(title: "Web Development")
        list.tasks = [task1, task2, task3, task4]
        return list
    }
}
