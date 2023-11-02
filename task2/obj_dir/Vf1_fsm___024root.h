// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vf1_fsm.h for the primary calling header

#ifndef VERILATED_VF1_FSM___024ROOT_H_
#define VERILATED_VF1_FSM___024ROOT_H_  // guard

#include "verilated.h"


class Vf1_fsm__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vf1_fsm___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(rst,0,0);
    VL_IN8(en,0,0);
    VL_OUT8(data_out,7,0);
    CData/*2:0*/ f1_fsm__DOT__current_state;
    CData/*2:0*/ f1_fsm__DOT__next_state;
    CData/*0:0*/ __Vtrigprevexpr___TOP__clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__rst__0;
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ __VstlIterCount;
    IData/*31:0*/ __VactIterCount;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vf1_fsm__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vf1_fsm___024root(Vf1_fsm__Syms* symsp, const char* v__name);
    ~Vf1_fsm___024root();
    VL_UNCOPYABLE(Vf1_fsm___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
