# PinyinParse

PinyinParse converts standard Mandarin Pinyin written with diacritic marks (e.g. `chuāng`) into IPA form (e.g. `chuang1`).

## Why?
At the time of writing, Apple's `AVSpeechSynthesizer`  had trouble reading some Pinyin written with diacritic marks when embedded in SSML, but worked as expected when written in IPA form.
