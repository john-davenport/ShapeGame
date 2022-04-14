import SpriteKit

class GameTimer: SKLabelNode {
    
    
    var totalSeconds: CGFloat = 0
    
    func update() {
        
        //convert remaining time to an int
        let timeLeftInteger = Int(totalSeconds)
        
        //update label text
        text = String(timeLeftInteger)
        
    }
    
    func restartTimer(duration: CGFloat) {
        
        removeAllActions()
        
        totalSeconds = duration
        
        let wait:SKAction = SKAction.wait(forDuration: 0.1)
        let finishTimer:SKAction = SKAction.run {
            
            self.totalSeconds -= 0.1
            
            
        }
        
        let seq:SKAction = SKAction.sequence([wait, finishTimer])
        self.run(SKAction.repeatForever(seq))
        
        
    }
    
    
    
    
    
}

