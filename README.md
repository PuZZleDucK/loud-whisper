# loud-whisper
browser -> rails -> wisper -> graphs

## browser
[x] Get audio (via js lib or gem?)
 - https://stackoverflow.com/questions/27846392/access-microphone-from-a-browser-javascript
[ ] Forward to rails controller
[ ] Rails controller creates a background job with a link back to the chat
[ ] Background job takes the audio chunk and passes it to wisper getting a transcript back
[ ] Concat transcript to chat log
[ ] Discard audio chunk

## possible issues
[ ] Aligning / overlapping audio chunks
  - capture extra overlapping chunks? and stitch back together?
  - use a stream somehow?
  - it might be ok with partials as long as a phoneme isn't split?

## rails
- [ ] pipeline
- [ ] tests
Versions:
- Rails 7.1.3
- ruby 3.1.0
- sqlite3 3.41.2

Dependancies:
- `sudo apt-get install libyaml-dev`
- wisper ... todo

## wisper
- pipe audio into wisper and log chat
- `wisper --input-file <audio-chunk>`

## graphs
- somthing more fancy than the histogram... word cloud
  - `<python-wcloud>`


## Other
* Configuration?
* Tests
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
