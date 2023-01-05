`timescale 1 ns / 1 ps
module alu(input signed [15:0] A, B, 
	input [3:0] ctrl,
	output reg signed  [31:0] result);
reg overflow;
reg [15:0] remainder;

always@(*)
begin
	case(ctrl)
		0:    
		  begin
		    result = A + B;   //add
	    end   
		1:
		begin
		  result = A - B;   //subtract
		end
		2:    
		begin
		  result = A * B;   //mult
		end
		3:    
		begin 
		  result = A / B;   //div
      remainder = A%B;
      result = {remainder,result[15:0]};

		end
		4:    
		begin
      result = A&B;   //and
		end
		5:    
		begin
		  result = A|B;   //or
    end
    6:
    begin
      result = $unsigned(A) + $unsigned(B); 
    end
	endcase
end	
endmodule
