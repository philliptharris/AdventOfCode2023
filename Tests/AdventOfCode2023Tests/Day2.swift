import XCTest

final class Day2: XCTestCase {
    func testPart1() throws {
        let lines = try Utilities.loadInputFile(named: "Day2")
        let games = lines.map { Game(input: $0) }
        let possibleGames = games.filter { $0.maxCubeSet.r <= 12 && $0.maxCubeSet.g <= 13 && $0.maxCubeSet.b <= 14 }
        let idsOfPossibleGames = possibleGames.map { $0.id }
        let sumOfIdsOfPossibleGames = idsOfPossibleGames.reduce(0, +)
        print(sumOfIdsOfPossibleGames)
    }
    func testPart2() throws {
        let answer: Int = try Utilities.loadInputFile(named: "Day2")
            .map { Game(input: $0).maxCubeSet.power }
            .reduce(0, +)
        print(answer)
    }
    struct Game {
        let id: Int
        let sets: [CubeSet]
        let maxCubeSet: CubeSet
        init(input: String) {
            let gameAndSets = input.split(separator: ": ")
            let game = gameAndSets[0]
            let setsInput = gameAndSets[1]
            self.id = Int(game.split(separator: " ")[1])!
            self.sets = setsInput.split(separator: "; ").map { CubeSet(input: String($0)) }
            self.maxCubeSet = CubeSet(r: sets.map { $0.r }.max()!, g: sets.map { $0.g }.max()!, b: sets.map { $0.b }.max()!)
        }
        struct CubeSet {
            let r: Int
            let g: Int
            let b: Int
            var power: Int { r * g * b }
            init(r: Int, g: Int, b: Int) {
                self.r = r
                self.g = g
                self.b = b
            }
            init(input: String) {
                var r = 0, g = 0, b = 0
                input
                    .split(separator: ", ")
                    .map {
                        let countAndColor = $0.split(separator: " ")
                        return (Int(countAndColor[0])!, String(countAndColor[1]))
                    }
                    .forEach {
                        switch $0.1 {
                        case "red":   r += $0.0
                        case "green": g += $0.0
                        case "blue":  b += $0.0
                        default: fatalError()
                        }
                    }
                self.r = r
                self.g = g
                self.b = b
            }
        }
    }
}
