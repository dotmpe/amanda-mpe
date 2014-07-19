T += example-1
T += grammar-1
T += grammar-2

default: $(T)

grammar-1: var/example/park-hikes.rnc 
	@rnv -c $^
	@echo [OK] Grammar 1

grammar-2: var/example/park-hikes.named.rnc 
	@rnv -p $^
	@echo [OK] Grammar 2

example-1: var/example/park-hikes.rnc var/example/park-hikes.named.rnc var/example/park-hikes.1.xml
	@rnv -q var/example/park-hikes.rnc var/example/park-hikes.1.xml
	@rnv -q var/example/park-hikes.named.rnc var/example/park-hikes.1.xml
	@echo [OK] Example 1

.PHONY: example-1

