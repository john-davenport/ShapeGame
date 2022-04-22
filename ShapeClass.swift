import Foundation
import SpriteKit

class ShapeClass: SKSpriteNode {
    
    //give the shape class a delegate 
    //allowing it to be clicked
    weak var delegate: ShapeClicked!
    
    //variables
    var shapeColor: String = ""
    var shapeShape: String = ""
    var value: Int = 0
    var label: SKLabelNode
    
    //initialize
    override init(texture: SKTexture!, color: UIColor, size: CGSize) {
        shapeColor = "Blue"
        shapeShape = "Square"
        value = 5
        label = SKLabelNode()
        
        super.init(texture: texture, color: color, size: size)
        
        label.fontSize = 55
        label.fontColor = .white
        self.addChild(label)
        label.position = CGPoint(x: 0, y: 0)
        label.zPosition = 1
        label.text = "\(self.value)"
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //allow shapes to be interacted with (maybe not necessary?
    override var isUserInteractionEnabled: Bool {
        set {
            //ignore
        }
        get {
            return true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //make shapes clickable by calling the delegate when touched
        self.delegate?.shapeClicked(shape: self)
    }
    
}
