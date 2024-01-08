// LanguageTests
//
// automatically generated)
// do not edit


import XCTest

final class Test_russian: XCTestCase {

    let languages = Languages()

    func test_russian() {
        let language = languages.russian
// / https: lingopie.com/blog/your-ultimate-guide-to-russian-numbers-how-to-count-in-russian/// 
        XCTAssertEqual(language.read(0).x, "ноль")
        XCTAssertEqual(language.read(1).x, "один")
        XCTAssertEqual(language.read(2).x, "два")
        XCTAssertEqual(language.read(3).x, "три")
        XCTAssertEqual(language.read(4).x, "четыре")
        XCTAssertEqual(language.read(5).x, "пять")
        XCTAssertEqual(language.read(6).x, "шесть")
        XCTAssertEqual(language.read(7).x, "семь")
        XCTAssertEqual(language.read(8).x, "восемь")
        XCTAssertEqual(language.read(9).x, "девять")
        XCTAssertEqual(language.read(10).x, "десять")
        XCTAssertEqual(language.read(11).x, "одиннадцать")
        XCTAssertEqual(language.read(12).x, "двенадцать")
        XCTAssertEqual(language.read(13).x, "тринадцать")
        XCTAssertEqual(language.read(14).x, "четырнадцать")
        XCTAssertEqual(language.read(15).x, "пятнадцать")
        XCTAssertEqual(language.read(16).x, "шестнадцать")
        XCTAssertEqual(language.read(17).x, "семнадцать")
        XCTAssertEqual(language.read(18).x, "восемнадцать")
        XCTAssertEqual(language.read(19).x, "девятнадцать")
        XCTAssertEqual(language.read(20).x, "двадцать")
        XCTAssertEqual(language.read(23).x, "двадцать три")
        XCTAssertEqual(language.read(30).x, "тридцать")
        XCTAssertEqual(language.read(33).x, "тридцать три")
        XCTAssertEqual(language.read(40).x, "сорок")
        XCTAssertEqual(language.read(50).x, "пятьдесят")
        XCTAssertEqual(language.read(60).x, "шестьдесят")
        XCTAssertEqual(language.read(70).x, "семьдесят")
        XCTAssertEqual(language.read(80).x, "восемьдесят")
        XCTAssertEqual(language.read(90).x, "девяносто")
        XCTAssertEqual(language.read(100).x, "стo")
        XCTAssertEqual(language.read(101).x, "стo один")
        XCTAssertEqual(language.read(111).x, "стo одиннадцать")
        XCTAssertEqual(language.read(131).x, "стo тридцать один")
        XCTAssertEqual(language.read(200).x, "двести")
        XCTAssertEqual(language.read(245).x, "двести сорок пять")
        XCTAssertEqual(language.read(300).x, "триста")
        XCTAssertEqual(language.read(375).x, "триста семьдесят пять")
        XCTAssertEqual(language.read(400).x, "четыреста")
        XCTAssertEqual(language.read(500).x, "пятьсот")
        XCTAssertEqual(language.read(600).x, "шестьсот")
        XCTAssertEqual(language.read(700).x, "семьсот")
        XCTAssertEqual(language.read(800).x, "восемьсот")
        XCTAssertEqual(language.read(900).x, "девятьсот")
        XCTAssertEqual(language.read(999).x, "девятьсот девяносто девять")
        XCTAssertEqual(language.read(1_000).x, "тысяча")
        XCTAssertEqual(language.read(1_348).x, "тысяча триста сорок восемь")
        XCTAssertEqual(language.read(1_534).x, "тысяча пятьсот тридцать четыре")
        XCTAssertEqual(language.read(2_000).x, "две тысячи")
        XCTAssertEqual(language.read(2_345).x, "две тысячи триста сорок пять")
        XCTAssertEqual(language.read(3_000).x, "три тысячи")
        XCTAssertEqual(language.read(4_000).x, "четыре тысячи")
        XCTAssertEqual(language.read(5_000).x, "пять тысяч")
        XCTAssertEqual(language.read(6_000).x, "шесть тысяч")
        XCTAssertEqual(language.read(7_000).x, "семь тысяч")
        XCTAssertEqual(language.read(8_000).x, "восемь тысяч")
        XCTAssertEqual(language.read(8_343).x, "восемь тысяч триста сорок три")
        XCTAssertEqual(language.read(9_000).x, "девять тысяч")
        XCTAssertEqual(language.read(9_203).x, "девять тысяч двести три")
        XCTAssertEqual(language.read(9_999).x, "девять тысяч девятьсот девяносто девять")
        XCTAssertEqual(language.read(10_000).x, "десять тысяч")
        XCTAssertEqual(language.read(11_000).x, "одиннадцать тысяч")
        XCTAssertEqual(language.read(11_111).x, "одиннадцать тысяч стo одиннадцать")
        XCTAssertEqual(language.read(12_000).x, "двенадцать тысяч")
        XCTAssertEqual(language.read(19_000).x, "девятнадцать тысяч")
        XCTAssertEqual(language.read(20_000).x, "двадцать тысяч")
        XCTAssertEqual(language.read(21_000).x, "двадцать одна тысяча")
        XCTAssertEqual(language.read(22_000).x, "двадцать две тысячи")
        XCTAssertEqual(language.read(23_000).x, "двадцать три тысячи")
        XCTAssertEqual(language.read(24_000).x, "двадцать четыре тысячи")
        XCTAssertEqual(language.read(25_000).x, "двадцать пять тысяч")
        XCTAssertEqual(language.read(23_456).x, "двадцать три тысячи четыреста пятьдесят шесть")
        XCTAssertEqual(language.read(41_000).x, "сорок одна тысяча")
        XCTAssertEqual(language.read(99_999).x, "девяносто девять тысяч девятьсот девяносто девять")
        XCTAssertEqual(language.read(100_000).x, "стo тысяч")
        XCTAssertEqual(language.read(101_000).x, "стo одна тысяча")
        XCTAssertEqual(language.read(101_111).x, "стo одна тысяча стo одиннадцать")
        XCTAssertEqual(language.read(234_567).x, "двести тридцать четыре тысячи пятьсот шестьдесят семь")
        XCTAssertEqual(language.read(243_382).x, "двести сорок три тысячи триста восемьдесят два")
        XCTAssertEqual(language.read(999_999).x, "девятьсот девяносто девять тысяч девятьсот девяносто девять")
        XCTAssertEqual(language.read(101_101_101).x, "стo один миллион стo одна тысяча стo один")
        XCTAssertEqual(language.read(234_567_890).x, "двести тридцать четыре миллиона пятьсот шестьдесят семь тысяч восемьсот девяносто")
        XCTAssertEqual(language.read(999_999_999).x, "девятьсот девяносто девять миллионов девятьсот девяносто девять тысяч девятьсот девяносто девять")
        XCTAssertEqual(language.read(1_000_000_000).x, "один миллиард")
        XCTAssertEqual(language.read(2_000_000_000).x, "два миллиарда")
        XCTAssertEqual(language.read(10_000_000_000).x, "десять миллиардов")
        XCTAssertEqual(language.read(1_000_000_000_000).x, "один триллион")
        XCTAssertEqual(language.read(2_000_000_000_000).x, "два триллиона")
        XCTAssertEqual(language.read(10_000_000_000_000).x, "десять триллионов")
// unclear:
// 1_000_000 один миллион// 
// 2_000_000 два миллиона// 
// 3_000_000 три миллиона// 
// 4_000_000 четыре миллиона// 
// 5_000_000 пять миллионов// 
// 6_000_000 шесть миллионов// 
// 7_000_000 семь миллионов// 
// 8_000_000 восемь миллионов// 
// 9_000_000 девять миллионов// 
// 10_000_000 десять миллионов// 
// 100_000_000 стo миллионов// 
// 22_000 "двадцать две тысячи"  "двадцать два тысячи"// 
// 21_000 "двадцать одна тысяча" "двадцать один тысяча"// 
// 41_000 "сорок одна тысяча"    "сорок один тысяча"// 
// 10_000_000_000_000  "дксять триллионов" "десять триллионов"// 
    }
}
