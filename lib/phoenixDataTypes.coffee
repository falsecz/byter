byter = require '../'
Long = require 'long'

Buffer.prototype.toByteArray = () ->
  return Array.prototype.slice.call this, 0



intSize = 4
doubleSize = 8
initIntBuffer = (input) ->
	b = new Buffer intSize
	b.writeInt32BE input, 0, yes
	return b

exports.toPDataUnsignedInt = (num) ->
	return initIntBuffer num

exports.toPDataSignedInt = (num) ->
	if num < 0 # negative number
		b = initIntBuffer Math.abs num + 1
		for value, index in b
			b[index] = b[index] ^ 255
		b[0] ^= 128	# sign bit
		return b
	b = initIntBuffer num
	b[0] ^= 128 # sign bit
	return b



exports.toPDataDouble = (num) ->
	b = new Buffer doubleSize
	if num is 0 # special case if num is zero
		b.fill 0
		b[0] = 128
		b[7] = 1
		return b

	b.writeDoubleBE num, 0, yes

	maxIndex = 7 # max index for inverting bits
	sum = 0
	sum += b[i] for i in [3..7] # check for numbers after comma

	if sum is 0	# no digits after comma
		maxIndex = 2

	if num < 0 # is negative number
		for index in [0..maxIndex] # invert bits
			b[index] = b[index] ^ 255
	else
		b[0] ^= 128 # sign bit
		maxIndex = 7

	maxIndex-- while ++b[maxIndex] is 256 # buffer overflow
	return b

exports.toPDataLong = (o) ->
	o = "#{o}" unless o.charAt
	l = Long.fromString o, yes

	b = new Buffer 8
	b.writeInt32BE l.high, 0
	b.writeInt32BE l.low, 4
	if l.isNegative()
		b[0] ^= 128
	else
		b[0] |= 128
	b

exports.pDataBytesToInt = (bytes) ->
	if bytes[0] < 128 # negative number
		for value, index in bytes
			bytes[index] = bytes[index] ^ 255
		bytes[0] &= 127	# sign bit
		# console.log bytes
		return -1 * (bytes.readInt32BE 0) - 1 # -1 for reverted numbers

	bytes[0] &= 127
	return bytes.readInt32BE 0

exports.pDataBytesToLong = (bytes) ->
	if bytes[0] < 128 # negative number
		for value, index in bytes
			bytes[index] = bytes[index] ^ 255
		bytes[0] &= 127	# sign bit
		high = bytes.readInt32BE 0
		low = bytes.readInt32BE 4
		x = Long.fromBits low + 1, high, yes
		return "-" + x.toString()

	bytes[0] &= 127
	high = bytes.readInt32BE 0
	low = bytes.readInt32BE 4
	x = Long.fromBits low, high, yes
	return x.toString()


exports.unsignedIntToBytes = (integer) ->
	return (exports.toPDataUnsignedInt integer).toByteArray()

# todo remove in next major
exports.unsgnedIntToBytes = exports.unsignedIntToBytes

exports.intToBytes = (integer) ->
	return (exports.toPDataSignedInt integer).toByteArray()

#alias for intToBytes
exports.integerToBytes = (integer) ->
	return intToBytes integer

exports.dateToBytes = (date) ->
	return (exports.toPDataLong date).toByteArray()

exports.longToBytes = (long) ->
	return (exports.toPDataLong long).toByteArray()

exports.bytesToInt = (bytes) ->
	return exports.pDataBytesToInt bytes

exports.bytesToLong = (bytes) ->
	return exports.pDataBytesToLong bytes

# unsigned and signed int encoding are same
exports.unsignedLongToBytes = (long) ->
	return (byter.longToBytes long).toByteArray()
