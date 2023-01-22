//  File Name: ContentView.swift

//  Authors: Himanshu (301296001) & Gurminder (301294300)
//  Subject: MAPD724 Advanced iOS Development
//  Assignment: 1 Part 1

//  Task: Slot Machine App UI
//  About App: Create the User Interface for Slot Machine game using SwiftUI that contains three images, spin button, reset and quit buttons also labels stating money, bet and current jackpot.

//  Date modified: 21/01/2023

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                Image("slot").resizable().aspectRatio(contentMode: .fit).padding(.all, 30.0)
                Spacer()
                
                ZStack {
                    VStack(spacing:0) {
                        
                        // HStack containing three images for the slot machine
                        HStack(spacing:10) {
                            Image("7").resizable().aspectRatio(contentMode: .fit).cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                            Image("7").resizable().aspectRatio(contentMode: .fit)
                                .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                            Image("7").resizable().aspectRatio(contentMode: .fit)
                                .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                        }
                        .padding(.all, 20)
                        .border(.black, width: 2)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.578, saturation: 1.0, brightness: 0.001)/*@END_MENU_TOKEN@*/)
                        
                        // HStack containg labels for game info
                        HStack(spacing: 4) {
                            
                            VStack(spacing:10) {
                                Text("Money")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                Text("💰 1000")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.orange)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.843, saturation: 0.991, brightness: 0.68)/*@END_MENU_TOKEN@*/)
                            .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                      
                            
                            VStack(spacing:10) {
                                Text("Bet")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                Text("💵 1000")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.yellow)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.843, saturation: 0.991, brightness: 0.68)/*@END_MENU_TOKEN@*/)
                            .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                            
                            VStack(spacing:10) {
                                Text("Jackpot")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                Text("💰 500")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hue: 0.173, saturation: 0.473, brightness: 1.0))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.843, saturation: 0.991, brightness: 0.68)/*@END_MENU_TOKEN@*/)
                            .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                        }
                        .padding(.vertical)
                    }
                    
                }
                .shadow(color: .purple,radius: 10, x: 0, y: 0)
     
                // Spin button to start the slot machine game
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image("sp").resizable().frame(width: 120, height: 120).aspectRatio(contentMode: .fit)
                })
                Spacer()
                
                // HStack conating two buttons: Reset and Quit
                HStack(spacing: 120) {
                    Button(action: {
                        
                    }, label: {
                        Image("rst").resizable().frame(width: 30, height: 30).aspectRatio(contentMode: .fit)
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Image("close").resizable().frame(width: 30, height: 30).aspectRatio(contentMode: .fit)
                    })
                }
                
            }
            .padding()

        }
        .background(.teal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
