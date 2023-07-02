//
//  ComposableArchitecturePracticeApp.swift
//  ComposableArchitecturePractice
//
//  Created by tunko on 2023/06/30.
//

import SwiftUI
import ComposableArchitecture

@main
struct ComposableArchitecturePracticeApp: App {
    
    let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: store)
        }
    }
}
