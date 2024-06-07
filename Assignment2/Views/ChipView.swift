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

struct ChipView: View {
    
    
    // MARK: - PROPERTIES
    var chipNumber : String
    var imageName : String
    
    var body: some View {
        ZStack{
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130)
            
            Text(chipNumber)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
        }
    }
}

struct ChipView_Previews: PreviewProvider {
    static var previews: some View {
        ChipView(chipNumber: "10", imageName: "blue-chip")
    }
}
