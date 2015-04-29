require_relative '../lib/base_emoji/base36'

RSpec.describe 'BaseEmoji Base32 methods' do
	context '#encode_base36' do
		it 'properly encodes integers' do
			expect(BaseEmoji.encode_base36).to eq '0'
			expect(BaseEmoji.encode_base36(2)). to eq '2'
			expect(BaseEmoji.encode_base36(4)). to eq '4'
			expect(BaseEmoji.encode_base36(8)). to eq '8'
			expect(BaseEmoji.encode_base36(16)). to eq 'g'
			expect(BaseEmoji.encode_base36(32)). to eq 'w'
			expect(BaseEmoji.encode_base36(64)). to eq '1s'
			expect(BaseEmoji.encode_base36(128)). to eq '3k'
			expect(BaseEmoji.encode_base36(256)). to eq '74'
		end
	end

	context '#encode_base36str' do
		it 'properly encodes strings' do
			expect(BaseEmoji.encode_base36str).to eq "0"
			expect(BaseEmoji.encode_base36str('f')).to eq '2u'
			expect(BaseEmoji.encode_base36str('fo')).to eq 'k8f'
			expect(BaseEmoji.encode_base36str('foo')).to eq '3zvxr'
			expect(BaseEmoji.encode_base36str('foob')).to eq 'sf742q'
			expect(BaseEmoji.encode_base36str('fooba')).to eq '5m42kzfl'
			expect(BaseEmoji.encode_base36str('foobar')).to eq '13x8yd7ywi'
		end
	end

	context '#decode_base36' do
		it 'properly decodes encoded values to an Integer' do
			expect(BaseEmoji.decode_base36('')).to eq 0
			expect(BaseEmoji.decode_base36('2')).to eq 2
			expect(BaseEmoji.decode_base36('4')).to eq 4
			expect(BaseEmoji.decode_base36('8')).to eq 8
			expect(BaseEmoji.decode_base36('g')).to eq 16
			expect(BaseEmoji.decode_base36('w')).to eq 32
			expect(BaseEmoji.decode_base36('1s')).to eq 64
			expect(BaseEmoji.decode_base36('3k')).to eq 128
			expect(BaseEmoji.decode_base36('74')).to eq 256
		end
	end

	context '#decode_base36str' do
		it 'properly decodes encoded values to a String' do
			expect(BaseEmoji.decode_base36str('')).to eq ''
			expect(BaseEmoji.decode_base36str('2u')).to eq 'f'
			expect(BaseEmoji.decode_base36str('k8f')).to eq 'fo'
			expect(BaseEmoji.decode_base36str('3zvxr')).to eq 'foo'
			expect(BaseEmoji.decode_base36str('sf742q')).to eq 'foob'
			expect(BaseEmoji.decode_base36str('5m42kzfl')).to eq 'fooba'
			expect(BaseEmoji.decode_base36str('13x8yd7ywi')).to eq 'foobar'
		end
	end
end