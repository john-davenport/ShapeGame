import Foundation
import SpriteKit

class ShapeClass: SKSpriteNode {
    
    weak var delegate: ShapeClicked!
    var shapeColor: String = ""
    var shapeShape: String = ""
    var value: Int = 0
    var label: SKLabelNode
    
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
    
    override var isUserInteractionEnabled: Bool {
        set {
            //ignore
        }
        get {
            return true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegate?.shapeClicked(shape: self)
    }
    
}
