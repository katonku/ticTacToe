import Darwin

print(
    """
    Welcome to TicTacToe!
    ---------------------
    """)

var nameOne: String = ""
while nameOne == "" {
    print("Player 1 nickname is:")
    nameOne = getUserInput()
    guard nameOne != "" else {
        print("Nickname can not be empty")
        continue
    }
}

let playerOne = (name: nameOne, sign: "X")

var nameTwo: String = ""
while nameTwo == "" {
    print("Player 2 nickname is:")
    nameTwo = getUserInput()
    guard nameTwo != "" else {
        print("Nickname can not be empty")
        continue
    }
}

let playerTwo = (name: nameTwo, sign: "O")

let minSize = 2
let maxSize = 6
var size: Int = 0
let cellDefaultValue = " "
while size > maxSize || size < minSize {
    print("Enter playfield size in \(minSize) and \(maxSize):")
    let potentialSize = getUserInput()
    guard let potentialSize = Int(potentialSize),
          potentialSize > minSize && potentialSize < maxSize else {
        print("Size is incorrect")
        continue
    }
    size = potentialSize
    break
}

var playField = createPlayField(size)
printPlayField()
print(
    """
    Let's play begines!
    -------------------
    """)

while true {
    makeTurn(playerOne)
    makeTurn(playerTwo)
}

func makeTurn(_ player: (name: String, sign: String)) {
    print("\(player.name), your turn!")
    var lineIndex: Int = 0
    var columnIndex: Int = 0
    
    while true {
        print("Enter line number:")
        let l = getPlayFieldIndex()
        
        print("Enter column number:")
        let c = getPlayFieldIndex()
        
        guard playField[l][c] == cellDefaultValue else {
            print("This cell alredy filled. Coose another.")
            continue
        }
        lineIndex = l
        columnIndex = c
        break
    }
    
    playField[lineIndex][columnIndex] = player.sign
    printPlayField()
}

func getPlayFieldIndex() -> Int {
    var index: Int = 0
    
    while true {
        let coordinate = getUserInput()
        guard let coordinate = Int(coordinate),
              coordinate > 0,
              coordinate <= playField.count else {
            print("Number should be from 1 to \(playField.count)")
            continue
        }
        index = coordinate - 1
        break
    }
    
    return index
}

func createPlayField(_ size: Int) -> [[String]] {
    var playField: [[String]] = []
    for _ in 0..<size {
        var line: [String] = []
        for _ in 0..<size {
            line.append(cellDefaultValue)
        }
        playField.append(line)
    }
    return playField
}

func printPlayField() {
    print("Now the playfield is like that: ")
    for i in 0...(size * 2  + 1) {
        let isEvenLine = i % 2 == 0 ? true : false
        for j in 0...(size * 2 + 1) {
            let isEvenElement = j % 2 == 0 ? true : false
            let havePrintRowNumber = i == 0 && isEvenElement
            let havePrintLineNumber = j == 0 && i > 0 && isEvenLine
            let lineArrayIndex = i / 2 - 1
            let rowArrayIndex = j / 2 - 1
            if isEvenLine {
                if havePrintRowNumber {
                    print(j / 2, terminator: "")
                } else if havePrintLineNumber {
                    print(i / 2, terminator: "")
                } else if isEvenElement {
                    print(playField[lineArrayIndex][rowArrayIndex], terminator: "")
                } else {
                    print("|", terminator: "")
                }
            } else {
                print("-", terminator: "")
            }
        }
        print("\n", terminator: "")
    }
}

func getUserInput() -> String {
    return readLine() ?? ""
}




 

