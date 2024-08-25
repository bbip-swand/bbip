//
//  ContentView.swift
//  BBIP
//
//  Created by 이건우 on 7/30/24.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onTapGesture {
            show = true
        }
        .navigationDestination(isPresented: $show) {
            UserInfoSetupView()
        }
    }
}

#Preview {
    ContentView()
}
