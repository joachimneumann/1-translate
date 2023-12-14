#!/usr/bin/env python3
import sys
import googletrans
from googletrans import Translator

from collections import namedtuple
Result = namedtuple('result', ["src", "dest", "text"])


# with open("english.translate.head") as file:
#     englishSource = "".join(line for line in file)


# translator = Translator()
# result = translator.translate(englishSource, src='en', dest='de')

languageName = "german"
languageCode = "de"
x = """1 Eins
2, zwei
3, drei
4, vier
5, fünf
6, sechs
7, sieben
8, acht
9, neun
"""

result = Result("en", languageCode, x)
print(result.src)
print(result.dest)
print(result.text)

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
    outputFile.write("    func test_"+languageName+"() {\n")
    outputFile.write("        let "+languageName+" = Translate"+languageName.capitalize()+"()\n")

    if languageName == "german":
        outputFile.write("        "+languageName+".useSoftHyphen = false\n")
        outputFile.write("        "+languageName+".capitalisation = false\n")

    for line in result.text.split("\n"):
        splitLine = line.split(" ")
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

#
# translator = Translator()
# languages = googletrans.LANGUAGES
# for languageCode, languageName in languages.items():
#     print(languageName)
#     result = translator.translate(englishSource, src='en', dest='de')
#     print(result)
#     exit(0)

#
# with open(sys.argv[1]) as file:
#     lines = file.readlines()
#
# outputFileName = sys.argv[1].replace(".txt", ".translate")
#
# with open(outputFileName, 'w') as outputFile:
#     for line in lines:
#         split = line.split(", ")
#         first = split[0].replace("        XCTAssertEqual(english.translate(", "")
#         first = first.replace(")", "")
#         second = split[1].replace("\")\n", "")
#         second = second.replace("\"", "")
#         if not len(split) == 2:
#             print("\nerror: wrong format in this line: " + line)
#             print(split)
#             exit(0)
#         outputFile.write(first + ", " + second+"\n")
# # outputFile.close()
