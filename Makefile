.phony: all clean build

all: clean build

clean:
	rm -f output/pedal_clip.stl

build:
	openscad -o output/pedal_clip.stl pedal_clip.scad
