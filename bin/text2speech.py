#!/usr/bin/env
#

from gtts import gTTS

with open("transcript.txt", "r") as trans:
  text = trans.read()
tts = gTTS(text, lang='en', tld='co.uk')
tts.save("pukki_british_voice.mp3")

