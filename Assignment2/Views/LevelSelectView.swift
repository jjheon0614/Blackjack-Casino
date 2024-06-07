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

struct LevelSelectView: View {
    
    // MARK: - PROPERTIES
    var level : Bool
    var chip : String
    var image :String
    var levelText : String
    var levelDescription : String
    
    @AppStorage("darkmode") var darkmode: Bool = false
    
    var body: some View {
        ZStack {
            if (!level) {
                Rectangle()
                    .fill(Color.black)
                    .opacity(0.5)
                    .frame(width: 350, height: 170)
                    .cornerRadius(20)
            } else {
                Rectangle()
                    .fill(darkmode ? Color("customblue") : Color.blue)
                    .opacity(0.8)
                    .frame(width: 350, height: 170)
                    .cornerRadius(20)
            }
            
            HStack(spacing: 50) {
                
                ChipView(chipNumber: chip, imageName: image)
                    
                
                VStack{
                    Text(levelText)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    
                    Text(levelDescription)
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                }
                
                
            }
            .frame(width: 310, height: 170)
            .padding(.horizontal, 40)
            
            
        }
        
    }
}

struct LevelSelectView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelectView(level: true, chip: "50", image: "yellow-chip", levelText: "Hard Mode", levelDescription: "Betting coin is 50")
    }
}
