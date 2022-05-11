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
    
    var highScoreButton = SKSpriteNode()
    var highScoreButtonLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        
        startButton = SKSpriteNode(color: .blue, size: CGSize(width: 350, height: 100))
        startButton.position = CGPoint(x: 300, y: 400)
        startButton.name = "startButton"
        addChild(startButton)
        
        startButtonLabel.text = "Start Game"
        startButtonLabel.fontSize = 40
        startButtonLabel.fontName = "American Typewriter Bold"
        startButtonLabel.position = CGPoint(x: 0, y: -15)
        startButton.addChild(startButtonLabel)
        
        highScoreButton = SKSpriteNode(color: .red, size: CGSize(width: 350, height: 100))
        highScoreButton.position = CGPoint(x: 300, y: 200)
        highScoreButton.name = "highScore"
        addChild(highScoreButton)
        
        highScoreButtonLabel.text = "High Scores"
        highScoreButtonLabel.fontSize = 40
        highScoreButtonLabel.fontName = "American Typewriter Bold"
        highScoreButtonLabel.position = CGPoint(x: 0, y: -15)
        highScoreButton.addChild(highScoreButtonLabel)
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        let touchedNodes = nodes(at: location)
        
        for n in touchedNodes {
            
            if n.name == "startButton" {
                
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                
                gameState = "PLAYING"
                
            } else if n.name == "highScore" {
                
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                
                gameState = "HIGHSCORE"
                
            }
            
            
        }
        
        
        
        
    }
    
    
}
