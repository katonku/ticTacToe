import Darwin

//print("Player 1 nickname is:")
//let nameOne = readLine()
//guard let nameOne else {
//    print("Nickname can not be empty")
//    exit(0)
//}
//
//print("Player 2 nickname is:")
//let nameTwo = readLine()
//guard let nameTwo else {
//    print("Nickname can not be empty")
//    exit(0)
//}

print("Play-field size is:")
let size = readLine() ?? ""
guard let size = Int(size), size < 11 else {
    print("Size is incorrect. It should be number under 6")
    exit(0)
}

var playField = createPlayField(size)
playField[0][1] = "x"
printPlayField(playField)

func createPlayField(_ size: Int) -> [[String]] {
    var playField: [[String]] = []
    for _ in 0..<size {
        var line: [String] = []
        for _ in 0..<size {
            line.append(" ")
        }
        playField.append(line)
    }
    return playField
}

func printPlayField(_ pf: [[String]]) {
    print("The playfield is like that: ")
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
                    print(pf[lineArrayIndex][rowArrayIndex], terminator: "")
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




 

