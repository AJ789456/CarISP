import Scenes
import Igis
import Foundation

  /*
     This class is responsible for rendering the background.
   */


class Background : RenderableEntity {
//Creates a rect for the "grass" portion
    var grass = Rect(topLeft:Point(x: 0, y: 0), size: Size(width: 0, height: 0))
//The color green
    let green = FillStyle(color:Color(.lightgreen))
//Creates a rect for the "road" portion
    var road = Rect(topLeft:Point(x: 0, y: 0), size: Size(width: 660, height: 0))
//The color gray
    let gray = FillStyle(color:Color(.gray))
    
    let crab: Audio
    var isPlaying = false
//Function to render a rectangle
    func renderRectangle(canvas: Canvas, rect: Rect, color: Color.Name) {
        let rectangle = Rectangle(rect: rect)
        let fill = FillStyle(color: Color(color))
        canvas.render(fill, rectangle)
    }
    
    init() {
        // Using a meaningful name can be helpful for debugging
        guard let crabURL = URL(string:"https://codermerlin.com/users/avanish-jeendru/CrabRave.mp3") else {
            fatalError("Failed to create URL for Crab Rave")
        }

        crab = Audio(sourceURL: crabURL, shouldLoop: true)
        super.init(name:"Background")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
//Size of the grass rect is entire canvas
        grass.size = canvasSize
//The road's x-position is in the middle        
        road.topLeft.x = canvasSize.width/2 - 330
//The road is as tall as the canvas
        road.size.height = canvasSize.height
        canvas.setup(crab)
    }    
    
//Function to clear the canvas so that frames to not overlap
    func clearCanvas(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize {
            let canvasRect = Rect(topLeft:Point(), size:canvasSize)
            let canvasClearRectangle = Rectangle(rect:canvasRect, fillMode:.clear)
            canvas.render(canvasClearRectangle)
        }
    }

    override func render(canvas: Canvas) {
//Clears the canvas
        clearCanvas(canvas: canvas)
//Render the grass rect as green and the road rect as gray
        let grassRect = Rectangle(rect:grass)
        canvas.render(green, grassRect)
        let roadRect = Rectangle(rect:road)
        canvas.render(gray, roadRect)

        if !isPlaying && crab.isReady {
            canvas.render(crab)
            isPlaying = true
        }
    }
}
