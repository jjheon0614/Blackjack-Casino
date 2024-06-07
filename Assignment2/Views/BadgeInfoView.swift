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

struct BadgeInfoView: View {
    
    
    // MARK: - PROPERTIES
    @Environment(\.dismiss) var dismiss
    @AppStorage("isEnglish") var isEnglish: Bool = true
    @AppStorage("darkmode") var darkmode: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                
                Image(darkmode ? "redTable" : "greenTable")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width)
                    .ignoresSafeArea()
                
                VStack(spacing: 30){
                    Spacer()
                    
                    Text(isEnglish ? "Achievement Badge" : "배지 달성")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    
                    HStack {
                        Image("crown")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.leading, 10.0)
                            .frame(width: 140)
                        
                        
                        Text(isEnglish ? "The Crown badge is given to the user who has the highest score" : "왕관 배지는 가장 높은 점수를 가진 플레이어에게 주어집니다")
                            .foregroundColor(Color.white)
                            .padding(.trailing, 10.0)
                    }
                    
                    
                    
                    HStack {
                        Image("red-chip")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.leading, 35.0)
                            .frame(width: 120)
                        
                        Spacer()
                        
                        
                        Text(isEnglish ? "The Red chip is given to the user who has played 10 times" : "빨간 칩은 게임을 10번 했을때 주어집니다")
                            .foregroundColor(Color.white)
                            .padding(.trailing, 10.0)
                    }
                    
                    HStack {
                        Image("blue-chip")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.leading, 35.0)
                            .frame(width: 120)
                        
                        Spacer()
                        
                        
                        Text(isEnglish ? "The Blue chip is given to the user who has played 5 times" : "파란 칩은 게임을 5버 했을때 주어집니다")
                            .foregroundColor(Color.white)
                            .padding(.trailing, 10.0)
                    }
                    
                    HStack {
                        Image("JS")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.leading, 35.0)
                            .frame(width: 120)
                        
                        Spacer()
                        
                        
                        Text(isEnglish ? "The J Spade is given to the user who has completed Stage 1" : "J 스페이드는 스테이지 1을 완료한 사람에게 주어집니다")
                            .foregroundColor(Color.white)
                            .padding(.trailing, 10.0)
                    }
                    
                    HStack {
                        Image("QS")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.leading, 35.0)
                            .frame(width: 120)
                        
                        Spacer()
                        
                        
                        Text(isEnglish ? "The Q Spade is given to the user who has completed Stage 1" : "Q 스페이드는 스테이지 2을 완료한 사람에게 주어집니다")
                            .foregroundColor(Color.white)
                            .padding(.trailing, 10.0)
                    }
                    
                    HStack {
                        Image("KS")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.leading, 35.0)
                            .frame(width: 120)
                        
                        Spacer()
                        
                        
                        Text(isEnglish ? "The K Spade is given to the user who has completed Stage 1" : "K 스페이드는 스테이지 3을 완료한 사람에게 주어집니다")
                            .foregroundColor(Color.white)
                            .padding(.trailing, 10.0)
                    }
                    
                    Spacer()
                    
                }
                .padding(.top)
                
                
            }
            .overlay(
                Button(action: {
                    playSound(sound: "LeaderBoardView", type: "mp3")
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(Color.white)
                        .font(.title)
                }
                    .foregroundColor(.white)
                    .padding(.top, 30)
                    .padding(.trailing, 20),
                alignment: .topTrailing
            )
        }
    }
}

struct BadgeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeInfoView()
    }
}
