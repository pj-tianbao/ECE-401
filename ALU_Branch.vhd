library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ALU_Branch is  

port(
    ALU_out_sig : in std_logic_vector (31 downto 0);
    ALUop_sig   : in std_logic_vector (4 downto 0);
    ALU_Branch_sig : out std_logic
);
end ALU_Branch;
architecture behaviour of ALU_Branch is  
begin
    process(ALU_out_sig,ALUop_sig)
begin
ALU_Branch_sig <= '0';
    
        case ALUop_sig is   
         when "00000" => -- BEQ: Branch if Equal (ALU_out == 0)
                if ALU_out_sig = X"00000000" then
                    ALU_Branch_sig <= '1';
                else
                    ALU_Branch_sig <= '0';
                end if;

            when "00001" => -- BNE: Branch if Not Equal (ALU_out /= 0)
                if ALU_out_sig /= X"00000000" then
                    ALU_Branch_sig <= '1';
                else
                    ALU_Branch_sig <= '0';
                end if;

            when "00100" => -- BLT: Branch if Less Than (signed)
                if signed(ALU_out_sig) < 0 then
                    ALU_Branch_sig <= '1';
                else
                    ALU_Branch_sig <= '0';
                end if;

            when "00101" => -- BGE: Branch if Greater or Equal (signed)
                if signed(ALU_out_sig) >= 0 then
                    ALU_Branch_sig <= '1';
                else
                    ALU_Branch_sig <= '0';
                end if;

            when "00110" => -- BLTU: Branch if Less Than (unsigned)
                if unsigned(ALU_out_sig) < 0 then
                    ALU_Branch_sig <= '1';
                else
                    ALU_Branch_sig <= '0';
                end if;

            when "00111" => -- BGEU: Branch if Greater or Equal (unsigned)
                if unsigned(ALU_out_sig) >= 0 then
                    ALU_Branch_sig <= '1';
                else
                    ALU_Branch_sig <= '0';
                end if;

            when others => -- Default case: No branch
                ALU_Branch_sig <= '0';
        end case;
    end process;
end behaviour;
    


