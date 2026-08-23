COMPILER = iverilog
SIMULATOR = vvp
VIEWER = gtkwave

SRC = src/cpu.v
TESTBENCH = sim/tb.v
OUTPUT = sim/design.vvp
VCD_FILE = sim/simulation.vcd

all: compile run

compile:
	$(COMPILER) -g2012 -o $(OUTPUT) $(SRC) $(TESTBENCH)

run:
	$(SIMULATOR) $(OUTPUT)

wave:
	$(VIEWER) $(VCD_FILE) &

clean:
	rm -f $(OUTPUT) $(VCD_FILE)

push:
	git add .
	git commit -m "CalcCore-8"
	git push origin main --force

test:
	make compile
	make run
	make wave

re:
	make clean
	make all