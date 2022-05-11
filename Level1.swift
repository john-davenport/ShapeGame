import SwiftUI
import SpriteKit

class Level1: SKScene, ShapeClicked {
    
    //Bindings
    @Binding var value1: Int
    @Binding var value2: String
    @Binding var moves: Int
    @Binding var targetValue: Int
    @Binding var targetColor: UIColor
    @Binding var targetShape: String
    @Binding var timerCount: CGFloat
    @Binding var playerPoints: Int
    @Binding var gameState: String
    @Binding var isPlaying: Bool
    
    //Initialize the bindings
    init(value1: Binding<Int>, value2: Binding<String>, moves: Binding<Int>, targetValue: Binding<Int>, targetColor: Binding<UIColor>, targetShape: Binding<String>, timerCount: Binding<CGFloat>, playerPoints: Binding<Int>, gameState: Binding<String>, isPlaying: Binding<Bool>) {
        
        _value1 = value1
        _value2 = value2
        _moves = moves
        _targetValue = targetValue
        _targetColor = targetColor
        _targetShape = targetShape
        _timerCount = timerCount
        _playerPoints = playerPoints
        _gameState = gameState
        _isPlaying = isPlaying
        
        super.init(size: CGSize(width: 600, height: 600))
        self.scaleMode = .fill
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Variables
    var timer = GameTimer()
    var shape = ShapeClass()
    var shapesOnBoard = [ShapeClass()]
    var valuesOnBoard = [Int()]
    var shapeIndex = Int()
    var levelTimerStart = 30.0
    var level = 1
    var highScore = Int()
    var currentHighScore = Int()
    
    //Array of possible colors in the game - note 
    //this string is the first part of the asset's
    //file name (i.e. BLUEcircle)
    let colors = [ UIColor(.blue),
                   UIColor(.orange),
                   UIColor(.purple),
                   UIColor(.green)]
    
    
    //Array of possible shapes in the game - note
    //this string is the second part of the 
    //asset's file name (i.e. blueCIRCLE)
    let shapes = [ "Circle",
                   "Square",
                   "Diamond",
                   "Star"]
    
    
    //An array of the possible grid positions within the gameboard
    //for shapes to appear.
    let gridPositions = [CGPoint(x: 300, y: 100),
                         CGPoint(x: 300, y: 500),
                         CGPoint(x: 300, y: 300),
                         CGPoint(x: 100, y: 100),
                         CGPoint(x: 100, y: 500),
                         CGPoint(x: 100, y: 300),
                         CGPoint(x: 500, y: 100),
                         CGPoint(x: 500, y: 500),
                         CGPoint(x: 500, y: 300)
    ]
    
    
    override func didMove(to view: SKView) {
        
        currentHighScore = UserDefaults().integer(forKey: "highScore")
        
        //initialize timer and start it when level loads
        timer = GameTimer()
        addChild(timer)
        timer.restartTimer(duration: levelTimerStart)
        shapesOnBoard = []
        
        //if the player wins (i.e. completes all five levels
        //the player's scorre needs to be shown on the win screen
        //otherwise the score needs to be reset.
        if gameState != "WIN" {
            playerPoints = 0
        }
        
        var i = 0 //used to escape the while statement below.
        
        //load the grid
        while i < gridPositions.count {
            let randomColor = getRandomColor()
            let randomShape = getRandomShape()
            let textureString = randomShape
            shape = ShapeClass(texture: SKTexture(imageNamed: textureString), color: randomColor, size: CGSize(width: 150, height: 150))
            shape.position = gridPositions[i]
            shape.delegate = self
            //shape.shapeColor = randomColor
            shape.shapeShape = randomShape
            shape.colorBlendFactor = 1
            shape.value = Int.random(in: 1...5)
            shape.label.text = "\(shape.value)"
            shape.label.position = CGPoint(x: 0, y: -20)
            shapesOnBoard.append(shape)
            valuesOnBoard.append(shape.value)
            addChild(shape)
            i += 1
        }
        
        //gets the first target color and shape.
        getPlayerTargets()
        
    }
    
    func resetBoard() {
        
        playerPoints += level * Int(timer.totalSeconds)
        timer.restartTimer(duration: 30 - CGFloat(level * 3))
        level += 1
        
        shapesOnBoard = []
        
        var i = 0 //used to escape the while statement below.
        
        //load the grid
        while i < gridPositions.count {
            let randomColor = getRandomColor()
            let randomShape = getRandomShape()
            let textureString = randomShape
            shape = ShapeClass(texture: SKTexture(imageNamed: textureString), color: randomColor, size: CGSize(width: 150, height: 150))
            shape.position = gridPositions[i]
            shape.delegate = self
            //shape.shapeColor = randomColor
            shape.shapeShape = randomShape
            shape.colorBlendFactor = 1
            shape.value = Int.random(in: 1...5)
            shape.label.text = "\(shape.value)"
            shape.label.position = CGPoint(x: 0, y: -20)
            shapesOnBoard.append(shape)
            valuesOnBoard.append(shape.value)
            addChild(shape)
            i += 1
        }
        
        //gets the first target color and shape.
        getPlayerTargets()
        
    }
    
    func getPlayerTargets() {
        
        //makes sure that at least one
        //shape is on the board
        if shapesOnBoard.count == 0 {
            resetBoard()
            return
        }
        
        //picks a random number between 0 and the number of shapes
        //on the board - 1
        shapeIndex = Int.random(in: 0...(shapesOnBoard.count - 1))
        //sets the target's color
        targetColor = shapesOnBoard[shapeIndex].color
        //sets the target's shape
        targetShape = shapesOnBoard[shapeIndex].shapeShape
        //sets the target's value
        targetValue = shapesOnBoard[shapeIndex].value
        
    }
    
    //used to pick a random shape from the shape array
    func getRandomShape() -> String {
        
        var randomIndex = 0 
        
        switch level {
            
        case 1: randomIndex = Int.random(in: 0...1)
        case 2: randomIndex = Int.random(in: 0...2)
        case 3: randomIndex = Int.random(in: 0...3)
        case 4: randomIndex = Int.random(in: 0...3)
        case 5: randomIndex = Int.random(in: 0...3)
            
        default: print("no levels beyond 5")
        }
        
        let randomShape = shapes[randomIndex]
        return randomShape
        
    }
    
    //used to pick a random color from the color array
    func getRandomColor() -> UIColor {
        
        var randomIndex = 0 
        
        switch level {
            
        case 1: randomIndex = Int.random(in: 0...1)
        case 2: randomIndex = Int.random(in: 0...2)
        case 3: randomIndex = Int.random(in: 0...3)
        case 4: randomIndex = Int.random(in: 0...3)
        case 5: randomIndex = Int.random(in: 0...3)
            
        default: print("no levels beyond 5")
        }
        
        let randomColor = colors[randomIndex]
        return randomColor
        
    }
    
    //used to pick a random position from the grid array
    func getRandomPosition() -> CGPoint {
        
        let randomPoint = gridPositions.randomElement()
        return randomPoint!
        
    }
    
    //actions that should occur when a shape is
    //clicked by the player on the gameboard.
    func shapeClicked(shape: ShapeClass) {
        
        
        
        if targetShape == shape.shapeShape && targetColor == shape.color && shape.value == targetValue {
            
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
            //if the shape clicked matches the shape, color and value
            //of the target then do something positive for the player.
            shape.removeFromParent()
            playerPoints += 10
            shapesOnBoard.remove(at: shapeIndex)
            getPlayerTargets()
            
        } else {
            
            //add haptic (heavy is used here to indicate incorrect guess
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
            //added a shake effect here to show a wrong guess
            let shake = SKAction.shake(duration: 0.3, amplitudeX: 50, amplitudeY: 50)
            shape.run(shake)
            
            //penalty for incorrect guess loss of time and points
            timer.totalSeconds -= CGFloat(1 * level)
            playerPoints -= level * 2
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        //this is used to control what elements are displayed 
        //on the main menu.
        if gameState == "PLAYING" {
            isPlaying = true
        } else {
            isPlaying = false
        }
        
        //update the timer
        timerCount = timer.totalSeconds
        
        if level > 5 {
            
            if playerPoints > currentHighScore {
                highScore = playerPoints
                UserDefaults().set(highScore, forKey: "highScore")
            }
            gameState = "WIN"
        }
        
        
        if timer.totalSeconds <= 0 {
            gameState = "LOSS"
        }
    }
}

//This extension handles creating a simple shaking animation for an
//incorrect guess by the player.
extension SKAction {
    class func shake(duration:CGFloat, amplitudeX:Int = 3, amplitudeY:Int = 3) -> SKAction {
        let numberOfShakes = duration / 0.015 / 2.0
        var actionsArray:[SKAction] = []
        for _ in 1...Int(numberOfShakes) {
            let dx = CGFloat(arc4random_uniform(UInt32(amplitudeX))) - CGFloat(amplitudeX / 2)
            let dy = CGFloat(arc4random_uniform(UInt32(amplitudeY))) - CGFloat(amplitudeY / 2)
            let forward = SKAction.moveBy(x: dx, y:dy, duration: 0.015)
            let reverse = forward.reversed()
            actionsArray.append(forward)
            actionsArray.append(reverse)
        }
        return SKAction.sequence(actionsArray)
    }
}
