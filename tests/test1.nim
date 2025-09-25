# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest
import cipherlib, encoding_lib

test "Caesar Cipher":
  check caesarEncode("Hello World", 3) == "Khoor Zruog"
  check caesarDecode("Khoor Zruog", 3) == "Hello World"
  
test "ROT13":
  check rot13("Hello World") == "Uryyb Jbeyq"
  check rot13("Uryyb Jbeyq") == "Hello World"

test "ROT47":
  check rot47Encode("Hello World!") == "w6==@ (@C=5P"
  check rot47Decode("w6==@ (@C=5P") == "Hello World!"

test "Vigenere Cipher":
  check vigenereEncode("ATTACKATDAWN", "LEMON") == "LXFOPVEFRNHR"
  check vigenereDecode("LXFOPVEFRNHR", "LEMON") == "ATTACKATDAWN"

test "Morse Code":
  check morseEncode("hello") == ".... . .-.. ---"
  check morseDecode(".... . .-.. ---") == "hello"


test "Bacon Code":
  require baconEncode("hello") == "AABBB AABAA ABABA  ABABA ABBAB"
  check baconDecode("AABBB AABAA ABABA ABABA ABBAB") == "hello"

