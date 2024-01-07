#!/usr/bin/env python3
import glob, os


for file in glob.glob("../../1-translate-tests/language/*.txt"):       ## first get full file name with directores using for loop
    filename = os.path.basename(file).replace(".txt", "")
    f = open(filename+".swift", 'w')
    f.write("// LanguageTests\n")
    f.write("//\n")
    f.write("// automatically generated)\n")
    f.write("// do not edit\n")
    f.write("\n")
    f.write("\n")
    f.write("import XCTest\n")
    f.write("\n")
    f.write("final class Test_"+filename+": XCTestCase {\n")
    f.write("\n")
    f.write("    let languages = Languages()\n")
    f.write("\n")
    f.write("    func test_"+filename+"() {\n")
    f.write("        let language = languages."+filename+"\n")

    with open(file) as file:
        for line in file:
            components = line.replace("\n", "").split(" ")
            if len(components) > 1:
                if components[0] == "SETTINGS":
                    f.write("        language."+components[1]+" = "+components[2]+"\n")
                else:
                    f.write("        XCTAssertEqual(language.read("+components[0]+").x, \""+" ".join(components[1:])+"\")\n")
    f.write("    }\n")
    f.write("}\n")
    f.close()

#     englishSource = "".join(line for line in file)
#
# translator = Translator()
#
# languages = googletrans.LANGUAGES
# for languageCode, languageName in languages.items():
#     outputFileName = "Test_Automatic_"+languageName.capitalize()+".swift"
#     if os.path.exists(outputFileName):
#         print(languageName+" already exists")
#     else :
#         print(languageName)
#         result = translator.translate(englishSource, src='en', dest=languageCode)
#         with open(outputFileName, 'w') as outputFile:
#             outputFile.write("//")
#             outputFile.write("//  "+outputFileName+"")
#             outputFile.write("//")
#             outputFile.write("//  Created by automatic.py")
#             outputFile.write("//")
#             outputFile.write("")
#             outputFile.write("import XCTest")
#             outputFile.write("")
#             outputFile.write("final class TranslationsTestsAutomatic"+languageName.capitalize()+": XCTestCase {")
#             outputFile.write("")
#             outputFile.write("    func test_automatic_"+languageName+"() {")
#             outputFile.write("        let "+languageName+" = Translate"+languageName.capitalize()+"()")
#             outputFile.write("        "+languageName+".groupSeparator = \"\"")
#             outputFile.write("        "+languageName+".decimalSeparator = \".\"")
#
#             if languageName == "german":
#                 outputFile.write("        "+languageName+".useSoftHyphen = false")
#                 outputFile.write("        "+languageName+".capitalisation = false")
#
#             for line in result.text.split(""):
#                 splitLine = line.split(" ", 1)
#                 if not line == "":
#                     if not len(splitLine) == 2:
#                         f.write("Error: line not two components:")
#                         f.write("XXX"+line+"XXX")
#                     else:
#                         number = splitLine[0]
#                         number = number.replace(" ", "")
#                         number = number.replace(",", "")
#                         translation = splitLine[1]
#                         translation = translation.replace(" ", "")
#                         translation = translation.replace(",", "")
#                         outputFile.write("        XCTAssertEqual("+languageName+".translate("+number+"), \""+translation+"\")")
#             outputFile.write("        }")
#             outputFile.write("}")
#
#         outputFile.close()
