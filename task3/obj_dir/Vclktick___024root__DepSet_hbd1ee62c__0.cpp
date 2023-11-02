// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vclktick.h for the primary calling header

#include "verilated.h"

#include "Vclktick__Syms.h"
#include "Vclktick___024root.h"

void Vclktick___024root___eval_act(Vclktick___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vclktick__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vclktick___024root___eval_act\n"); );
}

VL_INLINE_OPT void Vclktick___024root___nba_sequent__TOP__0(Vclktick___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vclktick__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vclktick___024root___nba_sequent__TOP__0\n"); );
    // Init
    SData/*15:0*/ __Vdly__clktick__DOT__count;
    __Vdly__clktick__DOT__count = 0;
    // Body
    __Vdly__clktick__DOT__count = vlSelf->clktick__DOT__count;
    if (vlSelf->rst) {
        vlSelf->tick = 0U;
        __Vdly__clktick__DOT__count = vlSelf->N;
    } else if (vlSelf->en) {
        if ((0U == (IData)(vlSelf->clktick__DOT__count))) {
            vlSelf->tick = 1U;
            __Vdly__clktick__DOT__count = vlSelf->N;
        } else {
            __Vdly__clktick__DOT__count = (0xffffU 
                                           & ((IData)(vlSelf->clktick__DOT__count) 
                                              - (IData)(1U)));
            vlSelf->tick = 0U;
        }
    }
    vlSelf->clktick__DOT__count = __Vdly__clktick__DOT__count;
}

void Vclktick___024root___eval_nba(Vclktick___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vclktick__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vclktick___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vclktick___024root___nba_sequent__TOP__0(vlSelf);
    }
}

void Vclktick___024root___eval_triggers__act(Vclktick___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vclktick___024root___dump_triggers__act(Vclktick___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vclktick___024root___dump_triggers__nba(Vclktick___024root* vlSelf);
#endif  // VL_DEBUG

void Vclktick___024root___eval(Vclktick___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vclktick__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vclktick___024root___eval\n"); );
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
            Vclktick___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                    Vclktick___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("clktick.sv", 1, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
                Vclktick___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
                Vclktick___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("clktick.sv", 1, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            Vclktick___024root___eval_nba(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
void Vclktick___024root___eval_debug_assertions(Vclktick___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vclktick__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vclktick___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->rst & 0xfeU))) {
        Verilated::overWidthError("rst");}
    if (VL_UNLIKELY((vlSelf->en & 0xfeU))) {
        Verilated::overWidthError("en");}
}
#endif  // VL_DEBUG
