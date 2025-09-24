# Sobel-edge-detection-VHDL
Utilizing a Sobel edge detector with VHDL language which can get a binary (bmp) image and find its edges.

A Sobel filter is an image convolutional-based filter, capable of finding an image's edges.

<img src="https://github.com/armin-mm/Sobel-edge-detection-VHDL/blob/main/Screenshot%20(2394).png" width="256">

At first, the input is converted to STD_LOGIC_VECTOR and then to integer type. Subsequently, A matrix form of the Sobel filter is applied to a 3*3 Matrix of input integers.

<img src="https://github.com/armin-mm/Sobel-edge-detection-VHDL/blob/main/image.png" width="256">

Modified version of an edge detector, with a threshold capable of adaptively choosing the sensitivity of edge detection.


<img src="https://github.com/armin-mm/Sobel-edge-detection-VHDL/blob/main/Screenshot%20(2395).png" width="256">

<img src="https://github.com/armin-mm/Sobel-edge-detection-VHDL/blob/main/Screenshot%20(2396).png" width="256">

<img src="https://github.com/armin-mm/Sobel-edge-detection-VHDL/blob/main/Screenshot%20(2397).png" width="256">
