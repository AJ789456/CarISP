import Scenes
import Igis
  /*
     This class is responsible for the interaction Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class InteractionLayer : Layer, KeyDownHandler {

    let lines = Lines()
    let car = Car()
    let score = Score()
    let obstacles = Obstacles()
//Speed of everything
    var roadSpeed = 5
//Counts the frames
    var count = 0

    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")
        
        // We insert our RenderableEntities in the constructor
//Inserts everthing onto the screen
        insert(entity: lines, at: .front)
        insert(entity: obstacles, at: .front)
        insert(entity: car, at: .front)
        insert(entity: score, at: .front)
    }
//?
    override func preSetup(canvasSize: Size, canvas: Canvas) {
        dispatcher.registerKeyDownHandler(handler: self)
    }
    
    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }

//Where are the key processing happens
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        //If d is clicked move the car right and let obstacles.swift know
        if key == "d" && roadSpeed != 0 {
            car.mRight = true
            obstacles.mRight = true
        }
        //If a is clicked move the car left and let obstacles.swift know
        if key == "a" && roadSpeed != 0 {
            car.mLeft = true
            obstacles.mLeft = true
        }
//If r is clicked start up the game again
        if key == "r" && roadSpeed == 0 {
            roadSpeed = 4
            if score.score > 9999 {
                score.xPos += 60
            } else if score.score > 999 {
                score.xPos += 40
            } else if score.score > 99 {
                score.xPos += 20
            }
//Reset the score after r is clicked
            score.score = 0
//Put the obstacle back at the top
            obstacles.yPos = 0
        }
        if key == "4" && altKey {
            car.appaMode = !car.appaMode
        }
    }
}
