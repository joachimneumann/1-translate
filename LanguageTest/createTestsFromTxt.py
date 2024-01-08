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
        if "." in number or "e" in number and not number.startswith("temp"):
            number = "\""+number+"\""
        translated = " ".join(components[1:])
        normalAndOverline = translated.split("OVERLINE")
        if len(normalAndOverline) != 2:
            if not "Impl." in translated:
                translated = "\""+translated+"\""
            write_("XCTAssertEqual(language.read(")
            write(number)
            write(").x, ")
            write(translated)
            write(")")
        else:
            normal = normalAndOverline[0].strip()
            if not "Impl." in normal:
                normal = "\""+normal+"\""
            overline = normalAndOverline[1].strip()
            if not "Impl." in overline:
                overline = "\""+overline+"\""
            write_("XCTAssertEqual(language.read(")
            write(number)
            write(").x, ")
            write(overline)
            write(")\n")
            write_("XCTAssertEqual(language.read_OVERLINE(")
            write(number)
            write(")!.x, ")
            write(normal)
            write(")")
    else:
        write("// "+" ".join(components))

for file in glob.glob("../../1-translate-tests/language/*.txt"):       ## first get full file name with directores using for loop
    tempIndex = 1
    filename = os.path.basename(file).replace(".txt", "")
    f = open(filename+".swift", 'w')
    writeln("// LanguageTests")
    writeln("//")
    writeln("// automatically generated)")
    writeln("// do not edit")
    writeln("")
    writeln("")
    writeln("import XCTest")
    writeln("")
    writeln("final class Test_"+filename+": XCTestCase {")
    writeln("")
    writeln("    let languages = Languages()")
    writeln("")
    writeln("    func test_"+filename+"() {")
    writeln("        let language = languages."+filename)

    with open(file) as file:
        for line in file:
            line = line.strip()
            if len(line) > 0:
                contentAndComment = line.split("//")
                content = contentAndComment[0].strip()
                comment = " ".join(contentAndComment[1:]).strip()

                if len(content) == 0:
                    if len(comment) > 0:
                        write("// "+comment)
                components = content.strip().split(" ")
                if len(components) < 2:
                    if len(components) < 2:
                        write("// "+components[0]+"\n")
                else:
                    if components[0] == "SETTINGS":
                        writeln("")
                        write_("language.")
                        write(components[1])
                        write(" = ")
                        write(components[2])
                        if len(comment) > 0:
                            write("// "+comment)
                    else:
                        assertEqual(components)
                        if len(comment) > 0:
                            write("  // "+comment)
                    writeln("")
    writeln("    }")
    writeln("}")
    f.close()
