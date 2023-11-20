//
//  TaskListHelper.swift
//  PHApp1
//
//  Created by Luis Aguilar on 11/19/23.
//

import Foundation
import CoreData

extension TaskList {
    
    var uid: UUID {
        #if DEBUG
        uid_!
        #else
        uid_ ?? UUID()
        #endif
    }
    
    var title: String {
        get { title_ ?? "" }
        set { title_ = newValue }
    }
    
    var createdDate: Date {
        //createdDate is only required to be set once
        //No need for a setter
        createdDate_ ?? Date()
    }
    
    //Create convenience initializer to avoid conflict with default one
    convenience init(title: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
    }
    
    //To make sure that every time we create an object, uid is set with a uniqueidentifier and createdDate with today's date
    public override func awakeFromInsert() {
        self.uid_ = UUID()
        self.createdDate_ = Date()
    }
    
    //Function to delete objects
    static func delete(tasklist: TaskList) {
        guard let context = tasklist.managedObjectContext else { return }
        context.delete(tasklist)
    }
    
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<TaskList> {
        let request = TaskList.fetchRequest()
        //Sort the elements fetched from Core Data
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TaskList.title_, ascending: true),
                                   NSSortDescriptor(keyPath: \TaskList.createdDate_, ascending: true)]
        request.predicate = predicate
        return request
    }
    
    //To mock sample data of TaskList for previews in other Views
    static var mockExample: TaskList {
        let context = PersistenceController.preview.container.viewContext
        let list = TaskList(title: "Web development", context: context)
        //let task = Task(title: "Study math", dueDate: Date(), context: context)
        
        return list
    }
    
}
