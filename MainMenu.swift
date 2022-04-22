import SwiftUI
import SpriteKit

struct MainMenu: View {
    
    //Gamedata needs to be made available to the view
    @EnvironmentObject var gameData: GameData
    
    //initizalize the scene and it's bindings
    var scene: SKScene {
        let scene = Level1(value1: $gameData.value1, 
                           value2: $gameData.value2, 
                           moves: $gameData.moves,
                           targetValue: $gameData.targetValue,
                           targetColor: $gameData.targetColor,
                           targetShape: $gameData.targetShape,
                           timerCount: $gameData.timerCount
        )
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
                Image("\(gameData.targetColor)"+"\(gameData.targetShape)")
                    .resizable()
                    .frame(width: 50, height: 50)
                
                Text("\(gameData.targetValue)")
            }
            
        }
        
        //the game's gameboard
        VStack(alignment:.leading) {
                SpriteView(scene: scene)
                    .scaledToFit()
                    .padding()
                }
        
        Spacer()
    }
}
