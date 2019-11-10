.phony: all clean build

all: clean build

clean:
	rm -f output/pedal_clip.*

build:
	openscad -o output/pedal_clip.stl pedal_clip.scad
	openscad -o output/pedal_clip.png pedal_clip.scad
