//
//  Test_Automatic_Thai.swift
//
//  Created by automatic.py
//

import XCTest

final class TestsThai: XCTestCase {

    func test_lanta() {
        let thai = TranslateThai()
        thai.groupSeparator = ""
        thai.decimalSeparator = "."
        XCTAssertEqual(thai.translate(100), "หนึ่งร้อย")
        XCTAssertEqual(thai.translate(101), "หนึ่งร้อยหนึ่ง")
        XCTAssertEqual(thai.translate(102), "หนึ่งร้อยสอง")
        XCTAssertEqual(thai.translate(1_000), "หนึ่งพัน")
        XCTAssertEqual(thai.translate(1_001), "หนึ่งพันหนึ่ง")
        XCTAssertEqual(thai.translate(1_005), "หนึ่งพันห้า")
    }
    
    func test_webpage() {
        let thai = TranslateThai()
        thai.groupSeparator = ""
        thai.decimalSeparator = "."
        
        /*
         https://www.thaipod101.com/blog/2019/10/24/thai-numbers
         8,126 — eight is in the thousand digit spot, so we read “eight” followed by the name of the thousand digit in Thai which is แปดพัน (bpàaet phan).
        8,126 — one is in the hundred digit spot, so we read “one” in Thai followed by the name of the hundred digit in Thai which is หนึ่งร้อย (nùeng ráauy).
        8,126 — two is in the ten digit spot, so we read “two” followed by the name of the ten digit in Thai which is ยี่สิบ (yîi sìp). (Don’t forget that for 20, Thai people read it ยี่สิบ [yîi sìp]).
        8,126 — six is in the unit digit spot, so we read “six” in Thai which is หก (hòk). (Don’t forget that for the unit digit, you read only the number and don’t read the name of the digit.)
        8,126 is แปดพันหนึ่งร้อยยี่สิบหก (bpàaet phan nùeng ráauy yîi sìp hòk).
        
        300,451 — three is in the hundred-thousand digit spot so we read “three” in Thai followed by the name of the hundred-thousand digit which is สามแสน (sǎam sǎaen).
        300,451 — since the number in the ten-thousand and thousand digit spots is 0, we can skip reading these two digits.
        300,451 — four is in the hundred digit spot, so we read “four” followed by the name of the hundred digit in Thai which is สี่ร้อย (sìi ráauy).
        300,451 — five is in the ten digit spot, so we read “five” followed by the name of the ten digit in Thai which is ห้าสิบ (hâa sìp).
        300,451 — one is in the unit digit spot, so we read one in Thai which is เอ็ด (èt). (Don’t forget that for numbers higher than 10, if 1 is in the unit digit spot, we read it เอ็ด [èt].)
        300,451 is สามแสนสี่ร้อยห้าสิบเอ็ด (sǎam sǎaen sìi ráauy hâa sìp èt).
         
         Example of 21,700,098
         21 and 700,098 — you divide the number into parts for every six digits from right to left first, so you get 21 and 700,098.
         21,700,098 — you read the left part first followed by ล้าน (láan) which is ยี่สิบเอ็ดล้าน (yîi sìp èt láan).
         21,700,098 — you read the right part after that which is เจ็ดแสนเก้าสิบแปด (jèt sǎaen gâo sìp bpàaet).
         21,700,098 is ยี่สิบเอ็ดล้านเจ็ดแสนเก้าสิบแปด (yîi sìp èt láan jèt sǎaen gâo sìp bpàaet).


       */

        XCTAssertEqual(thai.translate(8_000), "แปดพัน")
        XCTAssertEqual(thai.translate(100), "หนึ่งร้อย")
        XCTAssertEqual(thai.translate(20), "ยี่สิบ")
        XCTAssertEqual(thai.translate(6), "หก")
        XCTAssertEqual(thai.translate(126), "หนึ่งร้อยยี่สิบหก")
        XCTAssertEqual(thai.translate(8_126), "แปดพันหนึ่งร้อยยี่สิบหก")

        XCTAssertEqual(thai.translate(300_000), "สามแสน")
        XCTAssertEqual(thai.translate(400), "สี่ร้อย")
        XCTAssertEqual(thai.translate(50), "ห้าสิบ")
        XCTAssertNotEqual(thai.translate(1), "เอ็ด")
        XCTAssertEqual(thai.translate(300_451), "สามแสนสี่ร้อยห้าสิบเอ็ด")
        
        XCTAssertEqual(thai.translate(21_700_098), "ยี่สิบเอ็ดล้านเจ็ดแสนเก้าสิบแปด")
    }
    
    
    func test_thai() {
        let thai = TranslateThai()
        thai.groupSeparator = ""
        thai.decimalSeparator = "."
        XCTAssertEqual(thai.translate(0), "ศูนย์")
        XCTAssertEqual(thai.translate(1), "หนึ่ง")
        XCTAssertEqual(thai.translate(2), "สอง")
        XCTAssertEqual(thai.translate(3), "สาม")
        XCTAssertEqual(thai.translate(4), "สี่")
        XCTAssertEqual(thai.translate(5), "ห้า")
        XCTAssertEqual(thai.translate(6), "หก")
        XCTAssertEqual(thai.translate(7), "เจ็ด")
        XCTAssertEqual(thai.translate(8), "แปด")
        XCTAssertEqual(thai.translate(9), "เก้า")
        XCTAssertEqual(thai.translate(10), "สิบ")
        XCTAssertEqual(thai.translate(11), "สิบเอ็ด")
        XCTAssertEqual(thai.translate(12), "สิบสอง")
        XCTAssertEqual(thai.translate(13), "สิบสาม")
        XCTAssertEqual(thai.translate(14), "สิบสี่")
        XCTAssertEqual(thai.translate(15), "สิบห้า")
        XCTAssertEqual(thai.translate(16), "สิบหก")
        XCTAssertEqual(thai.translate(17), "สิบเจ็ด")
        XCTAssertEqual(thai.translate(18), "สิบแปด")
        XCTAssertEqual(thai.translate(19), "สิบเก้า")
        XCTAssertEqual(thai.translate(20), "ยี่สิบ")
        XCTAssertEqual(thai.translate(21), "ยี่สิบเอ็ด")
        XCTAssertEqual(thai.translate(22), "ยี่สิบสอง")
        XCTAssertEqual(thai.translate(23), "ยี่สิบสาม")
        XCTAssertEqual(thai.translate(24), "ยี่สิบสี่")
        XCTAssertEqual(thai.translate(25), "ยี่สิบห้า")
        XCTAssertEqual(thai.translate(26), "ยี่สิบหก")
        XCTAssertEqual(thai.translate(27), "ยี่สิบเจ็ด")
        XCTAssertEqual(thai.translate(28), "ยี่สิบแปด")
        XCTAssertEqual(thai.translate(29), "ยี่สิบเก้า")
        XCTAssertEqual(thai.translate(30), "สามสิบ") 
        XCTAssertEqual(thai.translate(31), "สามสิบเอ็ด")
        XCTAssertEqual(thai.translate(32), "สามสิบสอง")
        XCTAssertEqual(thai.translate(33), "สามสิบสาม")
        XCTAssertEqual(thai.translate(34), "สามสิบสี่")
        XCTAssertEqual(thai.translate(35), "สามสิบห้า")
        XCTAssertEqual(thai.translate(36), "สามสิบหก")
        XCTAssertEqual(thai.translate(37), "สามสิบเจ็ด")
        XCTAssertEqual(thai.translate(38), "สามสิบแปด")
        XCTAssertEqual(thai.translate(39), "สามสิบเก้า")
        XCTAssertEqual(thai.translate(40), "สี่สิบ")
        XCTAssertEqual(thai.translate(41), "สี่สิบเอ็ด")
        XCTAssertEqual(thai.translate(42), "สี่สิบสอง")
        XCTAssertEqual(thai.translate(43), "สี่สิบสาม")
        XCTAssertEqual(thai.translate(44), "สี่สิบสี่")
        XCTAssertEqual(thai.translate(45), "สี่สิบห้า")
        XCTAssertEqual(thai.translate(46), "สี่สิบหก")
        XCTAssertEqual(thai.translate(47), "สี่สิบเจ็ด")
        XCTAssertEqual(thai.translate(48), "สี่สิบแปด")
        XCTAssertEqual(thai.translate(49), "สี่สิบเก้า")
        XCTAssertEqual(thai.translate(50), "ห้าสิบ")
        XCTAssertEqual(thai.translate(51), "ห้าสิบเอ็ด")
        XCTAssertEqual(thai.translate(52), "ห้าสิบสอง")
        XCTAssertEqual(thai.translate(53), "ห้าสิบสาม")
        XCTAssertEqual(thai.translate(54), "ห้าสิบสี่")
        XCTAssertEqual(thai.translate(55), "ห้าสิบห้า")
        XCTAssertEqual(thai.translate(56), "ห้าสิบหก")
        XCTAssertEqual(thai.translate(57), "ห้าสิบเจ็ด")
        XCTAssertEqual(thai.translate(58), "ห้าสิบแปด")
        XCTAssertEqual(thai.translate(59), "ห้าสิบเก้า")
        XCTAssertEqual(thai.translate(60), "หกสิบ")
        XCTAssertEqual(thai.translate(61), "หกสิบเอ็ด")
        XCTAssertEqual(thai.translate(62), "หกสิบสอง")
        XCTAssertEqual(thai.translate(63), "หกสิบสาม")
        XCTAssertEqual(thai.translate(64), "หกสิบสี่")
        XCTAssertEqual(thai.translate(65), "หกสิบห้า")
        XCTAssertEqual(thai.translate(66), "หกสิบหก")
        XCTAssertEqual(thai.translate(67), "หกสิบเจ็ด")
        XCTAssertEqual(thai.translate(68), "หกสิบแปด")
        XCTAssertEqual(thai.translate(69), "หกสิบเก้า")
        XCTAssertEqual(thai.translate(70), "เจ็ดสิบ")
        XCTAssertEqual(thai.translate(71), "เจ็ดสิบเอ็ด")
        XCTAssertEqual(thai.translate(72), "เจ็ดสิบสอง")
        XCTAssertEqual(thai.translate(73), "เจ็ดสิบสาม")
        XCTAssertEqual(thai.translate(74), "เจ็ดสิบสี่")
        XCTAssertEqual(thai.translate(75), "เจ็ดสิบห้า")
        XCTAssertEqual(thai.translate(76), "เจ็ดสิบหก")
        XCTAssertEqual(thai.translate(77), "เจ็ดสิบเจ็ด")
        XCTAssertEqual(thai.translate(78), "เจ็ดสิบแปด")
        XCTAssertEqual(thai.translate(79), "เจ็ดสิบเก้า")
        XCTAssertEqual(thai.translate(80), "แปดสิบ")
        XCTAssertEqual(thai.translate(81), "แปดสิบเอ็ด")
        XCTAssertEqual(thai.translate(82), "แปดสิบสอง")
        XCTAssertEqual(thai.translate(83), "แปดสิบสาม")
        XCTAssertEqual(thai.translate(84), "แปดสิบสี่")
        XCTAssertEqual(thai.translate(85), "แปดสิบห้า")
        XCTAssertEqual(thai.translate(86), "แปดสิบหก")
        XCTAssertEqual(thai.translate(87), "แปดสิบเจ็ด")
        XCTAssertEqual(thai.translate(88), "แปดสิบแปด")
        XCTAssertEqual(thai.translate(89), "แปดสิบเก้า")
        XCTAssertEqual(thai.translate(90), "เก้าสิบ")
        XCTAssertEqual(thai.translate(91), "เก้าสิบเอ็ด")
        XCTAssertEqual(thai.translate(92), "เก้าสิบสอง")
        XCTAssertEqual(thai.translate(93), "เก้าสิบสาม")
        XCTAssertEqual(thai.translate(94), "เก้าสิบสี่")
        XCTAssertEqual(thai.translate(95), "เก้าสิบห้า")
        XCTAssertEqual(thai.translate(96), "เก้าสิบหก")
        XCTAssertEqual(thai.translate(97), "เก้าสิบเจ็ด")
        XCTAssertEqual(thai.translate(98), "เก้าสิบแปด") 
        XCTAssertEqual(thai.translate(99), "เก้าสิบเก้า")
        XCTAssertEqual(thai.translate(100), "หนึ่งร้อย")
        XCTAssertEqual(thai.translate(101), "หนึ่งร้อยหนึ่ง")
        XCTAssertEqual(thai.translate(102), "หนึ่งร้อยสอง")
        XCTAssertEqual(thai.translate(103), "หนึ่งร้อยสาม")
        XCTAssertEqual(thai.translate(104), "หนึ่งร้อยสี่")
        XCTAssertEqual(thai.translate(105), "หนึ่งร้อยห้า")
        XCTAssertEqual(thai.translate(106), "หนึ่งร้อยหก")
        XCTAssertEqual(thai.translate(107), "หนึ่งร้อยเจ็ด")
        XCTAssertEqual(thai.translate(108), "หนึ่งร้อยแปด")
        XCTAssertEqual(thai.translate(109), "หนึ่งร้อยเก้า")
        XCTAssertEqual(thai.translate(110), "หนึ่งร้อยสิบ")
        XCTAssertEqual(thai.translate(111), "หนึ่งร้อยสิบเอ็ด")
        XCTAssertEqual(thai.translate(112), "หนึ่งร้อยสิบสอง")
        XCTAssertEqual(thai.translate(113), "หนึ่งร้อยสิบสาม")
        XCTAssertEqual(thai.translate(119), "หนึ่งร้อยสิบเก้า")
        XCTAssertEqual(thai.translate(120), "หนึ่งร้อยยี่สิบ")
        XCTAssertEqual(thai.translate(121), "หนึ่งร้อยยี่สิบเอ็ด")
        XCTAssertEqual(thai.translate(190), "หนึ่งร้อยเก้าสิบ")
        XCTAssertEqual(thai.translate(200), "สองร้อย")
        XCTAssertEqual(thai.translate(201), "สองร้อยหนึ่ง")
        XCTAssertEqual(thai.translate(444), "สี่ร้อยสี่สิบสี่")
        XCTAssertEqual(thai.translate(500), "ห้าร้อย")
        XCTAssertEqual(thai.translate(580), "ห้าร้อยแปดสิบ")
        XCTAssertEqual(thai.translate(999), "เก้าร้อยเก้าสิบเก้า")
        XCTAssertEqual(thai.translate(1_000), "หนึ่งพัน")
        XCTAssertEqual(thai.translate(1_001), "หนึ่งพันหนึ่ง")
        XCTAssertEqual(thai.translate(1_005), "หนึ่งพันห้า")
        XCTAssertEqual(thai.translate(1_009), "หนึ่งพันเก้า")
        XCTAssertEqual(thai.translate(1_010), "หนึ่งพันสิบ")
        XCTAssertEqual(thai.translate(1_011), "หนึ่งพันสิบเอ็ด")
        XCTAssertEqual(thai.translate(1_012), "หนึ่งพันสิบสอง")
        XCTAssertEqual(thai.translate(1_015), "หนึ่งพันสิบห้า")
        XCTAssertEqual(thai.translate(1_035), "หนึ่งพันสามสิบห้า")
        XCTAssertEqual(thai.translate(1_099), "หนึ่งพันเก้าสิบเก้า")
        XCTAssertEqual(thai.translate(1_100), "หนึ่งพันหนึ่งร้อย")
        XCTAssertEqual(thai.translate(1_101), "หนึ่งพันหนึ่งร้อยหนึ่ง")
        XCTAssertEqual(thai.translate(1_105), "หนึ่งพันหนึ่งร้อยห้า")
        XCTAssertEqual(thai.translate(1_110), "หนึ่งพันหนึ่งร้อยสิบ")
        XCTAssertEqual(thai.translate(1_111), "หนึ่งพันหนึ่งร้อยสิบเอ็ด")
        XCTAssertEqual(thai.translate(1_115), "หนึ่งพันหนึ่งร้อยสิบห้า")
        XCTAssertEqual(thai.translate(1_121), "หนึ่งพันหนึ่งร้อยยี่สิบเอ็ด")
        XCTAssertEqual(thai.translate(1_125), "หนึ่งพันหนึ่งร้อยยี่สิบห้า")
        XCTAssertEqual(thai.translate(3_005), "สามพันห้า")
        XCTAssertEqual(thai.translate(3_105), "สามพันหนึ่งร้อยห้า")
        XCTAssertEqual(thai.translate(3_155), "สามพันหนึ่งร้อยห้าสิบห้า")
        XCTAssertEqual(thai.translate(8_126), "แปดพันหนึ่งร้อยยี่สิบหก")
        XCTAssertEqual(thai.translate(10_000), "หนึ่งหมื่น")
        XCTAssertEqual(thai.translate(10_001), "หนึ่งหมื่นหนึ่ง")
        XCTAssertEqual(thai.translate(20_000), "สองหมื่น")
        XCTAssertEqual(thai.translate(20_001), "สองหมื่นหนึ่ง")
        XCTAssertEqual(thai.translate(20_010), "สองหมื่นสิบ")
        XCTAssertEqual(thai.translate(20_101), "สองหมื่นหนึ่งร้อยหนึ่ง")
        XCTAssertEqual(thai.translate(100_000), "หนึ่งแสน")
        XCTAssertEqual(thai.translate(100_001), "หนึ่งแสนหนึ่ง")
        XCTAssertEqual(thai.translate(200_000), "สองแสน")
        XCTAssertEqual(thai.translate(201_000), "สองแสนหนึ่งพัน")
        XCTAssertEqual(thai.translate(200_001), "สองแสนหนึ่ง")
        XCTAssertEqual(thai.translate(201_001), "สองแสนหนึ่งพันหนึ่ง")
        XCTAssertEqual(thai.translate(300_451), "สามแสนสี่ร้อยห้าสิบเอ็ด")
        XCTAssertEqual(thai.translate(502_305), "ห้าแสนสองพันสามร้อยห้า")
        XCTAssertEqual(thai.translate(999_999), "เก้าแสนเก้าหมื่นเก้าพันเก้าร้อยเก้าสิบเก้า")
        XCTAssertEqual(thai.translate(21_700_098), "ยี่สิบเอ็ดล้านเจ็ดแสนเก้าสิบแปด")
        XCTAssertEqual(thai.translate(62_000_000), "หกสิบสองล้าน")
        XCTAssertEqual(thai.translate(62_003_005), "หกสิบสองล้านสามพันห้า")
        XCTAssertEqual(thai.translate(62_003_105), "หกสิบสองล้านสามพันหนึ่งร้อยห้า")
        XCTAssertEqual(thai.translate(62_003_155), "หกสิบสองล้านสามพันหนึ่งร้อยห้าสิบห้า")
        XCTAssertEqual(thai.translate(999_999_999), "เก้าร้อยเก้าสิบเก้าล้านเก้าแสนเก้าหมื่นเก้าพันเก้าร้อยเก้าสิบเก้า")
        XCTAssertEqual(thai.translate(99_000_000_909), "เก้าสิบเก้าพันล้านเก้าร้อยเก้า")
        XCTAssertEqual(thai.translate(99_999_999_999), "เก้าสิบเก้าพันล้านเก้าร้อยเก้าสิบเก้าล้านเก้าแสนเก้าหมื่นเก้าพันเก้าร้อยเก้าสิบเก้า")
        XCTAssertEqual(thai.translate(-1), "ลบหนึ่ง")
        XCTAssertEqual(thai.translate(-1.5), "ลบหนึ่งจุดห้า")
        XCTAssertEqual(thai.translate(1.5), "หนึ่งจุดห้า")
        XCTAssertEqual(thai.translate(3.1415926), "สามจุดหนึ่งสี่หนึ่งห้าเก้าสองหก")
        XCTAssertEqual(thai.translate(-3.1415926), "ลบสามจุดหนึ่งสี่หนึ่งห้าเก้าสองหก")
        //XCTAssertEqual(thai.translate("3.4e13"), "สามจุดสี่เท่าสิบถึงพลังของสิบสาม")
        }
}
