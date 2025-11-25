#!/usr/bin/env bash
set -euo pipefail

REDIS_CLI="/Users/guylubovitch/Documents/work/redis-stable/src/redis-cli"
: "${REDIS_HOST:=localhost}"
: "${REDIS_PORT:=6379}"

cli() { "$REDIS_CLI" -h "$REDIS_HOST" -p "$REDIS_PORT" "$@"; }

echo "Seeding 100 books into Redis ($REDIS_HOST:$REDIS_PORT)..."
cli DEL books:seq >/dev/null || true
cli DEL books:ids >/dev/null || true

cli DEL books:seq >/dev/null || true
cli DEL books:ids >/dev/null || true
cli HSET book:1 name "Book 001" author "George Orwell" isbn "978-1-000001" category "Dystopian" price "5.07" inventory "3" >/dev/null
cli SADD books:ids 1 >/dev/null
cli SET books:seq 1 >/dev/null
cli HSET book:2 name "Book 002" author "J.R.R. Tolkien" isbn "978-1-000002" category "Fantasy" price "5.14" inventory "6" >/dev/null
cli SADD books:ids 2 >/dev/null
cli SET books:seq 2 >/dev/null
cli HSET book:3 name "Book 003" author "J.D. Salinger" isbn "978-1-000003" category "Sci-Fi" price "5.21" inventory "9" >/dev/null
cli SADD books:ids 3 >/dev/null
cli SET books:seq 3 >/dev/null
cli HSET book:4 name "Book 004" author "F. Scott Fitzgerald" isbn "978-1-000004" category "Horror" price "5.28" inventory "12" >/dev/null
cli SADD books:ids 4 >/dev/null
cli SET books:seq 4 >/dev/null
cli HSET book:5 name "Book 005" author "C.S. Lewis" isbn "978-1-000005" category "Historical" price "5.35" inventory "15" >/dev/null
cli SADD books:ids 5 >/dev/null
cli SET books:seq 5 >/dev/null
cli HSET book:6 name "Book 006" author "Jane Austen" isbn "978-1-000006" category "Fiction" price "5.42" inventory "18" >/dev/null
cli SADD books:ids 6 >/dev/null
cli SET books:seq 6 >/dev/null
cli HSET book:7 name "Book 007" author "Ray Bradbury" isbn "978-1-000007" category "Classic" price "5.49" inventory "21" >/dev/null
cli SADD books:ids 7 >/dev/null
cli SET books:seq 7 >/dev/null
cli HSET book:8 name "Book 008" author "Mary Shelley" isbn "978-1-000008" category "Dystopian" price "5.56" inventory "24" >/dev/null
cli SADD books:ids 8 >/dev/null
cli SET books:seq 8 >/dev/null
cli HSET book:9 name "Book 009" author "Leo Tolstoy" isbn "978-1-000009" category "Fantasy" price "5.63" inventory "27" >/dev/null
cli SADD books:ids 9 >/dev/null
cli SET books:seq 9 >/dev/null
cli HSET book:10 name "Book 010" author "Harper Lee" isbn "978-1-000010" category "Sci-Fi" price "5.70" inventory "30" >/dev/null
cli SADD books:ids 10 >/dev/null
cli SET books:seq 10 >/dev/null
cli HSET book:11 name "Book 011" author "George Orwell" isbn "978-1-000011" category "Horror" price "5.77" inventory "33" >/dev/null
cli SADD books:ids 11 >/dev/null
cli SET books:seq 11 >/dev/null
cli HSET book:12 name "Book 012" author "J.R.R. Tolkien" isbn "978-1-000012" category "Historical" price "5.84" inventory "36" >/dev/null
cli SADD books:ids 12 >/dev/null
cli SET books:seq 12 >/dev/null
cli HSET book:13 name "Book 013" author "J.D. Salinger" isbn "978-1-000013" category "Fiction" price "5.91" inventory "39" >/dev/null
cli SADD books:ids 13 >/dev/null
cli SET books:seq 13 >/dev/null
cli HSET book:14 name "Book 014" author "F. Scott Fitzgerald" isbn "978-1-000014" category "Classic" price "5.98" inventory "42" >/dev/null
cli SADD books:ids 14 >/dev/null
cli SET books:seq 14 >/dev/null
cli HSET book:15 name "Book 015" author "C.S. Lewis" isbn "978-1-000015" category "Dystopian" price "6.05" inventory "45" >/dev/null
cli SADD books:ids 15 >/dev/null
cli SET books:seq 15 >/dev/null
cli HSET book:16 name "Book 016" author "Jane Austen" isbn "978-1-000016" category "Fantasy" price "6.12" inventory "48" >/dev/null
cli SADD books:ids 16 >/dev/null
cli SET books:seq 16 >/dev/null
cli HSET book:17 name "Book 017" author "Ray Bradbury" isbn "978-1-000017" category "Sci-Fi" price "6.19" inventory "51" >/dev/null
cli SADD books:ids 17 >/dev/null
cli SET books:seq 17 >/dev/null
cli HSET book:18 name "Book 018" author "Mary Shelley" isbn "978-1-000018" category "Horror" price "6.26" inventory "54" >/dev/null
cli SADD books:ids 18 >/dev/null
cli SET books:seq 18 >/dev/null
cli HSET book:19 name "Book 019" author "Leo Tolstoy" isbn "978-1-000019" category "Historical" price "6.33" inventory "57" >/dev/null
cli SADD books:ids 19 >/dev/null
cli SET books:seq 19 >/dev/null
cli HSET book:20 name "Book 020" author "Harper Lee" isbn "978-1-000020" category "Fiction" price "6.40" inventory "60" >/dev/null
cli SADD books:ids 20 >/dev/null
cli SET books:seq 20 >/dev/null
cli HSET book:21 name "Book 021" author "George Orwell" isbn "978-1-000021" category "Classic" price "6.47" inventory "63" >/dev/null
cli SADD books:ids 21 >/dev/null
cli SET books:seq 21 >/dev/null
cli HSET book:22 name "Book 022" author "J.R.R. Tolkien" isbn "978-1-000022" category "Dystopian" price "6.54" inventory "66" >/dev/null
cli SADD books:ids 22 >/dev/null
cli SET books:seq 22 >/dev/null
cli HSET book:23 name "Book 023" author "J.D. Salinger" isbn "978-1-000023" category "Fantasy" price "6.61" inventory "69" >/dev/null
cli SADD books:ids 23 >/dev/null
cli SET books:seq 23 >/dev/null
cli HSET book:24 name "Book 024" author "F. Scott Fitzgerald" isbn "978-1-000024" category "Sci-Fi" price "6.68" inventory "72" >/dev/null
cli SADD books:ids 24 >/dev/null
cli SET books:seq 24 >/dev/null
cli HSET book:25 name "Book 025" author "C.S. Lewis" isbn "978-1-000025" category "Horror" price "6.75" inventory "75" >/dev/null
cli SADD books:ids 25 >/dev/null
cli SET books:seq 25 >/dev/null
cli HSET book:26 name "Book 026" author "Jane Austen" isbn "978-1-000026" category "Historical" price "6.82" inventory "78" >/dev/null
cli SADD books:ids 26 >/dev/null
cli SET books:seq 26 >/dev/null
cli HSET book:27 name "Book 027" author "Ray Bradbury" isbn "978-1-000027" category "Fiction" price "6.89" inventory "81" >/dev/null
cli SADD books:ids 27 >/dev/null
cli SET books:seq 27 >/dev/null
cli HSET book:28 name "Book 028" author "Mary Shelley" isbn "978-1-000028" category "Classic" price "6.96" inventory "84" >/dev/null
cli SADD books:ids 28 >/dev/null
cli SET books:seq 28 >/dev/null
cli HSET book:29 name "Book 029" author "Leo Tolstoy" isbn "978-1-000029" category "Dystopian" price "7.03" inventory "87" >/dev/null
cli SADD books:ids 29 >/dev/null
cli SET books:seq 29 >/dev/null
cli HSET book:30 name "Book 030" author "Harper Lee" isbn "978-1-000030" category "Fantasy" price "7.10" inventory "90" >/dev/null
cli SADD books:ids 30 >/dev/null
cli SET books:seq 30 >/dev/null
cli HSET book:31 name "Book 031" author "George Orwell" isbn "978-1-000031" category "Sci-Fi" price "7.17" inventory "93" >/dev/null
cli SADD books:ids 31 >/dev/null
cli SET books:seq 31 >/dev/null
cli HSET book:32 name "Book 032" author "J.R.R. Tolkien" isbn "978-1-000032" category "Horror" price "7.24" inventory "96" >/dev/null
cli SADD books:ids 32 >/dev/null
cli SET books:seq 32 >/dev/null
cli HSET book:33 name "Book 033" author "J.D. Salinger" isbn "978-1-000033" category "Historical" price "7.31" inventory "99" >/dev/null
cli SADD books:ids 33 >/dev/null
cli SET books:seq 33 >/dev/null
cli HSET book:34 name "Book 034" author "F. Scott Fitzgerald" isbn "978-1-000034" category "Fiction" price "7.38" inventory "102" >/dev/null
cli SADD books:ids 34 >/dev/null
cli SET books:seq 34 >/dev/null
cli HSET book:35 name "Book 035" author "C.S. Lewis" isbn "978-1-000035" category "Classic" price "7.45" inventory "105" >/dev/null
cli SADD books:ids 35 >/dev/null
cli SET books:seq 35 >/dev/null
cli HSET book:36 name "Book 036" author "Jane Austen" isbn "978-1-000036" category "Dystopian" price "7.52" inventory "108" >/dev/null
cli SADD books:ids 36 >/dev/null
cli SET books:seq 36 >/dev/null
cli HSET book:37 name "Book 037" author "Ray Bradbury" isbn "978-1-000037" category "Fantasy" price "7.59" inventory "111" >/dev/null
cli SADD books:ids 37 >/dev/null
cli SET books:seq 37 >/dev/null
cli HSET book:38 name "Book 038" author "Mary Shelley" isbn "978-1-000038" category "Sci-Fi" price "7.66" inventory "114" >/dev/null
cli SADD books:ids 38 >/dev/null
cli SET books:seq 38 >/dev/null
cli HSET book:39 name "Book 039" author "Leo Tolstoy" isbn "978-1-000039" category "Horror" price "7.73" inventory "117" >/dev/null
cli SADD books:ids 39 >/dev/null
cli SET books:seq 39 >/dev/null
cli HSET book:40 name "Book 040" author "Harper Lee" isbn "978-1-000040" category "Historical" price "7.80" inventory "0" >/dev/null
cli SADD books:ids 40 >/dev/null
cli SET books:seq 40 >/dev/null
cli HSET book:41 name "Book 041" author "George Orwell" isbn "978-1-000041" category "Fiction" price "7.87" inventory "3" >/dev/null
cli SADD books:ids 41 >/dev/null
cli SET books:seq 41 >/dev/null
cli HSET book:42 name "Book 042" author "J.R.R. Tolkien" isbn "978-1-000042" category "Classic" price "7.94" inventory "6" >/dev/null
cli SADD books:ids 42 >/dev/null
cli SET books:seq 42 >/dev/null
cli HSET book:43 name "Book 043" author "J.D. Salinger" isbn "978-1-000043" category "Dystopian" price "8.01" inventory "9" >/dev/null
cli SADD books:ids 43 >/dev/null
cli SET books:seq 43 >/dev/null
cli HSET book:44 name "Book 044" author "F. Scott Fitzgerald" isbn "978-1-000044" category "Fantasy" price "8.08" inventory "12" >/dev/null
cli SADD books:ids 44 >/dev/null
cli SET books:seq 44 >/dev/null
cli HSET book:45 name "Book 045" author "C.S. Lewis" isbn "978-1-000045" category "Sci-Fi" price "8.15" inventory "15" >/dev/null
cli SADD books:ids 45 >/dev/null
cli SET books:seq 45 >/dev/null
cli HSET book:46 name "Book 046" author "Jane Austen" isbn "978-1-000046" category "Horror" price "8.22" inventory "18" >/dev/null
cli SADD books:ids 46 >/dev/null
cli SET books:seq 46 >/dev/null
cli HSET book:47 name "Book 047" author "Ray Bradbury" isbn "978-1-000047" category "Historical" price "8.29" inventory "21" >/dev/null
cli SADD books:ids 47 >/dev/null
cli SET books:seq 47 >/dev/null
cli HSET book:48 name "Book 048" author "Mary Shelley" isbn "978-1-000048" category "Fiction" price "8.36" inventory "24" >/dev/null
cli SADD books:ids 48 >/dev/null
cli SET books:seq 48 >/dev/null
cli HSET book:49 name "Book 049" author "Leo Tolstoy" isbn "978-1-000049" category "Classic" price "8.43" inventory "27" >/dev/null
cli SADD books:ids 49 >/dev/null
cli SET books:seq 49 >/dev/null
cli HSET book:50 name "Book 050" author "Harper Lee" isbn "978-1-000050" category "Dystopian" price "8.50" inventory "30" >/dev/null
cli SADD books:ids 50 >/dev/null
cli SET books:seq 50 >/dev/null
cli HSET book:51 name "Book 051" author "George Orwell" isbn "978-1-000051" category "Fantasy" price "8.57" inventory "33" >/dev/null
cli SADD books:ids 51 >/dev/null
cli SET books:seq 51 >/dev/null
cli HSET book:52 name "Book 052" author "J.R.R. Tolkien" isbn "978-1-000052" category "Sci-Fi" price "8.64" inventory "36" >/dev/null
cli SADD books:ids 52 >/dev/null
cli SET books:seq 52 >/dev/null
cli HSET book:53 name "Book 053" author "J.D. Salinger" isbn "978-1-000053" category "Horror" price "8.71" inventory "39" >/dev/null
cli SADD books:ids 53 >/dev/null
cli SET books:seq 53 >/dev/null
cli HSET book:54 name "Book 054" author "F. Scott Fitzgerald" isbn "978-1-000054" category "Historical" price "8.78" inventory "42" >/dev/null
cli SADD books:ids 54 >/dev/null
cli SET books:seq 54 >/dev/null
cli HSET book:55 name "Book 055" author "C.S. Lewis" isbn "978-1-000055" category "Fiction" price "8.85" inventory "45" >/dev/null
cli SADD books:ids 55 >/dev/null
cli SET books:seq 55 >/dev/null
cli HSET book:56 name "Book 056" author "Jane Austen" isbn "978-1-000056" category "Classic" price "8.92" inventory "48" >/dev/null
cli SADD books:ids 56 >/dev/null
cli SET books:seq 56 >/dev/null
cli HSET book:57 name "Book 057" author "Ray Bradbury" isbn "978-1-000057" category "Dystopian" price "8.99" inventory "51" >/dev/null
cli SADD books:ids 57 >/dev/null
cli SET books:seq 57 >/dev/null
cli HSET book:58 name "Book 058" author "Mary Shelley" isbn "978-1-000058" category "Fantasy" price "9.06" inventory "54" >/dev/null
cli SADD books:ids 58 >/dev/null
cli SET books:seq 58 >/dev/null
cli HSET book:59 name "Book 059" author "Leo Tolstoy" isbn "978-1-000059" category "Sci-Fi" price "9.13" inventory "57" >/dev/null
cli SADD books:ids 59 >/dev/null
cli SET books:seq 59 >/dev/null
cli HSET book:60 name "Book 060" author "Harper Lee" isbn "978-1-000060" category "Horror" price "9.20" inventory "60" >/dev/null
cli SADD books:ids 60 >/dev/null
cli SET books:seq 60 >/dev/null
cli HSET book:61 name "Book 061" author "George Orwell" isbn "978-1-000061" category "Historical" price "9.27" inventory "63" >/dev/null
cli SADD books:ids 61 >/dev/null
cli SET books:seq 61 >/dev/null
cli HSET book:62 name "Book 062" author "J.R.R. Tolkien" isbn "978-1-000062" category "Fiction" price "9.34" inventory "66" >/dev/null
cli SADD books:ids 62 >/dev/null
cli SET books:seq 62 >/dev/null
cli HSET book:63 name "Book 063" author "J.D. Salinger" isbn "978-1-000063" category "Classic" price "9.41" inventory "69" >/dev/null
cli SADD books:ids 63 >/dev/null
cli SET books:seq 63 >/dev/null
cli HSET book:64 name "Book 064" author "F. Scott Fitzgerald" isbn "978-1-000064" category "Dystopian" price "9.48" inventory "72" >/dev/null
cli SADD books:ids 64 >/dev/null
cli SET books:seq 64 >/dev/null
cli HSET book:65 name "Book 065" author "C.S. Lewis" isbn "978-1-000065" category "Fantasy" price "9.55" inventory "75" >/dev/null
cli SADD books:ids 65 >/dev/null
cli SET books:seq 65 >/dev/null
cli HSET book:66 name "Book 066" author "Jane Austen" isbn "978-1-000066" category "Sci-Fi" price "9.62" inventory "78" >/dev/null
cli SADD books:ids 66 >/dev/null
cli SET books:seq 66 >/dev/null
cli HSET book:67 name "Book 067" author "Ray Bradbury" isbn "978-1-000067" category "Horror" price "9.69" inventory "81" >/dev/null
cli SADD books:ids 67 >/dev/null
cli SET books:seq 67 >/dev/null
cli HSET book:68 name "Book 068" author "Mary Shelley" isbn "978-1-000068" category "Historical" price "9.76" inventory "84" >/dev/null
cli SADD books:ids 68 >/dev/null
cli SET books:seq 68 >/dev/null
cli HSET book:69 name "Book 069" author "Leo Tolstoy" isbn "978-1-000069" category "Fiction" price "9.83" inventory "87" >/dev/null
cli SADD books:ids 69 >/dev/null
cli SET books:seq 69 >/dev/null
cli HSET book:70 name "Book 070" author "Harper Lee" isbn "978-1-000070" category "Classic" price "9.90" inventory "90" >/dev/null
cli SADD books:ids 70 >/dev/null
cli SET books:seq 70 >/dev/null
cli HSET book:71 name "Book 071" author "George Orwell" isbn "978-1-000071" category "Dystopian" price "9.97" inventory "93" >/dev/null
cli SADD books:ids 71 >/dev/null
cli SET books:seq 71 >/dev/null
cli HSET book:72 name "Book 072" author "J.R.R. Tolkien" isbn "978-1-000072" category "Fantasy" price "10.04" inventory "96" >/dev/null
cli SADD books:ids 72 >/dev/null
cli SET books:seq 72 >/dev/null
cli HSET book:73 name "Book 073" author "J.D. Salinger" isbn "978-1-000073" category "Sci-Fi" price "10.11" inventory "99" >/dev/null
cli SADD books:ids 73 >/dev/null
cli SET books:seq 73 >/dev/null
cli HSET book:74 name "Book 074" author "F. Scott Fitzgerald" isbn "978-1-000074" category "Horror" price "10.18" inventory "102" >/dev/null
cli SADD books:ids 74 >/dev/null
cli SET books:seq 74 >/dev/null
cli HSET book:75 name "Book 075" author "C.S. Lewis" isbn "978-1-000075" category "Historical" price "10.25" inventory "105" >/dev/null
cli SADD books:ids 75 >/dev/null
cli SET books:seq 75 >/dev/null
cli HSET book:76 name "Book 076" author "Jane Austen" isbn "978-1-000076" category "Fiction" price "10.32" inventory "108" >/dev/null
cli SADD books:ids 76 >/dev/null
cli SET books:seq 76 >/dev/null
cli HSET book:77 name "Book 077" author "Ray Bradbury" isbn "978-1-000077" category "Classic" price "10.39" inventory "111" >/dev/null
cli SADD books:ids 77 >/dev/null
cli SET books:seq 77 >/dev/null
cli HSET book:78 name "Book 078" author "Mary Shelley" isbn "978-1-000078" category "Dystopian" price "10.46" inventory "114" >/dev/null
cli SADD books:ids 78 >/dev/null
cli SET books:seq 78 >/dev/null
cli HSET book:79 name "Book 079" author "Leo Tolstoy" isbn "978-1-000079" category "Fantasy" price "10.53" inventory "117" >/dev/null
cli SADD books:ids 79 >/dev/null
cli SET books:seq 79 >/dev/null
cli HSET book:80 name "Book 080" author "Harper Lee" isbn "978-1-000080" category "Sci-Fi" price "10.60" inventory "0" >/dev/null
cli SADD books:ids 80 >/dev/null
cli SET books:seq 80 >/dev/null
cli HSET book:81 name "Book 081" author "George Orwell" isbn "978-1-000081" category "Horror" price "10.67" inventory "3" >/dev/null
cli SADD books:ids 81 >/dev/null
cli SET books:seq 81 >/dev/null
cli HSET book:82 name "Book 082" author "J.R.R. Tolkien" isbn "978-1-000082" category "Historical" price "10.74" inventory "6" >/dev/null
cli SADD books:ids 82 >/dev/null
cli SET books:seq 82 >/dev/null
cli HSET book:83 name "Book 083" author "J.D. Salinger" isbn "978-1-000083" category "Fiction" price "10.81" inventory "9" >/dev/null
cli SADD books:ids 83 >/dev/null
cli SET books:seq 83 >/dev/null
cli HSET book:84 name "Book 084" author "F. Scott Fitzgerald" isbn "978-1-000084" category "Classic" price "10.88" inventory "12" >/dev/null
cli SADD books:ids 84 >/dev/null
cli SET books:seq 84 >/dev/null
cli HSET book:85 name "Book 085" author "C.S. Lewis" isbn "978-1-000085" category "Dystopian" price "10.95" inventory "15" >/dev/null
cli SADD books:ids 85 >/dev/null
cli SET books:seq 85 >/dev/null
cli HSET book:86 name "Book 086" author "Jane Austen" isbn "978-1-000086" category "Fantasy" price "11.02" inventory "18" >/dev/null
cli SADD books:ids 86 >/dev/null
cli SET books:seq 86 >/dev/null
cli HSET book:87 name "Book 087" author "Ray Bradbury" isbn "978-1-000087" category "Sci-Fi" price "11.09" inventory "21" >/dev/null
cli SADD books:ids 87 >/dev/null
cli SET books:seq 87 >/dev/null
cli HSET book:88 name "Book 088" author "Mary Shelley" isbn "978-1-000088" category "Horror" price "11.16" inventory "24" >/dev/null
cli SADD books:ids 88 >/dev/null
cli SET books:seq 88 >/dev/null
cli HSET book:89 name "Book 089" author "Leo Tolstoy" isbn "978-1-000089" category "Historical" price "11.23" inventory "27" >/dev/null
cli SADD books:ids 89 >/dev/null
cli SET books:seq 89 >/dev/null
cli HSET book:90 name "Book 090" author "Harper Lee" isbn "978-1-000090" category "Fiction" price "11.30" inventory "30" >/dev/null
cli SADD books:ids 90 >/dev/null
cli SET books:seq 90 >/dev/null
cli HSET book:91 name "Book 091" author "George Orwell" isbn "978-1-000091" category "Classic" price "11.37" inventory "33" >/dev/null
cli SADD books:ids 91 >/dev/null
cli SET books:seq 91 >/dev/null
cli HSET book:92 name "Book 092" author "J.R.R. Tolkien" isbn "978-1-000092" category "Dystopian" price "11.44" inventory "36" >/dev/null
cli SADD books:ids 92 >/dev/null
cli SET books:seq 92 >/dev/null
cli HSET book:93 name "Book 093" author "J.D. Salinger" isbn "978-1-000093" category "Fantasy" price "11.51" inventory "39" >/dev/null
cli SADD books:ids 93 >/dev/null
cli SET books:seq 93 >/dev/null
cli HSET book:94 name "Book 094" author "F. Scott Fitzgerald" isbn "978-1-000094" category "Sci-Fi" price "11.58" inventory "42" >/dev/null
cli SADD books:ids 94 >/dev/null
cli SET books:seq 94 >/dev/null
cli HSET book:95 name "Book 095" author "C.S. Lewis" isbn "978-1-000095" category "Horror" price "11.65" inventory "45" >/dev/null
cli SADD books:ids 95 >/dev/null
cli SET books:seq 95 >/dev/null
cli HSET book:96 name "Book 096" author "Jane Austen" isbn "978-1-000096" category "Historical" price "11.72" inventory "48" >/dev/null
cli SADD books:ids 96 >/dev/null
cli SET books:seq 96 >/dev/null
cli HSET book:97 name "Book 097" author "Ray Bradbury" isbn "978-1-000097" category "Fiction" price "11.79" inventory "51" >/dev/null
cli SADD books:ids 97 >/dev/null
cli SET books:seq 97 >/dev/null
cli HSET book:98 name "Book 098" author "Mary Shelley" isbn "978-1-000098" category "Classic" price "11.86" inventory "54" >/dev/null
cli SADD books:ids 98 >/dev/null
cli SET books:seq 98 >/dev/null
cli HSET book:99 name "Book 099" author "Leo Tolstoy" isbn "978-1-000099" category "Dystopian" price "11.93" inventory "57" >/dev/null
cli SADD books:ids 99 >/dev/null
cli SET books:seq 99 >/dev/null
cli HSET book:100 name "Book 100" author "Harper Lee" isbn "978-1-000100" category "Fantasy" price "12.00" inventory "60" >/dev/null
cli SADD books:ids 100 >/dev/null
cli SET books:seq 100 >/dev/null
echo "Done."