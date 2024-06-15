import XCTest
@testable import PinyinParse

final class PinyinParseTests: XCTestCase {
    let firstToneWords = [
        ("mā", "ma"),
        ("bā", "ba"),
        ("gāo", "gao"),
        ("dā", "da"),
        ("hāo", "hao"),
    ]
    let secondToneWords = [
        ("má", "ma"),
        ("máa", "maa"),
        ("zhá", "zha"),
        ("wén", "wen"),
        ("ké", "ke")
    ]
    let thirdToneWords = [
        ("mǎ", "ma"),
        ("xiǎn", "xian"),
        ("jiǎn", "jian"),
        ("wǎng", "wang"),
        ("gǔo", "guo")
    ]
    let fourthToneWords = [
        ("mà", "ma"),
        ("wò", "wo"),
        ("shì", "shi"),
        ("zài", "zai"),
        ("kàn", "kan")
    ]
    let neutralToneWords = [
        ("le", "le"),
        ("de", "de"),
        ("ma", "ma"),
        ("ne", "ne"),
        ("a", "a")
    ]
    let neutralToneWordsDotBefore = [
        ("·ma", "ma")
    ]
    
    func testFirstToneWords()   throws  { testWords(firstToneWords, tone: .first) }
    func testSecondToneWords()  throws  { testWords(secondToneWords, tone: .second) }
    func testThirdToneWords()   throws  { testWords(thirdToneWords, tone: .third) }
    func testFourthToneWords()  throws  { testWords(fourthToneWords, tone: .fourth) }
    func testNeutralToneWords() throws  { testWords(neutralToneWords, tone: .neutral) }
    
    func testWords(_ pairs: [(String, String)], tone: Pinyin.ToneMark) {
        pairs.forEach { pair in
            let pinyin = Pinyin(diacriticForm: pair.0)
            assert(pinyin.diacriticForm == pair.0)
            assert(pinyin.baseString == pair.1)
            assert(pinyin.tone == tone)
            assert(pinyin.ipaForm == "\(pair.1)\(tone.numericValue)")
        }
    }
    
    func testWordWithUmlautSameLetter() throws {
        let pinyin = Pinyin(diacriticForm: "nǚ")
        assert(pinyin.diacriticForm == "nǚ")
        assert(pinyin.baseString == "nü")
        assert(pinyin.tone == .third)
        assert(pinyin.ipaForm == "nü3")
    }
    
    func testWordWithUmlautDifferentLetter() throws {
        let pinyin = Pinyin(diacriticForm: "yüè")
        assert(pinyin.diacriticForm == "yüè")
        assert(pinyin.baseString == "yüe")
        assert(pinyin.tone == .fourth)
        assert(pinyin.ipaForm == "yüe4")
    }
}
