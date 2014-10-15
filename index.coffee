Long = require 'long'

phoenixDataTypes = require './lib/phoenixDataTypes'

isString = (o) -> o.charAt

exports.join = (w,e) ->
	size = 0
	size += b.length for b in arguments
	buf = new Buffer size

	offset = 0
	for b in arguments
		b.copy buf, offset
		offset += b.length
	buf

exports.stringToBytes = (o) ->
	return null unless o?
	new Buffer o?.toString?()

exports.bytesToString = (o) ->
	o.toString()

exports.longToBytes = (o) ->
	o = "#{o}" unless isString o
	l = Long.fromString o, yes

	b = new Buffer 8
	b.writeInt32BE l.high, 0
	b.writeInt32BE l.low, 4
	b

exports.bytesToLong = (o) ->
	high = o.readInt32BE 0
	low = o.readInt32BE 4
	x = Long.fromBits low, high, yes
	x


exports.intToBytes = (o) ->
	b = new Buffer 4
	b.writeInt32BE o, 0
	b

exports.bytesToInt = (b) ->
	b.readInt32BE 0

exports.floatToBytes = (o) ->
	o = parseFloat(o) if isString o

	b = new Buffer 4
	b.writeFloatBE o, 0
	b

exports.bytesToFloat = (b) ->
	b.readFloatBE 0

exports.boolToBytes = (o) ->
	b = new Buffer 1
	if o and o != "false"
		b[0] = -1
	else
		b[0] = 0
	return b

exports.bytesToBool = (b) ->
	return false if b[0] is 0
	true

exports.phoenix = phoenixDataTypes
