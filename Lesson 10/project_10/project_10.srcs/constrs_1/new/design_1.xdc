# ==============================================================================
# Світлодіоди (LEDs) - LD0..LD3 на платі PYNQ-Z2
# ==============================================================================
set_property -dict { PACKAGE_PIN R14 IOSTANDARD LVCMOS33 } [get_ports { led_tri_o[0] }];
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports { led_tri_o[1] }];
set_property -dict { PACKAGE_PIN N16 IOSTANDARD LVCMOS33 } [get_ports { led_tri_o[2] }];
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 } [get_ports { led_tri_o[3] }];

# ==============================================================================
# Кнопки (Buttons) - BTN0..BTN3 на платі PYNQ-Z2
# ==============================================================================
set_property -dict { PACKAGE_PIN D19 IOSTANDARD LVCMOS33 } [get_ports { button_tri_i[0] }];
set_property -dict { PACKAGE_PIN D20 IOSTANDARD LVCMOS33 } [get_ports { button_tri_i[1] }];
set_property -dict { PACKAGE_PIN L20 IOSTANDARD LVCMOS33 } [get_ports { button_tri_i[2] }];
set_property -dict { PACKAGE_PIN L19 IOSTANDARD LVCMOS33 } [get_ports { button_tri_i[3] }];

# ==============================================================================
# Перемикачі (Switches) - SW0..SW1 та два контакти роз'єму Arduino
# ==============================================================================
set_property -dict { PACKAGE_PIN M20 IOSTANDARD LVCMOS33 } [get_ports { switch_tri_i[0] }];
set_property -dict { PACKAGE_PIN M19 IOSTANDARD LVCMOS33 } [get_ports { switch_tri_i[1] }];


# ==============================================================================
# Clock (Тактовий сигнал 100 МГц)
# ==============================================================================
set_property -dict { PACKAGE_PIN H16 IOSTANDARD LVCMOS33 } [get_ports { clk_100MHz }];

# Часове обмеження (Timing Constraint) для порту. 10 нс = 100 МГц
#create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk_100MHz]

# ==============================================================================
# Reset (Кнопка скидання)
# ==============================================================================
set_property -dict { PACKAGE_PIN D18 IOSTANDARD LVCMOS33 } [get_ports { reset_rtl_0 }];