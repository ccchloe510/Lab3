// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vlfsr.h for the primary calling header

#ifndef VERILATED_VLFSR___024ROOT_H_
#define VERILATED_VLFSR___024ROOT_H_  // guard

#include "verilated.h"


class Vlfsr__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vlfsr___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(rst,0,0);
    VL_IN8(en,0,0);
    VL_OUT8(data_out,3,0);
    CData/*3:0*/ lfsr__DOT__sreg;
    CData/*0:0*/ lfsr__DOT__sreg3_xor_sreg4;
    CData/*0:0*/ __Vtrigprevexpr___TOP__clk__0;
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ __VstlIterCount;
    IData/*31:0*/ __VactIterCount;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vlfsr__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vlfsr___024root(Vlfsr__Syms* symsp, const char* v__name);
    ~Vlfsr___024root();
    VL_UNCOPYABLE(Vlfsr___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
