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

struct ContentView: View {
    
    
    // MARK: - PROPERTIES
    @AppStorage("isEnglish") var isEnglish: Bool = true
    @AppStorage("darkmode") var darkmode: Bool = false
    @AppStorage("continueUsername") var continueUsername: String = ""
    
    @StateObject var stageSetting = StageSetting()
    @StateObject var settings = Settings()
    @EnvironmentObject var userDataManager: UserDataManager
    @State private var isPlaying = false
    @State private var showingInfoView = false
    @State private var showingSettingView = false
    @State private var inputUsername = false
    @State private var username = ""
    @State private var isRanking = false
    @State private var isStage = false
    @State private var stageUsername = false
    
    
    var body: some View {
        
        if isPlaying {//move to PlayView
            
            PlayView(playerName: username)
                .environmentObject(settings)
                .environmentObject(stageSetting)
            
        } else if (isRanking) {//move to LeaderBoardView
            
            LeaderBoardView()
                .environmentObject(userDataManager)
            
        } else if (isStage) {//move to StageView
            
            StageView(playerName: username)
                .environmentObject(stageSetting)
                .environmentObject(userDataManager)
                .environmentObject(settings)
            
        } else {
            
            ZStack{
                
                
                Image(darkmode ? "redTable" : "greenTable")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(spacing: 50){
                    Image("Title")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .modifier(BackgroundModifier())
                    
                    HStack(spacing: 30){
                        Button {
                            inputUsername = true
                        } label: {
                            NavigationButton(imageName: "AS", textName: isEnglish ? "Play" : "시작")
                        }
                        
                        Button {
                            isRanking = true
                        } label: {
                            NavigationButton(imageName: "2S", textName: isEnglish ? "Rank" : "순위")
                        }
                    }
                    .padding(.horizontal)
    
                    HStack(spacing: 30){
                        
                        Button {
                            showingInfoView = true
                        } label: {
                            NavigationButton(imageName: "3S", textName: isEnglish ? "Guide" : "설명서")
                        }
                        
                        Button {
                            showingSettingView = true
                        } label: {
                            NavigationButton(imageName: "4S", textName: isEnglish ? "Setting" : "설정")
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    HStack(spacing: 30) {
                        Button {
                            stageUsername = true
                        } label: {
                            NavigationButton(imageName: "5S", textName: isEnglish ? "Stage" : "스테이지")
                        }
                        
                        
                        Button {
                            if !continueUsername.isEmpty {
                                username = continueUsername
                                isPlaying = true
                            }
                        } label: {
                            NavigationButton(imageName: "6S", textName: isEnglish ? "Resume" : "계속")
                        }
                        
                    }
                    
                }
                
                
                
                if inputUsername {
                    VStack {
                        
                        
                        TextField("Enter Username", text: $username)//get username from the textfield
                            .frame(width: 280, height: 50)
                        
                        Button(action: {
                            
                        
                            if !username.isEmpty {
                                userDataManager.updatePlaytime(forUsername: username)
                                isPlaying = true
                                stageSetting.stageOne = false
                                stageSetting.stageTwo = false
                                stageSetting.stageThree = false
                            }
                            
                            
                            
                            }) {
                                Text(isEnglish ? "Register" : "등록")
                                    .font(.system(.title, design: .rounded))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                                    .background(darkmode ? Color("customGreen") : Color.red)
                                }
                        
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, alignment: .center)
                    .background(.white)
                    .cornerRadius(20)
                }
                
                if stageUsername {//appear Textfield
                    VStack {
                        
                        
                        TextField("Enter Username", text: $username)
                            .frame(width: 280, height: 50)
                        
                        Button(action: {
                            
                        
                            if !username.isEmpty { //check the username is not empty
                                isStage = true
                            }
                            
                            
                            
                            }) {
                                Text(isEnglish ? "Register" : "등록")
                                    .font(.system(.title, design: .rounded))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                                    .background(darkmode ? Color("customGreen") : Color.red)
                                }
                        
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, alignment: .center)
                    .background(.white)
                    .cornerRadius(20)
                }
                
            }
            .onAppear(perform: {
                //playSound(sound: "contentView", type: "mp3")
              }
            )
            .sheet(isPresented: $showingInfoView) {//pop-up InfoView
                InfoView()
            }
            .sheet(isPresented: $showingSettingView) {//pop-up SettingView
                SettingView()
                    .environmentObject(settings)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
