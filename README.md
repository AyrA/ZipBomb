ZipBomb
=======

The result fo attempting to create an insanely large zip bomb,
a file that is so large, there is no storage big enough to hold the extracted contents.

How to
======

The procedure is simple:

1. Create a 4 Gigabyte (4*1024*1024*1024 Bytes) file and compress it once. Name it "Base.zip"
2. Copy the compressed file until you have 16 pieces, named 0.zip, 1.zip, ..., 9.zip, a.zip, b.zip, ..., f.zip
3. Compress the 16 created zip files and overwrite Base.zip with the result.
4. Repeat step 2 and 3 until satisfied.

Exponential growth
------------------

This will achieve exponential growth.
Even on the first level you already have 16 4GB files, resulting in 64 GB total.

Next levels
-----------
- 1 TB
- 16 TB
- 256 TB
- 4 PB
- 64 PB
- 1 EB (now the pattern repeats)
- 16 EB
- 256 EB
- 4 ZB (10th level)
- 64 ZB
- 1 YB
- 16 YB
- 256 YB
- *Beyond this point we lack SI units and we are only at 14 levels.*
- 1024 YB
- 16384 YB
- ...

Units
=====

We use Factor 1024 together with SI prefixes because that is the common way to do it at the moment.
We could use proper SI factors (1000) but then it would also be easier to only generate 10 or 100 archives per batch.
Also the basic file should be `4'000'000'000` bytes instead of `4'294'967'296`.
Maybe I try this once to check if I can yield even higher final sizes.

Below is the list of all units applicable to sizes we use

- (K) kilo
- (M) mega
- (G) giga
- (T) tera
- (P) peta
- (E) exa
- (Z) zetta
- (Y) yotta

The File
--------

The file to begin with is 4GB in size. It is filled with an uppercase `X`

10.zip
======

Info
----

- 10 Levels of compression
- 123 KB (126'678 bytes)

Uncompressed Size
-----------------

- `16*16*16*16*16*16*16*16*16*16*4*1024*1024*1024`
- 2^72
- `4722366482869645213696`
- 4 sextillion 722 quintillion 366 quadrillion 482 trillion 869 billion 645 million 213 thousand 696

20.zip
======

Info
----

- 20 Levels of compression
- 260 KB (266'742 bytes)

Uncompressed Size
-----------------

- `16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*4*1024*1024*1024`
- 2^112
- `5192296858534827628530496329220096`
- 5 decillion 192 nonillion 296 octillion 858 septillion 534 sextillion 827 quintillion 628 quadrillion 530 trillion 496 billion 329 million 220 thousand 96

30.zip
======

Info
----

- 30 Levels of compression
- 441 KB (452'598 bytes)

Uncompressed Size
-----------------

- `16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*4*1024*1024*1024`
- 2^152
- `5708990770823839524233143877797980545530986496`
- 5 quattuordecillion 708 tredecillion 990 duodecillion 770 undecillion 823 decillion 839 nonillion 524 octillion 233 septillion 143 sextillion 877 quintillion 797 quadrillion 980 trillion 545 billion 530 million 986 thousand 496

34.zip
======

This is the largest I could achieve without blowing up the base archive size.
On the next level it would jump from 533 KB to over 7 MB

Info
----

- 34 Levels of compression
- 522 KB (535'286 bytes)

Uncompressed Size
-----------------

- `16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*16*4*1024*1024*1024`
- 2^168
- `374144419156711147060143317175368453031918731001856`
- 374 quindecillion 144 quattuordecillion 419 tredecillion 156 duodecillion 711 undecillion 147 decillion 60 nonillion 143 octillion 317 septillion 175 sextillion 368 quintillion 453 quadrillion 31 trillion 918 billion 731 million 1 thousand 856

Notes
=====

The "Uncompressed size" is given in 4 different expressions, which all resemble the same number of bytes in this order:

- Basic calculation
- Exponential writing
- Raw number
- Spoken

Conclusions
===========

How to verify
-------------

The last level (34.zip) is made up of over 87 duodecillion archives (Number with 41 digits),
scanning this recursively would be impractical.
To verify this we use the fact, that zip archives store the CRC sum of a file.
A CRC sum is a 32 bit integer that is calculated from the content of a file.
To properly verify it we need to extract all archives on a level and make sure that they are identical,
either via checksum comparison or binary comparison.
Both methods are feasible due to the small size of the archives.
If the Archives are identical we can discard all but one file of a level and focus on that.
So instead of extracting a number of archives that would exceed the lifetime of the universe to process we only need to extract 34 of them.
On the last step we just have to extract the final file and check its size.

Security
--------

Some anti-virus software might try to extract the archive to process them,
this can be a huge impact on the AV performance.
In fact, 1/3 of all AV that VirusTotal supports timed out on the test,
which shows that improvement is needed in those programs, because it essentially blocks them.

Proof: [Virustotal: 34.zip](https://www.virustotal.com/en/file/ff5a0c21f83c9554b0bb9bcd1a41c707a56528e550fb7f8bd9a87f7621a17171/analysis/1470177174/)

You will find, that many scanners timed out, including common scanners like comodo, eset-nod32 and McAfee.

Archive Generator Infrastructure
================================

The archives were not generated manually.
I provide you with the full infrastructure needed to bootstrap your own Zip Bomb archives.

The minimum set needed is:

- 4G.bin (this must be extracted first)
- compress.bat
- 7z.exe
- 7z.dll

`compress.bat` will nag you if one of the other files is missing.

_BOOTSTRAP.zip
--------------

This contains the `__BOOTSTRAP.zip`. The reason for this is the rather limited compression of zip archives.
The next level is 4MB, this is just 31 KB.

__BOOTSTRAP.zip
---------------

This file is inside `_BOOTSTRAP.zip` and is approx. 4 MB in size. It contains the file `4G.bin`.
You can speed up the initial process of `compress.bat` a lot if you extract it to the same folder,
then rename it to `4G.zip`, and then extract it again to receive the `4G.bin`.
This way `compress.bat` will skip the step of compressing `4G.bin` again.

4G.bin
------

Does what the name implies, it occupies 4GB on the disk.
The NTFS file system supports compression on its own. If enabled, the file will occupy "only" 256 MB.
it is found inside `__BOOTSTRAP.zip` which is inside `_BOOTSTRAP.zip`.

7z.dll
------

Goes well together with `7z.exe`.

7z.exe
------

Goes fantastically with `7z.dll`.

A Great zip compression and decompression utility, 7-zip supports window and console users.
You can download it for free at [7-zip.org](http://7-zip.org). It supports many archive types and not just zip.
I only supply the console version here because we only need this.

7-zip can be used to browse the generated archives without the need to extract them all.

xx.zip
------

I provide you with the results of this "study", the 4 files `10.zip 20.zip 30.zip 34.zip`.
I recommend not extracting them, for obvious reasons.

README.md
---------

This document

compress.bat
------------

This is where the magic happens. It will create a new level of archives each time it is run.
Extract `4G.bin` before starting it.
Double click it to run.
If you run it the first time it will take a lot longer to run because it compresses `4G.bin` for the first time.
Any subsequent run of the file will only take one or two seconds, unless you delete `4G.zip` or `Base.zip`,
which causes the process to start over.

If you cancel the file mid-run you will end up with a defective `Base.zip`. Delete it. Also empty the `arc` folder.
Because the file replaces `Base.zip` on each run you might want to make backup copies of it.

If you want to start again from scratch with the compression,
just delete `Base.zip` but leave `4G.zip` and `4G.bin` intact.

You can open `compress.bat` it in a text editor if you want to edit it or have a look at the code.

This file could be improved in multiple ways.
For example to not require the original file when the zipped version is present.