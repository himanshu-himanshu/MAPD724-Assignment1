//  File Name: ContentView.swift

//  Authors: Himanshu (301296001) & Gurminder (301294300)
//  Subject: MAPD724 Advanced iOS Development
//  Assignment: 1 Part 3

//  Task: Slot Implementing Database in Slot Machine App

//  About App: Add data persistence into your app to save Global Jackpot and the Highest Payout for the user. We are using Firebase to do the job.

//  Date modified: 18/02/2023

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

struct InfoView: View {

    var body: some View {
        ZStack {
            
            LinearGradient(colors: [Color.teal, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("slot").resizable().aspectRatio(contentMode: .fit).padding(.horizontal, 90)
                VStack(spacing: 10) {
                    
                    Text("How to play")
                        .font(.system(size: 28, weight: .medium, design: .default))
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
  
                    Text("1. Place your bet using coin button as without bet player cannot play the game.")
                       
                    Text("2. Bet must be greater than your current money.")
                    
                    Text("3. More than one blank will loose amount twice of your bet.")
   
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
                
                VStack(spacing: 10) {
                    Text("Winning Combinations")
                        .font(.system(size: 28, weight: .medium, design: .default))
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    VStack(spacing: 10) {
                        HStack {
                            Text("Three identical symbols -> Jackpot 🧨")
                                .font(.system(size: 18,weight: .medium, design: .default))
                        }
                        
                        HStack {
                            Text("Two identical symbols -> Bet * 5 💰")
                                .font(.system(size: 18,weight: .medium, design: .default))
                        }
                        HStack {
                            Text("No Blanks and One Coin -> Bet * 2 💵")
                                .font(.system(size: 18,weight: .medium, design: .default))
                        }
                    }
                   
                       
                }
                .padding(.vertical, 20)
                Spacer()
            }
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
    }
}

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
    //@State var globalJackpot = 0
    @StateObject var scoreManager = ScoreManager()

    
    /** Function to generate random numbers */
    func generateRandom() -> String {
        let randomImage = arc4random_uniform(10) + 1;
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
            // More than one blank will loose twice of your bet
            if(randomOne == randomTwo || randomTwo == randomThree || randomThree == randomOne) {
                self.userMoney = self.userMoney - (self.currentBet * 2)
            } else {
                self.userMoney = self.userMoney - self.currentBet
            }
        } else {
            if(randomOne == randomTwo && randomTwo == randomThree) {
                if(scoreManager.highScore == 0) {
                    scoreManager.highScore = self.jackpot + self.currentBet
                    scoreManager.saveScoresToFirebase(score: scoreManager.highScore)
                } else if (scoreManager.highScore < (self.jackpot + self.currentBet)) {
                    scoreManager.highScore = self.jackpot + self.currentBet
                    scoreManager.saveScoresToFirebase(score: scoreManager.highScore)
                }
                
                scoreManager.globalJackpot = scoreManager.globalJackpot + self.jackpot + self.currentBet
                scoreManager.saveJackpotScoresToFirebase()
                self.userMoney = self.userMoney + self.jackpot + self.currentBet
                self.showJackpotAlert = true
                self.jackpot = 1000
                print(self.currentBet)
               
            } else if(randomOne == randomTwo || randomTwo == randomThree || randomOne == randomThree) {
                self.userMoney = self.userMoney + (5 * self.currentBet)
                if(scoreManager.highScore == 0) {
                    scoreManager.highScore = 5 * self.currentBet
                    scoreManager.saveScoresToFirebase(score: scoreManager.highScore)
                } else if (scoreManager.highScore < 5 * self.currentBet) {
                    scoreManager.highScore = 5 * self.currentBet
                    scoreManager.saveScoresToFirebase(score: scoreManager.highScore)
                }
            }
            
            if(randomOne != randomTwo && randomTwo != randomThree) {
                if(randomOne == "10" || randomTwo == "10" || randomThree == "10") {
                    self.userMoney = self.userMoney + (2 * self.currentBet)
                    if(scoreManager.highScore == 0) {
                        scoreManager.highScore = 2 * self.currentBet
                        scoreManager.saveScoresToFirebase(score: scoreManager.highScore)
                    } else if (scoreManager.highScore < 2 * self.currentBet) {
                        scoreManager.highScore = 2 * self.currentBet
                        scoreManager.saveScoresToFirebase(score: scoreManager.highScore)
                    }
                } else {
                    self.userMoney = self.userMoney - self.currentBet
                }
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
        NavigationStack {
            ZStack {
                VStack {
                    Image("slot").resizable().aspectRatio(contentMode: .fit).padding(.bottom, 20.0).padding(.horizontal, 60)
                    
                    ZStack {
                        VStack(spacing:0) {
                            
                            HStack(spacing: 40) {
                                VStack(spacing: 10) {
                                    Text("Global Jackpot")
                                        .font(.system(size: 20,weight: .heavy, design: .default))
                                    Text("⚡️ $" + String(scoreManager.globalJackpot))
                                        .font(.system(size: 22,weight: .heavy, design: .default))
                                }
                                
                                VStack(spacing: 10) {
                                    Text("Highest Payout")
                                        .font(.system(size: 20,weight: .heavy, design: .default))
                                    Text("💵 $" + String(scoreManager.highScore))
                                        .font(.system(size: 22,weight: .heavy, design: .default))
                                }
                            
                            }
                            .padding(.bottom, 30)
                            
                            // HStack containing three images for the slot machine
                            HStack(spacing:10) {
                                Image(self.imageOne).resizable().aspectRatio(contentMode: .fit).cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                                    .frame(
                                          minWidth: 100,
                                          maxWidth: 100,
                                          minHeight: 100,
                                          maxHeight: 100
                                        )
                                Image(self.imageTwo).resizable().aspectRatio(contentMode: .fit)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                                    .frame(
                                          minWidth: 100,
                                          maxWidth: 100,
                                          minHeight: 100,
                                          maxHeight: 100
                                        )
                                Image(self.imageThree).resizable().aspectRatio(contentMode: .fit)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                                    .frame(
                                          minWidth: 100,
                                          maxWidth: 100,
                                          minHeight: 100,
                                          maxHeight: 100
                                        )
                            }
                            .frame(
                                  minWidth: 0,
                                  maxWidth: .infinity
                                )
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
                            .padding(.top, 10)
                        }
                    }
                    .shadow(color: .purple,radius: 10, x: 0, y: 0)
                    
                    // Spin button to start the slot machine game
                    Button(action: {
                        spinLogic()
                    }, label: {
                        Image("sp").resizable().frame(width: 120, height: 120).aspectRatio(contentMode: .fit)
                    })
                    .disabled(self.isSpinDisabled)
                    .padding(.vertical, 20)
                    
                    
                    // HStack containing three buttons: Place Bet, Reset and Quit
                    HStack(spacing: 60) {
                        Button(action: {
                            resetGame()
                        }, label: {
                            Image("rst").resizable().frame(width: 30, height: 30).aspectRatio(contentMode: .fit)
                        })
                        
                        Button(action: {
                            self.showBetAlert = true
                        }, label: {
                            Image("dlr").resizable().frame(width: 60, height: 60).aspectRatio(contentMode: .fit).background(.clear)
                        })
                        
                        
                        Button(action: {
                            self.showExitAlert = true
                        }, label: {
                            Image("close").resizable().frame(width: 30, height: 30).aspectRatio(contentMode: .fit)
                        })
                    }
                  
                    NavigationLink("Info") {
                        InfoView()
                    }
                    .foregroundColor(.black)
                    .padding(.top, 20)
                }
                .padding()
            }
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .topLeading
                )
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
                    message: Text("You won the jackpot!!!!")
                )
            }.alert("Do you want to exit game?", isPresented: self.$showExitAlert) {
                Button("No", role: .cancel) {}
                Button("Yes", action: exitGame)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
