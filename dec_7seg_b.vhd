-- updated to have bus output for segments, jlobo dec 2007

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

-- Hexadecimal to 7 Segment Decoder for LED Display

ENTITY dec_7seg_b IS
	
	PORT( clock_1_8432MHz	: IN	STD_LOGIC;
			reset		 			: IN	STD_LOGIC;
			hex_digit			: IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
	      HEX		 			: OUT   STD_LOGIC_VECTOR(6 downto 0) );

END dec_7seg_b;

ARCHITECTURE a OF dec_7seg_b IS
	SIGNAL segment_data : STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN
	PROCESS
		-- HEX to 7 Segment Decoder for LED Display
	BEGIN
		WAIT UNTIL clock_1_8432MHz'EVENT and clock_1_8432MHz = '1';
		if reset='1' then
			HEX<=(others => '0');
		else
			-- Hex-digit is the four bit binary value to display in hexadecimal
		  CASE Hex_digit IS
				WHEN "0000" =>
					 segment_data <= "1111110";
				WHEN "0001" =>
					 segment_data <= "0110000";
				WHEN "0010" =>
					 segment_data <= "1101101";
				WHEN "0011" =>
					 segment_data <= "1111001";
				WHEN "0100" =>
					 segment_data <= "0110011";
				 WHEN "0101" =>
					 segment_data <= "1011011";
				 WHEN "0110" =>
					 segment_data <= "1011111";
			 WHEN "0111" =>
					 segment_data <= "1110000";
			  WHEN "1000" =>
					 segment_data <= "1111111";
			 WHEN "1001" =>
					 segment_data <= "1111011"; 
				WHEN "1010" =>
					 segment_data <= "1110111";
				 WHEN "1011" =>
					 segment_data <= "0011111"; 
				 WHEN "1100" =>
					 segment_data <= "1001110"; 
				 WHEN "1101" =>
					 segment_data <= "0111101"; 
				 WHEN "1110" =>
					  segment_data <= "1001111"; 
				 WHEN "1111" =>
					  segment_data <= "1000111"; 
				 WHEN OTHERS =>
				 segment_data <= "0111110";
		  END CASE;
		end if;
		-- extract segment data bits and invert
		-- LED driver circuit is inverted
		HEX(6) <= NOT segment_data(0);
		HEX(5) <= NOT segment_data(1);
		HEX(4) <= NOT segment_data(2);
		HEX(3) <= NOT segment_data(3);	
		HEX(2) <= NOT segment_data(4);
		HEX(1) <= NOT segment_data(5);
		HEX(0) <= NOT segment_data(6);
	
	END PROCESS;
END a;

