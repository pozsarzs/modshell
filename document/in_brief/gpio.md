## Accessing of Raspberry Pi GPIO ports

### GPIO base address

|  Raspberry Pi version   |GPIO base address|
|-------------------------|:---------------:|
|Pi 1 / Pi Zero (BCM2835) |0x20200000       |
|Pi 2, 3 (BCM2836/BCM2837)|0x3F200000       |
|Pi 4, 5 (BCM2711)        |0xFE200000       |

### GPIO memory map and control

Register size: 32 bit

|Register |Offset|Function                           |
|---------|:----:|-----------------------------------|
|GPFSEL0  |0x00  |GPIO 0-9 set mode                  |
|GPFSEL1  |0x04  |GPIO 10-19 set mode                |
|GPFSEL2  |0x08  |GPIO 20-29 set mode                |
|GPFSEL3  |0x0C  |GPIO 30-39 set mode                |
|GPFSEL4  |0x10  |GPIO 40-49 set mode                |
|GPFSEL5  |0x14  |GPIO 50-53 set mode                |
|GPSET0   |0x1C  |GPIO 0-31 set to high              |
|GPSET1   |0x20  |GPIO 32-53 set to high             |
|GPCLR0   |0x28  |GPIO 0-31 set to low               |
|GPCLR1   |0x2C  |GPIO 32-53 set to low              |
|GPLEV0   |0x34  |GPIO 0-31 get status               |
|GPLEV1   |0x38  |GPIO 32-53 get status              |
|GPEDS0   |0x40  |GPIO 0-31 event detection          |
|GPEDS1   |0x44  |GPIO 32-53 event detection         |
|GPREN0   |0x4C  |GPIO 0-31 enable rising egde       |
|GPREN1   |0x50  |GPIO 32-53 enable rising egde      |
|GPFEN0   |0x58  |GPIO 0-31 enable falling egde      |
|GPFEN1   |0x5C  |GPIO 32-53 enable falling egde     |
|GPPUD    |0x94  |Pull-up/pull-down control          |
|GPPUDCLK0|0x98  |GPIO 0-31 enable pull-up/pull-down |
|GPPUDCLK1|0x9C  |GPIO 32-53 enable pull-up/pull-down|

Note:  

**GPFSELx**:  
- input mode: `000`,  
- output mode: `001`,  
- other modes: `010`...`111`.  
