import SwiftUI
import SpriteKit

class MainMenu: SKScene {
    
    @Binding var gameState: String 
    
    init(gameState: Binding<String>) {
        
        _gameState = gameState
        
        super.init(size: CGSize(width: 600, height: 600))
        self.scaleMode = .fill
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var startButton = SKSpriteNode()
    var startButtonLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        //create start button
        startButton = SKSpriteNode(color: .blue, size: CGSize(width: 350, height: 100))
        startButton.position = CGPoint(x: 300, y: 400)
        startButton.name = "startButton"
        addChild(startButton)
        
        //add label to start button
        startButtonLabel.text = "Start Game"
        startButtonLabel.fontSize = 40
        startButtonLabel.fontName = "American Typewriter Bold"
        startButtonLabel.position = CGPoint(x: 0, y: -15)
        startButton.addChild(startButtonLabel)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        let touchedNodes = nodes(at: location)
        
        //change gameState based on button name
        for n in touchedNodes {
            if n.name == "startButton" {
                gameState = "PLAYING"
            }
        }
    }
}
