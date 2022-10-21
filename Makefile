.PHONY: clean superclean validate
.DEFAULT_GOAL := submission.zip

submit := vocab description inferred
ttl := $(addsuffix .ttl,$(submit))
png := $(addsuffix .png,$(submit))

clean:
	rm -f inferred.ttl diff.txt *.png submission.zip

superclean: clean
	$(MAKE) -s -C tools/jena clean
	$(MAKE) -s -C tools/rdflib clean

tools/jena/bin/riot:
	which java || sudo apt update && sudo apt -y install default-jre
	$(MAKE) -s -C tools/jena

tools/rdflib/bin/rdf2dot:
	which python3 || sudo apt update && sudo apt -y install python3 python3-venv
	$(MAKE) -s -C tools/rdflib

validate: vocab.ttl description.ttl | tools/jena/bin/riot
	./tools/jena/bin/riot --validate $^
	@echo "Turtle files are valid."

inferred.ttl: vocab.ttl description.ttl | validate
	./tools/jena/bin/riot --formatted=ttl --rdfs $< $(word 2,$^) > $@

diff.txt: description.ttl inferred.ttl | validate
	./tools/jena/bin/rdfdiff $^ TTL TTL > $@ ; true

%.png: %.ttl | validate tools/rdflib/bin/rdf2dot
	which dot || sudo apt update && sudo apt -y install graphviz
	./tools/rdflib/bin/rdf2dot $< | dot -Tpng > $@

submission.zip: $(ttl) $(png) diff.txt
	which zip || sudo apt update && sudo apt -y install zip
	zip $@ $^
