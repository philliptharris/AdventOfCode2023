import XCTest
import Foundation

final class Day1: XCTestCase {
    
    func testDay1Part1() throws {
        let sum = try Self.loadInputFile(named: "Day1")
            .map { Self.extractEncodedIntegerViaFirstAndLastNumeralDigits(from: $0) ?? 0 }
            .reduce(0, +)
        print(sum)
    }
    static func extractEncodedIntegerViaFirstAndLastNumeralDigits(from input: String) -> Int? {
        let numbers = input.filter { $0.isNumber }
        guard !numbers.isEmpty else { return nil }
        return Int("\(numbers.first!)\(numbers.last!)")
    }
    
    func testDay1Part2() throws {
        let sum = try Self.loadInputFile(named: "Day1")
            .map { Self.extractEncodedIntegerViaBothSpelledOutDigitsAndNumeralDigits(from: $0) ?? 0 }
            .reduce(0, +)
        print(sum)
    }
    static func extractEncodedIntegerViaBothSpelledOutDigitsAndNumeralDigits(from input: String) -> Int? {
        var remainingInput = input
        var extractedDigits: [String] = []
        while remainingInput.count > 0 {
            var didFindNumber = false
            SpelledOutDigit.allDigits.forEach {
                if remainingInput.hasPrefix($0.spelledOut) {
                    extractedDigits.append($0.numeral)
                    // Note: We'll keep the last character of the spelled-out number in the remainingInput because apparently the author thinks "eighthree" should be parsed as 83!?
                    remainingInput.removeFirst($0.spelledOut.count - 1)
                    didFindNumber = true
                }
            }
            if let firstCharacter = remainingInput.first, firstCharacter.isNumber {
                extractedDigits.append(String(firstCharacter))
                remainingInput.removeFirst()
                didFindNumber = true
            }
            if !didFindNumber {
                remainingInput.removeFirst()
            }
        }
        let twoDigitInteger = Int("\(extractedDigits.first!)\(extractedDigits.last!)")
        print("\(extractedDigits.joined(separator: ".")) from \(input) -> \(twoDigitInteger!)")
        return twoDigitInteger
    }
    
    enum InputFileLoadingError: Error {
        case failedToGenerateStringFromFileData
    }
    static func loadInputFile(named name: String) throws -> [String] {
        let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appending(component: "Input/\(name).txt")
        let data = try Data(contentsOf: url)
        guard let contents = String(data: data, encoding: .utf8) else { throw InputFileLoadingError.failedToGenerateStringFromFileData }
        let lines = contents.split(whereSeparator: \.isNewline)
        return lines.map { String($0) }
    }
    
    struct SpelledOutDigit {
        let spelledOut: String
        let numeral: String
        static let allDigits: [SpelledOutDigit] = {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "en-US")
            formatter.numberStyle = .spellOut
            return (1...9).map { SpelledOutDigit(spelledOut: formatter.string(from: NSNumber(integerLiteral: $0))!, numeral: String($0)) }
        }()
    }
}
