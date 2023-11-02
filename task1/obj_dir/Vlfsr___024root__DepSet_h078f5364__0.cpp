// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vlfsr.h for the primary calling header

#include "verilated.h"

#include "Vlfsr__Syms.h"
#include "Vlfsr___024root.h"

void Vlfsr___024root___eval_act(Vlfsr___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlfsr__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlfsr___024root___eval_act\n"); );
}

VL_INLINE_OPT void Vlfsr___024root___nba_sequent__TOP__0(Vlfsr___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlfsr__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlfsr___024root___nba_sequent__TOP__0\n"); );
    // Init
    CData/*3:0*/ __Vdly__lfsr__DOT__sreg;
    __Vdly__lfsr__DOT__sreg = 0;
    // Body
    __Vdly__lfsr__DOT__sreg = vlSelf->lfsr__DOT__sreg;
    if (vlSelf->rst) {
        __Vdly__lfsr__DOT__sreg = 1U;
    } else if (vlSelf->en) {
        __Vdly__lfsr__DOT__sreg = ((0xcU & ((IData)(vlSelf->lfsr__DOT__sreg) 
                                            << 1U)) 
                                   | (((IData)(vlSelf->lfsr__DOT__sreg3_xor_sreg4) 
                                       << 1U) | (1U 
                                                 & ((IData)(vlSelf->lfsr__DOT__sreg) 
                                                    >> 3U))));
    }
    vlSelf->lfsr__DOT__sreg = __Vdly__lfsr__DOT__sreg;
    vlSelf->data_out = vlSelf->lfsr__DOT__sreg;
    vlSelf->lfsr__DOT__sreg3_xor_sreg4 = (1U & VL_REDXOR_4(
                                                           (0xcU 
                                                            & (IData)(vlSelf->lfsr__DOT__sreg))));
}

void Vlfsr___024root___eval_nba(Vlfsr___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlfsr__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlfsr___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vlfsr___024root___nba_sequent__TOP__0(vlSelf);
    }
}

void Vlfsr___024root___eval_triggers__act(Vlfsr___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vlfsr___024root___dump_triggers__act(Vlfsr___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vlfsr___024root___dump_triggers__nba(Vlfsr___024root* vlSelf);
#endif  // VL_DEBUG

void Vlfsr___024root___eval(Vlfsr___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlfsr__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlfsr___024root___eval\n"); );
    // Init
    VlTriggerVec<1> __VpreTriggered;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        __VnbaContinue = 0U;
        vlSelf->__VnbaTriggered.clear();
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            vlSelf->__VactContinue = 0U;
            Vlfsr___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                    Vlfsr___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("lfsr.sv", 1, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
                Vlfsr___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
                Vlfsr___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("lfsr.sv", 1, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            Vlfsr___024root___eval_nba(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
void Vlfsr___024root___eval_debug_assertions(Vlfsr___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vlfsr__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vlfsr___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->rst & 0xfeU))) {
        Verilated::overWidthError("rst");}
    if (VL_UNLIKELY((vlSelf->en & 0xfeU))) {
        Verilated::overWidthError("en");}
}
#endif  // VL_DEBUG
