import SwiftUI
import SpriteKit

class Level1: SKScene, ShapeClicked {
    
    //Bindings
    @Binding var value1: Int
    @Binding var value2: String
    @Binding var moves: Int
    @Binding var targetValue: Int
    @Binding var targetColor: String
    @Binding var targetShape: String
    @Binding var timerCount: CGFloat
    
    
    
    //Initialize the bindings
    init(value1: Binding<Int>, value2: Binding<String>, moves: Binding<Int>, targetValue: Binding<Int>, targetColor: Binding<String>, targetShape: Binding<String>, timerCount: Binding<CGFloat>) {
        
        _value1 = value1
        _value2 = value2
        _moves = moves
        _targetValue = targetValue
        _targetColor = targetColor
        _targetShape = targetShape
        _timerCount = timerCount
        
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

    //Array of possible colors in the game - note 
    //this string is the first part of the asset's
    //file name (i.e. BLUEcircle)
    let colors = [ "Blue",
                   "Orange"]
    
    
    //Array of possible shapes in the game - note
    //this string is the second part of the 
    //asset's file name (i.e. blueCIRCLE)
    let shapes = [ "Circle",
                   "Square"]
    
    
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
        shapesOnBoard = []
        
        var i = 0 //used to escape the while statement below.
        
        //load the grid
        while i < gridPositions.count {
            let randomColor = getRandomColor()
            let randomShape = getRandomShape()
            let textureString = randomColor + randomShape
            shape = ShapeClass(texture: SKTexture(imageNamed: textureString), color: .clear, size: CGSize(width: 150, height: 150))
            shape.position = gridPositions[i]
            shape.delegate = self
            shape.shapeColor = randomColor
            shape.shapeShape = randomShape
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
            return
        }
        
        //picks a random number between 0 and the number of shapes
        //on the board - 1
        shapeIndex = Int.random(in: 0...(shapesOnBoard.count - 1))
        //sets the target's color
        targetColor = shapesOnBoard[shapeIndex].shapeColor
        //sets the target's shape
        targetShape = shapesOnBoard[shapeIndex].shapeShape
        //sets the target's value
        targetValue = shapesOnBoard[shapeIndex].value
        
    }
    
    //used to pick a random shape from the shape array
    func getRandomShape() -> String {
        
        let randomShape = shapes.randomElement()
        return randomShape!
        
    }
    
    //used to pick a random color from the color array
    func getRandomColor() -> String {
        
        let randomColor = colors.randomElement()
        return randomColor!
        
    }
    
    //used to pick a random position from the grid array
    func getRandomPosition() -> CGPoint {
        
        let randomPoint = gridPositions.randomElement()
        return randomPoint!
        
    }
    
    //actions that should occur when a shape is
    //clicked by the player on the gameboard.
    func shapeClicked(shape: ShapeClass) {
        
        
        if targetShape == shape.shapeShape && targetColor == shape.shapeColor && shape.value == targetValue {
            
            //if the shape clicked matches the shape, color and value
            //of the target then do something positive for the player.
            shape.removeFromParent()
            shapesOnBoard.remove(at: shapeIndex)
            getPlayerTargets()
            
        } else {
            
            //I don't know what to do here yet... something negative maybe?
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        //update the timer
        timerCount = timer.totalSeconds
        
    }
    
    
}
