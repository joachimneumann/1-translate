#!/usr/bin/env python3
import glob, os

def is_number(number):
    is_number = True
    try:
        num = float(number)
        # check for "nan" floats
        is_number = num == num   # or use `math.isnan(num)`
    except ValueError:
        is_number = False
    return is_number

def is_calculation(number):
    if number.startswith("-"):
        testNumber = number[1:]
    else:
        testNumber = number
    if any(ext in ["+", "-", "*", "/"] for ext in testNumber):
        return True
    return False

def write(content):
    f.write(content)
def writeln(content):
    write(content)
    write("\n")
def writeln_(content):
    write_(content)
    write("\n")
def write_(content):
    write("        ")
    write(content)

tempIndex = 1

def assertEqual(components):
    global tempIndex
    number = components[0]
    if is_calculation(number):
        temp = "temp"+str(tempIndex)
        writeln("")
        writeln_("let "+temp+" = "+number)
        number = temp
        tempIndex = tempIndex + 1
    if is_number(number) or number.startswith("temp"):
        #if "." in number or "e" in number and not number.startswith("temp"):
        if "e" in number and not number.startswith("temp"):
            number = "\""+number+"\""
        translated = " ".join(components[1:])
        if not "Implementation." in translated:
            translated = "\""+translated+"\""
        write_("XCTAssertEqual(language.translate(")
        write(number)
        write(").x, ")
        write(translated)
        write(")")
    else:
        write_("// "+" ".join(components))

# Get full file name with directores using for loop
for file in glob.glob("../../1-translate-tests/language/*.txt"):
    tempIndex = 1
    
    basename = os.path.basename(file).replace(".txt", "")
    variant = None
    variantCapitalized = None
    if "VARIANT" in basename:
        parts = basename.split("VARIANT")
        basename = parts[0]
        variant = parts[1]
        variantCapitalized = variant[0].upper() + variant[1:]
    basenameCapitalized = basename[0].upper() + basename[1:]

    # is this language implemented?
    implementation = basenameCapitalized+".swift"
    implementationWithPath = "../NumberTranslator/LanguageImplementation/" + implementation
    if not os.path.isfile(implementationWithPath):
        #print(implementationWithPath, "not found")
        continue
    
    print(implementation)

    
    if variant == None:
        f = open(basenameCapitalized+"Test.swift", 'w')
    else:
        f = open(basenameCapitalized+variantCapitalized+"Test.swift", 'w')
    writeln("// Note: This file is automatically generated")
    writeln("//       It will be overwritten when testing")
    writeln("")
    writeln("import XCTest")
    writeln("import NumberTranslator")
    writeln("")
    if variant == None:
        writeln("final class Test_"+basenameCapitalized+": XCTestCase {")
        writeln("    let language = "+basenameCapitalized+"Implementation()")
        writeln("    func test"+basenameCapitalized+"() {")
    else:
        writeln("final class Test_"+basenameCapitalized+variantCapitalized+": XCTestCase {")
        writeln("    let language = "+basenameCapitalized+"Implementation(variant: "+basenameCapitalized+"Implementation.Variant."+variant+")")
        writeln("    func test"+basenameCapitalized+variantCapitalized+"() {")

    with open(file) as file:
        for line in file:
            line = line.strip()
            if len(line) > 0:
                contentAndComment = line.split("//")
                content = contentAndComment[0].strip()
                comment = " ".join(contentAndComment[1:]).strip()

                if len(content) == 0:
                    if len(comment) > 0:
                        writeln_("// "+comment)
                else:
                    components = content.strip().split(" ")
                    if len(components) < 2:
                        write_("// "+components[0]+"\n")
                    else:
                        if components[0] == "SETTINGS":
                            writeln("")
                            write_("language.")
                            write(components[1])
                            write(" = ")
                            write(components[2])
                            if len(comment) > 0:
                                write(" // "+comment)
                        else:
                            assertEqual(components)
                            if len(comment) > 0:
                                write(" // "+comment)
                        writeln("")
    writeln("    }")
    writeln("}")
    f.close()
