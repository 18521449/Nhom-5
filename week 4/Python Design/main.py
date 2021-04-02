import os
# Run RGB2Binary.py to convert RGB Image to Binary txt file
os.system('python3 /home/nguyentienluan/Documents/Lab1_W2/PY_RGB2HSV/Imgtotext.py')

# Compile module verilog and testbench
# os.system('vlog /home/nguyentienluan/Documents/Lab1_W2/HDL_RGB2HSV/rgb2hsv.v /home/nguyentienluan/Documents/Lab1_W2/HDL_RGB2HSV/testbench.v /home/nguyentienluan/Documents/Lab1_W2/HDL_RGB2HSV/Addition.v /home/nguyentienluan/Documents/Lab1_W2/HDL_RGB2HSV/Division.v /home/nguyentienluan/Documents/Lab1_W2/HDL_RGB2HSV/Hue.v /home/nguyentienluan/Documents/Lab1_W2/HDL_RGB2HSV/MaxMin.v /home/nguyentienluan/Documents/Lab1_W2/HDL_RGB2HSV/Multiply.v /home/nguyentienluan/Documents/Lab1_W2/HDL_RGB2HSV/Saturation.v /home/nguyentienluan/Documents/Lab1_W2/HDL_RGB2HSV/Value.v')
os.system('vlog /home/nguyentienluan/Documents/Lab1_W2/HDL_RGB2HSV_Pipeline/testbench.v -v und1')
# Run simulation
os.system('vsim -c -do "run -all" testbench')

# Convert Binary to Decimal and display result
os.system('python3 /home/nguyentienluan/Documents/Lab1_W2/PY_RGB2HSV/fpToHSV.py')