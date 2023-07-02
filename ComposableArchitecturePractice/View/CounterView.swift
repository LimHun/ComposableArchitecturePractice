//
//  CounterView.swift
//  ComposableArchitecturePractice
//
//  Created by tunko on 2023/06/30.
//

import SwiftUI
import ComposableArchitecture

extension CounterFeature.State: Equatable {
    static func == (lhs: CounterFeature.State, rhs: CounterFeature.State) -> Bool {
        return lhs.count == rhs.count
    }
}

struct CounterView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            BoxView(count: viewStore.count, isLoading: viewStore.isLoading, isTimerRunning: viewStore.isTimerRunning, fact: viewStore.fact) {
                store.send(.decrementButtonTapped)
            } callIncrement: {
                store.send(.incrementButtonTapped)
            } callFact: {
                store.send(.factButtonTapped)
            } callTimer: {
                store.send(.toggleTimerButtonTapped)
            }
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        })
    }
}
