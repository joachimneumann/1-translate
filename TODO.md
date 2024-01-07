- Russian
- Ukrainian
- Thai trennung, 1e5
- Vietnamese: compact?
- public repository with Tests

Tests base on text files:
https://medium.com/bleeding-edge/writing-better-unit-tests-in-swift-part-one-e4a06fbc682b
https://medium.com/bleeding-edge/writing-better-unit-tests-in-swift-part-two-d19b69f3d794

protocol LanguageProtocol {
    func read_1_9()
    var zero: String?
}
typealias Language = LanguageBaseClass & LanguageProtocol

babylonian add zero as option

Delete old compiler warnings:
rm -rf ~/Library/Developer/Xcode/DerivedData
