## Personal Statement of Tingxu Chen

## Overview
* [PC Module](#pc)
* [Data Memory Module](#data-memory-module)
* [Cache Module](#cache)
* [Mistakes and Reflections about the Project](#mistakes-i-made-and-reflections-about-the-project)
* [Future Work](#future-work)

___

## PC 

This module is central to controlling the program counter (PC) in the architecture. [(pc module commit)](https://github.com/franfafdaf/IAC_23autumn_Group17-Coursework/commit/6aa6b993b8752f16c7e7337d3006bb28a0c2efe2)

- **Inputs:** The module takes in clock (`clk`), reset (`rst`), and several control signals (`PCSrc`, `JalSrc`), along with immediate extension (`ImmExt`) and register data (`RD1`).
- **Outputs:** It outputs the next program counter value (`PC`) and the incremented program counter value (`PC_Plus`).
- **Functionality:** The module calculates the next PC value based on control signals. It selects between jump and branch addresses, and increments the PC accordingly.

![program counter](image-2.png)
___

## Data Memory Module

The `DataMemory` module simulates the CPU's memory component, dealing with the storage and retrieval of data. 

- **Inputs:** Receives clock signal (`clk`), write enable (`WE`), store and load type signals (`StSrc`, `LdSrc`), address (`A`), and write data (`WD`).
- **Outputs:** Provides read data output (`RD`).
- **Functionality:** The module is capable of both reading from and writing to a simulated memory array. It handles different types of load and store operations, ensuring correct data manipulation as per instruction requirements.

In the initial phase of developing the DataMemory module, my focus was primarily on basic load and store operations, specifically handling whole words (32 bits). The first version of the module was straightforward, catering only to these whole-word operations.[(1st version commit)](https://github.com/franfafdaf/IAC_23autumn_Group17-Coursework/commit/0cbc6d43edb3240f4cd97543063ee1066876af62) As the project progressed, my teammates introduced additional functionality for byte-wise manipulation, allowing us to handle more granular data operations. This enhancement was crucial for operations like SB (store byte) and LBU (load byte unsigned), providing us the flexibility to work with single bytes.So, firstly i only used 'BE' to represent the type of operation.[(2nd version commit)](https://github.com/franfafdaf/IAC_23autumn_Group17-Coursework/commit/99389ef5d3e26b237e4acf8a502acc6dee36b1b6)

At first, i added 2 blocks to prepare for the correct version of data to be loaded and stored separately.[(3rd version p1 commit)](https://github.com/franfafdaf/IAC_23autumn_Group17-Coursework/commit/5a9c7c1e9ffbeaf08a1180077f31225f7d7f63c3),[(3rd version p2 commit)](https://github.com/franfafdaf/IAC_23autumn_Group17-Coursework/commit/6a3e3c46f9b6ce6c86b8ad880c43fbbbe5dadce8),[(3rd version p3 commit)](https://github.com/franfafdaf/IAC_23autumn_Group17-Coursework/commit/8f2f756e7f3fa9c44dd746199804985639e9df6f).Unfortunately, this led to complications, and the module didn't function as expected. For the final version, it worked in a single module which was similar and more logical than the 2nd version.[(4th version commit)](https://github.com/franfafdaf/IAC_23autumn_Group17-Coursework/commit/87b4f5e04cdb38b76a5298fe1c16340e928a8256)

## Data Mux

This module functions as a data selector. It chooses between different data inputs like the ALU result, data read from memory, the incremented program counter value, and then directs the chosen data to its output. This selection is based on the control signal provided to it. [(data mux module commit)](https://github.com/franfafdaf/IAC_23autumn_Group17-Coursework/commit/c4a6135593346b9a64454955b24c7be1a8a59d7b)

![Data Memory and Data Mux]([image-1.png](https://drive.google.com/file/d/1meq9t_9Z3ZN9SdjNwCjRmWhrkpRerFcJ/view?usp=sharing))
___

## Cache

### Direct Mapped Cache

We initially implemented a direct-mapped cache approach.The module operates with inputs like the clock signal, address input, and data input, and outputs the data retrieved from the cache along with a hit signal indicating successful data retrieval.[(direct module commit)](https://github.com/franfafdaf/IAC_23autumn_Group17-Coursework/commit/f1bca92fce395beb0b1330499e958dae02881769) We also write a simple testbench to test for the very basic scenarios. I co-authored this part with Yiyao Zhou and the details of the logic would be in her personal statement.
___

### 4-Way Associative Cache

Since the Direct_mapped_cache was not enough, we implemented a 4-way associative cache with 8 sets.[(4-way module commit)](https://github.com/franfafdaf/IAC_23autumn_Group17-Coursework/commit/e72619723225143b5b0abf1c6b6e8e16d904c5c5) Each set in this cache comprises four lines, and each line is equipped with its own valid and dirty bits. The valid bit in each line indicates whether the data in that line is valid, while the dirty bit shows if the data has been modified since being loaded into the cache.

For the replacement strategy:

**Function of 'replace_way_flag':** This flag is an array where each entry corresponds to a cache set. The value stored in each entry of this array indicates the next line within the respective set that should be replaced.

**Determining Which Line to Replace:** When a cache miss occurs and all lines in the target set are valid, the cache control logic looks at the 'replace_way_flag' for that set to decide which line to overwrite.

**Cycling Through Lines:** The value in 'replace_way_flag' is typically incremented each time a line in the set is replaced. For instance, if the current value is 0, indicating the first line was most recently replaced, the next line to be replaced would be line 1, and so on. 

**Updating the 'replace_way_flag':** After a line is replaced, the replace_way_flag for that set is updated to point to the next line in sequence. 

And then, i wrote a very simple [(testbench commit)](https://github.com/franfafdaf/IAC_23autumn_Group17-Coursework/commit/84f29ab0822bfa9234d42771058c10a2ff3abcf0) to test the performance of output in different scenarios. It shows the correct results for basic data_out and hit/miss.[(test results commit)](https://github.com/franfafdaf/IAC_23autumn_Group17-Coursework/commit/59443453a40fd88c791f7923187867f79f513738)

___

## Mistakes I made and Reflections about the Project

Reflecting on this project, I recognize that my initial approach of meticulously dissecting each aspect into smaller fragments, while thorough, occasionally posed integration challenges. This method, though detail-oriented, sometimes led me to overlook the cohesive structure of the entire system. I aslo wrote about the [Hazard Unit](https://github.com/franfafdaf/IAC_23autumn_Group17-Coursework/blob/ctx/hazard_unit.sv) and [Write Back Stage](https://github.com/franfafdaf/IAC_23autumn_Group17-Coursework/blob/ctx/WriteBack.sv), however, they were not comprehensive enough and failed to consider specific design details, leading to its ultimate non-adoption.

The experience has been enlightening, particularly in enhancing my understanding of the RISC-V CPU's operations. The process of developing various components and trying to integrate them provided me with a deeper insight into how different parts of a CPU work together. The project also required me to adapt to new concepts and changes in design. This experience has improved my ability to be flexible and adjust strategies as needed.

___

## Future Work

Given more time to enhance the project, I would explore the implementation of advanced memory management techniques. Specifically, adding functionality to handle more complex memory operations, like memory synchronization primitives, could significantly improve the module's utility in a broader range of applications.

