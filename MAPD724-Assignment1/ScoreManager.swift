//  File Name: ScoreManager.swift

//  Authors: Himanshu (301296001) & Gurminder (301294300)
//  Subject: MAPD724 Advanced iOS Development
//  Assignment: 1 Part 3

//  Task: Slot Implementing Database in Slot Machine App
//  About App: Add data persistence into your app to save Global Jackpot and the Highest Payout for the user. We are using Firebase to do the job.

//  Date modified: 18/02/2023

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

class ScoreManager: ObservableObject {
    
    /** Global Variables */
    @Published var highScore = 0
    @Published var globalJackpot = 0
    
    // Firebase initialization
    var db = Firestore.firestore()
    
    // init() function
    init() {
        getScores()
        getJackpotScores()
    }
    
    // Function to get scores from firebase
    func getScores() {
        let ref = db.collection("highScore")
        ref.getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let score:String = (document.data()["highScore"] as! String)
                    print(score)
                    self.highScore = Int(score)!
                    print(self.highScore)
                }
            }
        }
    }
    
    // Function to get scores from firebase
    func getJackpotScores() {
        let ref = db.collection("scores")
        ref.getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let score:String = (document.data()["globalJackpot"] as! String)
                    print(score)
                    self.globalJackpot = Int(score)!
                    print(self.globalJackpot)
                }
            }
        }
    }

    // Function to save scores from firebase
    func saveScoresToFirebase(score: Int) {
        db.collection("highScore").document("highScore").setData([
            "highScore": String(score),
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added")
            }
        }
    }
    
    // Function to save scores from firebase
    func saveJackpotScoresToFirebase() {
        db.collection("scores").document("globalJackpot").setData([
            "globalJackpot": String(self.globalJackpot),
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added")
            }
        }
    }

}
