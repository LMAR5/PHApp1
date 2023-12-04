//
//  ContentView.swift
//  PHApp1
//
//  Created by Luis Aguilar on 11/18/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //@Environment(\.managedObjectContext) private var viewContext
    //let persistenceController = PersistenceController.shared
    @State private var selection: TaskSection? = TaskSection.initialValue
    
    var body: some View {
        TabView{
            NavigationSplitView {
                MainView(selection: $selection)
                    .navigationTitle("Priority Hub")
            } detail: {
                TaskListView(title: selection?.displayName ?? "All", selection: selection)
            }
            .tabItem( { Label("Main", systemImage: "house") } )
            DashboardMain()
                .tabItem({
                    Label("Dashboard", systemImage: "chart.bar")
                })
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
