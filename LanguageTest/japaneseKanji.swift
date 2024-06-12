// Note: This file is automatically generated
//       It will be overwritten when testing

import XCTest

final class Test_japaneseKanji: XCTestCase {

    let language = Languages().japaneseKanji

    func test_japaneseKanji() {
        XCTAssertEqual(language.read(0).x, "零")
        XCTAssertEqual(language.read(1).x, "一")
        XCTAssertEqual(language.read(2).x, "二")
        XCTAssertEqual(language.read(3).x, "三")
        XCTAssertEqual(language.read(4).x, "四")
        XCTAssertEqual(language.read(5).x, "五")
        XCTAssertEqual(language.read(6).x, "六")
        XCTAssertEqual(language.read(7).x, "七")
        XCTAssertEqual(language.read(8).x, "八")
        XCTAssertEqual(language.read(9).x, "九")
        XCTAssertEqual(language.read(10).x, "十")
        XCTAssertEqual(language.read(11).x, "十一")
        XCTAssertEqual(language.read(12).x, "十二")
        XCTAssertEqual(language.read(13).x, "十三")
        XCTAssertEqual(language.read(14).x, "十四")
        XCTAssertEqual(language.read(15).x, "十五")
        XCTAssertEqual(language.read(16).x, "十六")
        XCTAssertEqual(language.read(17).x, "十七")
        XCTAssertEqual(language.read(18).x, "十八")
        XCTAssertEqual(language.read(19).x, "十九")
        XCTAssertEqual(language.read(20).x, "二十")
        XCTAssertEqual(language.read(30).x, "三十")
        XCTAssertEqual(language.read(32).x, "三十二")
        XCTAssertEqual(language.read(50).x, "五十")
        XCTAssertEqual(language.read(54).x, "五十四")
        XCTAssertEqual(language.read(78).x, "七十八")
        XCTAssertEqual(language.read(98).x, "九十八")
        XCTAssertEqual(language.read(99).x, "九十九")
        XCTAssertEqual(language.read(100).x, "一百")
        XCTAssertEqual(language.read(101).x, "一百 零一")
        XCTAssertEqual(language.read(102).x, "一百 零二")
        XCTAssertEqual(language.read(103).x, "一百 零三")
        XCTAssertEqual(language.read(104).x, "一百 零四")
        XCTAssertEqual(language.read(110).x, "一百 一十")
        XCTAssertEqual(language.read(111).x, "一百 一十一")
        XCTAssertEqual(language.read(112).x, "一百 一十二")
        XCTAssertEqual(language.read(113).x, "一百 一十三")
        XCTAssertEqual(language.read(120).x, "一百 二十")
        XCTAssertEqual(language.read(130).x, "一百 三十")
        XCTAssertEqual(language.read(140).x, "一百 四十")
        XCTAssertEqual(language.read(125).x, "一百 二十五")
        XCTAssertEqual(language.read(132).x, "一百 三十二")
        XCTAssertEqual(language.read(147).x, "一百 四十七")
        XCTAssertEqual(language.read(151).x, "一百五十一")
        XCTAssertEqual(language.read(152).x, "一百 五十二")
        XCTAssertEqual(language.read(166).x, "一百 六十六")
        XCTAssertEqual(language.read(178).x, "一百 七十八")
        XCTAssertEqual(language.read(183).x, "一百 八十三")
        XCTAssertEqual(language.read(197).x, "一百 九十七")
        XCTAssertEqual(language.read(200).x, "二百")
        XCTAssertEqual(language.read(208).x, "二百 零八")
        XCTAssertEqual(language.read(300).x, "三百")
        XCTAssertEqual(language.read(302).x, "三百二")
        XCTAssertEqual(language.read(305).x, "三百 零五")
        XCTAssertEqual(language.read(400).x, "四百")
        XCTAssertEqual(language.read(432).x, "四百 三十二")
        XCTAssertEqual(language.read(469).x, "四百六十九")
        XCTAssertEqual(language.read(500).x, "五百")
        XCTAssertEqual(language.read(600).x, "六百")
        XCTAssertEqual(language.read(700).x, "七百")
        XCTAssertEqual(language.read(800).x, "八百")
        XCTAssertEqual(language.read(900).x, "九百")
        XCTAssertEqual(language.read(301).x, "三百 零一")
        XCTAssertEqual(language.read(565).x, "五百 六十五")
        XCTAssertEqual(language.read(732).x, "七百 三十二")
        XCTAssertEqual(language.read(890).x, "八百 九十")
        XCTAssertEqual(language.read(945).x, "九百 四十五")
        XCTAssertEqual(language.read(1000).x, "一千")
        XCTAssertEqual(language.read(1001).x, "一千 零一")
        XCTAssertEqual(language.read(1003).x, "一千 零三")
        XCTAssertEqual(language.read(1005).x, "一千 零五")
        XCTAssertEqual(language.read(1006).x, "一千 零六")
        XCTAssertEqual(language.read(1010).x, "一千 零一十")
        XCTAssertEqual(language.read(1020).x, "一千 零二十")
        XCTAssertEqual(language.read(1035).x, "一千 零三十五")
        XCTAssertEqual(language.read(1100).x, "一千 一百")
        XCTAssertEqual(language.read(1111).x, "一千 一百 一十一")
        XCTAssertEqual(language.read(1200).x, "一千 二百")
        XCTAssertEqual(language.read(1234).x, "一千 二百 三十四")
        XCTAssertEqual(language.read(1500).x, "千五百") // 一千五百
        XCTAssertEqual(language.read(1999).x, "一千 九百 九十九")
        XCTAssertEqual(language.read(2000).x, "二千")
        XCTAssertEqual(language.read(2001).x, "二千 零一")
        XCTAssertEqual(language.read(2010).x, "二千 零一十")
        XCTAssertEqual(language.read(2025).x, "二千二十五")
        XCTAssertEqual(language.read(2345).x, "二千 三百 四十五")
        XCTAssertEqual(language.read(3000).x, "三千")
        XCTAssertEqual(language.read(3454).x, "三千 四百 五十四")
        XCTAssertEqual(language.read(4000).x, "四千")
        XCTAssertEqual(language.read(5000).x, "五千")
        XCTAssertEqual(language.read(6000).x, "六千")
        XCTAssertEqual(language.read(7000).x, "七千")
        XCTAssertEqual(language.read(7045).x, "七千 零四十五")
        XCTAssertEqual(language.read(8000).x, "八千")
        XCTAssertEqual(language.read(9000).x, "九千")
        XCTAssertEqual(language.read(1_0000).x, "一万")
        XCTAssertEqual(language.read(1_0001).x, "一万 零一")
        XCTAssertEqual(language.read(1_0003).x, "一万 零三")
        XCTAssertEqual(language.read(1_0101).x, "一万 零一百 零一")
        XCTAssertEqual(language.read(1_0207).x, "一万 零二百 零七")
        XCTAssertEqual(language.read(1_0509).x, "一万 零五百 零九")
        XCTAssertEqual(language.read(1_1000).x, "一万 一千")
        XCTAssertEqual(language.read(1_1050).x, "一万 一千 零五十")
        XCTAssertEqual(language.read(1_1500).x, "一万 一千 五百")
        XCTAssertEqual(language.read(1_1741).x, "一万 一千 七百 四十一")
        XCTAssertEqual(language.read(1_2000).x, "一万 二千")
        XCTAssertEqual(language.read(1_2345).x, "一万 二千 三百 四十五")
        XCTAssertEqual(language.read(1_3200).x, "一万 三千 二百")
        XCTAssertEqual(language.read(1_8000).x, "一万 八千")
        XCTAssertEqual(language.read(2_0000).x, "二万")
        XCTAssertEqual(language.read(2_3456).x, "二万 三千 四百 五十六")
        XCTAssertEqual(language.read(3_1240).x, "三万 一千 二百 四十")
        XCTAssertEqual(language.read(4_0000).x, "四万")
        XCTAssertEqual(language.read(4_0005).x, "四万 零五")
        XCTAssertEqual(language.read(4_0050).x, "四万 零五十")
        XCTAssertEqual(language.read(4_0500).x, "四万 零五百")
        XCTAssertEqual(language.read(4_5000).x, "四万 五千")
        XCTAssertEqual(language.read(5_0555).x, "五万 零五百 五十五")
        XCTAssertEqual(language.read(5_2152).x, "五万 二千 一百 五十二")
        XCTAssertEqual(language.read(5_6700).x, "五万 六千 七百")
        XCTAssertEqual(language.read(10_0000).x, "十万")
        XCTAssertEqual(language.read(10_0070).x, "十万 零七十")
        XCTAssertEqual(language.read(10_0222).x, "十万 零二百 二十二")
        XCTAssertEqual(language.read(10_1010).x, "十万 一千 零一十")
        XCTAssertEqual(language.read(11_0000).x, "十一万")
        XCTAssertEqual(language.read(12_3446).x, "十二万 三千 四百 四十六")
        XCTAssertEqual(language.read(20_0000).x, "二十万")
        XCTAssertEqual(language.read(20_0300).x, "二十万 零三百")
        XCTAssertEqual(language.read(21_4000).x, "二十一万 四千")
        XCTAssertEqual(language.read(30_0000).x, "三十万")
        XCTAssertEqual(language.read(30_0250).x, "三十万 零二百 五十")
        XCTAssertEqual(language.read(56_7000).x, "五十六万 七千")
        XCTAssertEqual(language.read(76_5432).x, "七十六万 五千 四百 三十二")
        XCTAssertEqual(language.read(100_0000).x, "一億")
        // 100_0001 一百万 零一
        // 100_0010 一百万 零一十
        // 100_0100 一百万 零一百
        // 100_1000 一百万 一千
        // 101_0000 一百 零一万
        // 101_0101 一百 零一万 零一百 零一
        // 110_0000 一百 一十万
        // 112_3456 一百 一十二万 三千 四百 五十六
        // 162_8333 一百 六十二万 八千 三百 三十三
        // 291_4680 二百 九十一万 四千 六百 八十
        // 600_9123 六百万 九千 一百 二十三
        // 608_9123 六百 零八万 九千 一百 二十三
        // 670_0123 六百 七十万 零一百 二十三
        // 670_9123 六百 七十万 九千 一百 二十三
        // 678_9003 六百 七十八万 九千 零三
        // 678_9123 六百 七十八万 九千 一百 二十三
        // 678_9100 六百 七十八万 九千 一百
        // 678_9120 六百 七十八万 九千 一百 二十
        // 678_0023 六百 七十八万 零二十三
        // 700_0000 七百万
        // 789_0000 七百 八十九万
        // 789_0298 七百 八十九万 零二百 九十八
        // 800_0000 八百万
        // 800_0300 八百万 零三百
        // 1000_0000 一千万
        // 1010_1010 一千 零一十万 一千 零一十
        XCTAssertEqual(language.read(1_500_0000).x, "千五百万") // 一千五百万
        // 2700_0000 二千 七百万
        // 2721_4000 二千 七百 二十一万 四千
        // 2721_4896 二千 七百 二十一万 四千 八百 九十六
        // 2772_1000 二千 七百 七十二万 一千
        // 3456_7890 三千 四百 五十六万 七千 八百 九十
        // 5379_8250 五千 三百 七十九万 八千 二百 五十
        // 9800_0000 九千 八百万
        // 9876_5000 九千 八百 七十六万 五千
        // 9876_5432 九千 八百 七十六万 五千 四百 三十二
        XCTAssertEqual(language.read(1_0000_0000).x, "一億")
        // 1_0101_0101 一亿 零一百 零一万 零一百 零一
        // 1_2345_6789 一亿 二千 三百 四十五万 六千 七百 八十九
        // 2_0080_0000 二亿 零八十万
        // 2_4050_0000 二亿 四千 零五十万
        // 3_0000_0000 三亿
        // 4_1429_4182 四亿 一千 四百 二十九万 四千 一百 八十二
        // 10_0000_0000 十亿
        // 10_1010_1010 十亿 一千 零一十万 一千 零一十
        // 12_0008_0000 十二亿 零八万
        // 13_2680_0000 十三亿 二千 六百 八十万
        // 98_7654_3210 九十八亿 七千 六百 五十四万 三千 二百 一十
        // 251_5836_7200 二百 五十一亿 五千 八百 三十六万 七千 二百
        // 1234_5678_9012 一千 二百 三十四亿 五千 六百 七十八万 九千 零一十二
        // 6789_8765_4321 六千 七百 八十九亿 八千 七百 六十五万 四千 三百 二十一
        XCTAssertEqual(language.read(1_0000_0000_0000).x, "一兆")
    }
}
