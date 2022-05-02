import Scenes
import Igis

  /*
     This class is responsible for rendering the background.
   */


class Background : RenderableEntity {

    var grass = Rect(topLeft:Point(x: 0, y: 0), size: Size(width: 0, height: 0))
    let green = FillStyle(color:Color(.lightgreen))

    var road = Rect(topLeft:Point(x: 0, y: 0), size: Size(width: 0, height: 0))
    let gray = FillStyle(color:Color(.gray))
    
    func renderRectangle(canvas: Canvas, rect: Rect, color: Color.Name) {
        let rectangle = Rectangle(rect: rect)
        let fill = FillStyle(color: Color(color))
        canvas.render(fill, rectangle)
    }
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        grass.size = canvasSize
        
        road.topLeft.x = canvasSize.width/2 - 330
        road.size.width = 660
        road.size.height = canvasSize.height
        
    }    
    

    func clearCanvas(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize {
            let canvasRect = Rect(topLeft:Point(), size:canvasSize)
            let canvasClearRectangle = Rectangle(rect:canvasRect, fillMode:.clear)
            canvas.render(canvasClearRectangle)
        }
    }

    override func render(canvas: Canvas) {
        clearCanvas(canvas: canvas)
        let grassRect = Rectangle(rect:grass)
        canvas.render(green, grassRect)
        let roadRect = Rectangle(rect:road)
        canvas.render(gray, roadRect)
    }
}
