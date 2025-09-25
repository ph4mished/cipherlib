# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest
import cipherlib

#other tests: with symbols, 
suite "Caesar Cipher":
  test "caesar with spaces":
    check caesarEncode("hello world", 3) == "khoor zruog"
    check caesarDecode("khoor zruog", 3) == "hello world"

  test "case-sensitive caesar ":
  check caesarEncode("HelLo World", 3) == "KhoOr Zruog"
  check caesarDecode("KHoor Zruog", 3) == "HEllo World"
  

suite "ROT13 Cipher":
  test "ROT13 with spaces":
    check rot13("hello world") == "uryyb jbeyq"
    check rot13("uryyb jbeyq") == "hello world"
  
  test "case-sensitiveRROT13":
  check rot13("Hello WoRld") == "Uryyb JbEyq"
  check rot13("UrYyb JbeyQ") == "HeLlo WorlD"


suite "ROT47 Cipher":
  test "ROT47 with spaces":
    check rot47Encode("hello world") == "96==@ H@C=5"
    check rot47Decode("96==@ H@C=5") == "hello world"

   test "case-insensitive ROT47":
    check rot47Encode("hELLo wOrlD") == "9t{{@ H~C=s"
    check rot47Decode("9t{{@ H~C=s") == "hELLo wOrlD"

suite "Vigenere Cipher"
  test "vigenere with spaces":
    check vigenereEncode("attack at dawn", "sword") == "sphrfc wh udoj"
    check vigenereDecode("sphrfc wh udoj", "sword") == "attack at dawn"

  test "case-sensitive vigenere":
  check vigenereEncode("aTTackAtdaWN", "SWoRd") == "sPHrfcWhudOJ"
  check vigenereDecode("sPHrfcWhudOJ", "sword") == "aTTackAtdaWN"

suite "Morse Code"
  test "morse code with spaces":
    check morseEncode("hello world") == ".... . .-.. .-.. ---  .-- --- .-. .-.. -.."
    check morseDecode(".... . .-.. .-.. ---  .-- --- .-. .-.. -..") == "hello world"

  test "case-sensitive morse code":
    check morseEncode("HeLLO WoRLd") == ".... . .-.. .-.. ---  .-- --- .-. .-.. -.."
    check morseDecode(".... . .-.. .-.. ---  .-- --- .-. .-.. -..") == "HeLLO WoRLd"


test "Bacon Code":
  require baconEncode("hello") == "AABBB AABAA ABABA  ABABA ABBAB"
  check baconDecode("AABBB AABAA ABABA ABABA ABBAB") == "hello"

