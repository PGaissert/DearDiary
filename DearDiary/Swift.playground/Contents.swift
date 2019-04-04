import UIKit

//: Hello World
// My first Swift program
print("Hello World!")

//: Variables and constants
var myVariable = 42
myVariable = 50
let myConstant = 43

//: Implicit and explicit type declaration
let implicitBool = true
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70

//: No implicit type conversion
let label = "The width is "
let width = 94
let widthLabel = label + String(width)

//: String interpolation
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

//: Equality
let shirt = String("Doesn't matter.")
let pants = String("Doesn't matter.")
shirt == pants

//: Array basics
var things: [String] = ["catfish", "water", "tulips", "blue paint"]
things.removeLast()
things.count
things[1] = "bottle of water"
things

//: Dictionary basics
var occupations: [String : String] = ["Malcolm" : "Captain",
                                      "Kaylee" : "Mechanic"]
occupations["Jayne"] = "Public Relations"

//: Foreach loop
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0

for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}

teamScore

//: Foreach with range
var firstForLoop = 0

for i in 0..<4 {
    firstForLoop += i
}

firstForLoop

//: Class declaration und instance methods
class Shape {
    var numberOfSides = 0

    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

//: Class instantiation und method call
let shape = Shape()
shape.numberOfSides = 7
let shapeDescription = shape.simpleDescription()

//: External parameter names
class Counter {
    var count: Int = 0

    func incrementBy(_ amount: Int, numberOfTimes times: Int) {
        count += amount * times
    }
}

let counter = Counter()
counter.incrementBy(2, numberOfTimes: 7)

//: Initializer
class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
        self.name = name
    }

    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

//: Stored Property (*sideLength*) and Computed Property (*perimeter*)
class EquilateralTriangle {
    // Stored Property
    var sideLength: Double

    // Computed Property
    var perimeter: Double {
        get {
            return 3 * sideLength
        }
        set {
            sideLength = newValue / 3
        }
    }

    init(sideLength: Double) {
        self.sideLength = sideLength
    }
}

var triangle = EquilateralTriangle(sideLength: 3.1)
triangle.perimeter
triangle.perimeter = 9.9
triangle.sideLength

//: Enum declaration
enum Suit {
    case spades
    case hearts
    case diamonds
    case clubs
}
let hearts = Suit.hearts

//: Optional Type. Can be nil, which means the absence of a value.
var optionalString: String? = "Hello"
optionalString = nil

//: Non-Optional Type. Can never be nil, always has a value. Compile time error when assigning *nil*.
var nonOptionalString: String = "Goodbye"

//: Working with Optionals
var optionalName: String? = "John Appleseed"

//: Optional Binding with *if let*. "Unwraps" the Optional and assigns the value to a new constant. If *optionalName* is *nil* the else branch is executed.
if let name = optionalName {
    print("optionalName is NOT nil. It's \(name)")
} else {
    print("optionalName is nil")
}

//: Optional Chaining
//:
//: ----
//:
//: If *optionalName* is *nil*, uppercased() will not be called, instead *nil* is returned. Return value always has optional type *String?*.
let optionalResult = optionalName?.uppercased()

//: Forced Unwrapping
//:
//: ----
//:
//: Runtime crash if *optionalName* is *nil*. Return value has non-optional type *String*.
let nonOptionalResult = optionalName!.uppercased()

//: Pyramid of doom
func pyramidOfDoomSubmit(name: String?, address: String?, phone: String?) {
    if let name = name {
        if let address = address {
            if let phone = phone {
                let message = "\(name)\n\(address)\n\(phone)"
                print(message)

                // Send to server
            } else {
                print("No phone to submit")
            }
        } else {
            print("No address to submit")
        }
    } else {
        print("No name to submit")
    }
}

//: guard
func submit(name: String?, address: String?, phone: String?) {
    guard let name = name else {
        print("No name to submit")
        return
    }

    guard let address = address else {
        print("No address to submit")
        return
    }

    guard let phone = phone else {
        print("No phone to submit")
        return
    }

    let message = "\(name)\n\(address)\n\(phone)"
    print(message)

    // Send to server
}

//: Protocols
//: - Protocols can inherit from other protocols
protocol Drinkable {
    func drink()
}

//: Conforming to a protocol
class Beer: Drinkable {
    private enum State {
        case full
        case empty
    }

    private var state: State = .full

    // MARK: - Drinkable

    func drink() {
        state = .empty
    }
}

let augustiner = Beer()
augustiner.drink()

//: Generics also works with protocols. Compiler error while trying to add *bp* to *drinkableArray*.
var drinkableStuff = [Drinkable]()

drinkableStuff.append(augustiner)

class Gasoline {}
let bp = Gasoline()

//: Closures as completion handlers for asynchronous tasks
func reallyLongOperation(completionHandler: @escaping () -> Void) {
    // Do work that takes some time
    completionHandler()
}

reallyLongOperation(completionHandler: {
    print("Done")
})

//: Trailing Closure
reallyLongOperation {
    print("Done, too")
}
