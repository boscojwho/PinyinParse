//
//  String+Pinyin.swift
//  HKSCS
//
//  Created by Bosco Ho on 2024-06-13.
//

import Foundation

struct Pinyin {
    /// e.g. `chuang` or `yü`, preserving any diacritic marks for disambiguating readings.
    let baseString: String
    /// e.g. `chuāng`.
    let diacriticForm: String
    /// e.g. `chuang1`.
    let ipaForm: String
    let tone: ToneMark
    init(diacriticForm: String) {
        self.baseString = diacriticForm.removingPinyinToneMarks()
        self.tone = diacriticForm.toneMark() ?? .neutral
        self.diacriticForm = diacriticForm
        self.ipaForm = "\(diacriticForm.removingPinyinToneMarks())\(self.tone.numericValue)"
    }
}

extension Pinyin {
    @frozen
    enum ToneMark: String, CaseIterable {
        case first      = "\u{0304}"
        case second     = "\u{0301}"
        case third      = "\u{030C}"
        case fourth     = "\u{0300}"
        /// Placed before syllable, not commonly used in Pinyin.
        case neutral    = "\u{00B7}"
        
        var numericValue: Int {
            switch self {
            case .first:    1
            case .second:   2
            case .third:    3
            case .fourth:   4
            case .neutral:  5
            }
        }
    }
    
    /// Used to disambiguate certain readings of "u".
    static let umlaut = "\u{0308}"
}

extension String {
    /// Assumes Pinyin is written in common form, where there is one tone mark (not including umlauts) per character.
    @discardableResult
    func removingPinyinToneMarks() -> String {
        let retVal = self.decomposedStringWithCanonicalMapping.unicodeScalars.filter { char in
            /// Keep scalar if it doesn't match any tone mark.
            Pinyin.ToneMark.allCases.first { $0.rawValue == String(char) } == nil
        }
        return String(retVal)
    }
    
    func toneMark() -> Pinyin.ToneMark? {
        let tone = self.decomposedStringWithCanonicalMapping.unicodeScalars.first { char in
            /// Keep scalar if it doesn't match any tone mark.
            Pinyin.ToneMark.allCases.first { $0.rawValue == String(char) } != nil
        }
        if let tone {
            let str = String(tone)
            let toneMark = Pinyin.ToneMark(rawValue: str)
            return toneMark
        } else {
            return nil
        }
    }
}
