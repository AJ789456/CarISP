import Igis
import Scenes

class Score: RenderableEntity {

    var score = 0
    var xPos = 0
    var adjust = false
    var count = 0
    let obstacles = Obstacles()

    func renderText(canvas: Canvas, x: Int, y: Int, text: String){
        let Text = Text(location: Point(x: x, y: y), text: text)
        Text.font = "30pt Arial"
        canvas.render(Text)
    }
    
    init() {
        super.init(name: "Score")
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        xPos = canvasSize.width - 55
    }
    
    override func render(canvas:Canvas) {
        if score > 99 && score < 1000 && !adjust {
            xPos -= 20
            adjust = true
        }
        if score > 999 && score < 10000 && adjust {
            xPos -= 20
            adjust = false
        }
        if score > 9999 && !adjust {
            xPos -= 20
            adjust = true
        }
        renderText(canvas: canvas, x: xPos, y: 40, text: String(score))
        count += 1
        guard let layer = layer as? InteractionLayer else {
            fatalError("InteractionLayer required")
        }
        if count % 2 == 0 && layer.roadSpeed != 0 {
            score += 1
        }
    }
}
