import tables, strutils



#other encodings to add
#semaphore
#base32

#ENCODING ALGORITHMS
# Simple Morse Code implementation
const morseCode = {
  'A': ".-", 'B': "-...", 'C': "-.-.", 'D': "-..", 'E': ".", 'F': "..-.",
  'G': "--.", 'H': "....", 'I': "..", 'J': ".---", 'K': "-.-", 'L': ".-..",
  'M': "--", 'N': "-.", 'O': "---", 'P': ".--.", 'Q': "--.-", 'R': ".-.",
  'S': "...", 'T': "-", 'U': "..-", 'V': "...-", 'W': ".--", 'X': "-..-",
  'Y': "-.--", 'Z': "--..", '0': "-----", '1': ".----", '2': "..---",
  '3': "...--", '4': "....-", '5': ".....", '6': "-....", '7': "--...",
  '8': "---..", '9': "----.", '.': ".-.-.-", ',': "--..--", '?': "..--.."
}.toTable

const reverseMorse = block:
  var table: Table[string, char]
  for key, value in morseCode:
    table[value] = key
  table

proc morseEncode*(text: string): string =
  var words: seq[string] = @[]
  for ch in text.toUpperAscii():
    if ch in morseCode:
      words.add(morseCode[ch])
    elif ch == ' ':
      words.add(" ")
  result = words.join(" ")

proc morseDecode*(morse: string): string =
  var chars: seq[char] = @[]
  for code in morse.split(' '):
    if code in reverseMorse:
      chars.add(reverseMorse[code])
    else:
        chars.add(' ')
  result = chars.join("")



