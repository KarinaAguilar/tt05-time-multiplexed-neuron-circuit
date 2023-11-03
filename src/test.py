import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles


@cocotb.test()
async def test_my_design(dut):

    CONSTANT_CURRENT = 80 #Injecting current

    dut._log.info("start simulation")

    #init clock
    clock = Clock(dut.clk, 1, units="ns")
    cocotb.start_soon(clock.start())

    dut.rst_n.value = 0 #low to reset
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1 #out of reset

    dut.ena.value = 1 #enable design

    dut.ui_in.value = CONSTANT_CURRENT
    await ClockCycles(dut.clk, 30)

    CONSTANT_CURRENT = 45
    dut.ui_in.value = CONSTANT_CURRENT
    await ClockCycles(dut.clk, 10)

    for _ in range(200):
        await RisingEdge(dut.clk)

    assert dut.ui_in.value == dut.ui_in.value
    dut._log.info("Finished Test")
