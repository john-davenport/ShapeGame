import SwiftUI
import SpriteKit

struct ContentView: View {
    
    //Gamedata needs to be made available to the view
    @EnvironmentObject var gameData: GameData
    @Environment(\.openURL) var openURL
    
    //initizalize the scene and it's bindings
    var level1Scene: SKScene {
        let scene = Level1(value1: $gameData.value1, 
                           value2: $gameData.value2, 
                           moves: $gameData.moves,
                           targetValue: $gameData.targetValue,
                           targetColor: $gameData.targetColor,
                           targetShape: $gameData.targetShape,
                           timerCount: $gameData.timerCount,
                           playerPoints: $gameData.playerPoints,
                           gameState: $gameData.gameState,
                           isPlaying: $gameData.isPlaying
        )
        scene.size = CGSize(width: 600, height: 600)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear
        
        return scene
    }
    
    var mainMenu: SKScene {
        
        let scene = MainMenu(gameState: $gameData.gameState)
        scene.size = CGSize(width: 600, height: 600)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear
        
        return scene
        
    }
    
    var gameOver: SKScene {
        
        let scene = GameOver(gameState: $gameData.gameState)
        scene.size = CGSize(width: 600, height: 600)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear
        return scene
        
    }
    
    var winScene: SKScene {
        
        let scene = WinScene(gameState: $gameData.gameState)
        scene.size = CGSize(width: 600, height: 600)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear
        return scene
        
    }
    
    var highScoreScene: SKScene {
        
        let scene = HighScore(gameState: $gameData.gameState)
        scene.size = CGSize(width: 600, height: 600)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear
        return scene
        
    }
    
    @State private var isPresenting = false
    
    var body: some View {
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            // It's an iPhone
        
        ZStack{
            
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                //Display the timer
                Text("TIME: \(self.gameData.timerCount, specifier: "%.1f")")
                    .font(.system(size: 40))
                    .padding(.top, 50)
                    .opacity(gameData.isPlaying ? 1 : 0)
                
                ZStack {
                    //display the target
                    Image("\(gameData.targetShape)")
                        .resizable()
                        .foregroundColor(Color(gameData.targetColor))
                        .colorMultiply(Color(gameData.targetColor))
                        .frame(width: 50, height: 50)
                        .opacity(gameData.isPlaying ? 1 : 0)
                    
                    Text("\(gameData.targetValue)")
                        .opacity(gameData.isPlaying ? 1 : 0)
                }
                
                
                Text("Shapes&Numbers")
                    .font(.system(size: 30))
                    .bold()
                    .padding(.top, -35)
                    .opacity(gameData.isPlaying ? 0 : 1)
                Text("A Swift Playgrounds Project")
                    .font(.caption)
                    .italic()
                    .opacity(gameData.isPlaying ? 0 : 1)
                
                //the game's gameboard
                VStack(alignment:.leading) {
                    
                    if gameData.gameState == "MAIN" {
                        SpriteView(scene: mainMenu, options: .allowsTransparency)
                            .ignoresSafeArea()
                            .scaledToFit()
                            .padding(.top, -35)
                            
                        
                    } else if gameData.gameState == "PLAYING" {
                        SpriteView(scene: level1Scene, options: .allowsTransparency)
                            .ignoresSafeArea()
                            .scaledToFit()
                            .padding(.top, -35)
                            .padding()
                            
                    } else if gameData.gameState == "LOSS" {
                        
                        SpriteView(scene: gameOver, options: .allowsTransparency)
                            .ignoresSafeArea()
                            .scaledToFit()
                            .padding(.top, -35)
                            
                        
                    } else if gameData.gameState == "WIN" {
                        
                        SpriteView(scene: winScene, options: .allowsTransparency)
                            .ignoresSafeArea()
                            .scaledToFit()
                            .padding(.top, -35)
                        
                    } else if gameData.gameState == "HIGHSCORE" {
                        
                        SpriteView(scene: highScoreScene, options: .allowsTransparency)
                            .ignoresSafeArea()
                            .scaledToFit()
                            .padding()
                    }
                    
                }
                
                Spacer()
                
                Text("Current Score")
                    .opacity(gameData.isPlaying ? 1 : 0)
                Text("\(gameData.playerPoints)")
                    .font(.system(size: 40))
                    .opacity(gameData.isPlaying ? 1 : 0)
                HStack{
                    Button("About"){
                        isPresenting.toggle()
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                    .controlSize(.regular)
                    .padding(.bottom, 25)
                    .fullScreenCover(isPresented: $isPresenting,
                                     onDismiss: didDismiss) {
                        VStack {
                            About()
                            Text("Tap to Dismiss")
                        }
                        .onTapGesture {
                            isPresenting.toggle()
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.blue)
                        .ignoresSafeArea()
                    }
                    Button("YouTube"){
                        openURL(URL(string: "https://www.youtube.com/johndavgamedev")!)
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                    .controlSize(.regular)
                    .padding(.bottom, 25)
                    
                    Button("Twitter"){
                        openURL(URL(string: "https://www.twitter.com/johndavtweets")!)
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
                    .controlSize(.regular)
                    .padding(.bottom, 25)
                }
            }
        }
    case .pad:
        // It's an iPad
        ZStack{
            
            GeometryReader { bounds in
                
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack(alignment: .center) {
                    //Display the timer
                    Text("TIME: \(self.gameData.timerCount, specifier: "%.1f")")
                        .font(.system(size: 80))
                        .opacity(gameData.isPlaying ? 1 : 0)
                    
                    ZStack {
                        //display the target
                        Image("\(gameData.targetShape)")
                            .resizable()
                            .foregroundColor(Color(gameData.targetColor))
                            .colorMultiply(Color(gameData.targetColor))
                            .frame(width: 80, height: 80)
                            .opacity(gameData.isPlaying ? 1 : 0)
                        
                        Text("\(gameData.targetValue)")
                            .font(.system(size: 30))
                            .opacity(gameData.isPlaying ? 1 : 0)
                        
                    }
                    
                    Text("Shapes&Numbers")
                        .font(.system(size: 80))
                        .bold()
                        .padding(.top, -35)
                        .opacity(gameData.isPlaying ? 0 : 1)
                    Text("A Swift Playgrounds Project")
                        .font(.system(size: 30))
                        .italic()
                        .opacity(gameData.isPlaying ? 0 : 1)
                    
                    //the game's gameboard
                    VStack() {
                        
                        if gameData.gameState == "MAIN" {
                            SpriteView(scene: mainMenu, options: .allowsTransparency)
                                .ignoresSafeArea()
                                .frame(maxWidth: 800,maxHeight: 800)
                                .scaledToFit()
                            
                        } else if gameData.gameState == "PLAYING" {
                            SpriteView(scene: level1Scene, options: .allowsTransparency)
                                .ignoresSafeArea()
                                .frame(maxWidth: 800,maxHeight: 800)
                                .padding(.top, -35)
                                .scaledToFit()
                            
                        } else if gameData.gameState == "LOSS" {
                            
                            SpriteView(scene: gameOver, options: .allowsTransparency)
                                .ignoresSafeArea()
                                .frame(maxWidth: 800,maxHeight: 800)
                                .scaledToFit()
                            
                            
                        } else if gameData.gameState == "WIN" {
                            
                            SpriteView(scene: winScene, options: .allowsTransparency)
                                .ignoresSafeArea()
                                .frame(maxWidth: 800,maxHeight: 800)
                                .scaledToFit()
                            
                        } else if gameData.gameState == "HIGHSCORE" {
                            
                            SpriteView(scene: highScoreScene, options: .allowsTransparency)
                                .ignoresSafeArea()
                                .frame(maxWidth: 800,maxHeight: 800)
                                .scaledToFit()
                        }
                        
                    }
                    
                    Spacer(minLength: 60)
                    
                    Text("Current Score")
                        .font(.system(size: 70))
                        .opacity(gameData.isPlaying ? 1 : 0)
                    Text("\(gameData.playerPoints)")
                        .font(.system(size: 70))
                        .opacity(gameData.isPlaying ? 1 : 0)
                    
                    HStack{
                        Button("About"){
                            isPresenting.toggle()
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle)
                        .controlSize(.regular)
                        .padding(.bottom, 25)
                        .fullScreenCover(isPresented: $isPresenting,
                                         onDismiss: didDismiss) {
                            VStack {
                                About()
                                Text("Tap to Dismiss")
                            }
                            .onTapGesture {
                                isPresenting.toggle()
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.blue)
                            .ignoresSafeArea()
                        }
                        Button("YouTube"){
                            openURL(URL(string: "https://www.youtube.com/johndavgamedev")!)
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle)
                        .controlSize(.regular)
                        .padding(.bottom, 25)
                        
                        Button("Twitter"){
                            openURL(URL(string: "https://www.twitter.com/johndavtweets")!)
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle)
                        .controlSize(.regular)
                        .padding(.bottom, 25)
                    }
                    Spacer()
                }.frame(maxWidth: bounds.size.width, maxHeight: bounds.size.height)
            }
            .colorScheme(.dark)
        }
        case .unspecified: fatalError("Device Not Supported")
        case .carPlay: fatalError("Device Not Supported")
        case .tv: fatalError("Device Not Supported")
        case .mac: fatalError("Device Not Supported")
    @unknown default: fatalError("Device Not Supported")
}
    }
    func didDismiss() {
        // Handle the dismissing action.
    }
}
