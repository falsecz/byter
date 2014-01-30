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
#### Float ####
```coffee-script
byter.floatToBytes 1.234
byter.floatToBytes "1.234"
byter.bytesToFloat bytes
```


#### Join bytes ####
```coffee-script
a = byter.intToBytes 10
aa = byter.intToBytes "10"
byter.join a, aa, ...
```

Support for [Hbase Phoenix](https://github.com/forcedotcom/phoenix "HBase Phoenix") v 3.0.0 data types
-----
```coffee-script
a = byter.phoenix.intToBytes 10
a = byter.phoenix.unsignedIntToBytes 10
a = byter.phoenix.longToBytes "-1387547769370"
a = byter.phoenix.dateToBytes "1387547769370" #micro timestamp
a = byter.phoenix.unsignedLongToBytes "1387547769370"
#write a to hbase
```
