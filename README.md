# High Speed Adder
This projects aims to design an high speed adder based on recursive doubling technique and fabricate at the SKY130nm technology node.
## Specifications
    Inputs: in1, in2 each of 18 bits
            Mode for add/sub selection
    Output: Sum which is of 19 bits.
    
 ## Block Diagram
 Step1: Precomputation of carry status signals of "Generate", "Propagate", "Kill".
 Step2: Computation of actuaal carry signals for all bits.
 Step3: Final Sum computation by XORing Carry and propgate signals at each bit.
 ![acc_cla](https://user-images.githubusercontent.com/61288836/138144766-a2e20fd1-88c1-4d33-ad66-ab533f0943c1.png)

 
 ## EDA Tools and Environment
 Process Node: Sky130nm
 Simulations:iverilog
 RTL to GDSII: Openlane
 SoC Wrapper: Caravel Harness
 
 ## Pre-Synthesis Simulation
 <img width="964" alt="Screenshot (459)" src="https://user-images.githubusercontent.com/61288836/138146364-fbb48589-7766-4e1b-b08a-22440ac0a4b5.png">

 
 ## Post-Synthesis Simulation
 ![Screenshot (461)](https://user-images.githubusercontent.com/61288836/138146434-aa52a047-e680-4113-a28f-9c2d3d91cbf7.png)

 ## RTL to GDSII
 ![layout](https://user-images.githubusercontent.com/61288836/138146634-6c15d27d-c3af-43fe-91d8-4f8447eb238d.png)

 
    
