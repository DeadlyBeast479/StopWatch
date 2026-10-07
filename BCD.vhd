LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY BCD_to_7seg IS
    PORT(
        bcd : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END BCD_to_7seg;

ARCHITECTURE Behavioral OF BCD_to_7seg IS
BEGIN

    PROCESS(bcd)
    BEGIN

        CASE bcd IS

            WHEN "0000" => seg <= "1000000"; -- 0
            WHEN "0001" => seg <= "1111001"; -- 1
            WHEN "0010" => seg <= "0100100"; -- 2
            WHEN "0011" => seg <= "0110000"; -- 3
            WHEN "0100" => seg <= "0011001"; -- 4
            WHEN "0101" => seg <= "0010010"; -- 5
            WHEN "0110" => seg <= "0000010"; -- 6
            WHEN "0111" => seg <= "1111000"; -- 7
            WHEN "1000" => seg <= "0000000"; -- 8
            WHEN "1001" => seg <= "0010000"; -- 9

            WHEN OTHERS => seg <= "1111111";

        END CASE;

    END PROCESS;

END Behavioral;