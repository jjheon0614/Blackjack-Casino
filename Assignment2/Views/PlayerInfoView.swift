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

struct PlayerInfoView: View {
    
    
    // MARK: - PROPERTIES
    let highest: Bool
    let user: User
    
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .frame(width: 300, height: 100)
                .cornerRadius(10)
                    .foregroundColor(Color.white.opacity(0.5))
                    .blur(radius: 26)
            VStack{
                HStack{
                    Spacer()
                    Text(user.username)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                
                    
                    Spacer()
                    Spacer()
                    
                    Text("\(user.highScore)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Text("\(user.playTimes)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }
                
                HStack {
                    if highest {
                        Image("crown")
                            .resizable()
                            .aspectRatio(contentMode: .fit
                            )
                            .frame(width: 45)
                    }
                    
                    if (user.playTimes >= 10) {
                        ZStack {
                            Image("red-chip")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                        }
                    } else if (user.playTimes >= 5) {
                        ZStack {
                            Image("blue-chip")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                        }
                    }
                    
                    if (user.reachStageOne) {
                        Image("JS")
                            .resizable()
                            .aspectRatio(contentMode: .fit
                            )
                            .frame(width: 20)
                    }
                    
                    if (user.reachStageTwo) {
                        Image("QS")
                            .resizable()
                            .aspectRatio(contentMode: .fit
                            )
                            .frame(width: 20)
                    }
                    
                    if (user.reachStageThree) {
                        Image("KS")
                            .resizable()
                            .aspectRatio(contentMode: .fit
                            )
                            .frame(width: 20)
                    }
                    
                    Spacer()
                }
                .padding(.leading, 25.0)
            }
            .frame(width: 300, height: 100)
            
        }
    }
}



struct PlayerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerInfoView(highest: true, user: User(username: "Jaeheon", playTimes: 30, highScore: 400, reachStageOne: true, reachStageTwo: true, reachStageThree: true))
    }
}
