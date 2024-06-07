/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Jaeheon Jeong
  ID: s3821004
  Created  date: 17/08/2023
  Last modified: 06/09/2023
  Acknowledgement: none
*/

import Foundation
import SwiftUI


// Define the UserDataManager class
class UserDataManager: ObservableObject {
    @AppStorage("users") var usersData: Data = Data() // Store users data in AppStorage
    
    @Published var users: [User] = [] {
        didSet {
            // When users are modified, update the AppStorage data
            do {
                usersData = try JSONEncoder().encode(users)
            } catch {
                print("Error encoding users data: \(error)")
            }
        }
    }
    
    init() {
        // Load users data from AppStorage
        if let loadedData = UserDefaults.standard.data(forKey: "users") {
            do {
                users = try JSONDecoder().decode([User].self, from: loadedData)
            } catch {
                print("Error decoding users data: \(error)")
            }
        }
    }
    
    func updatePlaytime(forUsername username: String) {
            if let index = users.firstIndex(where: { $0.username == username }) {
                // User found, update playtime
                users[index].playTimes += 1
            } else {
                // User not found, create a new User struct
                let newUser = User(username: username, playTimes: 1, highScore: 0, reachStageOne: false, reachStageTwo: false, reachStageThree: false) // You can set highScore to the default value
                users.append(newUser)
            }
        }
    
    
    func updateScore(forUsername username: String, currentScore: Int) {
            if let index = users.firstIndex(where: { $0.username == username }) {
                // User found, update high score if current score is higher
                if currentScore > users[index].highScore {
                    users[index].highScore = currentScore
                }
            }
        }
    
    
    func updateStageOne(forUsername username: String) {
        if let index = users.firstIndex(where: { $0.username == username }) {
            // User found, update reachStageOne to true
            users[index].reachStageOne = true
        }
    }
    
    
    func updateStageTwo(forUsername username: String) {
        if let index = users.firstIndex(where: { $0.username == username }) {
            // User found, update reachStageOne to true
            users[index].reachStageTwo = true
        }
    }

    
    func updateStageThree(forUsername username: String) {
        if let index = users.firstIndex(where: { $0.username == username }) {
            // User found, update reachStageOne to true
            users[index].reachStageThree = true
        }
    }


}
