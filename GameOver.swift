import SwiftUI
import SpriteKit

class GameOver: SKScene {
    
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
    
    var mainMenu = SKSpriteNode()
    var mainMenuButtonLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        
        startButton = SKSpriteNode(color: .red, size: CGSize(width: 350, height: 100))
        startButton.position = CGPoint(x: 300, y: 360)
        startButton.name = "startButton"
        addChild(startButton)
        
        startButtonLabel.text = "Play Again?"
        startButtonLabel.fontSize = 40
        startButtonLabel.fontName = "American Typewriter Bold"
        startButtonLabel.position = CGPoint(x: 0, y: -15)
        startButton.addChild(startButtonLabel)
        
        mainMenu = SKSpriteNode(color: .blue, size: CGSize(width: 350, height: 100))
        mainMenu.position = CGPoint(x: 300, y: 220)
        mainMenu.name = "mainMenu"
        addChild(mainMenu)
        
        mainMenuButtonLabel.text = "Main Menu"
        mainMenuButtonLabel.fontSize = 40
        mainMenuButtonLabel.fontName = "American Typewriter Bold"
        mainMenuButtonLabel.position = CGPoint(x: 0, y: -15)
        mainMenu.addChild(mainMenuButtonLabel)
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        let touchedNodes = nodes(at: location)
        
        for n in touchedNodes {
            if n.name == "startButton" {
                gameState = "PLAYING"
            }
            if n.name == "mainMenu" {
                gameState = "MAIN"
            }
        }
    }
}
