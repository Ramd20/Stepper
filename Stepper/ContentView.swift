//
//  ContentView.swift
//  Stepper
//
//  Created by Ram Devakumar on 4/8/26.
//

import SwiftUI

struct ContentView: View {
    @State private var steps: Double = 0
    let healthKit = HealthKitManager()
    
    var body: some View {
        VStack {
            Text("Steps Today")
                .font(.headline)
            Text("\(Int(steps))")
                .font(.largeTitle)
        }
        .onAppear {
            healthKit.requestPermission { success in
                if success {
                    healthKit.fetchTodaySteps { count in
                        DispatchQueue.main.async {
                            steps = count
                        }
                    }
                }
            }
        }
    }
}
