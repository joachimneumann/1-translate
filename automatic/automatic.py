#!/usr/bin/env python3
import sys
import googletrans
from googletrans import Translator

# from collections import namedtuple
# Result = namedtuple('result', ["src", "dest", "text"])
# languageName = "german"
# languageCode = "de"
# x = """1 Eins
# 2, zwei
# 3, drei
# 4, vier
# 5, fünf
# 6, sechs
# 7, sieben
# 8, acht
# 9, neun
# """
# result = Result("en", languageCode, x)
# print(result.src)
# print(result.dest)
# print(result.text)

languageName = "german"
languageCode = "de"

with open("originalEnglish.txt") as file:
    englishSource = "".join(line for line in file)

translator = Translator()

languages = googletrans.LANGUAGES
for languageCode, languageName in languages.items():
    print(languageName)
    result = translator.translate(englishSource, src='en', dest=languageCode)

    outputFileName = "Test_Automatic_"+languageName.capitalize()+".swift"
    with open(outputFileName, 'w') as outputFile:
        outputFile.write("//\n")
        outputFile.write("//  "+outputFileName+"\n")
        outputFile.write("//\n")
        outputFile.write("//  Created by automatic.py\n")
        outputFile.write("//\n")
        outputFile.write("\n")
        outputFile.write("import XCTest\n")
        outputFile.write("\n")
        outputFile.write("final class TranslationsTestsAutomatic"+languageName.capitalize()+": XCTestCase {\n")
        outputFile.write("\n")
        outputFile.write("    func test_automatic_"+languageName+"() {\n")
        outputFile.write("        let "+languageName+" = Translate"+languageName.capitalize()+"()\n")
        outputFile.write("        "+languageName+".groupSeparator = \"\"\n")
        outputFile.write("        "+languageName+".decimalSeparator = \".\"\n")

        if languageName == "german":
            outputFile.write("        "+languageName+".useSoftHyphen = false\n")
            outputFile.write("        "+languageName+".capitalisation = false\n")

        for line in result.text.split("\n"):
            splitLine = line.split(" ", 1)
            if not line == "":
                if not len(splitLine) == 2:
                    print("Error: line not two components:")
                    print("XXX"+line+"XXX")
                    exit(0)
                number = splitLine[0]
                number = number.replace(" ", "")
                number = number.replace(",", "")
                translation = splitLine[1]
                translation = translation.replace(" ", "")
                translation = translation.replace(",", "")
                outputFile.write("        XCTAssertEqual("+languageName+".translate("+number+"), \""+translation+"\")\n")
        outputFile.write("        }\n")
        outputFile.write("}\n")

    outputFile.close()
