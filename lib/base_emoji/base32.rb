module BaseEmoji
	def self.encode_base32(str='')
		self._encode_base32('ABCDEFGHIJKLMNOPQRSTUVWXYZ234567', str)
	end

	def self.decode_base32(enc)
		self._decode_base32('ABCDEFGHIJKLMNOPQRSTUVWXYZ234567', enc)
	end

	def self.encode_base32hex(str='')
		self._encode_base32('0123456789ABCDEFGHIJKLMNOPQRSTUV', str)
	end

	def self.decode_base32hex(enc)
		self._decode_base32('0123456789ABCDEFGHIJKLMNOPQRSTUV', enc)
	end

	def self._encode_base32(chars, str)
		# Convert the input string into binary and join them
		str.each_byte.map { |byte| 
			byte.to_s(2).rjust(8, '0')
		}.join.scan(/.{1,40}/).map { |part|
			padding = part.length % 5
			part += "0" * (5 - padding) if padding > 0

			part = part.scan(/.{5}/).map { |piece|
				chars[piece.to_i(2)]
			}.join

			part += '=' * (8 - part.length)

			part
		}.join
	end

	def self._decode_base32(chars, enc)
		raise 'Invalid encoding' if enc.length % 8 != 0

		enc.upcase.gsub('=', '').each_char.map { |char| 
			raise 'Invalid encoding' if !chars.index(char)

			chars.index(char).to_s(2).rjust(5, '0')
		}.join.scan(/.{8}/).map { |byte| 
			byte.to_i(2).chr(Encoding::UTF_8)
		}.join
	end
end