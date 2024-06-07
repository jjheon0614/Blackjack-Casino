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

import SwiftUI

struct PlayButton: View {
    
    // MARK: - PROPERTIES
    var text : String
    
    @AppStorage("darkmode") var darkmode: Bool = false
    
    var body: some View {
        Text(text)
            .foregroundColor(Color.white)
            .frame(width: 140, height: 70)
            .background(darkmode ? Color("customGreen") : Color.red)
            .font(.title)
            .fontWeight(.bold)
            .cornerRadius(20)
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButton(text: "Hit")
    }
}
