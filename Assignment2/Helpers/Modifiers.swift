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



struct ButtonModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
          .font(.title)
          .fontWeight(.bold)
          .padding()
          .background(Color.red)
          .foregroundColor(.white)
          .cornerRadius(10)
  }
}


struct BackgroundModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
          
          .frame(width: 200)
  }
}


struct scoreNumberStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .heavy, design: .rounded))
    }
}

struct scoreLabelStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
}

struct scoreCapsuleStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(
                Capsule()
                    .foregroundColor(Color.black))
            .opacity(0.5)
    }
}
