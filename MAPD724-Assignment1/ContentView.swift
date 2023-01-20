import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            VStack {
                Image("slot").resizable().aspectRatio(contentMode: .fit).padding(.all, 30.0)
                Spacer()
                
                ZStack {
                    VStack(spacing:0) {
                        HStack(spacing:10) {
                            Image("7").resizable().aspectRatio(contentMode: .fit).cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                            Image("7").resizable().aspectRatio(contentMode: .fit)
                                .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                            Image("7").resizable().aspectRatio(contentMode: .fit)
                                .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                        }
                        .padding(.all, 20)
                        .border(.purple, width: 4)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.578, saturation: 1.0, brightness: 0.001)/*@END_MENU_TOKEN@*/)
                        
                        HStack(spacing: 16) {
                            
                            VStack(spacing:10) {
                                Text("Money")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                Text("💰 1000")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.orange)
                            }
                            .padding()
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.843, saturation: 0.991, brightness: 0.68)/*@END_MENU_TOKEN@*/)
                            .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                      
                            
                            VStack(spacing:10) {
                                Text("Your Bet")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                Text("💵 10")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.yellow)
                            }
                            .padding()
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.843, saturation: 0.991, brightness: 0.68)/*@END_MENU_TOKEN@*/)
                            .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                            
                            VStack(spacing:10) {
                                Text("Jackpot")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                Text("💰 500")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hue: 1.0, saturation: 1.0, brightness: 0.441))
                            }
                            .padding()
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.843, saturation: 0.991, brightness: 0.68)/*@END_MENU_TOKEN@*/)
                            .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                        }
                        .padding(.all)
                    }
                    
                }
                .shadow(color: .purple,radius: 20, x: 0, y: 0)
     
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image("sp").resizable().frame(width: 120, height: 120).aspectRatio(contentMode: .fit)
                })
                Spacer()
                
                
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
