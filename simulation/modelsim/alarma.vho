-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"

-- DATE "03/26/2025 19:59:01"

-- 
-- Device: Altera EP3C16F484C6 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIII;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIII.CYCLONEIII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	alarma IS
    PORT (
	clk : IN std_logic;
	reset : IN std_logic;
	alarma_personas : IN std_logic;
	habilitar_ascensor : IN std_logic;
	alarma_sonora : BUFFER std_logic;
	alarma_visual : BUFFER std_logic
	);
END alarma;

-- Design Ports Information
-- habilitar_ascensor	=>  Location: PIN_F9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alarma_sonora	=>  Location: PIN_Y1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alarma_visual	=>  Location: PIN_J6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_K8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alarma_personas	=>  Location: PIN_J2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_G2,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF alarma IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL ww_alarma_personas : std_logic;
SIGNAL ww_habilitar_ascensor : std_logic;
SIGNAL ww_alarma_sonora : std_logic;
SIGNAL ww_alarma_visual : std_logic;
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \habilitar_ascensor~input_o\ : std_logic;
SIGNAL \alarma_sonora~output_o\ : std_logic;
SIGNAL \alarma_visual~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \alarma_personas~input_o\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \process_0~0_combout\ : std_logic;
SIGNAL \alarma_sonora~reg0feeder_combout\ : std_logic;
SIGNAL \alarma_sonora~reg0_q\ : std_logic;
SIGNAL \alarma_visual~reg0_q\ : std_logic;

BEGIN

ww_clk <= clk;
ww_reset <= reset;
ww_alarma_personas <= alarma_personas;
ww_habilitar_ascensor <= habilitar_ascensor;
alarma_sonora <= ww_alarma_sonora;
alarma_visual <= ww_alarma_visual;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);

-- Location: IOOBUF_X0_Y6_N9
\alarma_sonora~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alarma_sonora~reg0_q\,
	devoe => ww_devoe,
	o => \alarma_sonora~output_o\);

-- Location: IOOBUF_X0_Y24_N2
\alarma_visual~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alarma_visual~reg0_q\,
	devoe => ww_devoe,
	o => \alarma_visual~output_o\);

-- Location: IOIBUF_X0_Y14_N1
\clk~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G4
\clk~inputclkctrl\ : cycloneiii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: IOIBUF_X0_Y20_N1
\alarma_personas~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alarma_personas,
	o => \alarma_personas~input_o\);

-- Location: IOIBUF_X0_Y22_N8
\reset~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset,
	o => \reset~input_o\);

-- Location: LCCOMB_X1_Y20_N2
\process_0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \process_0~0_combout\ = (\alarma_personas~input_o\) # (\reset~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alarma_personas~input_o\,
	datad => \reset~input_o\,
	combout => \process_0~0_combout\);

-- Location: LCCOMB_X1_Y20_N24
\alarma_sonora~reg0feeder\ : cycloneiii_lcell_comb
-- Equation(s):
-- \alarma_sonora~reg0feeder_combout\ = \process_0~0_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \process_0~0_combout\,
	combout => \alarma_sonora~reg0feeder_combout\);

-- Location: FF_X1_Y20_N25
\alarma_sonora~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alarma_sonora~reg0feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alarma_sonora~reg0_q\);

-- Location: FF_X1_Y20_N3
\alarma_visual~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alarma_visual~reg0_q\);

-- Location: IOIBUF_X7_Y29_N22
\habilitar_ascensor~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_habilitar_ascensor,
	o => \habilitar_ascensor~input_o\);

ww_alarma_sonora <= \alarma_sonora~output_o\;

ww_alarma_visual <= \alarma_visual~output_o\;
END structure;


