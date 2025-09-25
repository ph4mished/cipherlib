import strutils, tables

#this now looks good but still needs much improvement
#other ciphers to add
#affine cipher
#rail fence cipher
#keyword cipher
#beaufort cipher
#porta
#chaocipher
#gronsfeld cipher (vigenere cipher that  uses numbers instead of letters)




#there are differences between ciphers and encoding

#ciphers requires a key or algorithm knowledge before the encrypted data can be reversed to its raw form. eg Ceasar and AES.
# ciphers can also be called cryptography

#encodings on the other hand do not need any key for data transformation or retrieval, hence they are easy to reverse. eg. base64, base32, morse and braille code

#CIPHER LIBS
# Caesar Cipher Encoding
proc caesarEncode*(text: string, shift: int): string =
  result = newString(text.len)
  for i, c in text:
    if c in {'a'..'z'}:
      result[i] = chr((ord(c) - ord('a') + shift) mod 26 + ord('a'))
    elif c in {'A'..'Z'}:
      result[i] = chr((ord(c) - ord('A') + shift) mod 26 + ord('A'))
    else:
      result[i] = c

#Caesar cipher decoding
proc caesarDecode*(text: string, shift: int): string =
  caesarEncode(text, 26 - shift)

# ROT13 (special case of Caesar by using shift count of 13)
proc rot13*(text: string): string =
  caesarEncode(text, 13)

# ROT47
proc rot47Encode*(text: string): string =
  result = newString(text.len)
  for i, c in text:
    if c >= '!' and c <= '~':
      result[i] = chr((ord(c) - 33 + 47) mod 94 + 33)
    else:
      result[i] = c

proc rot47Decode*(text: string): string =
  rot47Encode(text)  # ROT47 is self-reversible

# Helper function to convert chararacter to uppercase
proc toUpper*(c: char): char =
  if c in {'a'..'z'}:
    result = chr(ord(c) - ord('a') + ord('A'))
  else:
    result = c

# Vigenère Cipher (Fixed)
proc vigenereEncode*(text, key: string): string =
  result = newString(text.len)
  var keyIndex = 0
  for i, c in text:
    if c in {'a'..'z'}:
      let shift = ord(key[keyIndex mod key.len].toUpper) - ord('A')
      result[i] = chr((ord(c) - ord('a') + shift) mod 26 + ord('a'))
      inc keyIndex
    elif c in {'A'..'Z'}:
      let shift = ord(key[keyIndex mod key.len].toUpper) - ord('A')
      result[i] = chr((ord(c) - ord('A') + shift) mod 26 + ord('A'))
      inc keyIndex
    else:
      result[i] = c

proc vigenereDecode*(text, key: string): string =
  result = newString(text.len)
  var keyIndex = 0
  for i, c in text:
    if c in {'a'..'z'}:
      let shift = ord(key[keyIndex mod key.len].toUpper) - ord('A')
      result[i] = chr((ord(c) - ord('a') - shift + 26) mod 26 + ord('a'))
      inc keyIndex
    elif c in {'A'..'Z'}:
      let shift = ord(key[keyIndex mod key.len].toUpper) - ord('A')
      result[i] = chr((ord(c) - ord('A') - shift + 26) mod 26 + ord('A'))
      inc keyIndex
    else:
      result[i] = c

#this is like caesars cipher but returns result in uppercase
proc gronsfeldEncode*(text: string, key: int): string = 
  caesarEncode(text, key).toUpperAscii
#ill come back to you


#autohotkey is like vigenere cipher just that it adds the text to the key
proc autokeyEncode*(text, key: string): string =
  vigenereEncode(text, key & text)

proc autokeyDecode*(text, key: string): string = 
  vigenereDecode(text, key & text)


#bacon cipher is a steganographic cipher
const baconCode = {
  'a': "AAAAA", 'b': "AAAAB", 'c': "AAABA", 'd': "AAABB", 'e': "AABAA", 'f': "AABAB",
  'g': "AABBA", 'h': "AABBB", 'i': "ABAAA", 'j': "ABAAA", 'k': "ABAAB", 'l': "ABABA",
  'm': "ABABB", 'n': "ABBAA", 'o': "ABBAB", 'p': "ABBBA", 'q': "ABBBB", 'r': "BAAAA",
  's': "BAAAB", 't': "BAABA", 'u': "BAABB", 'v': "BAABB", 'w': "BABAA", 'x': "BABAB",
  'y': "BABBA", 'z': "BABBB"
}.toTable

const reverseBacon = block:
  var table: Table[string, char]
  for key, value in baconCode:
    table[value] = key
  table

proc baconEncode*(text: string): string =
  var words: seq[string] = @[]
  for ch in text:
    if ch in baconCode:
      words.add(baconCode[ch])
  result = words.join(" ")

proc baconDecode*(bacon: string): string =
  var chars: seq[char] = @[]
  for code in bacon.split(' '):
    if code in reverseBacon:
      chars.add(reverseBacon[code])
  result = chars.join("")




