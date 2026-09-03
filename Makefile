COMPILER = iverilog
SIMULATOR = vvp
VIEWER = gtkwave

SRC = src/cpu.v src/ram.v src/top.v
TESTBENCH = sim/tb.v
OUTPUT = sim/design.vvp
VCD_FILE = sim/simulation.vcd

.PHONY: all compile run wave clean push test re

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
	-git commit -m "Calc-Core-8"
	git push origin main --force

test: compile run wave

re: clean all
