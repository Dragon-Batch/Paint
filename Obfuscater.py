import sys, random, string, os

if len(sys.argv) > 1:
    if os.path.isfile(sys.argv[1]) == False:
        print('batch file must exist.')
        sys.exit()
else:
    print('batch file is needed.')
    sys.exit()

input_name = sys.argv[1]
output_name = "Obfuscated." + input_name

random_name_letters = random.choice(['capital_letters','lowercase_letters'])
if random_name_letters == 'capital_letters':
    name_chars = string.ascii_lowercase + "@#$_+-{[]},.?"
else:
    name_chars = string.ascii_uppercase + "@#$_+-{[]},.?"

must_escape_chars = '><^|"~'
random_mess = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
all_chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$-_+/(){}[],.? " + must_escape_chars
random_mess_list = []
char_dictionary = {}
is_in_variable = False

def generate_mess (min_len=4, max_len=7):
    while True:
        building_mess = ""
        for a in range(random.randint(min_len, max_len)):
            building_mess += random.choice(name_chars)
        if building_mess not in random_mess_list:
            random_mess_list.append(building_mess)
            return(building_mess)

for a in all_chars:
    char_dictionary[f"{a}"] = []
    for b in range(10):
        char_dictionary[f"{a}"].append(generate_mess())


set_name = generate_mess()
space_name = generate_mess()
equals_name = generate_mess()


obfuscated = (
    "@echo off\n"
    "echo Depending On The Size Of This Package.\n"
    "echo This Might Take A bit.\n"
    "echo Please Feel Free To Do Something Else\n"
    "echo While This Is Opening...\n"
    f"set {set_name}=set\n"
    f"%{set_name}% \"{space_name}= \"\n"
    f"%{set_name}%%{space_name}%{equals_name}==\n"
)

for a in all_chars:
    if a in must_escape_chars:
        if a == '^':
            for b in range(len(char_dictionary[f"{a}"])):
                obfuscated += f"%{set_name}%%{space_name}%" + char_dictionary[f"{a}"][b] + f"%{equals_name}%^{a}\n"
        else:
            if a == '%':
                for b in range(len(char_dictionary[f"{a}"])):
                    obfuscated += f"%{set_name}%%{space_name}%" + char_dictionary[f"{a}"][b] + f"%{equals_name}%%\n"
            else:
                for b in range(len(char_dictionary[f"{a}"])):
                    obfuscated += f"%{set_name}%%{space_name}%" + char_dictionary[f"{a}"][b] + f"%{equals_name}%^{a}\n"
    else:
        for b in range(len(char_dictionary[f"{a}"])):
            obfuscated += f"%{set_name}%%{space_name}%" + char_dictionary[f"{a}"][b] + f"%{equals_name}%{a}\n"

obfuscated += f"%{random.choice(char_dictionary['c'])}%%{random.choice(char_dictionary['l'])}%%{random.choice(char_dictionary['s'])}%\n"

with open(input_name, mode="r", encoding="utf-8") as input_file:
    with open(output_name, mode="w", encoding="utf-8") as output_file:
        for a in input_file.readlines():
            if not a.startswith(":") == True:
                building_line = ""
                for b in a:
                    if b == "%":
                        if is_in_variable == False:
                            is_in_variable = True
                        else:
                            is_in_variable = False
                    if is_in_variable == False:
                        if b in all_chars:
                            building_line += b.replace(b, "%{}%".format(random.choice(char_dictionary[f"{b}"])))
                        else:
                            building_line += b
                    else:
                        building_line += b
            obfuscated += a + '\n'
        output_file.write(obfuscated)