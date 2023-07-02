//
//  CounterFeature.swift
//  ComposableArchitecturePractice
//
//  Created by tunko on 2023/06/30.
//

import SwiftUI
import ComposableArchitecture

struct CounterFeature: ReducerProtocol {
    struct State {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case timerTick
        case toggleTimerButtonTapped
        case empty
    }
    
    enum CancelID { case timer }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            state.fact = nil
            return .none
        case .incrementButtonTapped:
            state.count += 1
            state.fact = nil
            return .none
            
        case .factButtonTapped:
            state.fact = nil
            state.isLoading = true
            let task = EffectTask<Action>.run(
                // 우선순위
                //priority: TaskPriority.high,
                // 작업
                operation: { [count = state.count] send in
                    let (data, _) = try await URLSession.shared
                        .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                    let fact = String(decoding: data, as: UTF8.self)
                    print("fact : \(fact)")
                    await send(.factResponse(fact)) //
                },
                // 오류 핸들링
                catch: { error, send in
                    
                })
            return task
        case let .factResponse(fact):
            state.fact = fact
            state.isLoading = false
            return .none
            
        case .toggleTimerButtonTapped:
            state.isTimerRunning.toggle()
            if state.isTimerRunning {
                return .run { send in
                    while true {
                        try await Task.sleep(for: .seconds(1))
                        await send(.timerTick)
                    }
                }
                .cancellable(id: CancelID.timer)
            } else {
                return .cancel(id: CancelID.timer)
            }
        case .timerTick:
            state.count += 1
            //state.fact = nil
            return .run { send in
                await send(.factButtonTapped)
            }
        case .empty:
            return .none
        }
    
    }
}
