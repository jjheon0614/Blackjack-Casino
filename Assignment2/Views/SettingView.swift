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

struct SettingView: View {
    
    
    // MARK: - PROPERTIES
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: Settings
    @AppStorage("isEnglish") var isEnglish: Bool = true
    @AppStorage("darkmode") var darkmode: Bool = false
    
    var body: some View {
        
        
        GeometryReader { geometry in
            ZStack{
                
                withAnimation{
                    Image(darkmode ? "redTable" : "greenTable")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width)
                        .ignoresSafeArea()
                }
                
                VStack{


                    Spacer()

                    HStack{
                        DarkmodeToggleView()

                        Spacer()

                        LanguageToggleView(isEnglish: $isEnglish)//use Binding to change value
                    }
                    .padding(.horizontal)
                    .frame(width: geometry.size.width)


                    Text(isEnglish ? "Choose The Level" : "난이도를 고르시오")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)

                    Spacer()

                    VStack(spacing: 30){



                        Button {
                            settings.isEasy = true
                            settings.isNormal = false
                            settings.isHard = false
                        } label: {


                            LevelSelectView(level: settings.isEasy, chip: "10", image: "blue-chip", levelText: isEnglish ? "Easy Mode" : "쉬움", levelDescription: isEnglish ? "Betting coin is 50" : "배팅금이 50 입니다")

                        }

                        Button {
                            settings.isEasy = false
                            settings.isNormal = true
                            settings.isHard = false
                        } label: {


                            LevelSelectView(level: settings.isNormal, chip: "30", image: "red-chip", levelText: isEnglish ? "Normal Mode" : "중간", levelDescription: isEnglish ? "Betting coin is 30" : "배팅금이 30 입니다")

                        }

                        Button {
                            settings.isEasy = false
                            settings.isNormal = false
                            settings.isHard = true
                        } label: {


                            LevelSelectView(level: settings.isHard, chip: "50", image: "yellow-chip", levelText: isEnglish ? "Hard Mode" : "어려움", levelDescription: isEnglish ? "Betting coin is 10" : "배팅금이 10 입니다")

                        }

                    }
                    Spacer()

                }
                .onAppear(perform: {playSound(sound: "LeaderBoardView", type: "mp3")})
                .padding(.top, 50)
                .overlay(

                    Button(action: {
                        playSound(sound: "contentView", type: "mp3")
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.white)
                            .font(.title)
                    }
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .padding(.horizontal, 20),
                    alignment: .topTrailing
                )
            }
        }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        let settings = Settings()
        return SettingView()
                    .environmentObject(settings)
    }
}
