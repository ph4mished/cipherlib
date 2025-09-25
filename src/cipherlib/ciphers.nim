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

# Helper function to convert chararacter to uppercase
proc toUpper(c: char): char =
  if c in {'a'..'z'}:
    result = chr(ord(c) - ord('a') + ord('A'))
  else:
    result = c

# Helper function to convert chararacter to lowercase
proc toLower(c: char): char =
  if c in {'a'..'z'}:
    result = chr(ord(c) + ord('a') + ord('A'))
  else:
    result = c


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


#autokey is like vigenere cipher just that it adds the text to the key
#[proc autokeyEncode*(text, key: string): string =
  vigenereEncode(text, key & text)

proc autokeyDecode*(text, key: string): string = 
  vigenereDecode(text, key & text)]#


#bacon cipher is a steganographic cipher
#[const baconCode = {
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
  result = words.join(" ")]
proc baconDecode*(bacon: string): string =
  var chars: seq[char] = @[]
  for code in bacon.split(' '):
    if code in reverseBacon:
      chars.add(reverseBacon[code])
  result = chars.join("")]#

  #bacon cipher2
  #Although this bacon cipher uses all the 26 letters of the english alphabet, only 24 are recognized
  #'i' and 'j' share the same bacon code and also 'u' and 'v' also share  the same bacon code
 
  #thought: decoding this cipher is going to be a bit tricky without anything for validation

  #additions
  #bacon steganographic encryption functions will be added
  #it will accept covertext and text to hide

  #thougt: i think i'll fallback to using baconEncode(codeNumber, text). where the code number will be either 24 or 26. empty will mean 24.
  #wont it be too error prone than being explicit on the function name
const bacon24Table = block:
    var table = initTable[string, char]()
    const baconLetters = "abcdefghiklmnopqrstuwxyz"
    for i, ch in baconLetters:
        var baconCode = toBin(i, 5).replace("0", "A").replace("1", "B")
        table[baconCode] = ch
    table

const bacon26Table = block:
    var table = initTable[string, char]()
    const baconLetters = "abcdefghijklmnopqrstuvwxyz" 
    for i, ch in baconLetters:
        var baconCode = toBin(i, 5).replace("0", "A").replace("1", "B")
        table[baconCode] = ch
    table



  #to ensure j maps to the value of i and same as v and u
proc mapChars(ch: char): char =
  case ch
  of 'j' : 'i'
  of 'v' : 'u'
  else:
    ch

proc baconEncode*(cipherSize: int, text: string): string = 
  result = ""
  for ch in text.toLowerAscii():
    if ch in {'a'..'z'}:
      if cipherSize == 24:
        let mc = mapChars(ch)
        let i = ord(mc) - ord('a')
        var bin = toBin(i, 5)
        result.add(bin.replace("0", "A").replace("1", "B"))
        result.add(" ")
      elif cipherSize == 26:
        let i = ord(ch) - ord('a')
        var bin = toBin(i, 5)
        result.add(bin.replace("0", "A").replace("1", "B"))
        result.add(" ")
    else:
      result.add(ch)


proc baconDecode*(cipherSize: int, bacon: string): string =
  result = ""
  for code in bacon.split(' '):
    if cipherSize == 24:
      if code.len == 5 and code in bacon24Table:
        result.add(bacon24Table[code])
      elif code.len == 0:
            result.add(" ")
      else:
        result.add(code)
    elif cipherSize == 26:
      if code.len == 5 and code in bacon26Table:
        result.add(bacon26Table[code])
      elif code.len == 0:
            result.add(" ")
      else:
        result.add(code)



proc bacon24Encode*(text: string): string =
  baconEncode(24, text)

 

proc bacon24Decode*(bacon: string): string =
  baconDecode(24, bacon)


#Bacon 26. This one uses the 26 letters of the english alphabet where each letter has its unique bacon code

proc bacon26Encode*(text: string): string =
  baconEncode(26, text)


proc bacon26Decode*(bacon: string): string =
  baconDecode(26, bacon)



#Bacon steganographic encoding
#[proc bacon24StegoEncode*(coverText, message: string): string =  
  if coverText.len < message.len*5:
    raise newException(ValueError, "Cover text is too short for message")
  else:
    #var result = newString(coverText.len)
    var i = 0
    var output = ""
    let encodedText = bacon24Encode(message)
    #for ch in encodedText:
    for ch in coverText:
      if ch.isAlphaAscii():
        if encodedText[i] == 'A':
          echo encodedText[1]
          output.add(ch.toLowerAscii())
        elif encodedText[1] == 'B':
            output.add(ch.toUpperAscii())
            inc i 
        else:
            output.add(ch)
      return output]#

proc bacon24StegoEncode*(coverText, message: string): string =
  result = newString(coverText.len)
  
  let encMessage = bacon24Encode(message).replace(" ", "")
  var j = 0
  var output = ""
  for i, c in coverText:
    if c.isAlphaAscii():
      if encMessage[j] == 'A' and j <  encMessage.len:
        output.add toLowerAscii(c)
        inc j
      else:
        output.add toUpperAscii(c)
        inc j
    else:
      #result[i] = c
      output.add c

  echo "Processsed ", j, "bits out of ", encMessage.len
  return output

      
   
#since bacon uses 5 bits units, the coverText should be 5*message.len in order for a sensible encoding
#to take place\
#logic
#[it encodes the message and make length checks 
it the toggles the case of the covertext based on the bit of the encoded message
spaces and symbols are an exception for toggling]#
