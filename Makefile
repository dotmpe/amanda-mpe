T += example-1
T += grammar-1
T += grammar-2
T += pegjs-1

default: $(T)

.PHONY: $(T)

grammar-1: var/example/park-hikes.rnc 
	@rnv -c $^
	@echo [OK] Grammar 1

# FIXME:grammar-2
#grammar-2: var/example/park-hikes.named.rnc 
#	@rnv -p $^
#	@echo [OK] Grammar 2

example-1: var/example/park-hikes.rnc var/example/park-hikes.named.rnc var/example/park-hikes.1.xml
	@rnv -q var/example/park-hikes.rnc var/example/park-hikes.1.xml
	@rnv -q var/example/park-hikes.named.rnc var/example/park-hikes.1.xml
	@echo [OK] Example 1

# FIXME: pegjs-1
#pegjs-1:
#	node peg.js

