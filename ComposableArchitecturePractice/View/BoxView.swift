//
//  BoxView.swift
//  ComposableArchitecturePractice
//
//  Created by tunko on 2023/06/30.
//

import SwiftUI

struct BoxView: View {
    var count: Int
    var isLoading: Bool
    var isTimerRunning: Bool
    var fact: String?
//    @Binding var fact: String?
    var callDecrement: () -> Void
    var callIncrement: () -> Void
    var callFact: () -> Void
    var callTimer: () -> Void
    
    var body: some View {
        VStack {
            Text("count: \(count)")
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            HStack {
                Button("-") {
                    callDecrement()
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                Button("+") {
                    callIncrement()
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            }
            
            Button("Fact") {
                callFact()
            }
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            
            Button(isTimerRunning ? "Stop timer" : "Start timer") {
                callTimer()
            }
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            
            Text(fact ?? "empty")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.green.gradient)
                }
        }
        .animation(.default, value: fact)
    }
}

struct BoxView_Previews: PreviewProvider {
    static var previews: some View {
        BoxView(count: 999, isLoading: false, isTimerRunning: false, callDecrement: {
            
        }, callIncrement: {
            
        }, callFact: {
            
        }, callTimer: {
            
        })
    }
}
