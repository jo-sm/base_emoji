require_relative '../lib/base_emoji/base64'

RSpec.describe 'BaseEmoji Base64 methods' do
	context '#encode_base64' do
		it 'properly encodes strings according to RFC 4648' do
			expect(BaseEmoji.encode_base64).to eq ''
			expect(BaseEmoji.encode_base64('f')).to eq 'Zg=='
			expect(BaseEmoji.encode_base64('fo')).to eq 'Zm8='
			expect(BaseEmoji.encode_base64('foo')).to eq 'Zm9v'
			expect(BaseEmoji.encode_base64('foob')).to eq 'Zm9vYg=='
			expect(BaseEmoji.encode_base64('fooba')).to eq 'Zm9vYmE='
			expect(BaseEmoji.encode_base64('foobar')).to eq 'Zm9vYmFy'
		end
	end

	context '#decode_base64' do
		it 'properly decodes encoded values' do
			expect(BaseEmoji.decode_base64('Zg==')).to eq 'f'
			expect(BaseEmoji.decode_base64('Zm8=')).to eq 'fo'
			expect(BaseEmoji.decode_base64('Zm9v')).to eq 'foo'
			expect(BaseEmoji.decode_base64('Zm9vYg==')).to eq 'foob'
			expect(BaseEmoji.decode_base64('Zm9vYmE=')).to eq 'fooba'
			expect(BaseEmoji.decode_base64('Zm9vYmFy')).to eq 'foobar'
		end

		it 'raises if encoding is incorrect or missing' do
			expect{BaseEmoji.decode_base64}.to raise_error(ArgumentError)
			expect{BaseEmoji.decode_base64('foobar')}.to raise_error(RuntimeError)
			expect{BaseEmoji.decode_base64('foo-')}.to raise_error(RuntimeError)
		end
	end
end