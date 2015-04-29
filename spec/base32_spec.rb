require_relative '../lib/base_emoji/base32'

RSpec.describe 'BaseEmoji Base32 methods' do
	context '#encode_base32' do
		it 'properly encodes strings according to RFC 4648' do
			expect(BaseEmoji.encode_base32).to eq ''
			expect(BaseEmoji.encode_base32('f')).to eq 'MY======'
			expect(BaseEmoji.encode_base32('fo')).to eq 'MZXQ===='
			expect(BaseEmoji.encode_base32('foo')).to eq 'MZXW6==='
			expect(BaseEmoji.encode_base32('foob')).to eq 'MZXW6YQ='
			expect(BaseEmoji.encode_base32('fooba')).to eq 'MZXW6YTB'
			expect(BaseEmoji.encode_base32('foobar')).to eq 'MZXW6YTBOI======'
		end
	end

	context '#encode_base32hex' do
		it 'properly encodes strings according to RFC 4648' do
			expect(BaseEmoji.encode_base32hex).to eq ''
			expect(BaseEmoji.encode_base32hex('f')).to eq 'CO======'
			expect(BaseEmoji.encode_base32hex('fo')).to eq 'CPNG===='
			expect(BaseEmoji.encode_base32hex('foo')).to eq 'CPNMU==='
			expect(BaseEmoji.encode_base32hex('foob')).to eq 'CPNMUOG='
			expect(BaseEmoji.encode_base32hex('fooba')).to eq 'CPNMUOJ1'
			expect(BaseEmoji.encode_base32hex('foobar')).to eq 'CPNMUOJ1E8======'
		end
	end

	context '#decode_base32' do
		it 'properly decodes encoded values' do
			expect(BaseEmoji.decode_base32('MY======')).to eq 'f'
			expect(BaseEmoji.decode_base32('MZXQ====')).to eq 'fo'
			expect(BaseEmoji.decode_base32('MZXW6===')).to eq 'foo'
			expect(BaseEmoji.decode_base32('MZXW6YQ=')).to eq 'foob'
			expect(BaseEmoji.decode_base32('MZXW6YTB')).to eq 'fooba'
			expect(BaseEmoji.decode_base32('MZXW6YTBOI======')).to eq 'foobar'
		end

		it 'raises if the encoding is incorrect or missing' do
			expect{BaseEmoji.decode_base32}.to raise_error(ArgumentError)
			expect{BaseEmoji.decode_base32('foobar')}.to raise_error(RuntimeError)
			expect{BaseEmoji.decode_base32('foobar--')}.to raise_error(RuntimeError)
		end
	end

	context '#decode_base32hex' do
		it 'properly decodes encoded values' do
			expect(BaseEmoji.decode_base32hex('CO======')).to eq 'f'
			expect(BaseEmoji.decode_base32hex('CPNG====')).to eq 'fo'
			expect(BaseEmoji.decode_base32hex('CPNMU===')).to eq 'foo'
			expect(BaseEmoji.decode_base32hex('CPNMUOG=')).to eq 'foob'
			expect(BaseEmoji.decode_base32hex('CPNMUOJ1')).to eq 'fooba'
			expect(BaseEmoji.decode_base32hex('CPNMUOJ1E8======')).to eq 'foobar'

		end

		it 'raises if the encoding is incorrect or missing' do
			expect{BaseEmoji.decode_base32hex}.to raise_error(ArgumentError)
			expect{BaseEmoji.decode_base32hex('foobar')}.to raise_error(RuntimeError)
			expect{BaseEmoji.decode_base32hex('foobar--')}.to raise_error(RuntimeError)
		end
	end
end