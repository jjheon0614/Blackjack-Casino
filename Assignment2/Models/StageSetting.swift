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

class StageSetting: ObservableObject {
    @Published var stageOne = false
    @Published var stageTwo = false
    @Published var stageThree = false
}
