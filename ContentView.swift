import SwiftUI
import SpriteKit

struct ContentView: View {
    
    //Gamedata needs to be made available to the view
    @EnvironmentObject var gameData: GameData
    
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
        return scene
    }
    
    var mainMenu: SKScene {
        
        let scene = MainMenu(gameState: $gameData.gameState)
        scene.size = CGSize(width: 600, height: 600)
        scene.scaleMode = .aspectFill
        return scene
        
    }
    
    var gameOver: SKScene {
        
        let scene = GameOver(gameState: $gameData.gameState)
        scene.size = CGSize(width: 600, height: 600)
        scene.scaleMode = .aspectFill
        return scene
        
    }
    
    var winScene: SKScene {
        
        let scene = WinScene(gameState: $gameData.gameState)
        scene.size = CGSize(width: 600, height: 600)
        scene.scaleMode = .aspectFill
        return scene
        
    }
    
    var highScoreScene: SKScene {
        
        let scene = HighScore(gameState: $gameData.gameState)
        scene.size = CGSize(width: 600, height: 600)
        scene.scaleMode = .aspectFill
        return scene
        
    }
    
    var body: some View {
        
        VStack(alignment: .center) {
            //Display the timer
            Text("TIME: \(self.gameData.timerCount, specifier: "%.1f")")
                .font(.system(size: 40))
                .padding(.top, 50)
            
            ZStack {
                //display the target
                Image("\(gameData.targetShape)")
                    .resizable()
                    .foregroundColor(Color(gameData.targetColor))
                    .colorMultiply(Color(gameData.targetColor))
                    .frame(width: 50, height: 50)
                
                Text("\(gameData.targetValue)")
            }
            
        }
        .opacity(gameData.isPlaying ? 1 : 0)
        
        
        Text("SHAPE GAME")
            .font(.system(size: 40))
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
                SpriteView(scene: mainMenu)
                    .ignoresSafeArea()
                    .scaledToFit()
                    .padding()
                    .onAppear {
                        mainMenu.isPaused = true
                    }
                    .onDisappear {
                        mainMenu.isPaused = false
                    }
                
            } else if gameData.gameState == "PLAYING" {
                SpriteView(scene: level1Scene)
                    .ignoresSafeArea()
                    .scaledToFit()
                    .padding()
                    .onAppear {
                        mainMenu.isPaused = true
                    }
                    .onDisappear {
                        mainMenu.isPaused = false
                    }
            } else if gameData.gameState == "LOSS" {
                
                SpriteView(scene: gameOver)
                    .ignoresSafeArea()
                    .scaledToFit()
                    .padding()
                    .onAppear {
                        mainMenu.isPaused = true
                    }
                    .onDisappear {
                        mainMenu.isPaused = false
                    }
                
            } else if gameData.gameState == "WIN" {
                
                SpriteView(scene: winScene)
                    .ignoresSafeArea()
                    .scaledToFit()
                    .padding()
                    .onAppear {
                        mainMenu.isPaused = true
                    }
                    .onDisappear {
                        mainMenu.isPaused = false
                    }
                
            } else if gameData.gameState == "HIGHSCORE" {
                
                SpriteView(scene: highScoreScene)
                    .ignoresSafeArea()
                    .scaledToFit()
                    .padding()
                    .onAppear {
                        mainMenu.isPaused = true
                    }
                    .onDisappear {
                        mainMenu.isPaused = false
                    }
                
            }
            
            
            
        }
        
        Text("Current Score")
            .opacity(gameData.isPlaying ? 1 : 0)
        Text("\(gameData.playerPoints)")
            .font(.system(size: 40))
            .opacity(gameData.isPlaying ? 1 : 0)
        
        Spacer()
    }
}
