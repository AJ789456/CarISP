import Igis
import Scenes
import Foundation

class Car: RenderableEntity {
//Image of car
    let car: Image
//X-position of the car
    var middle = 0
//Lower end of the canvas
    var canvasEnd = 0
//Booleans to see if the car need to move left of right
    var mLeft = false
    var mRight = false
//Counts how far the car has moved to stop it later
    var moved = 0
//Determine whether the car is in the center, right or left lane
    var distance = 0
//Booleans to see if the car is in the process of moving for a smoother transition  
    var lefting = false
    var righting = false
    
    init() {
//Creates the car's URL
        guard let carURL = URL(string:"https://codermerlin.com/users/avanish-jeendru/mustang.png") else {
            fatalError("Failed to create URL for Car")
        }
//Makes car the desired image        
        car = Image(sourceURL: carURL)
      
        super.init(name: "Car")
                
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
//Sets up the car image
        canvas.setup(car)
//Sets the starting X-position of the car
        middle = canvasSize.width / 2 - 83
//Calculates where the end of the canvas is
        canvasEnd = canvasSize.height
    }
    
    override func render(canvas:Canvas) {
//Renders the car
        if car.isReady {
            car.renderMode = .destinationRect(Rect(topLeft:Point(x:middle, y:canvasEnd - 280), size:Size(width: 166, height:250)))
            canvas.render(car) 
        }
//If the car is told to move left, move left over the next few frames only if it is not in the leftmost lane
        if mLeft && moved < 22 && distance > -1 && !righting {
            lefting = true
            middle -= 10
            moved += 1
//If the car is in the leftmost lane make sure the car isn't told to move left again
        } else if distance == -1 {
            mLeft = false
        }
//After the car finishes moving, set mLeft to false because it doesn't need to move left anymore
        if moved == 22 && mLeft {
            moved = 0
            distance -= 1
            mLeft = false
            lefting = false
        }
//If the car is told to move right, move right over the next few frames only if it is not in the rightmost lane
        if mRight && moved < 22 && distance < 1 && !lefting {
            righting = true
            middle += 10
            moved += 1
//If the car is in the rightmost lane make sure the car isn't told to move right again
        } else if distance == 1 {
            mRight = false
        }
//After the car finishes moving, set mRight to false because it doesn't need to move right anymore
        if moved == 22 && mRight {
            moved = 0
            distance += 1
            mRight = false
            righting = false
        }
        
    }
}
