require_relative '../lib/base_emoji/base58'

RSpec.describe 'BaseEmoji Base58 methods' do
	context '#encode_base58' do
			it 'properly encodes integers' do
			expect(BaseEmoji.encode_base58).to eq '1'
			expect(BaseEmoji.encode_base58(2)). to eq '3'
			expect(BaseEmoji.encode_base58(4)). to eq '5'
			expect(BaseEmoji.encode_base58(8)). to eq '9'
			expect(BaseEmoji.encode_base58(16)). to eq 'h'
			expect(BaseEmoji.encode_base58(32)). to eq 'y'
			expect(BaseEmoji.encode_base58(64)). to eq '27'
			expect(BaseEmoji.encode_base58(128)). to eq '3d'
			expect(BaseEmoji.encode_base58(256)). to eq '5q'
		end
	end

	context '#encode_base58str' do
		it 'properly encodes strings' do
			expect(BaseEmoji.encode_base58str).to eq '1'
			expect(BaseEmoji.encode_base58str('f')).to eq '2L'
			expect(BaseEmoji.encode_base58str('fo')).to eq '8N8'
			expect(BaseEmoji.encode_base58str('foo')).to eq 'ApAP'
			expect(BaseEmoji.encode_base58str('foob')).to eq '3BSaF9'
			expect(BaseEmoji.encode_base58str('fooba')).to eq 'cyiqGLZ'
			expect(BaseEmoji.encode_base58str('foobar')).to eq 'T1yV2Yzy'
		end
	end

	context '#decode_base58' do
		it 'properly decodes encoded values to an Integer' do
			expect(BaseEmoji.decode_base58('')).to eq 1
			expect(BaseEmoji.decode_base58('3')).to eq 2
			expect(BaseEmoji.decode_base58('5')).to eq 4
			expect(BaseEmoji.decode_base58('9')).to eq 8
			expect(BaseEmoji.decode_base58('h')).to eq 16
			expect(BaseEmoji.decode_base58('y')).to eq 32
			expect(BaseEmoji.decode_base58('27')).to eq 64
			expect(BaseEmoji.decode_base58('3d')).to eq 128
			expect(BaseEmoji.decode_base58('5q')).to eq 256
		end
	end

	context '#decode_base58str' do 
		it 'properly decodes encoded values to a String' do
			expect(BaseEmoji.decode_base58str('')).to eq ''
			expect(BaseEmoji.decode_base58str('2L')).to eq 'f'
			expect(BaseEmoji.decode_base58str('8N8')).to eq 'fo'
			expect(BaseEmoji.decode_base58str('ApAP')).to eq 'foo'
			expect(BaseEmoji.decode_base58str('3BSaF9')).to eq 'foob'
			expect(BaseEmoji.decode_base58str('cyiqGLZ')).to eq 'fooba'
			expect(BaseEmoji.decode_base58str('T1yV2Yzy')).to eq 'foobar'
		end
	end
end