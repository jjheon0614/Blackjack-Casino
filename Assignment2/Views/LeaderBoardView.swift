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

struct LeaderBoardView: View {
    
    
    // MARK: - PROPERTIES
    @EnvironmentObject var userDataManager: UserDataManager
    @AppStorage("isEnglish") var isEnglish: Bool = true
    
    @State var isContentView = false
    @State var showingBadgeInfoView = false
    
    
    var body: some View {
        
            
            if isContentView {//move to ContentView
                ContentView()
            } else {
                
                GeometryReader { geometry in
                    ZStack{
                        
                        Image("greenTable")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width)
                            .ignoresSafeArea()
                        
                        
                        
                        VStack {
                            HStack {
                                Button {
                                    isContentView = true
                                } label: {
                                    Text(isEnglish ? "Go back" : "뒤로가기")
                                        .foregroundColor(Color.white)
                                }
                                .padding(.leading, 20.0)
                                
                                Spacer()
                                
                                Button {
                                    playSound(sound: "click", type: "wav")
                                    showingBadgeInfoView = true
                                } label: {
                                    Image(systemName: "info.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit
                                        )
                                        .frame(width: 25)
                                        .foregroundColor(.white)
                                }
                                .padding(.trailing, 20.0)
                            }
                            
                            
                            Image("Title")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200)
                            
                            Text(isEnglish ? "RANK" : "랭크")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            
                            HStack{
                                Spacer()
                                
                                Text(isEnglish ? "User\nName" : "유저")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                
                                Spacer()
                                Spacer()
                                Spacer()
                                
                                
                                Text(isEnglish ? "High\nScore" : "최고\n점수")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                
                                Spacer()
                                
                                
                                
                                Text(isEnglish ? "Play\nTime" : "게임\n횟수")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                
                                Spacer()
                                
                                
                            }.frame(width: 300, height: 50)
                            
                            ScrollView{//make it scroll
                                ForEach(Array(userDataManager.users.sorted(by: { $0.highScore > $1.highScore }).enumerated()), id: \.1.username) { index, user in
                                    PlayerInfoView(highest: index == 0, user: user)
                                        .padding()
                                }
                            }
                        }
                    }
                    
                }
                .onAppear(perform: {playSound(sound: "LeaderBoardView", type: "mp3")})
                .sheet(isPresented: $showingBadgeInfoView) {//pop-up the BadgeInfoView
                        BadgeInfoView()
                        .onAppear(perform: {playSound(sound: "LeaderBoardView", type: "mp3")})
            }
        }
    }
}

struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        let userDataManager = UserDataManager() // Create a mock instance
                userDataManager.users = [
                    User(username: "User1", playTimes: 5, highScore: 200, reachStageOne: false, reachStageTwo: false, reachStageThree: false),
                    User(username: "User2", playTimes: 8, highScore: 300, reachStageOne: false, reachStageTwo: false, reachStageThree: false),
                    User(username: "User3", playTimes: 3, highScore: 150, reachStageOne: false, reachStageTwo: false, reachStageThree: false),
                    User(username: "User4", playTimes: 3, highScore: 150, reachStageOne: false, reachStageTwo: false, reachStageThree: false),
                    User(username: "User3", playTimes: 3, highScore: 150, reachStageOne: false, reachStageTwo: false, reachStageThree: false),
                    User(username: "User3", playTimes: 3, highScore: 150, reachStageOne: false, reachStageTwo: false, reachStageThree: false)
                ]

                return LeaderBoardView()
                    .environmentObject(userDataManager)
    }
}
