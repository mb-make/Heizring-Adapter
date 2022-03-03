
STL=print.stl
PNG=Heizring-Adapter.png


all: ${PNG} ${STL}

%.png: %.scad
	openscad -o $@ $^

%.stl: %.scad
	openscad -o $@ $^

clean:
	rm -f ${PNG} ${STL}

