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
    
    //Initialize the bindings
    init(value1: Binding<Int>, value2: Binding<String>, moves: Binding<Int>, targetValue: Binding<Int>, targetColor: Binding<UIColor>, targetShape: Binding<String>, timerCount: Binding<CGFloat>, playerPoints: Binding<Int>, gameState: Binding<String>) {
        
        _value1 = value1
        _value2 = value2
        _moves = moves
        _targetValue = targetValue
        _targetColor = targetColor
        _targetShape = targetShape
        _timerCount = timerCount
        _playerPoints = playerPoints
        _gameState = gameState
        
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

    //Array of possible colors in the game
    let colors = [ UIColor(.blue),
                   UIColor(.orange),
                   UIColor(.purple),
                   UIColor(.green)]
    
    
    //Array of possible shapes in the game
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
        
        //initialize timer and start it when level loads
        timer = GameTimer()
        addChild(timer)
        timer.restartTimer(duration: levelTimerStart)
        
        shapesOnBoard = [] // ensure shapes on board is empty at start
        
        var i = 0 //used to escape the while statement below.
        
        //load the grid
        while i < gridPositions.count {
            let randomColor = getRandomColor()
            let randomShape = getRandomShape()
            let textureString = randomShape
            shape = ShapeClass(texture: SKTexture(imageNamed: textureString), color: randomColor, size: CGSize(width: 150, height: 150))
            shape.position = gridPositions[i]
            shape.delegate = self
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
        
        //give player points for beating previous level
        playerPoints += level * Int(timer.totalSeconds)
        //reset timer for new level
        timer.restartTimer(duration: 30 - CGFloat(level * 3))
        //increase level
        level += 1
        
        //ensure shapes on board is empty at start of new level
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
            //reset board when player has cleared it
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
        
        //the random index determines how many shapes & colors
        //to choose from for each level.
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
            
            //if the shape clicked matches the shape, color and value
            //of the target then do something positive for the player.
            shape.removeFromParent()
            playerPoints += 10
            shapesOnBoard.remove(at: shapeIndex)
            getPlayerTargets()
            
        } else {
            
            timer.totalSeconds -= CGFloat(1 * level)
            //I don't know what to do here yet... something negative maybe?
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        //update the timer
        timerCount = timer.totalSeconds
        
        //player wins when they clear five levels
        if level > 5 {
            gameState = "WIN"
        }
        
        //player loses if the timer hits zero
        if timer.totalSeconds <= 0 {
            gameState = "LOSS"
        }
        
    }
    
    
}
