BaseEmoji: Encode your text as emoji
====================================

## What is it?

`BaseEmoji` is a way to encode your text into emoji. It's just like encoding into base64. You can encode `foobar` into `😾🚩🍧🏁🍁🏈🚥🍧🎅`!

Additionally, `BaseEmoji` also contains utilities for encoding and decoding `base64` (RFC), `base32` (RFC, not Crockford), `base36`, (strings/integers) `base58` (strings/integers, using the Flickr alphabet), and `base16` (RFC). 

## Who might use it?

Anyone who has a use for any of the above mentioned encoding schemes.

## Does it save space?

Just like `base64` and `base32`, `base_emoji`'s encoded strings are different and use a different amount of space compared to the original string:

```ruby
"foobar".bytesize # => 6
encoded = BaseEmoji.encode_base_emoji("foobar") # => "😾🚩🍧🏁🍁🏈🚥🍧🎅"
encoded.bytesize # => 36

"Hello world".bytesize # => 11
encoded = BaseEmoji.encode_base_emoji("Hello world") # => "😻🔋🍆🐢👺💥🎷😻💯😤🍻😎💥👺🎅😾"
encoded.bytesize # => 64

"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pulvinar.".bytesize # => 75
encoded = BaseEmoji.encode_base_emoji("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pulvinar.") # => "💥😋🔫😳⛔🍕🏈💨😈😘🍆🍳🍻💨🚴😻😾🌊🎴🚴🍕😈😤👺🙅👾🎴😃👺😀🙅😾😖😄💁🚩🍧💨🎭👾🎭🎃😘🚩🌊⭐👺😱💥😀🌊🍻💣🎷🐢💯😖🍕👺🏮😡🍰🚴💣🍻🙈💣🎷😋⭐🏈🍺🍕😱😈😾😉😤🍑😈🙈😉🚩😾🎷😍🐢💁🎅⭐😖😘😋😘😱🐢😤🎴😾😤💯🙅😍"
encoded.bytesize # => 408
```

As you can see, encoding in base emoji is on average 6x larger than the encoded string. 

## Testing

This library uses RSpec to run its tests. To run the test suite, run `rspec --format doc`

## License

MIT

## Copyright

2015 Joshua Smock