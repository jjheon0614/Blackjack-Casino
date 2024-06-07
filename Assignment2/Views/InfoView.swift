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

struct InfoView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.dismiss) var dismiss
    @AppStorage("isEnglish") var isEnglish: Bool = true
    
    var body: some View {
        ZStack{
            
            VStack{
                
                
                Image("Title")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .modifier(BackgroundModifier())
                
                Form {
                    Section(header: Text(isEnglish ? "How To Play" : "가이드")) {
                        Text(isEnglish ? "Click 'Hit' to get card until it is not over 21." : "'히트'를 눌러 21이 넘기전가지 카드를 얻으세요.")
                        Text(isEnglish ? "Click 'Stand' to stop getting card and see the result." : "'스탠드'를 눌러 카드를 그만받고 결과를 확인하세요.")
                        Text(isEnglish ? "Dealer will show the covered card and get the cards that dealer wants." : "딜러가 뒤집어진 카드를 오픈하고 딜러가 얻고 싶은만큼 카드를 얻을 겁니다")
                        Text(isEnglish ? "Result will show with Player win, lose, or draw by comparing with Dealer's card score." : "딜러 점수와 비교해서 플리이어 승, 패, 무승부를 결정합니다.")
                        Text(isEnglish ? "if you want to stop the game, you can click the pause button on the right top." : "중간에 멈추고 싶으면 정지 버튼을 누르면 됩니다.")
                  }
                    Section(header: Text(isEnglish ? "Card Number" : "카드 점수")) {
                        HStack{
                            Spacer()
                            Image("AS")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60)
                            
                            Image(systemName: "arrowshape.right.fill")
                            
                            
                            Image("10S")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60)
                            
                            Text(" : ")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text("1")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Image(systemName: "arrowshape.right.fill")
                            
                            Text("10")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
        
                        }
                        
                        HStack{
                            Spacer()
                            Image("JS")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60)
                            
                            
                            Image("QS")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60)
                            
                            Image("KS")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60)
                            
                            Text(" : ")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            
                            
                            Text("10")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
        
                        }
                        
                    }
                    Section(header: Text(isEnglish ? "Application Information" : "앱 정보")) {
                        HStack {
                            Text(isEnglish ? "App Name" : "앱 이름")
                          Spacer()
                            Text(isEnglish ? "BLACKJACK Casino" : "블랙잭 카지노")
                        }
                        HStack {
                            Text(isEnglish ? "Course" : "코스")
                          Spacer()
                          Text("COSC2659")
                        }
                        HStack {
                            Text(isEnglish ? "Year Published" : "출간 연도")
                          Spacer()
                          Text("2023")
                        }
                        HStack {
                            Text(isEnglish ? "Location" : "위치")
                          Spacer()
                          Text("Saigon South Campus")
                        }
                  }
                }
                .font(.system(.body, design: .rounded))
            }
            .onAppear(perform: {playSound(sound: "InfoView", type: "mp3")})
            .padding(.top, 40)
            .overlay(
              Button(action: {
                  
                  playSound(sound: "contentView", type: "mp3")
                  dismiss()
                  
              }) {
                  
                  Image(systemName: "xmark.circle")
                      .foregroundColor(Color.black)
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

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
