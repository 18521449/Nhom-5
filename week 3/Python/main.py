import os
# Run RGB2Binary.py to convert RGB Image to Binary txt file
os.system('python3 /home/pc/Documents/W2/PY/fpttohsv.py')

# Compile module verilog and testbench
os.system('vlog /home/pc/Documents/W2/HDL/rhb2hsv.v /home/pc/Documents/W2/HDL/testbench.v')

# Run simulation
os.system('vsim -c -do "run -all" testbench')

# Convert Binary to Decimal and display result
os.system('python3 /home/pc/Documents/W2/PY/fptohsv.py')