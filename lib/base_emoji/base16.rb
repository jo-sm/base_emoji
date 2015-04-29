module BaseEmoji
	def self.to_base16(str='') 
		str.each_byte.map { |byte|
			byte.to_s(16)
		}.join
	end

	def self.from_base16(enc='')
		enc.scan(/.{2}/).map { |byte|
			byte.to_i(16).chr
		}.join
	end
end