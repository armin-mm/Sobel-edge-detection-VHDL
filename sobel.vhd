library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity	sobel	is
	port(
		data_in			: in   std_logic_vector(0 to 71);
		valid          : in  std_logic ;
	   clk            : in  std_logic ;
	   rst    	      : in  std_logic ;
		ack			:	out  std_logic := '0';
		data_out		:	out  std_logic_vector(0 to 7));
		
end sobel;

architecture behavioral of sobel is

type matrix  is array (0 to 2,0 to 2) of integer ;

begin
process (data_in,clk , valid, rst)

variable sx  			: integer; -- keeps the sigma of convolution
variable temp 			: std_logic_vector(0 to 7) ; -- keep each 8 bit slice of input 
variable pixel 		: matrix ;   -- save the array of integer of input

begin
if (rst = '1') then
	 sx := 0;	
elsif (rising_edge(clk)) then
	
  for i in 0 to 2 loop
		  for j in 0 to 2 loop
			 for k in 0 to 7 loop
			   temp(k) := data_in(24*i + 8*j + k) ;
			 end loop ;
			  pixel(i ,j) := conv_integer (temp );
	 	  end loop ;
	   end loop ;
				 		 
   sx := 	pixel(0 ,0)*1   + 	 pixel(0 ,1)*2 +		   pixel(0 ,2)*1
	+			pixel(1 ,0)*0   +		 pixel(1 ,1)*0 +			pixel(1 ,2)*0
	+			pixel(2 ,0)*(-1)   +	 pixel(2 ,1)*(-2) + 		pixel(2 ,2)*(-1)	;
	
		if (sx<0) then
			  sx := 0;	
			elsif (sx>255) then			
				sx :=255 ;			  
		end if; 		
	end if;	
	data_out <= std_logic_vector(to_unsigned(sx,data_out'length));
	if (valid='1') then		
		ack<='1';
		else 
		ack<='0';
		end if ;
end process;
end behavioral ;
