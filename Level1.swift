import SwiftUI
import SpriteKit

class Level1: SKScene, ShapeClicked {
    
    //bindings
    
    @Binding var value1: Int
    @Binding var value2: String
    @Binding var moves: Int
    
    @Binding var targetValue: Int
    @Binding var targetColor: String
    @Binding var targetShape: String
    
    @Binding var timerCount: CGFloat
    
    var timer = GameTimer()
    
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
    
    var shapesOnBoard = [ShapeClass()]
    var valuesOnBoard = [Int()]
    var shapeIndex = Int()
    
    var levelTimerStart = 30.0

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let shapes = [ "Circle",
                   "Square"]
    
    let colors = [ "Blue",
                   "Orange"]
    
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
    
    var shape = ShapeClass()
    
    override func didMove(to view: SKView) {
        
        timer = GameTimer()
        addChild(timer)
        timer.restartTimer(duration: levelTimerStart)
        
        
        
        var i = 0
        
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
        
        getPlayerTargets()
        
    }
    
    func getPlayerTargets() {
        
        if shapesOnBoard.count == 1 {
            return
        }
        
        shapeIndex = Int.random(in: 1...(shapesOnBoard.count - 1))
        targetShape = shapesOnBoard[shapeIndex].shapeShape
        targetColor = shapesOnBoard[shapeIndex].shapeColor
        targetValue = shapesOnBoard[shapeIndex].value
        
        
        
    }
    
    func getRandomShape() -> String {
        
        let randomShape = shapes.randomElement()
        
        return randomShape!
        
    }
    
    func getRandomColor() -> String {
        
        let randomColor = colors.randomElement()
        
        return randomColor!
        
    }
    
    func getRandomPosition() -> CGPoint {
        
        let randomPoint = gridPositions.randomElement()
        
        return randomPoint!
        
    }
    
    func shapeClicked(shape: ShapeClass) {
        
        
        if targetShape == shape.shapeShape && targetColor == shape.shapeColor && shape.value == targetValue {
            
            shape.removeFromParent()
            shapesOnBoard.remove(at: shapeIndex)
            getPlayerTargets()
            
        } else {
            
            //I don't know what to do here yet
            
        }
        
        
        
        
        
//        if shape.value == targetValue && shape.shapeColor == targetColor {
//            print("Woohoo")
//            shape.removeFromParent()
//            targetColor = getRandomShape()
//            targetValue = Int.random(in: 1...5)
//            moves += 1
//        } else {
//            print("wrong!")
//            moves -= 1
//        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        timerCount = timer.totalSeconds
        
        
        
    }
    
    
}
