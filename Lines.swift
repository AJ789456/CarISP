import Igis
import Scenes

class Lines: RenderableEntity {

    var line0 = Rect(topLeft:Point(x: 0, y: -140), size:Size(width: 20, height: 100))
    var line1 = Rect(topLeft:Point(x: 0, y: 10), size:Size(width: 20, height: 100))
    var line2 = Rect(topLeft:Point(x: 0, y: 160), size:Size(width: 20, height: 100))
    var line3 = Rect(topLeft:Point(x: 0, y: 310), size:Size(width: 20, height: 100))
    var line4 = Rect(topLeft:Point(x: 0, y: 460), size:Size(width: 20, height: 100))
    var line5 = Rect(topLeft:Point(x: 0, y: 610), size:Size(width: 20, height: 100))
    var line6 = Rect(topLeft:Point(x: 0, y: 760), size:Size(width: 20, height: 100))
    var line0a = Rect(topLeft:Point(x: 0, y: -140), size:Size(width: 20, height: 100))
    var line1a = Rect(topLeft:Point(x: 0, y: 10), size:Size(width: 20, height: 100))
    var line2a = Rect(topLeft:Point(x: 0, y: 160), size:Size(width: 20, height: 100))
    var line3a = Rect(topLeft:Point(x: 0, y: 310), size:Size(width: 20, height: 100))
    var line4a = Rect(topLeft:Point(x: 0, y: 460), size:Size(width: 20, height: 100))
    var line5a = Rect(topLeft:Point(x: 0, y: 610), size:Size(width: 20, height: 100))
    var line6a = Rect(topLeft:Point(x: 0, y: 760), size:Size(width: 20, height: 100))
    var canvasEnd = 0
    var num = 0
    var speed = 4    
    var pause = false

 //   func stopper() {
 //       pause = true
 //       print(pause)
 //   }
    
    init() {
        super.init(name: "Lines")
    }
    
    override func setup(canvasSize: Size, canvas: Canvas) {
        line0.topLeft.x = canvasSize.width / 2 - 120
        line1.topLeft.x = canvasSize.width / 2 - 120
        line2.topLeft.x = canvasSize.width / 2 - 120
        line3.topLeft.x = canvasSize.width / 2 - 120
        line4.topLeft.x = canvasSize.width / 2 - 120
        line5.topLeft.x = canvasSize.width / 2 - 120
        line6.topLeft.x = canvasSize.width / 2 - 120
        line0a.topLeft.x = canvasSize.width / 2 + 100
        line1a.topLeft.x = canvasSize.width / 2 + 100
        line2a.topLeft.x = canvasSize.width / 2 + 100
        line3a.topLeft.x = canvasSize.width / 2 + 100
        line4a.topLeft.x = canvasSize.width / 2 + 100
        line5a.topLeft.x = canvasSize.width / 2 + 100
        line6a.topLeft.x = canvasSize.width / 2 + 100
        canvasEnd = canvasSize.height
    }
        
    override func render(canvas:Canvas) {
        let line0Rect = Rectangle(rect: line0)
        let line1Rect = Rectangle(rect: line1)
        let line2Rect = Rectangle(rect: line2)
        let line3Rect = Rectangle(rect: line3)
        let line4Rect = Rectangle(rect: line4)
        let line5Rect = Rectangle(rect: line5)
        let line6Rect = Rectangle(rect: line6)
        let line0aRect = Rectangle(rect: line0a)
        let line1aRect = Rectangle(rect: line1a)
        let line2aRect = Rectangle(rect: line2a)
        let line3aRect = Rectangle(rect: line3a)
        let line4aRect = Rectangle(rect: line4a)
        let line5aRect = Rectangle(rect: line5a)
        let line6aRect = Rectangle(rect: line6a)
        let white = FillStyle(color: Color(.white))
        canvas.render(white, line0Rect, line1Rect, line2Rect, line3Rect, line4Rect, line5Rect, line6Rect, line0aRect, line1aRect, line2aRect, line3aRect, line4aRect, line5aRect, line6aRect)
        print("dis is in da line \(pause)")
        if pause == false {
            line0.topLeft.y += speed
            line1.topLeft.y += speed
            line2.topLeft.y += speed
            line3.topLeft.y += speed
            line4.topLeft.y += speed
            line5.topLeft.y += speed
            line6.topLeft.y += speed
            line0a.topLeft.y += speed
            line1a.topLeft.y += speed
            line2a.topLeft.y += speed
            line3a.topLeft.y += speed
            line4a.topLeft.y += speed
            line5a.topLeft.y += speed
            line6a.topLeft.y += speed
        }
        if line6.topLeft.y > canvasEnd {
            line6.topLeft.y = line0.topLeft.y - 150
        }
        if line5.topLeft.y > canvasEnd {
            line5.topLeft.y = line6.topLeft.y - 150
        }
        if line4.topLeft.y > canvasEnd {
            line4.topLeft.y = line5.topLeft.y - 150
        }
        if line3.topLeft.y > canvasEnd {
            line3.topLeft.y = line4.topLeft.y - 150
        }
        if line2.topLeft.y > canvasEnd {
            line2.topLeft.y = line3.topLeft.y - 150
        }
        if line1.topLeft.y > canvasEnd {
            line1.topLeft.y = line2.topLeft.y - 150
        }
        if line0.topLeft.y > canvasEnd {
            line0.topLeft.y = line1.topLeft.y - 150
        }
        if line6a.topLeft.y > canvasEnd {
            line6a.topLeft.y = line0a.topLeft.y - 150
        }
        if line5a.topLeft.y > canvasEnd {
            line5a.topLeft.y = line6a.topLeft.y - 150
        }
        if line4a.topLeft.y > canvasEnd {
            line4a.topLeft.y = line5a.topLeft.y - 150
        }
        if line3a.topLeft.y > canvasEnd {
            line3a.topLeft.y = line4a.topLeft.y - 150
        }
        if line2a.topLeft.y > canvasEnd {
            line2a.topLeft.y = line3a.topLeft.y - 150
        }
        if line1a.topLeft.y > canvasEnd {
            line1a.topLeft.y = line2a.topLeft.y - 150
        }
        if line0a.topLeft.y > canvasEnd {
            line0a.topLeft.y = line1a.topLeft.y - 150
        }
        if num % 200 == 0 && speed < 15 && !(speed == 0) {
            speed += 1
        }
        num += 1
    }
}
