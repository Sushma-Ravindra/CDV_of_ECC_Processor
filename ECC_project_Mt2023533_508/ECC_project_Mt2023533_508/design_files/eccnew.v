
module ECC_all_Parts(
input clk , rst ,
input [162:0]a,b,k,xp,yp,
output [162:0] xq,yq
//output reg[162:0] out_X1 , out_X2 , out_Z1 , out_Z2
);
reg [162:0] X1,X2,Z1,Z2;
wire [162:0] V3b,V2b,V1b,V3a,V2a,V1a,V1,V2,V3,R1,R2,R3,R3a,R3b,R3c,temp_X1,temp_X2,temp_Z1,temp_Z2,t_Z2;
wire [162:0] init_X2,init_Z2,init_X2a;
reg [7:0]count;
//Init
	   multiplier_163b m13(.mult_out(init_Z2),.mult_in1(xp),.mult_in2(xp));
	   multiplier_163b m14(.mult_out(init_X2),.mult_in1(init_Z2),.mult_in2(init_Z2));
	   cs_adder_163b cs4(.adder_out(init_X2a),.adder_in1(init_X2),.adder_in2(b));
	   
	   
	
	    multiplier_163b m1(.mult_out(V1),.mult_in1(X1),.mult_in2(Z2));
		multiplier_163b m2(.mult_out(V2),.mult_in1(X2),.mult_in2(Z1));
		multiplier_163b m3(.mult_out(V3),.mult_in1(X1),.mult_in2(Z1));
		multiplier_163b m4(.mult_out(R3),.mult_in1(Z1),.mult_in2(Z1));
		multiplier_163b m5(.mult_out(R3a),.mult_in1(R3),.mult_in2(R3));
		cs_adder_163b cs1(.adder_out(t_Z2),.adder_in1(V1),.adder_in2(V2));
		multiplier_163b m6(.mult_out(temp_Z2),.mult_in1(t_Z2),.mult_in2(t_Z2));
		multiplier_163b m7(.mult_out(temp_Z1),.mult_in1(V3),.mult_in2(V3));
		multiplier_163b m8(.mult_out(V1a),.mult_in1(V1),.mult_in2(V2));
		multiplier_163b m9(.mult_out(V2a),.mult_in1(xp),.mult_in2(temp_Z2));
		multiplier_163b m10(.mult_out(V3a),.mult_in1(b),.mult_in2(R3));
		multiplier_163b m11(.mult_out(R3b),.mult_in1(X1),.mult_in2(X1));
		multiplier_163b m12(.mult_out(R3c),.mult_in1(R3),.mult_in2(R3));
		cs_adder_163b cs2(.adder_out(temp_X2),.adder_in1(V1a),.adder_in2(V2a));
		cs_adder_163b cs3(.adder_out(temp_X1),.adder_in1(V3a),.adder_in2(R3c));
	   
	   
	   
	   
	   
	   
	   
//Affine Coordinates to Projective coordinates conversion


	
always @(posedge clk,posedge rst)
begin
		if(rst)
		begin		
			count <= 8'b0;
			X1 <= xp;
			Z1 <= 163'b1;
			X2 <= init_X2a;
			Z2 <= init_Z2;		
		end

	
		
		else if((k[count] == 1'b1) && (count <= 8'b10100001))             
		begin
		
				   X1 <= temp_X2;
				   X2 <= temp_X1;
				   Z1 <= temp_Z2;
				   Z2 <= temp_Z1;
				   count <= count + 8'b1;
		
		end
		else if((k[count] == 1'b0) && (count <= 8'b10100001))
		begin
				   X1 <= temp_X1;
				   X2 <= temp_X2;
				   Z1 <= temp_Z1;
				   Z2 <= temp_Z2;
				   count <= count + 8'b1;
		
		end
		else
		begin
		
			X1 <= X1;
			X2 <= X2;
			Z1 <= Z1;
			Z2 <= Z2;
		end
	end
	
	wire [162:0] v_v1,v_v2,v_v3;
	
	 inversion_op i1(.clk(clk),.rst(rst),.inv_out(v_v1),.inv_inp(Z1));
	 inversion_op i2(.clk(clk),.rst(rst),.inv_out(v_v2),.inv_inp(Z2));
	 inversion_op i3(.clk(clk),.rst(rst),.inv_out(v_v3),.inv_inp(xp));
	 multiplier_163b m15(.mult_out(R1),.mult_in1(X1),.mult_in2(V1));
	 
	 wire [162:0] r_V2,r_R3,r_V1,r_V3,rem_V2,re_V2;
	 multiplier_163b m16(.mult_out(r_V2),.mult_in1(X2),.mult_in2(v_v2));
	 wire [162:0] s_R3;
	 
	 multiplier_163b m17(.mult_out(s_R3),.mult_in1(xp),.mult_in2(xp));
	 cs_adder_163b cs5(.adder_out(r_R3),.adder_in1(s_R3),.adder_in2(yp));
	 cs_adder_163b cs6(.adder_out(r_V1),.adder_in1(xp),.adder_in2(R1));
	 cs_adder_163b cs7(.adder_out(re_V2),.adder_in1(xp),.adder_in2(r_V2));
	 wire [162:0] rem1_V1;
	 multiplier_163b m18(.mult_out(rem1_V1),.mult_in1(r_V1),.mult_in2(v_v3));
	 multiplier_163b m19(.mult_out(rem_V2),.mult_in1(rem1_V1),.mult_in2(re_V2));
	 wire [162:0] rem1_V2,rem2_V2;
	 cs_adder_163b cs8(.adder_out(rem1_V2),.adder_in1(rem_V2),.adder_in2(r_R3));
	 multiplier_163b m20(.mult_out(rem2_V2),.mult_in1(rem1_V1),.mult_in2(rem1_V2));
	 
	 cs_adder_163b cs9(.adder_out(R2),.adder_in1(rem2_V2),.adder_in2(yp));
	
	
	
	assign xq = R1,yq = R2 ;
	
	
	
	
	endmodule
	
	

	