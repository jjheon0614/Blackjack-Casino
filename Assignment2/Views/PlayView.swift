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

struct PlayView: View {
    
    
    
    // MARK: - PROPERTIES
    
    let shape = ["C", "D", "H", "S"]
    let number = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var userDataManager: UserDataManager
    @EnvironmentObject var stageSetting: StageSetting
    
    @AppStorage("isEnglish") var isEnglish: Bool = true
    @AppStorage("darkmode") var darkmode: Bool = false
    
    
    @AppStorage("continueUsername") var continueUsername: String = ""
    @AppStorage("continuePlayerScore") var continuePlayerScore: Int = 0
    @AppStorage("continueHighScore") var continueHighScore: Int = 0
    
    @State private var playerCards = [String]()
    @State private var dealerCards = [String]()
    @State var playerTotal = 0
    @State var dealerTotal = 0
    @State var isHit = true
    @State var isStand = false
    @State var isEven = false
    @State var playerCoin = 150
    @State var highScore = 150
    @State private var gameEnd = false
    @State var playerWinGame = false
    @State var playerLoseGame = false
    @State var isContentView = false
    @State var dealerFirstCard = 0
    @State var noMoney = false
    @State var isPaused = false
    @State var completeStage = false
    
    @State private var isThirdCardVisible = false
    
    let playerName : String
    
    
    
    // MARK: - FUNCTIONS (GAME LOGICS)
    
    
    //MARK: - START GAME
    func startGame() {
        
        // Clear the playerCards and dealerCards arrays
        playerCards = []
        dealerCards = []
        
        gameEnd = false
        isStand = false
        isEven = false
        isHit = true
        playerWinGame = false
        playerLoseGame = false
        dealerFirstCard = 0
        
        if continueUsername.isEmpty {
            continuePlayerScore = playerCoin
            continueHighScore = highScore
        } else {
            playerCoin = continuePlayerScore
            highScore = continueHighScore
        }
        
        
        continueUsername = playerName
        
        playerTotal = 0
        dealerTotal = 0
        
        for i in 0..<2 {
            var cardNumber: Int
            var cardShape: Int
            
            repeat {
                cardNumber = Int.random(in: 0..<number.count)
                cardShape = Int.random(in: 0..<shape.count)
            } while !checkDuplicate(card: number[cardNumber] + shape[cardShape])
            
            playerCards.append(number[cardNumber] + shape[cardShape])
            
            
            
            if (cardNumber >= 10) {
                cardNumber = 10
            }
            
            cardNumber += 1
            
            if (cardNumber >= 10) {
                cardNumber = 10
            }
            
            
            playerTotal += cardNumber
            
            repeat {
                cardNumber = Int.random(in: 0..<number.count)
                cardShape = Int.random(in: 0..<shape.count)
            } while !checkDuplicate(card: number[cardNumber] + shape[cardShape])
            
            dealerCards.append(number[cardNumber] + shape[cardShape])
            
            cardNumber += 1
            
            if (cardNumber >= 10) {
                cardNumber = 10
            }
            
            if (i == 0) {
                dealerFirstCard = cardNumber
            }
            
            dealerTotal += cardNumber
        }
        
        print("Player's cards: \(playerCards.joined(separator: ", "))")
        print("Dealer's cards: \(dealerCards.joined(separator: ", "))")
    }
    
    
    //MARK: - PLAYER LOSE LOGIC
    func playerLose() {
        
        
        if (settings.isHard) {
            playerCoin -= 50
        } else if (settings.isNormal) {
            playerCoin -= 30
        } else {
            playerCoin -= 10
        }
        
        continuePlayerScore = playerCoin
        
        gameEnd = true
        
        
        if (playerCoin <= 0) {
            userDataManager.updateScore(forUsername: playerName, currentScore: highScore)
            
            continueUsername = ""
            noMoney = true
        } else {
            playerLoseGame = true
        }
    }
    
    
    //MARK: - PLAYER WIN LOGIC
    func playerWin() {
        playerWinGame = true
        
        
        
        
        if (settings.isHard) {
            playerCoin += 50
        } else if (settings.isNormal) {
            playerCoin += 30
        } else {
            playerCoin += 10
        }
        
        
        if (playerCoin > highScore) {
            highScore = playerCoin
            userDataManager.updateScore(forUsername: playerName, currentScore: highScore)
        }
        
        continuePlayerScore = playerCoin
        continueHighScore = highScore
        
        if stageSetting.stageOne {
            if (highScore >= 200) {
                userDataManager.updateStageOne(forUsername: playerName)
                
                completeStage = true
            }
        } else if (stageSetting.stageTwo) {
            if (highScore >= 300) {
                userDataManager.updateStageTwo(forUsername: playerName)
                
                completeStage = true
            }
        } else if (stageSetting.stageThree) {
            if (highScore >= 400) {
                userDataManager.updateStageThree(forUsername: playerName)
                
                completeStage = true
            }
        }
        
        
        gameEnd = true
    }
    
    
    
    //MARK: - STAND FUNCTION
    func stand() {
        if (playerTotal <= 21) {
            while (dealerTotal <= 17) {
                var cardNumber: Int
                var cardShape: Int
                
                repeat {
                    cardNumber = Int.random(in: 0..<number.count)
                    cardShape = Int.random(in: 0..<shape.count)
                } while !checkDuplicate(card: number[cardNumber] + shape[cardShape])
                
                dealerCards.append(number[cardNumber] + shape[cardShape])
                
                cardNumber += 1
                
                if (cardNumber >= 10) {
                    cardNumber = 10
                }
                
                dealerTotal += cardNumber
            }
        }
        
        if (playerTotal == dealerTotal) {
            isEven = true
            print("Draw")
            gameEnd = true
        } else if (dealerTotal > 21) {
            if (playerTotal <= 21) {
                playerWin()
            } else {
                isEven = true
                print("Draw")
                gameEnd = true
            }
        } else if (playerTotal < dealerTotal) {
            print("Dealer won\n")
            playerLose()
        } else {
            print("Player won\n")
            playerWin()
        }
        
    }
    
    //MARK: - FIND DUPLICATE CARD
    func checkDuplicate(card: String) -> Bool {
        return !playerCards.contains(card) && !dealerCards.contains(card)
    }
    
    
    //MARK: - HIT FUNCTION
    func hit() {
        
        
        var cardNumber: Int
        var cardShape: Int
        
        repeat {
            cardNumber = Int.random(in: 0..<number.count)
            cardShape = Int.random(in: 0..<shape.count)
        } while !checkDuplicate(card: number[cardNumber] + shape[cardShape])
        
        playerCards.append(number[cardNumber] + shape[cardShape])
        
        cardNumber += 1
        
        if (cardNumber >= 10) {
            cardNumber = 10
        }
        
        
        playerTotal += cardNumber
        
        print("player Total: \(playerTotal)\n")
        
        if (playerTotal > 21) {
            isStand = true
            isHit = false
            print("Player lose!!")
            playerLose()
        } else if (playerTotal == 21) {
            isStand = true
            isHit = false
            
            stand()
        }
    }
    
    
    
    //MARK: - BODY
    var body: some View {
        
        
        if (isContentView) {
            ContentView()
        } else {
            
            GeometryReader { geometry in
                
                ZStack{
                    
                    Image(darkmode ? "redTable" : "greenTable")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width)
                        .ignoresSafeArea()
                    
                    VStack{
                        
                        HStack {
                            
                            Spacer()
                            
                            Button {
                                isPaused = true
                                playSound(sound: "click", type: "wav")
                            } label: {
                                Image(systemName: "pause.fill")
                                    .foregroundColor(darkmode ? Color("customGreen") : Color.red)
                                    .aspectRatio(contentMode: .fit)
                            }
                            .padding(.trailing, 20.0)
                            
                            
                        }
                        
                        if dealerCards.count >= 2 {
                            let totalWidth = CGFloat(dealerCards.count - 1) * 70
                            HStack(spacing: 0) {
                                ForEach(0..<dealerCards.count, id: \.self) { index in
                                    
                                    if index == 0 {
                                        if !isStand {
                                            Image(darkmode ? "darkback" : "back")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 140)
                                                .offset(x: CGFloat(index) * -70 + totalWidth/2)
                                        } else {
                                            Image(dealerCards[index]).resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 130)
                                                .offset(x: CGFloat(index) * -70 + totalWidth/2)
                                        }
                                    } else {
                                        Image(dealerCards[index])
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 130)
                                            .offset(x: CGFloat(index) * -70 + totalWidth/2)
                                    }
                                }
                            }
                            .frame(minWidth: 380, maxWidth: .infinity)
                        }
                        
                        
                        
                        
                        HStack{
                            Text(isEnglish ? "Dealer" : "딜러")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            
                            if (gameEnd) {
                                Text("\(dealerTotal)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                            } else {
                                Text("\(dealerTotal - dealerFirstCard)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                            }
                            
                        }
                        
                        HStack(spacing: 10) {
                            
                            HStack{
                                Text(isEnglish ? "Player\nMoney" : "보유\n코인".uppercased())
                                    .modifier(scoreLabelStyle())
                                    .multilineTextAlignment(.trailing)
                                Text("\(playerCoin)")
                                    .modifier(scoreNumberStyle())
                            }
                            .modifier(scoreCapsuleStyle())
                            
                            
                            if (settings.isHard) {
                                ChipView(chipNumber: "50", imageName: "yellow-chip")
                            } else if (settings.isNormal) {
                                ChipView(chipNumber: "30", imageName: "red-chip")
                            } else {
                                ChipView(chipNumber: "10", imageName: "blue-chip")
                            }
                            
                            HStack{
                                Text("\(highScore)")
                                    .modifier(scoreNumberStyle())
                                    .multilineTextAlignment(.leading)
                                Text(isEnglish ? "High\nScore" : "최고\n점수".uppercased())
                                    .modifier(scoreLabelStyle())
                                
                            }
                            .modifier(scoreCapsuleStyle()
                            )
                        }
                        
                        
                        HStack{
                            Text(playerName)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            
                            
                            Text("\(playerTotal)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                        }
                        
                        if playerCards.count >= 2 {
                            let totalWidth = CGFloat(playerCards.count - 1) * 70
                            
                            HStack(spacing: 0) {
                                ForEach(0..<playerCards.count, id: \.self) { index in
                                    Image(playerCards[index])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 130)
                                        .offset(x: CGFloat(index) * -70 + totalWidth/2)
                                }
                                .transition(.move(edge: .trailing))
                                .animation(.easeInOut(duration: 0.5))
                                .onAppear {
                                    // Check if the third card should be visible
                                    if playerCards.count > 3 {
                                        isThirdCardVisible = true
                                    }
                                }
                            }
                            .frame(minWidth: 380, maxWidth: .infinity)
                        }
                        
                        
                        
                        
                        HStack(spacing: 20){
                            
                            Button {
                                isHit = false
                                isStand = true
                                
                                playSound(sound: "click", type: "wav")
                                
                                if (playerTotal <= 21) {
                                    stand()
                                }
                                
                            } label: {
                                PlayButton(text: isEnglish ? "Stand" : "스탠드")
                            }
                            
                            Button {
                                
                                playSound(sound: "click", type: "wav")
                                
                                if isHit {
                                    hit()
                                }
                                
                                
                            } label: {
                                PlayButton(text: isEnglish ? "Hit" : "히트")
                            }
                            
                        }
                    }
                    .onAppear {
                        startGame()
                    }
                    
                    
                    
                    
                    if isPaused {
                        
                        Color.black
                            .opacity(0.5)
                            .ignoresSafeArea()
                        
                        HStack(spacing: 20){
                            Button {
                                
                                userDataManager.updateScore(forUsername: playerName, currentScore: highScore)
                                
                                continueUsername = ""
                                
                                playSound(sound: "click", type: "wav")
                                
                                self.isContentView = true
                            } label: {
                                PlayButton(text: isEnglish ? "Quit" : "그만하기")
                            }
                            
                            Button {
                                
                                isPaused = false
                                
                                playSound(sound: "click", type: "wav")
                                
                            } label: {
                                PlayButton(text: isEnglish ? "Continue" : "계속")
                            }
                        }
                        
                    }
                    
                    if playerWinGame {
                        
                        Color.black
                            .opacity(0.5)
                            .ignoresSafeArea()
                        
                        VStack{
                            Image("lose")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300)
                            
                            Spacer()
                            
                            Image("win")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300)
                            
                            
                        }.onAppear {
                        perform:do {
                            playSound(sound: "win", type: "mp3")
                        }
                            // Use DispatchQueue to toggle playerWinGame after 1.5 second (adjust duration as needed)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                startGame()
                                playerWinGame = false
                            }
                        }
                        
                    }
                    
                    
                    
                    
                    
                    if playerLoseGame {
                        
                        Color.black
                            .opacity(0.5)
                            .ignoresSafeArea()
                        
                        VStack{
                            Image("win")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300)
                            
                            Spacer()
                            
                            Image("lose")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300)
                            
                            
                        }.onAppear {
                        perform:do {
                            playSound(sound: "lose", type: "mp3")
                        }
                            // Use DispatchQueue to toggle playerWinGame after 1.5 second (adjust duration as needed)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                startGame()
                                playerLoseGame = false
                            }
                        }
                        
                    }
                    
                    if isEven {
                        ZStack{
                            Color.black
                                .opacity(0.5)
                                .ignoresSafeArea()
                            
                            Text(isEnglish ? "DRAW" : "무승부")
                                .font(.system(size: 60))
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                        }.onAppear {
                            // Use DispatchQueue to toggle playerWinGame after 1.5 second (adjust duration as needed)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                startGame()
                                isEven = false
                            }
                        }.onAppear(perform: {
                            playSound(sound: "draw", type: "wav")
                        })
                    }
                    
                    if completeStage {
                        VStack{
                            Text(isEnglish ? "Stage Completed" : "스테이지 완료")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                                .background(Color.red)
                            
                            
                            VStack{
                                Image("Title")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                                
                                
                                Button {
                                    playSound(sound: "click", type: "wav")
                                    self.noMoney = false
                                    self.isContentView = true
                                } label: {
                                    Text(isEnglish ? "Go to menu" : "메뉴".uppercased())
                                        .foregroundColor(Color.black)
                                }
                                .padding(.vertical,10)
                                .padding(.horizontal, 20)
                                .background(
                                    Capsule()
                                        .strokeBorder(lineWidth: 2)
                                        .foregroundColor(Color.red)
                                )
                            }
                            .padding(.bottom)
                            
                        }
                        .background(.white)
                        .cornerRadius(20)
                    }
                    
                    
                    if noMoney {
                        VStack{
                            Text(isEnglish ? "Game Over" : "게임 종료")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                                .background(Color.red)
                            
                            VStack{
                                Image("Title")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                                
                                Text(isEnglish ? "You lost your money!!!\nGood luck for next time" : "보유 코인을 다 잃었습니다!!!\n다음 기회를 기대하세요")
                                    .font(.system(.body, design: .rounded))
                                    .multilineTextAlignment(.center)
                                
                                
                                HStack {
                                    Button {
                                        playSound(sound: "click", type: "wav")
                                        self.noMoney = false
                                        self.isContentView = true
                                    } label: {
                                        Text(isEnglish ? "Go to menu" : "메뉴".uppercased())
                                            .foregroundColor(Color.black)
                                    }
                                    .padding(.vertical,10)
                                    .padding(.horizontal, 20)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 2)
                                            .foregroundColor(Color.red)
                                    )
                                    
                                    
                                    Button {
                                        
                                        playSound(sound: "click", type: "wav")
                                        
                                        self.noMoney = false
                                        self.playerCoin = 150
                                        userDataManager.updatePlaytime(forUsername: playerName)
                                        
                                        startGame()
                                    } label: {
                                        Text(isEnglish ? "New Game" : "새 게임".uppercased())
                                            .foregroundColor(Color.black)
                                    }
                                    .padding(.vertical,10)
                                    .padding(.horizontal, 20)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 2)
                                            .foregroundColor(Color.red)
                                    )
                                }
                            }
                            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 280, idealHeight: 300, maxHeight: 350, alignment: .center)
                            
                        }
                        .onAppear(perform: {
                            playSound(sound: "gameEnd", type: "mp3")
                        })
                        .background(.white)
                        .cornerRadius(20)
                    }
                    
                }
            }
        }
        
    }
    
}


struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        let settings = Settings()
        let stageSetting = StageSetting()
        return PlayView(playerName: "Jaeheon")
                    .environmentObject(settings)
                    .environmentObject(stageSetting)
    }
}
