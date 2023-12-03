import Foundation

class Utilities {
    
    private init() {}
    
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
}
