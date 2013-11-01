Byter
=====
Byte from/to conversion library for String, Int, Long
Support joining bytes


Usage
-----
Install `npm install byter`

Require `byter = require 'byter'`

#### String ####
```coffee-script
byter.stringToBytes "test"
byter.bytesToString bytes
```

#### Long ####
```coffee-script
byter.longToBytes "9223372036854775807"
byter.bytesToLong bytes
```

#### Int ####
```coffee-script
byter.intToBytes 10
byter.intToBytes "10"
byter.bytesToInt bytes
```

#### Join bytes ####
```coffee-script
a = byter.intToBytes 10
aa = byter.intToBytes "10"
byter.join a, aa, ...
```
