// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vf1_fsm.h"
#include "Vf1_fsm__Syms.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

Vf1_fsm::Vf1_fsm(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vf1_fsm__Syms(contextp(), _vcname__, this)}
    , clk{vlSymsp->TOP.clk}
    , rst{vlSymsp->TOP.rst}
    , en{vlSymsp->TOP.en}
    , data_out{vlSymsp->TOP.data_out}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vf1_fsm::Vf1_fsm(const char* _vcname__)
    : Vf1_fsm(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vf1_fsm::~Vf1_fsm() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vf1_fsm___024root___eval_debug_assertions(Vf1_fsm___024root* vlSelf);
#endif  // VL_DEBUG
void Vf1_fsm___024root___eval_static(Vf1_fsm___024root* vlSelf);
void Vf1_fsm___024root___eval_initial(Vf1_fsm___024root* vlSelf);
void Vf1_fsm___024root___eval_settle(Vf1_fsm___024root* vlSelf);
void Vf1_fsm___024root___eval(Vf1_fsm___024root* vlSelf);

void Vf1_fsm::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vf1_fsm::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vf1_fsm___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_activity = true;
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vf1_fsm___024root___eval_static(&(vlSymsp->TOP));
        Vf1_fsm___024root___eval_initial(&(vlSymsp->TOP));
        Vf1_fsm___024root___eval_settle(&(vlSymsp->TOP));
    }
    // MTask 0 start
    VL_DEBUG_IF(VL_DBG_MSGF("MTask0 starting\n"););
    Verilated::mtaskId(0);
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vf1_fsm___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfThreadMTask(vlSymsp->__Vm_evalMsgQp);
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vf1_fsm::eventsPending() { return false; }

uint64_t Vf1_fsm::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "%Error: No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vf1_fsm::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vf1_fsm___024root___eval_final(Vf1_fsm___024root* vlSelf);

VL_ATTR_COLD void Vf1_fsm::final() {
    Vf1_fsm___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vf1_fsm::hierName() const { return vlSymsp->name(); }
const char* Vf1_fsm::modelName() const { return "Vf1_fsm"; }
unsigned Vf1_fsm::threads() const { return 1; }
void Vf1_fsm::prepareClone() const { contextp()->prepareClone(); }
void Vf1_fsm::atClone() const {
    contextp()->threadPoolpOnClone();
}
std::unique_ptr<VerilatedTraceConfig> Vf1_fsm::traceConfig() const {
    return std::unique_ptr<VerilatedTraceConfig>{new VerilatedTraceConfig{false, false, false}};
};

//============================================================
// Trace configuration

void Vf1_fsm___024root__trace_init_top(Vf1_fsm___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    Vf1_fsm___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vf1_fsm___024root*>(voidSelf);
    Vf1_fsm__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->scopeEscape(' ');
    tracep->pushNamePrefix(std::string{vlSymsp->name()} + ' ');
    Vf1_fsm___024root__trace_init_top(vlSelf, tracep);
    tracep->popNamePrefix();
    tracep->scopeEscape('.');
}

VL_ATTR_COLD void Vf1_fsm___024root__trace_register(Vf1_fsm___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void Vf1_fsm::trace(VerilatedVcdC* tfp, int levels, int options) {
    if (tfp->isOpen()) {
        vl_fatal(__FILE__, __LINE__, __FILE__,"'Vf1_fsm::trace()' shall not be called after 'VerilatedVcdC::open()'.");
    }
    if (false && levels && options) {}  // Prevent unused
    tfp->spTrace()->addModel(this);
    tfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    Vf1_fsm___024root__trace_register(&(vlSymsp->TOP), tfp->spTrace());
}
