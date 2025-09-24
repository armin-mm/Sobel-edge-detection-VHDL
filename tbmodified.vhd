

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all; -- require for writing/reading std_logic etc.

entity read_write_file_ex is
end read_write_file_ex;

architecture tb of read_write_file_ex is
	signal data_in			: std_logic_vector(71 downto 0) := (others => '0');	-- 72-bit concatenated input
	signal data_out			: std_logic_vector(7  downto 0);	-- 8-bit output
	
	signal clk				: std_logic := '0';	-- clock
	signal rst				: std_logic := '0';	-- reset
	signal valid			: std_logic := '0';	-- valid
	signal ack				: std_logic;	-- acknowledge

	-- buffer for storing the text from input and for output files
	file input_buf : text;  -- text is keyword
	file output_buf : text;  -- text is keyword
begin     
	UUT : entity work.modifiedsobel port map (clk => clk, rst => rst, data_in => data_in, valid => valid, data_out => data_out, ack => ack);
	
	clk_generator : process
	begin
		-- generate 100 MHZ clock
		clk <= NOT (clk);
		wait for 5 ns;
	end process;
	
	tb1 : process
		variable read_col_from_input_buf : line; -- read lines one by one from input_buf
		variable write_col_to_output_buf : line; -- write lines one by one to output_buf
		variable buf_data_from_file : line;  -- buffer for storind the data from input read-file
		variable val_data_in	: std_logic_vector(71 downto 0); 
		variable val_data_in_2	: std_logic_vector(71 downto 0); 
		variable val_comma		: character;  -- for commas between data in file
		variable good_num		: boolean;
	begin
	-- ####################################################################
	-- Reset Sobel component
		rst <= '1';
		wait for 40 ns;
		rst <= '0';
	-- Reading data
		-- if modelsim-project is created, then provide the relative path of 
		-- input-file (i.e. read_file_ex.txt) with respect to main project folder
		file_open(input_buf, "input.txt",  read_mode);  
		-- writing data
		file_open(output_buf, "output.txt",  write_mode); 
		
		while not endfile(input_buf) loop
			readline(input_buf, read_col_from_input_buf);
			read(read_col_from_input_buf, val_data_in, good_num);
			next when not good_num;  -- i.e. skip the header lines

			-- Pass the variable to a signal to allow the sobel to use it
			val_data_in_2	:= (val_data_in(7 downto 0) & val_data_in(15 downto 8) & val_data_in(23 downto 16) & val_data_in(31 downto 24) & val_data_in(39 downto 32) & val_data_in(47 downto 40) & val_data_in(55 downto 48) & val_data_in(63 downto 56) & val_data_in(71 downto 63));
			data_in			<= val_data_in_2;
			valid			<= '1';
			wait for 10 ns;  --  wait for 1 clock cycle
			valid			<= '0';
			wait until ack = '0';
			wait for 10 ns;  --  wait for 1 clock cycle

			write(write_col_to_output_buf, data_out);

			writeline(output_buf, write_col_to_output_buf);
		end loop;
		file_close(input_buf);             
		file_close(output_buf);             
		wait;
	end process;
end tb ; -- tb