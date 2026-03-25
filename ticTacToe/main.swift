import Darwin

let symbol = (
    default: " ",
    symbolOne: "X",
    symbolTwo: "O"
)

var playField = [[String]]()

print(
    """
    Welcome to TicTacToe!
    ---------------------
    """)

while true {
    
    let nameOne = getUserNickName("Input player 1 nickname")
    
    let playerOne = (name: nameOne, sign: symbol.symbolOne)
    
    let nameTwo = getUserNickName("Input player 2 nickname")
    
    let playerTwo = (name: nameTwo, sign: symbol.symbolTwo)
    
    let playFieldSize = getFieldSize()
    
    playField = createPlayField(playFieldSize)
    
    printPlayField()
    
    print(
        """
        Let's play begines!
        -------------------
        """)
    
    while true {
        makeStep(playerOne)
        printPlayField()
        if isWin() {
            print("\(playerOne.name) is a WINNER")
            break
        }
        if isGameFinished() {
            print("The game is over")
            break
        }
        makeStep(playerTwo)
        printPlayField()
        if isWin() {
            print("\(playerOne.name) is a WINNER")
            break
        }
        if isGameFinished() {
            print("The game is over")
            break
        }
    }
    
    let newGameChoose = getUserInput("For new game input 'y'")
    guard newGameChoose == "y" else {
        exit(0)
    }
    print("---------------------")
    continue
}



func makeStep(_ player: (name: String, sign: String)) {
    print("\(player.name), your turn!")
    var lineIndex: Int
    var columnIndex: Int
    
    while true {
        lineIndex = getIndex("Enter line number")
        columnIndex = getIndex("Enter column number")
        
        guard playField[lineIndex][columnIndex] == symbol.default else {
            print("This cell alredy filled. Choose another.")
            continue
        }
        break
    }
    
    playField[lineIndex][columnIndex] = player.sign
}

func getIndex(_ description: String) -> Int {
    while true {
        let coordinate = getUserInput(description)
        guard let c = Int(coordinate), c > 0, c <= playField.count
        else {
            print("Number should be from 1 to \(playField.count)")
            continue
        }
        return c - 1
    }
}

func createPlayField(_ size: Int) -> [[String]] {
    var playField: [[String]] = []
    for _ in 0..<size {
        var line: [String] = []
        for _ in 0..<size {
            line.append(symbol.default)
        }
        playField.append(line)
    }
    return playField
}

func printPlayField() {
    print("Now the playfield is like that: ")
    for i in 0...(playField.count * 2  + 1) {
        let isEvenLine = i % 2 == 0 ? true : false
        for j in 0...(playField.count * 2 + 1) {
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

func getUserInput(_ description: String? = nil) -> String {
    if let description {
        print(description)
    }
    return readLine() ?? ""
}

func getUserNickName(_ description: String) -> String {
    var name = String()
    while name.isEmpty {
        name = getUserInput(description)
        guard !name.isEmpty else {
            print("Nickname can not be empty")
            continue
        }
    }
    return name
}

func getFieldSize() -> Int {
    while true {
        let minSize = 2
        let maxSize = 6
        let size = getUserInput("Enter playfield size in \(minSize) and \(maxSize):")
        guard let size = Int(size), size >= minSize && size <= maxSize
        else {
            print("Size is incorrect. Try again.")
            continue
        }
        return size
    }
}

func isGameFinished() -> Bool {
    for i in 0..<playField.count {
        for j in 0..<playField.count {
            if playField[i][j] == symbol.default {
                return false
            }
        }
    }
    return true
}

func isWinOnRow() -> Bool {
    for i in 0..<playField.count {
        let firstSymbol = playField[i][0]
        if firstSymbol != symbol.default {
            for j in 1..<playField.count {
                if playField[i][j] != firstSymbol {
                    return false
                }
            }
            return true
        }
    }
    return false
}

func isWinOnColumn() -> Bool {
    for i in 0..<playField.count {
        let firstSymbol = playField[i][0]
        if firstSymbol != symbol.default {
            for j in 1..<playField.count {
                if playField[j][i] != firstSymbol {
                    return false
                }
            }
            return true
        }
    }
    return false
}

func isWinOnMainDiagonal() -> Bool {
    let firstSymbol = playField[0][0]
    if firstSymbol != symbol.default {
        for i in 1..<playField.count {
            if playField[i][i] != firstSymbol {
                return false
            }
        }
        return true
    }
    return false
}

func isWinOnSubDiagonal() -> Bool {
    let firstSymbol = playField[0][playField.count - 1]
    if firstSymbol != symbol.default {
        for i in 1..<playField.count {
            if playField[i][playField.count - i - 1] != firstSymbol {
                return false
            }
        }
        return true
    }
    return false
}

func isWin() -> Bool {
    return isWinOnRow()
    || isWinOnColumn()
    || isWinOnMainDiagonal()
    || isWinOnSubDiagonal()
}


 

