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

struct NavigationButton: View {
    
    // MARK: - PROPERTIES
    var imageName: String
    var textName: String
    @State private var isPlaying = false
    
    var body: some View {
        ZStack{
            
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .overlay(Color.black.opacity(0.5))
                .rotationEffect(.degrees(-25)) // rotate -25 degree
                
            
            Text(textName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            
            
        }
        .frame(width: 140)
    }
}

struct NavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButton(imageName: "AS", textName: "Play")
    }
}
