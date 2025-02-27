/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Jaeheon Jeong
  ID: s3821004
  Created  date: 17/08/2023
  Last modified: 06/09/2023
  Acknowledgement: “DarkmodeToggle,” GitHub, https://github.com/Inncoder/SwiftUI-Animations/tree/master/Animations/DarkmodeToggle (accessed Sep. 6, 2023).
*/


import SwiftUI

struct DarkmodeToggleView: View {
    
    
    // MARK: - PROPERTIES
    @AppStorage("darkmode") var darkmode: Bool = false
    
    
    var body: some View {
        ZStack {
            
            ZStack {
                Color(self.darkmode ?
                    UIColor.black :
                    UIColor(red: 0.67,
                            green: 0.81,
                            blue: 1.00,
                            alpha: 1.00)
                    )
                MiniImages(darkmode: $darkmode)
            }
            .frame(width: 100, height: 50)
            .mask(
                Capsule()
                    .foregroundColor(self.darkmode ?
                        Color.black :
                        Color(UIColor(red: 0.67,
                                      green: 0.81,
                                      blue: 1.00,
                                      alpha: 1.00))
                        )
            )
            ZStack {
                Button {
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                            darkmode.toggle()
                        }
                } label: {
                    Circle()
                        .foregroundColor(darkmode ?
                            .white :
                            .yellow
                        )
                        .frame(width: 45, height: 45)
                }
                
                Button {
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                            darkmode.toggle()
                        }
                } label: {
                    Circle()
                        .foregroundColor(self.darkmode ?
                            Color.black :
                            Color(UIColor(red: 0.67,
                                          green: 0.81,
                                          blue: 1.00,
                                          alpha: 1.00))
                            )
                        .offset(x: darkmode ? -22.5: -45)
                        .rotationEffect(.degrees(darkmode ?
                            45:
                            0)
                        )
                        .frame(width: 45, height: 45)
                }
                
                
            }
            .offset(x: darkmode ?
                23 :
                -23
            )
            .mask(
                Circle()
                    .frame(width: 45, height: 45)
                    .offset(x: darkmode ? 23 : -23)
            )
            
        }
    }
}



struct DarkmodeToggleView_Previews: PreviewProvider {
    static var previews: some View {
        DarkmodeToggleView()
    }
}



struct MiniImages: View {
    
    @Binding var darkmode: Bool
    
    var body: some View {
        ZStack {
            Image(systemName: "cloud.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 15, height: 10)
                .offset(x: 15, y: 0)
                .opacity(darkmode ? 0 : 1)
            Image(systemName: "cloud.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 15, height: 10)
                .offset(x: 30, y: 10)
                .opacity(darkmode ? 0 : 1)
            
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 5, height: 5)
                .offset(x: -20, y: -12)
                .opacity(darkmode ? 1 : 0)
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 5, height: 5)
                .offset(x: -5, y: -5)
                .opacity(darkmode ? 1 : 0)
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 5, height: 5)
                .offset(x: -25, y: 10)
                .opacity(darkmode ? 1 : 0)
        }
    }
}
