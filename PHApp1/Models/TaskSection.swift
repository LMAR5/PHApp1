//
//  TaskSection.swift
//  PHApp1
//
//  Created by Luis Aguilar on 11/19/23.
//

import Foundation

enum TaskSection: Identifiable, CaseIterable, Hashable {
    
    case all
    case done
    case pending
    case highpriority
    case list(TaskList)
    
    var id: String {
        switch self {
        case .all:
            return "all"
        case .done:
            return "done"
        case .pending:
            return "pending"
        case .highpriority:
            return "important"
        case .list(let taskList):
            return taskList.uid.uuidString
        }
    }
    
    var displayName: String {
        switch self {
        case .all:
            return "All"
        case .done:
            return "Done"
        case .pending:
            return "Pending"
        case .highpriority:
            return "High priority"
        case .list(let taskList):
            return taskList.title
        }
    }
    
    var iconName: String {
        switch self {
        case .all:
            return "star"
        case .done:
            return "checkmark.circle"
        case .pending:
            return "list.clipboard"
        case .highpriority:
            return "exclamationmark.bubble"
        case .list(_):
            return "list.bullet"
        }
    }
    
    static var allCases: [TaskSection] {
        [.all, .done, .pending, .highpriority]
    }
    
    static func == (lhs: TaskSection, rhs: TaskSection) -> Bool {
        lhs.id == rhs.id
    }
    
    static var initialValue: TaskSection? {
        nil
    }
}
