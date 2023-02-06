//  File Name: ContentView.swift

//  Authors: Himanshu (301296001) & Gurminder (301294300)
//  Subject: MAPD724 Advanced iOS Development
//  Assignment: 1 Part 2

//  Task: Slot Machine App Functionality
//  About App: Create the User Interface for Slot Machine game using SwiftUI that contains three images, spin button, reset and quit buttons also labels stating money, bet and current jackpot.

//  Date modified: 04/02/2023

import SwiftUI

struct ContentView: View {
    
    /** Global Variables */
    @State var userMoney = 1000
    @State var currentBet = 100
    @State var newBet = ""
    @State var jackpot = 500
    @State var imageOne = "0"
    @State var imageTwo = "0"
    @State var imageThree = "0"
    @State var isSpinDisabled = false
    @State var showAlert = false
    @State var showNoMoneyAlert = false
    @State var showBetAlert = false
    @State var showEmptyBetAlert = false
    @State var showJackpotAlert = false
    @State var showExitAlert = false
    
    /** Function to generate random numbers */
    func generateRandom() -> String {
        let randomImage = arc4random_uniform(9) + 1;
        return String(randomImage)
    }
    
    /** Set images according to random generated numbers */
    func setRandomImages() {
        if(self.currentBet > self.userMoney) {
            return
        }
        let randomOne = generateRandom()
        let randomTwo = generateRandom()
        let randomThree = generateRandom()
        self.imageOne = randomOne
        self.imageTwo = randomTwo
        self.imageThree = randomThree
        checkWinOrLoss(randomOne: randomOne, randomTwo: randomTwo, randomThree: randomThree)
    }
    
    /** Check if player is winning or loosing */
    func checkWinOrLoss(randomOne:String, randomTwo:String, randomThree:String) {
    
        if(randomOne == "9" || randomTwo == "9" || randomThree == "9") {
            // Checking blanks, '9' = Blank
            self.userMoney = self.userMoney - self.currentBet
        } else {
            if(randomOne == randomTwo && randomTwo == randomThree) {
                self.userMoney = self.userMoney + self.jackpot + self.currentBet
                self.showJackpotAlert = true
                self.jackpot = 1000
                print(self.currentBet)
            } else if(randomOne == randomTwo || randomTwo == randomThree || randomOne == randomThree) {
                self.userMoney = self.userMoney + (5 * self.currentBet)
            }
            
            if(randomOne != randomTwo && randomTwo != randomThree) {
                self.userMoney = self.userMoney - self.currentBet
            }
        }
    }
    
    /** Function to reset the game */
    func resetGame() {
        self.jackpot = 500
        self.userMoney = 1000
        self.currentBet = 100
        self.imageOne = "0"
        self.imageTwo = "0"
        self.imageThree = "0"
        self.isSpinDisabled = false
        self.showBetAlert = false
        self.showNoMoneyAlert = false
        self.showBetAlert = false
        self.showEmptyBetAlert = false
        self.showJackpotAlert = false
        self.showExitAlert = false
    }
    
    /** Check users money */
    func checkUsersMoney() {
        if(Int(self.userMoney) == 0) {
            self.showNoMoneyAlert = true
        }
    }
    
    /** Function to set new bet */
    func setNewBet() {
        if(self.newBet == "" || self.newBet == " ") {
            self.currentBet = 0
        } else {
            self.currentBet = Int(self.newBet)!
        }
        self.newBet = ""
        self.isSpinDisabled = false
    }
    
    /** Function to exit game */
    func exitGame() {
        exit(0)
    }
    
    func spinLogic() {

        if(self.currentBet <= 0) {
            self.showEmptyBetAlert = true
            return
        }
        
        if(self.userMoney <= 0 ) {
            self.showNoMoneyAlert = true
        }
        
        if(currentBet > userMoney) {
            print(userMoney, currentBet)
            self.isSpinDisabled = true
        }
        
        setRandomImages()
    }
    
    var body: some View {
        ZStack {
            VStack {
                Image("slot").resizable().aspectRatio(contentMode: .fit).padding(.bottom, 30.0).padding(.horizontal, 30)
                Spacer()
                
                ZStack {
                    VStack(spacing:0) {
                        
                        // HStack containing three images for the slot machine
                        HStack(spacing:10) {
                            Image(self.imageOne).resizable().aspectRatio(contentMode: .fit).cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                            Image(self.imageTwo).resizable().aspectRatio(contentMode: .fit)
                                .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                            Image(self.imageThree).resizable().aspectRatio(contentMode: .fit)
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
                                Text("💰" + String(userMoney))
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
                                Text("💵" + String(currentBet))
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
                                Text("💰" + String(jackpot))
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
                   spinLogic()
                }, label: {
                    Image("sp").resizable().frame(width: 120, height: 120).aspectRatio(contentMode: .fit)
                })
                .disabled(self.isSpinDisabled)
                Spacer()
                
                // HStack conating two buttons: Reset and Quit
                HStack(spacing: 60) {
                    Button(action: {
                        resetGame()
                    }, label: {
                        Image("rst").resizable().frame(width: 30, height: 30).aspectRatio(contentMode: .fit)
                    })
                    
                    Button(action: {
                        self.showBetAlert = true
                    }, label: {
                        Image("dlr").resizable().frame(width: 6200, height: 60).aspectRatio(contentMode: .fit).background(.clear)
                    })
                    
                    
                    Button(action: {
                        self.showExitAlert = true
                    }, label: {
                        Image("close").resizable().frame(width: 30, height: 30).aspectRatio(contentMode: .fit)
                    })
                }
            }
            .padding()
        }
        .background(.teal)
        .alert("Important message", isPresented: self.$showAlert) {
            Button("OK", role: .cancel) { }
        }.alert(isPresented: $showNoMoneyAlert) {
            Alert(
                title: Text("Money Lost!"),
                message: Text("You don't have enough money")
            )
        }.alert("Enter new bet", isPresented: self.$showBetAlert) {
            TextField("Bet", text: $newBet)
            Button("Update", action: setNewBet)
        }.alert("Place some bet to play", isPresented: self.$showEmptyBetAlert) {
            Button("Ok", role: .cancel ,action: {})
        }.alert(isPresented: $showJackpotAlert) {
            Alert(
                title: Text("Jackpot!"),
                message: Text("You wont the jackpot!!!!")
            )
        }.alert("Do you want to exit game?", isPresented: self.$showExitAlert) {
            Button("No", role: .cancel) {}
            Button("Yes", action: exitGame)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
