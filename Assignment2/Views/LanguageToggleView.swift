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

struct LanguageToggleView: View {
    
    // MARK: - PROPERTIES
    @Binding var isEnglish: Bool
    
    
    var body: some View {
        ZStack {
            
            
            ZStack {
                Color(UIColor.white)
                    .opacity(0.5)
            }
            .frame(width: 100, height: 50)
            .mask(
                Capsule()
                    .foregroundColor(Color.black)
            )
            
            
            ZStack {
                Button {
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                        isEnglish.toggle()
                        }
                } label: {
                    ZStack{
                        Circle()
                            .foregroundColor(.black)
                            .frame(width: 45, height: 45)
                        
                        if isEnglish {
                            Text("EN")
                                .foregroundColor(Color.white)
                        } else {
                            Text("KR")
                                .foregroundColor(Color.white)
                        }
                    }
                    
                }
                
                
            }
            .offset(x: isEnglish ?
                -23 :
                23
            )
            .mask(
                Circle()
                    .frame(width: 45, height: 45)
                    .offset(x: isEnglish ? -23 : 23)
            )
            
        }
    }
}

struct LanguageToggleView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageToggleView(isEnglish: .constant(true))
    }
}
