LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY stopwatch IS
    PORT(
        clk     : IN STD_LOGIC;
        go      : IN STD_LOGIC;
        syn_clr : IN STD_LOGIC;

        sseg0   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        sseg1   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        sseg2   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END stopwatch;

ARCHITECTURE Structural OF stopwatch IS

    SIGNAL tick_01s : STD_LOGIC;
    SIGNAL carry0   : STD_LOGIC;
    SIGNAL carry1   : STD_LOGIC;

    SIGNAL decimas  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL segundos : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL decenas  : STD_LOGIC_VECTOR(3 DOWNTO 0);

    SIGNAL seg0_aux : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL seg1_aux : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL seg2_aux : STD_LOGIC_VECTOR(6 DOWNTO 0);

    SIGNAL run      : STD_LOGIC := '0';
    SIGNAL go_ant   : STD_LOGIC := '1';

BEGIN

    -- Botón GO
    PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            go_ant <= go;
            IF syn_clr = '0' THEN
                run <= '0';
            ELSIF go_ant = '1' AND go = '0' THEN
                run <= NOT run;
            END IF;
        END IF;
    END PROCESS;

    md_cinco: ENTITY WORK.mod5000000
        PORT MAP(
            clk  => clk,
            rst  => NOT syn_clr,
            en   => run,
            tick => tick_01s
        );


    -- Décimas
    md_diez1: ENTITY WORK.mod10
        PORT MAP(
            clk   => clk,
            rst   => NOT syn_clr,
            en    => tick_01s,
            q     => decimas,
            carry => carry0
        );


    -- Segundos unidades
    md_diez2: ENTITY WORK.mod10
        PORT MAP(
            clk   => clk,
            rst   => NOT syn_clr,
            en    => carry0,
            q     => segundos,
            carry => carry1
        );


    -- Segundos decenas
    md_diez3: ENTITY WORK.mod10
        PORT MAP(
            clk   => clk,
            rst   => NOT syn_clr,
            en    => carry1,
            q     => decenas,
            carry => OPEN
        );


    -- Displays
    seg0: ENTITY WORK.BCD_to_7seg
        PORT MAP(
            bcd => decimas,
            seg => seg0_aux
        );

    seg1: ENTITY WORK.BCD_to_7seg
        PORT MAP(
            bcd => segundos,
            seg => seg1_aux
        );

    seg2: ENTITY WORK.BCD_to_7seg
        PORT MAP(
            bcd => decenas,
            seg => seg2_aux
        );


    -- Punto decimal
    sseg0 <= '1' & seg0_aux;
    sseg1 <= '0' & seg1_aux;
    sseg2 <= '1' & seg2_aux;

END Structural;