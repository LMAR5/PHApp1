//
//  DashboardMain.swift
//  PHApp1
//
//  Created by Luis Aguilar on 12/3/23.
//

import SwiftUI

struct DashboardMain: View {
    
    var body: some View {
        Group {
            NavigationSplitView {
                VStack {
                    ScrollView {
                        CircularProgressView()
                            .frame(width: 220, height: 220)
                            .padding()
                        BarChartView().padding()
                        PieChartView().padding()
                        TableView()
                            .aspectRatio(contentMode: .fit)
                    }
                }.navigationTitle("Dashboard")
            } detail: {
                //code
            }
            .navigationSplitViewStyle(.automatic)
        }
        
    }
}

#Preview {
    DashboardMain()
}
