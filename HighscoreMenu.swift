import SwiftUI
import SpriteKit

class HighScore: SKScene {
    
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
    var startLabel = SKLabelNode()
    var highScoreHeading = SKLabelNode()
    var highScoreLabel = SKLabelNode()
    var highScore = 0
    
    override func didMove(to view: SKView) {
        
        highScoreHeading.text = "HIGH SCORE:"
        highScoreHeading.fontSize = 55
        highScoreHeading.fontName = "American Typewriter"
        highScoreHeading.position = CGPoint(x: 300, y: 400)
        addChild(highScoreHeading)
        
        highScoreLabel.text = "\(UserDefaults().integer(forKey: "highScore"))"
        highScoreLabel.fontSize = 35
        highScoreLabel.fontName = "American Typewriter"
        highScoreLabel.position = CGPoint(x: 300, y: 350)
        addChild(highScoreLabel)
        
        startButton = SKSpriteNode(color: .blue, size: CGSize(width: 350, height: 100))
        startButton.position = CGPoint(x: 300, y: 220)
        startButton.name = "startButton"
        addChild(startButton)
        
        startLabel.text = "Back"
        startLabel.fontSize = 40
        startLabel.fontName = "American Typewriter Bold"
        startLabel.position = CGPoint(x: 0, y: -15)
        startButton.addChild(startLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for child in children {
            if child.name == "startButton" {
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                gameState = "MAIN"
            }
        }
        
    }
    
    
}

