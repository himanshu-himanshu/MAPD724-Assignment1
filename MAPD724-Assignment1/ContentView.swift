//
//  ContentView.swift
//  MAPD724-Assignment1
//
//  Created by Himanshu on 2023-01-14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.teal.ignoresSafeArea()
                   
            VStack {
                Image("slot").resizable().aspectRatio(contentMode: .fit).padding(.bottom)
                HStack(spacing:20) {
                    Image("7").resizable().aspectRatio(contentMode: .fit).cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                    Image("7").resizable().aspectRatio(contentMode: .fit)
                        .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                    Image("7").resizable().aspectRatio(contentMode: .fit)
                        .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                }
                .padding()
                .background(.pink)
                .padding()
                .shadow(radius: 0, x:7, y:7)
                
                Button(action: {
                    
                }, label: {
                    Image("sp").resizable().frame(width: 120, height: 120).aspectRatio(contentMode: .fit)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().background(.teal)
    }
}
