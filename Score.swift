import Igis
import Scenes
import Foundation

class Score: RenderableEntity {

//The score
    var score = 0
//The x-position for the score
    var xPos = 0
//The frame count
    var count = 0
//The x-position of the center of the canvas
    var middleX = 0
//The color black
    let black = FillStyle(color: Color(.black))
//The y-position of the center of the canvas
    var middleY = 0
//Tracks the high score
    var highScore = 0
    let logo: Image
    let obstacles = Obstacles()

//Function to render white text
    func renderText(canvas: Canvas, x: Int, y: Int, text: String){
        let Text = Text(location: Point(x: x, y: y), text: text)
        Text.font = "30pt Arial"
        let white = FillStyle(color: Color(.white))
        canvas.render(white, Text)
    }
    
    init() {
        guard let logoURL = URL(string:"https://codermerlin.com/users/avanish-jeendru/logo.png") else {
            fatalError("Failed to create URL for logo")
        }
        
        logo = Image(sourceURL: logoURL)

        super.init(name: "Score")
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
//Setups the three variables correctly
        xPos = canvasSize.width - 55
        middleX = canvasSize.center.x
        middleY = canvasSize.center.y
        canvas.setup(logo)
    }
    
    override func render(canvas:Canvas) {
//Used to adjust x-position of the score when the number grows
        if score == 100 {
            xPos -= 10
        }
        if score == 1000 {
            xPos -= 10
        }
        if score == 10000 {
            xPos -= 10
        }
//Renders the score and high score, if applicable
        renderText(canvas: canvas, x: xPos, y: 40, text: String(score))
        if highScore > 0 {
            renderText(canvas:canvas, x: 5, y: 40, text: "HI: \(highScore)")
        }
//Increases frame count
        count += 1
//Allows us access the road speed
        guard let layer = layer as? InteractionLayer else {
            fatalError("InteractionLayer required")
        }
//Every 200 frames, add one point
        if count % 2 == 0 && layer.roadSpeed != 0 {
            score += 1
        }
//After the player loses, render the "Game Over!" box
        if layer.roadSpeed == 0 && score != 0 {
            canvas.render(black, Rectangle(rect: Rect(topLeft: Point(x: middleX-250, y: middleY-250), size: Size(width: 500, height: 490)), fillMode: .fill))
            if logo.isReady {
                logo.renderMode = .destinationRect(Rect(topLeft:Point(x:middleX-228, y: middleY - 240), size:Size(width: 455, height: 260)))
            canvas.render(logo) 
            }
            renderText(canvas: canvas, x: middleX-105, y:middleY+60, text: "Game Over!")
            renderText(canvas: canvas, x: xPos-middleX-145, y:middleY+110, text: "Your final score was \(score)")
            renderText(canvas: canvas, x: middleX-240, y:middleY+160, text: "Press r twice to play again")
//If the current score is higher than the highscore, change the highscore
            if score > highScore {
                highScore = score
            }
        }
    }
}
