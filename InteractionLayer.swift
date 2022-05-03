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
    var roadSpeed = 4
    var count = 0

    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")
        
        // We insert our RenderableEntities in the constructor
        insert(entity: lines, at: .front)
        insert(entity: score, at: .front)
        insert(entity: obstacles, at: .front)
        insert(entity: car, at: .front)

    }

    override func preSetup(canvasSize: Size, canvas: Canvas) {
        dispatcher.registerKeyDownHandler(handler: self)
    }
    
    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }


    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        if key == "d" && roadSpeed != 0 {
            car.mRight = true
            obstacles.mRight = true
        }
        if key == "a" && roadSpeed != 0 {
            car.mLeft = true
            obstacles.mLeft = true
        }
    }
}
