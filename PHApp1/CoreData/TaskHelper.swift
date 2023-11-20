//
//  TaskHelper.swift
//  PHApp1
//
//  Created by Luis Aguilar on 11/19/23.
//

import Foundation
import CoreData

extension Task {
   
    var uid: UUID {
        #if DEBUG
        uid_!
        #else
        uid_ ?? UUID()
        #endif
    }
    
    //To transform the optional "title" to a not optional one
    //Handle optionals, so in case "title" is null (was not set), use an empty string
    var title: String {
        //Getter: If CD "title_" is null, return an empty string
        get { title_ ?? "" }
        //Setter: Assigning value to CD attribute
        set { title_ = newValue }
    }
    
    //Define getter and setter to initialize the field with today's date
    var dueDate: Date {
        get { dueDate_ ?? Date() }
        set { dueDate_ = newValue }
    }
    
    //Create convenience initializer to avoid conflict with default one
    convenience init(title: String, dueDate: Date, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.dueDate = dueDate
    }
    
    //To make sure that every time we create an object, uid is set with a uniqueidentifier
    public override func awakeFromInsert() {
        self.uid_ = UUID()
    }
    
    //Function to delete objects
    static func delete(task: Task) {
        guard let context = task.managedObjectContext else { return }
        context.delete(task)
    }
    
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<Task> {
        let request = Task.fetchRequest()
        //Sort the elements fetched from Core Data
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Task.dueDate_, ascending: true),
                                   NSSortDescriptor(keyPath: \Task.title_, ascending: true)]
        request.predicate = predicate
        return request
    }
    
    //To mock sample data of Task for previews in other Views
    static var mockExample: Task {
        let context = PersistenceController.preview.container.viewContext
        let task = Task(title: "Study math", dueDate: Date(), context: context)
        
        return task
    }
    
}
