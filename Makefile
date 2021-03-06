SOURCE :=  $(wildcard source/**/*.py) $(wildcard source/*.py)

COPY_EXPORT_FILES := $(wildcard export/**/*.*) $(wildcard export/*.*)
COPY_EXPORT_DEST_FILES := $(patsubst export/%,build/%, $(COPY_EXPORT_FILES))


all: parseTest build/spells.json copyExport test


build/spells.json: $(SOURCE) $(wildcard resources/*/*.txt)
	$(info )
	$(info ************   Creating Json   ************)
	mkdir -p build
	python source/parse-spells.py -json="build/spells.json" -list="build/spelllist.txt" -class="build/List of all 5e spells.txt"


copyExport: $(COPY_EXPORT_FILES)
	$(info )
	$(info ************ Copying Resources ************)
	cp -f -RT export build


test:
	$(info )
	$(info ************  Verifying Json   ************)
	python -m pytest


parseTest: 
	$(info )
	$(info ************ Verifying scripts ************)
	python source/parse-spells.py --doctest


init:
	pip install -r requirements.txt


new-spells:
	python source/make-missing-spells.py


clean:
	rm -r build/