import Igis
import Scenes
import Foundation

class Obstacles: RenderableEntity {
//Images of the obstacles
    let cat: Image
    let granny: Image
    let cone: Image
//Randomizes which obstacle appears
    var when = 1
//X-value of the 3 different lanes
    var middleL = 0
    var leftL = 0
    var rightL = 0
//Y-position of the obstacles
    var yPos = 0
//Variable for the bottom of the canvas
    var canvasEnd = 0
//Next 7 variables are from Car.swift to find out where the car is
    var middle = 0
    var mRight = false
    var mLeft = false
    var moved = 0
    var lefting = false
    var righting = false
    var distance = 0
//Randomizes where the obstacles
    var index = 0
    var list = [Int]()
//Bounding rects for hit detection
    var carBoundingRect = Rect(topLeft: Point(x: 0, y: 0), size: Size(width: 0, height: 0))
    var catBoundingRect = Rect(topLeft: Point(x: 0, y: 0), size: Size(width: 0, height: 0))
    var coneBoundingRect = Rect(topLeft: Point(x: 0, y: 0), size: Size(width: 0, height: 0))
    var grannyBoundingRect = Rect(topLeft: Point(x: 0, y: 0), size: Size(width: 0, height: 0))
    
    init() {
//Creates all the image URLs and images
        guard let catURL = URL(string: "https://codermerlin.com/users/avanish-jeendru/cat.png") else {
            fatalError("Failed to create URL for cat")
        }
        cat = Image(sourceURL: catURL)

        guard let grannyURL = URL(string: "https://codermerlin.com/users/avanish-jeendru/granny.png") else {
            fatalError("Failed to create URL for granny")
        }
        granny = Image(sourceURL: grannyURL)

        guard let coneURL = URL(string: "https://codermerlin.com/users/avanish-jeendru/cone.png") else {
            fatalError("Failed to create URL for cone")
        }
        cone = Image(sourceURL: coneURL)

        super.init(name: "Obstacles")
                
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
//Determines the x-position of the 3 lanes
        middleL = canvasSize.center.x
        leftL = canvasSize.center.x - 220
        rightL = canvasSize.center.x + 220
//Calculates where the end of the canvas is
        canvasEnd = canvasSize.height
//Creates a list with the 3 lanes as the options
        list = [middleL, leftL, rightL]
//Sets the car position in the middle of the canvas
        middle = canvasSize.width / 2 - 83
//Sets up the images
        canvas.setup(cat, granny, cone)
    }
   
    override func render(canvas:Canvas) {
//Refer to comments in the Car.swift
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

        if mRight && moved < 22 && distance < 1 && !lefting{
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
//Correctly creates the bounding rects where they are supposed to be
        catBoundingRect = Rect(topLeft: Point(x: list[index] - 50, y: yPos-80), size: Size(width:100, height: 50))
        grannyBoundingRect = Rect(topLeft: Point(x: list[index]-50, y: yPos-125), size: Size(width:100, height: 110))
        coneBoundingRect = Rect(topLeft: Point(x: list[index]-22, y: yPos-60), size: Size(width:40, height: 40))
        carBoundingRect = Rect(topLeft: Point(x: middle+15, y: canvasEnd-280), size : Size(width: 136, height: 250))
//        canvas.render(Rectangle(rect: carBoundingRect))
//Renders the cat
        if cat.isReady && when == 1 {
            cat.renderMode = .destinationRect(Rect(topLeft:Point(x:list[index]-50, y:yPos-100), size:Size(width: 100, height:100)))
//            canvas.render(Rectangle(rect: catBoundingRect))
            canvas.render(cat)
        }
//Renders the granny       
        if granny.isReady && when == 2 {
            granny.renderMode = .destinationRect(Rect(topLeft:Point(x:list[index]-70, y:yPos-150), size:Size(width: 150, height:150)))
//            canvas.render(Rectangle(rect: grannyBoundingRect))
            canvas.render(granny)
            
        }
//Renders the cone        
        if cone.isReady && when == 3 {
            cone.renderMode = .destinationRect(Rect(topLeft:Point(x:list[index]-50, y:yPos-100), size:Size(width: 100, height:100)))
//            canvas.render(Rectangle(rect: coneBoundingRect))
            canvas.render(cone)
            
        }
        
    }
    override func calculate(canvasSize: Size) {
//Creates "containment zones" for the obstacles
        let containmentCat = catBoundingRect.containment(target: carBoundingRect)
        let containmentGranny = grannyBoundingRect.containment(target: carBoundingRect)
        let containmentCone = coneBoundingRect.containment(target: carBoundingRect)
//Allows us to access the speed from Interactionlayer        
        guard let layer = layer as? InteractionLayer else {
            fatalError("InteractionLayer required")
        }
//If the the car touches any of the obstacles turn the speed to zero
        if layer.roadSpeed != 0 {
            if !containmentCat.intersection([.contact]).isEmpty && when == 1{
                layer.roadSpeed = 0          
            }
            
            if !containmentGranny.intersection([.contact]).isEmpty && when == 2{
                layer.roadSpeed = 0
            }
            
            if !containmentCone.intersection([.contact]).isEmpty && when == 3{
                layer.roadSpeed = 0
            }
        }

//If the obstacles' y-position passes the end of the canvas, reset them to the top
        if yPos > canvasEnd+50 {
            yPos = 0
//Randomizes the image
            when = Int.random(in: 1 ... 3)
//Randomizes the lane
            index = Int.random(in: 0 ... 2)
        } else {
//Move the obstacle down the canvas
            yPos += layer.roadSpeed
        }
    }
}

