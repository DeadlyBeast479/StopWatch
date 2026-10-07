LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY mod5000000 IS
    PORT(
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        en  : IN STD_LOGIC;
        tick : OUT STD_LOGIC
    );
END mod5000000;

ARCHITECTURE Behavioral OF mod5000000 IS
    SIGNAL count : INTEGER RANGE 0 TO 4999999 := 0;
BEGIN

    PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN

            tick <= '0';

            IF rst = '1' THEN
                count <= 0;

            ELSIF en = '1' THEN

                IF count = 4999999 THEN
                    count <= 0;
                    tick <= '1';
                ELSE
                    count <= count + 1;
                END IF;

            END IF;

        END IF;
    END PROCESS;

END Behavioral;