import SwiftUI
import SpriteKit

class GameData: ObservableObject {
    
    //A simple file containing the data that needs to be
    //passed between the SwiftUI views and the SpriteView
    
    @Published var value1: Int = 0
    @Published var value2: String = ""
    @Published var moves: Int = 5
    
    @Published var targetValue: Int = 0
    @Published var targetColor: String = ""
    @Published var targetShape: String = ""
    
    @Published var timerCount: CGFloat = 30.0
    
}
