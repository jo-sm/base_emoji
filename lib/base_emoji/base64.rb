module BaseEmoji
	ALPHABET_64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

	def self.encode_base64(str='')
		str.each_byte.map { |byte|
			byte.to_s(2).rjust(8, '0')
		}.join.scan(/.{1,24}/).map { |part| 
			padding = part.length % 6
			part += '0' * (6 - padding) if padding > 0

			part = part.scan(/.{6}/).map { |piece| 
				self::ALPHABET_64[piece.to_i(2)]
			}.join

			part += '=' * (4 - part.length)

			part
		}.join
	end

	def self.encode_base64url(str='')
		self.encode_base64(str).gsub(/[\+\/]/, '+' => '-', '/' => '_')
	end

	def self.decode_base64(enc)			
		raise 'Invalid encoding' if enc.length % 4 != 0

		enc.gsub('=', '').each_char.map { |char| 
			raise 'Invalid encoding' if !self::ALPHABET_64.index(char)

			self::ALPHABET_64.index(char).to_s(2).rjust(6, '0')
		}.join.scan(/.{8}/).map { |byte| 
			byte.to_i(2).chr(Encoding::UTF_8)
		}.join
	end

	def self.decode_base64url(enc)
		self.decode_base64(enc.gsub(/[\-_]/, '-' => '+', '_' => '/'))
	end
end