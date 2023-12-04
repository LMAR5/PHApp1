//
//  DashboardMain.swift
//  PHApp1
//
//  Created by Luis Aguilar on 12/3/23.
//

import SwiftUI

struct DashboardMain: View {
    var body: some View {
        NavigationView {
            VStack {
                CircularProgressView(progress: 0.8)
                    .frame(width: 220, height: 220)
                    .padding()
                BarChartView().padding()
            }.navigationTitle("Dashboard")
        }
    }
}

#Preview {
    DashboardMain()
}
