require_relative('./base_emoji')

def to_base16(str) 
	str.each_byte.map { |byte|
		byte.to_s(16)
	}.join.upcase
end

def to_base32(str)
	_to_base32('ABCDEFGHIJKLMNOPQRSTUVWXYZ234567', str)
end

def to_base32_hex(str)
	_to_base32('0123456789ABCDEFGHIJKLMNOPQRSTUV', str)
end

def _to_base32(chars, str)

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
	}.join.upcase
end

def to_base64(str)
	chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	str.each_byte.map { |byte|
		byte.to_s(2).rjust(8, '0')
	}.join.scan(/.{1,24}/).map { |part| 
		padding = part.length % 6
		part += '0' * (6 - padding) if padding > 0

		part = part.scan(/.{6}/).map { |piece| 
			chars[piece.to_i(2)]
		}.join

		part += '=' * (4 - part.length)

		part
	}.join
end

str = ARGV[0] || "foobar"

puts "String: #{str}"
puts "Base 16: #{to_base16(str)}. Is valid: #{to_base16(str) == '666F6F626172'}"
puts "Base 32: #{to_base32(str)}. Is valid: #{to_base32(str) == 'MZXW6YTBOI======'}"
puts "Base 32 Hex: #{to_base32_hex(str)}. Is valid: #{to_base32_hex(str) == 'CPNMUOJ1E8======'}"
puts "Base 64: #{to_base64(str)}. Is valid: #{to_base64(str) == 'Zm9vYmFy'}"
b =  BaseEmoji::to_base_emoji("hello world!!! ⭕️")
puts b
puts "hello world!!! ⭕️".bytesize
puts b.bytesize
puts BaseEmoji::from_base_emoji(b)
