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

struct StageView: View {
    
    
    // MARK: - PROPERTIES
    @AppStorage("isEnglish") var isEnglish: Bool = true
    @AppStorage("darkmode") var darkmode: Bool = false
    

    @EnvironmentObject var userDataManager: UserDataManager
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var stageSetting: StageSetting
    
    @State var isContentView = false
    @State var isPlaying = false
    
    var playerName : String
    
    var body: some View {
        
        if isContentView {//move to ContentView
            ContentView()
        } else if (isPlaying) {
            PlayView(playerName : self.playerName)//send data to PlayView
                .environmentObject(settings)
                .environmentObject(stageSetting)
                .environmentObject(userDataManager)
        } else {
            GeometryReader { geometry in
                ZStack{
                    Image(darkmode ? "redTable" : "greenTable")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width)
                        .ignoresSafeArea()
                    
                    VStack{
                        HStack{
                            Button {
                                isContentView = true
                                
                            } label: {
                                Text(isEnglish ? "Go back" : "뒤로가기")
                                    .foregroundColor(Color.white)
                            }
                            .padding(.leading, 20.0)
                            
                            Spacer()
                        }
                        .offset(y: -100)
                        
                        VStack(spacing: 30) {
                            Image("Title")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .modifier(BackgroundModifier())
                            
                            Button {//Change the Stage Settings
                                stageSetting.stageOne = true
                                stageSetting.stageTwo = false
                                stageSetting.stageThree = false
                                
                                isPlaying = true
                                userDataManager.updatePlaytime(forUsername: self.playerName)
                            } label: {
                                VStack{
                                    Text(isEnglish ? "Stage 1" : "스테이지 1")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        
                                    
                                    Text(isEnglish ? "Make the high score to 200" : "200점으로 만드세요")
                                }
                                .foregroundColor(Color.white)
                                .frame(width: 250, height: 70)
                                .background(darkmode ? Color("customGreen") : Color.red)
                                .cornerRadius(20)
                            }
                            
                            
                            Button {
                                stageSetting.stageOne = false
                                stageSetting.stageTwo = true
                                stageSetting.stageThree = false
                                
                                isPlaying = true
                                userDataManager.updatePlaytime(forUsername: self.playerName)
                            } label: {
                                VStack{
                                    Text(isEnglish ? "Stage 2" : "스테이지 2")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        
                                    
                                    Text(isEnglish ? "Make the high score to 300" : "300점으로 만드세요")
                                }
                                .foregroundColor(Color.white)
                                .frame(width: 250, height: 70)
                                .background(darkmode ? Color("customGreen") : Color.red)
                                .cornerRadius(20)
                            }
                            
                            
                            Button {
                                stageSetting.stageOne = false
                                stageSetting.stageTwo = false
                                stageSetting.stageThree = true
                                
                                isPlaying = true
                                userDataManager.updatePlaytime(forUsername: self.playerName)
                            } label: {
                                VStack{
                                    Text(isEnglish ? "Stage 3" : "스테이지 3")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        
                                    
                                    Text(isEnglish ? "Make the high score to 400" : "400점으로 만드세요")
                                }
                                .foregroundColor(Color.white)
                                .frame(width: 250, height: 70)
                                .background(darkmode ? Color("customGreen") : Color.red)
                                .cornerRadius(20)
                            }
                            
                            
                        }
                        
                        
                        
                        
                    }
                }
            }
        }

    }
}

struct StageView_Previews: PreviewProvider {
    static var previews: some View {
        StageView(playerName: "Jaeheon")
    }
}
