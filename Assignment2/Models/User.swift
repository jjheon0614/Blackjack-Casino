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

// Define the User struct
struct User: Identifiable, Codable {
    var id = UUID()
    var username: String
    var playTimes: Int
    var highScore: Int
    var reachStageOne: Bool
    var reachStageTwo: Bool
    var reachStageThree: Bool
}

