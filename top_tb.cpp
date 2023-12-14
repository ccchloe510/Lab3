#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vtop.h"
#include "vbuddy.cpp"    
#define MAX_SIM_CYC 1000000

int main(int argc, char **argv, char **env){
  int simcyc;
  int tick;

  Verilated::commandArgs(argc, argv);

  Vtop * top = new Vtop;

  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("top.vcd");
 
  if (vbdOpen()!=1) return(-1);
  vbdHeader("Pipelined_F1");

  top->clk = 1;
  top->rst = 1;
  top->trigger = 0;

  for (simcyc=0; simcyc<MAX_SIM_CYC; simcyc++) {
    // dump variables into VCD file and toggle clock
    for (tick=0; tick<2; tick++) {
      tfp->dump (2*simcyc+tick);
      top->clk = !top->clk;
      top->eval ();
    }

    top->rst = 0;
    uint32_t value_32bit = top->a0;
    uint8_t data_out = static_cast<uint8_t>(value_32bit & 0xFF);
    vbdBar(data_out & 0xFF);

    top->trigger = vbdFlag();
    vbdCycle(simcyc);

    // either simulation finished, or 'q' is pressed
    if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) 
      exit(0);
  }

  vbdClose();     
  tfp->close(); 
  exit(0);
}