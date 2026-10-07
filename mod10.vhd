LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY mod10 IS
    PORT(
        clk   : IN STD_LOGIC;
        rst   : IN STD_LOGIC;
        en    : IN STD_LOGIC;
        q     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        carry : OUT STD_LOGIC
    );
END mod10;

ARCHITECTURE Behavioral OF mod10 IS
    SIGNAL count : INTEGER RANGE 0 TO 9 := 0;
BEGIN

    PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN

            carry <= '0';

            IF rst = '1' THEN
                count <= 0;

            ELSIF en = '1' THEN

                IF count = 9 THEN
                    count <= 0;
                    carry <= '1';
                ELSE
                    count <= count + 1;
                END IF;

            END IF;

        END IF;
    END PROCESS;

    q <= STD_LOGIC_VECTOR(TO_UNSIGNED(count, 4));

END Behavioral;