// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vclktick.h for the primary calling header

#ifndef VERILATED_VCLKTICK___024ROOT_H_
#define VERILATED_VCLKTICK___024ROOT_H_  // guard

#include "verilated.h"


class Vclktick__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vclktick___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(rst,0,0);
    VL_IN8(en,0,0);
    VL_OUT8(tick,0,0);
    CData/*0:0*/ __Vtrigprevexpr___TOP__clk__0;
    CData/*0:0*/ __VactContinue;
    VL_IN16(N,15,0);
    SData/*15:0*/ clktick__DOT__count;
    IData/*31:0*/ __VactIterCount;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vclktick__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vclktick___024root(Vclktick__Syms* symsp, const char* v__name);
    ~Vclktick___024root();
    VL_UNCOPYABLE(Vclktick___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
