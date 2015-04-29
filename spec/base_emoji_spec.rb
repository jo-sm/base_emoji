require_relative '../lib/base_emoji/base_emoji'

RSpec.describe BaseEmoji do
	context '#encode_base_emoji' do
		it 'properly encodes strings' do
			expect(BaseEmoji.encode_base_emoji).to eq '🙅'
			expect(BaseEmoji.encode_base_emoji('f')).to eq '🍳🏈😡'
			expect(BaseEmoji.encode_base_emoji('fo')).to eq '🙅🐢🎷💥'
			expect(BaseEmoji.encode_base_emoji('foo')).to eq '🗿👻😻🏁🎷'
			expect(BaseEmoji.encode_base_emoji('foob')).to eq '🐚😻⛄🔫🏮🐚💯'
			expect(BaseEmoji.encode_base_emoji('fooba')).to eq '💯🚥⚡🚥🎃⚡💯👺'
			expect(BaseEmoji.encode_base_emoji('foobar')).to eq '😾🚩🍧🏁🍁🏈🚥🍧🎅'
		end
	end

	context '#decode_base_emoji' do
		it 'properly decodes encoded values' do
			expect(BaseEmoji.decode_base_emoji('🙅')).to eq ''
			expect(BaseEmoji.decode_base_emoji('🍳🏈😡')).to eq 'f'
			expect(BaseEmoji.decode_base_emoji('🙅🐢🎷💥')).to eq 'fo'
			expect(BaseEmoji.decode_base_emoji('🗿👻😻🏁🎷')).to eq 'foo'
			expect(BaseEmoji.decode_base_emoji('🐚😻⛄🔫🏮🐚💯')).to eq 'foob'
			expect(BaseEmoji.decode_base_emoji('💯🚥⚡🚥🎃⚡💯👺')).to eq 'fooba'
			expect(BaseEmoji.decode_base_emoji('😾🚩🍧🏁🍁🏈🚥🍧🎅')).to eq 'foobar'
		end

		it 'raises if the encoding is incorrect or missing' do
			expect{BaseEmoji.decode_base_emoji('🐚😻⛄💯')}.to raise_error(RuntimeError)
			expect{BaseEmoji.decode_base_emoji('foobar')}.to raise_error(RuntimeError)
			expect{BaseEmoji.decode_base_emoji}.to raise_error(ArgumentError)
		end
	end
end