---
layout: default
title: "string 使用的一些函数"
---
```cmake
set(MYSTR "Hello")



string(TOLOWER ${MYSTR} str1) 
string(TOUPPER ${MYSTR} str2)

message("str1 = " ${str1} )  
# str1 = hello 
message("str2 = " ${str2} ) 
# str2 = HELLO

string(APPEND MYSTR " kitty")
message("MYSTR = " ${MYSTR} ) 
# MYSTR = Hello kitty

#匹配最后的/ 替换成"" 删除最后的斜杠的意思
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

```





```cmake
String operations.
 string(FIND <string> <substring> <output_variable> [REVERSE])
 string(REPLACE <match_string> <replace_string> <output_variable> <input> [<input>...])
 string(REGEX MATCH <regular_expression> <output_variable> <input> [<input>...])
 string(REGEX MATCHALL <regular_expression> <output_variable> <input> [<input>...])
 string(REGEX REPLACE <regular_expression> <replacement_expression> <output_variable> <input> [<input>...])
 string(APPEND <string_variable> [<input>...])
 string(PREPEND <string_variable> [<input>...])
 string(CONCAT <output_variable> [<input>...])
 string(JOIN <glue> <output_variable> [<input>...])
 string(TOLOWER <string> <output_variable>)
 string(TOUPPER <string> <output_variable>)
 string(LENGTH <string> <output_variable>)
 string(SUBSTRING <string> <begin> <length> <output_variable>)
 string(STRIP <string> <output_variable>)
 string(GENEX_STRIP <string> <output_variable>)
 string(REPEAT <string> <count> <output_variable>)
 string(COMPARE LESS <string1> <string2> <output_variable>)
 string(COMPARE GREATER <string1> <string2> <output_variable>)
 string(COMPARE EQUAL <string1> <string2> <output_variable>)
 string(COMPARE NOTEQUAL <string1> <string2> <output_variable>)
 string(COMPARE LESS_EQUAL <string1> <string2> <output_variable>)
 string(COMPARE GREATER_EQUAL <string1> <string2> <output_variable>)
 string(<HASH> <output_variable> <input>)
 string(ASCII <number> [<number> ...] <output_variable>)
 string(HEX <string> <output_variable>)
 string(CONFIGURE <string> <output_variable> [@ONLY] [ESCAPE_QUOTES])
 string(MAKE_C_IDENTIFIER <string> <output_variable>)
 string(RANDOM [LENGTH <length>] [ALPHABET <alphabet>] [RANDOM_SEED <seed>] <output_variable>)
 string(TIMESTAMP <output_variable> [<format_string>] [UTC])
 string(UUID <output_variable> NAMESPACE <namespace> NAME <name> TYPE <MD5|SHA1> [UPPER])
  string(JSON <out-var> [ERROR_VARIABLE <error-variable>] GET <json-string> <member|index> [<member|index> ...])
 string(JSON <out-var> [ERROR_VARIABLE <error-variable>] TYPE <json-string> <member|index> [<member|index> ...])
 string(JSON <out-var> [ERROR_VARIABLE <error-var>] MEMBER <json-string> [<member|index> ...] <index>)
 string(JSON <out-var> [ERROR_VARIABLE <error-variable>] LENGTH <json-string> [<member|index> ...])
 string(JSON <out-var> [ERROR_VARIABLE <error-variable>] REMOVE <json-string> <member|index> [<member|index> ...])
 string(JSON <out-var> [ERROR_VARIABLE <error-variable>] SET <json-string> <member|index> [<member|index> ...] <value>)
 string(JSON <out-var> [ERROR_VARIABLE <error-var>] EQUAL <json-string1> <json-string2>)

String operations.

Synopsis
^^^^^^^^

 Search and Replace
   string(FIND <string> <substring> <out-var> [...])
   string(REPLACE <match-string> <replace-string> <out-var> <input>...)
   string(REGEX MATCH <match-regex> <out-var> <input>...)
   string(REGEX MATCHALL <match-regex> <out-var> <input>...)
   string(REGEX REPLACE <match-regex> <replace-expr> <out-var> <input>...)

 Manipulation
   string(APPEND <string-var> [<input>...])
   string(PREPEND <string-var> [<input>...])
   string(CONCAT <out-var> [<input>...])
   string(JOIN <glue> <out-var> [<input>...])
```

