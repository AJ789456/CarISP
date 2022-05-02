import Igis
import Scenes
import Foundation

class Car: RenderableEntity {
    let car: Image
    var middle = 0
    var canvasEnd = 0
    var mLeft = false
    var mRight = false
    var moved = 0
    var distance = 0
    var lefting = false
    var righting = false
    
    init() {
        guard let carURL = URL(string:"https://codermerlin.com/users/avanish-jeendru/mustang.png") else {
            fatalError("Failed to create URL for Car")
        }
        car = Image(sourceURL: carURL)
      
        super.init(name: "Car")
                
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        canvas.setup(car)
        middle = canvasSize.width / 2 - 83
        canvasEnd = canvasSize.height
    }
    
    override func render(canvas:Canvas) {
        if car.isReady {
            car.renderMode = .destinationRect(Rect(topLeft:Point(x:middle, y:canvasEnd - 280), size:Size(width: 166, height:250)))
            canvas.render(car)
         
        }
        
        if mLeft && moved < 22 && distance > -1 && !righting {
            lefting = true
            middle -= 10
            moved += 1
        } else if distance == -1 {
            mLeft = false
        }
                
        if moved == 22 && mLeft {
            moved = 0
            distance -= 1
            mLeft = false
            lefting = false
        }

        if mRight && moved < 22 && distance < 1 && !lefting {
            righting = true
            middle += 10
            moved += 1
        } else if distance == 1 {
            mRight = false
        }
        
        if moved == 22 && mRight {
            moved = 0
            distance += 1
            mRight = false
            righting = false
        }
        
    }
}
