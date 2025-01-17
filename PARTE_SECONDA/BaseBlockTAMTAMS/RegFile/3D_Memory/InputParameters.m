clear all
clc

%TEST PARAMETERS
%channel length 
L =	1.00E-07;
%transistor width
W =	1.00E-06;
%ratio of mobilities pmos/nmos
Beta = 2;

%FILE PARAMETERS
%transistors area
Tr_n_Area = W*L;
Tr_p_Area = Beta*Tr_n_Area;
%gate capacitance of a floating gate transistor
	C_g_fg = 2.5E-16*L;		
%drain capacitance of a floating gate transistor
	C_d_fg = 1.7E-16*L;
%gate capacitance of the SST and GST transistors
	C_g_pt = 5E-16*L;
%drain capacitance of the SST and GST transistors
	C_d_pt = 1.7E-16*L;
%interconnect capacitance per unit of lenght of the wordline
	C_wl_wire = 3.06E-14;
%interconnect capacitance per unit of lenght of the bitline
	C_bl_wire = 3.06E-14;
%interconnect capacitance per unit of lenght of the string select line
	C_ssl_wire = 3.06E-14;
%number of bitlines	
	N_bl_array = [64, 128, 256, 512, 1024, 2048];
%number of wordlines
	N_wl_array = [64, 128, 256, 512, 1024, 2048];
%number of bit in a wordline
	N_bit_word = 32;
%number of slices
    N_slice_array = [32, 64, 128, 256];
%pass-transistor voltage
	V_on_pt = 3;
%precharge voltage
	V_bl_prec = 3;
%erase voltage
	V_bl_erase = 20;
%zero reading probability
	p_0 = 0.5;
%tunnel energy [J]
	E_tunnel = 1.6E-19;
%programming bitline voltage
	V_prog = 20;
%selected wordline voltage
	V_rd_sel = 3;
%unselected wordline voltage
	V_rd_unsel = 6;
%one read voltage
	V_rd_1 = 3;
%zero read voltage
	V_rd_0 = 2.5;
%voltage to inhibit the programming
    V_inhibit = 10;


%read frequency
	f_read = 5.00E+06;
%write frequency
	f_write = 1.00E+06;
%erase frequency
	f_erase = 5.00E+06;
	

%R e C are defined just before the call to the function


%ion current of the precharge mos
	I_on_driver = 1E-3*L;
%output capacitance of the driver driving the gate of the pmos inside the precharge unit
	C_ext_pu_driver = 20E-16*L;
%gate capacitante of the pmos inside the precharge unit
	Cg_pre = Beta*5E-16*L;
%output resistance of the driver driving the gate of the pmos inside the precharge unit
	R_ext_pu_driver = 50;
%gate capacitance of a nmos inside the slice decoder
	Cg_sdec_n = 5E-16*L;
%gate capacitance of a nmos inside the row decoder
	Cg_rdec_n = 5E-16*L;
%gate capacitance of a nmos inside the column decoder	
	Cg_cdec_n = 5E-16*L;
%drain capacitance of the evaluation n-mos transistor in the slice decoder
	Cd_sdec_n = 1.7E-16*L;
%drain capacitance of the evaluation n-mos transistor in the row decoder
	Cd_rdec_n = 1.7E-16*L;
%drain capacitance of the evaluation n-mos transistor in the column decoder
	Cd_cdec_n = 1.7E-16*L;
%drain capacitance of the precharge pmos inside the dynamic slice decoder
	Cd_sdec_pcharge = Beta*1.7E-16*L;
%gate capacitance of the pmos inside the inverter on the output of the slice decoder
	Cg_sdec_inv_p = Beta*5E-16*L;
%gate capacitance of the nmos inside the inverter on the output of the slice decoder
	Cg_sdec_inv_n = 5E-16*L;
%equivalent resistance of the nmos in the slice decoder
	Req_sdec_n = 200;
%equivalent resistance of the pmos inside the inverter on the output of the slice decoder
	Req_sdec_inv_p = 200;
%drain resistance of the pmos inside the inverter on the output of the slice decoder
	Cd_sdec_inv_p = Beta*1.7E-16*L;
%drain resistance of the pmos inside the inverter on the output of the slice decoder
	Cd_sdec_inv_n = 1.7E-16*L;
%equivalent resistance of the nmos in the row decoder
	Req_rdec_n = 200;
%drain capacitance of the precharge pmos inside the dynamic row decoder
	Cd_rdec_pcharge = Beta*1.7E-16*L;
%gate capacitance of the pmos inside the inverter on the output of the row decoder
	Cg_rdec_inv_p = Beta*5E-16*L;
%gate capacitance of the nmos inside the inverter on the output of the row decoder
	Cg_rdec_inv_n = 5E-16*L;
%equivalent resistance of the pmos inside the inverter on the output of the row decoder
	Req_rdec_inv_p = 200;
%drain capacitance of the p_MOS of the inverter on the output of the row decoder
	Cd_rdec_inv_p = Beta*1.7E-16*L;
%drain capacitance of the n_MOS of the inverter on the output of the row decoder
	Cd_rdec_inv_n = 1.7E-16*L;
%drain capacitance of the precharge MOS inside the dynamic column decoder
	Cd_cdec_pcharge = Beta*1.7E-16*L;
%gate capacitance of the p_MOS of the inverter on the output of the row decoder
	Cg_cdec_inv_p = Beta*5E-16*L;
%gate capacitance of the n_MOS of the inverter on the output of the row decoder
	Cg_cdec_inv_n = 5E-16*L;
%drain capacitance of the sense amplifier p-MOS transistor
	Cd_sa_p = Beta*1.7E-16*L;
%drain capacitance of the sense amplifier n-MOS transistor
	Cd_sa_n = 1.7E-16*L;
%gate capacitance of the sense amplifier p-MOS transistor
	Cg_sa_p = Beta*5E-16*L;
%gate capacitance of the sense amplifier n-MOS transistor
	Cg_sa_n = 5E-16*L;
%input sense amplifier resistance
	Req_sa_mod_parallel = 100;
%percentage of voltage swing that makes the sense amplifier switch
	K_SA = 0.05;
%equivalent resistance of the slice pass transistor
	Req_slice = 200;
%drain capacitance of the pass transistor on the output from the slice
	Cd_slice = 1.7E-16*L;
%gate capacitance of the pass transistor on the output from the slice
	Cg_slice = 5E-16*L;
%equivalent resistance of a row pass transistor, on the output of the row decoder and connecting it to the wordline
	Req_rowpass = 200;
%gate capacitance of a row pass transistor, on the output of the row decoder and connecting it to the wordline
	Cg_rowpass = 5E-16*L;
%drain capacitance of a row pass transistor, on the output of the row decoder and connecting it to the wordline
	Cd_rowpass = 1.7E-16*L;
%equivalent resistance of a column pass transistor, on the output of the column decoder and connecting it to the sense amplifier
	Req_colpass = 200;
%gate capacitance of the pass transistor on the output of the column decoder and connecting it to the sense amplifier
	Cg_colpass = 5E-16*L;
%drain capacitance of the pass transistor on the output of the column decoder and connecting it to the sense amplifier
	Cd_colpass = 1.7E-16*L;
%number of erase cycles
	N_erase = 3;
	
%distance between columns of transistor
	Pitch_pp = 3.00E-07;
%gate/drain distance
	Pitch_contact_PT = 5.00E-08;
%Gate gate distance between floating gate mos
	Pitch_FGT_FGT = 1.50E-07;
%Gate gate distance between floating gate mos and normal mos
	Pitch_PT_FGT = 1.50E-07;
%drain/source contact in new generation mos (equal to 0 for bulk tech)
	H_contact = 0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
%%COMPUTATIONS - TEST 1 N_bl N_wl Variation

for i=1:numel(N_wl_array)
N_slice = 1;   
N_wl = N_wl_array(i);
N_bl = N_bl_array(i);

for j=1:N_wl
%array of the resistances used in the elmore delay model of a string
	R(j)= 200;
%array of the capacitances used in the elmore delay model of a string
	C(j)= C_d_fg;
end


 [ P_read, P_write, P_erase, Total_area, Total_volume, Total_delay ] = Memories3D (	N_slice,...
	C_g_fg,...
	C_d_fg,...
	C_g_pt,...
	C_d_pt,...
	C_wl_wire,...
	C_bl_wire,...
	C_ssl_wire,...	
	N_bl,...
	N_wl,...
	N_bit_word,...
	V_on_pt,...
	V_bl_prec,...
    V_bl_erase,...
	p_0,...
	E_tunnel,... 
	V_prog,...
	V_rd_sel,... 
	V_rd_unsel,... 
	V_rd_1,... 
	V_rd_0,...
	V_inhibit,...
	f_read,... 
	f_write,...
	f_erase,...
	R,...	
	C,... 
	I_on_driver,... 	
	C_ext_pu_driver,...
	Cg_pre,...
	R_ext_pu_driver,...
	Cg_sdec_n,...
	Cg_rdec_n,...
	Cg_cdec_n,...
	Cd_sdec_n,...
	Cd_rdec_n,...
	Cd_cdec_n,...
	Req_sdec_n,...			
	Cd_sdec_pcharge,...				
	Cg_sdec_inv_p,...
	Cg_sdec_inv_n,...
	Req_sdec_inv_p,...
	Cd_sdec_inv_p,...
	Cd_sdec_inv_n,...
	Req_rdec_n,...
	Cd_rdec_pcharge,...
	Cg_rdec_inv_p,...
	Cg_rdec_inv_n,...
	Req_rdec_inv_p,...
	Cd_rdec_inv_p,...
	Cd_rdec_inv_n,...
	Cd_cdec_pcharge,...
	Cg_cdec_inv_p,...
	Cg_cdec_inv_n,...
	Cd_sa_p,...
	Cd_sa_n,...
	Cg_sa_p,...
	Cg_sa_n,...
	Req_sa_mod_parallel,...
	K_SA,...	
	Req_slice,...
	Cd_slice,...
	Cg_slice,...
	Req_rowpass,...
	Cg_rowpass,...
	Cd_rowpass,...
	Req_colpass,...
	Cg_colpass,...
	Cd_colpass,...
	N_erase,... 	
	Tr_n_Area,...
	Tr_p_Area,...
	Pitch_pp,...
	Pitch_contact_PT,...
	Pitch_FGT_FGT,...
	Pitch_PT_FGT,...
	H_contact);

Total_delay_array_1(i)=Total_delay;
Total_area_array_1(i)=Total_area;
Total_volume_array_1(i)=Total_volume;
P_read_array_1(i)=P_read;
P_write_array_1(i)=P_write;
P_erase_array_1(i)=P_erase;

end

figure(1)
xq= 64:1:2048;
s = spline(N_wl_array,Total_delay_array_1,xq); %xq coordinate x punti interpolazione, s coordinate y punti interpolazione
plot(N_wl_array,Total_delay_array_1, '*', xq, s)
title('Total delay')
xlabel('N_{wl} and N_{bl}')
ylabel('Delay')
grid on
print('delay_sim','-depsc')

figure(2)
xq= 64:1:2048;
s = spline(N_wl_array,Total_area_array_1,xq); %xq coordinate x punti interpolazione, s coordinate y punti interpolazione
plot(N_wl_array,Total_area_array_1, '*', xq, s)
title('Total area')
xlabel('N_{wl} and N_{bl}')
ylabel('Area')
grid on

figure(3)
xq= 64:1:2048;
s = spline(N_wl_array,Total_volume_array_1,xq); %xq coordinate x punti interpolazione, s coordinate y punti interpolazione
plot(N_wl_array,Total_volume_array_1, '*', xq, s)
title('Total volume')
xlabel('N_{wl} and N_{bl}')
ylabel('Volume')
grid on

figure(4)
xq= 64:1:2048;
s = spline(N_wl_array,P_read_array_1,xq); %xq coordinate x punti interpolazione, s coordinate y punti interpolazione
plot(N_wl_array,P_read_array_1, '*', xq, s)
title('Read Power')
xlabel('N_{wl} and N_{bl}')
ylabel('Power')
grid on

figure(5)
xq= 64:1:2048;
s = spline(N_wl_array,P_write_array_1,xq); %xq coordinate x punti interpolazione, s coordinate y punti interpolazione
plot(N_wl_array,P_write_array_1, '*', xq, s)
title('Write Power')
xlabel('N_{wl} and N_{bl}')
ylabel('Power')
grid on

figure(6)
xq= 64:1:2048;
s = spline(N_wl_array,P_erase_array_1,xq); %xq coordinate x punti interpolazione, s coordinate y punti interpolazione
plot(N_wl_array,P_erase_array_1, '*', xq, s)
title('Erase Power')
xlabel('N_{wl} and N_{bl}')
ylabel('Power')
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
%%COMPUTATIONS - TEST 2 N_slice Variation

for k=1:numel(N_slice_array)
N_slice = N_slice_array(k);   
N_wl = N_wl_array(5);
N_bl = N_bl_array(5);

for l=1:N_wl
%array of the resistances used in the elmore delay model of a string
	R(l)= 200;
%array of the capacitances used in the elmore delay model of a string
	C(l)= C_d_fg;
end


 [ P_read, P_write, P_erase, Total_area, Total_volume, Total_delay ] = Memories3D (	N_slice,...
	C_g_fg,...
	C_d_fg,...
	C_g_pt,...
	C_d_pt,...		%c_gaa_pt PASS TRANSISTOR SST GST
	C_wl_wire,...
	C_bl_wire,...
	C_ssl_wire,...	
	N_bl,...
	N_wl,...
	N_bit_word,...
	V_on_pt,...
	V_bl_prec,...
    V_bl_erase,...
	p_0,...
	E_tunnel,... 
	V_prog,...
	V_rd_sel,... 
	V_rd_unsel,... 
	V_rd_1,... 
	V_rd_0,...
	V_inhibit,...
	f_read,... 
	f_write,...
	f_erase,...
	R,...	
	C,... 
	I_on_driver,... 	
	C_ext_pu_driver,...
	Cg_pre,...
	R_ext_pu_driver,...
	Cg_sdec_n,...
	Cg_rdec_n,...
	Cg_cdec_n,...
	Cd_sdec_n,...
	Cd_rdec_n,...
	Cd_cdec_n,...
	Req_sdec_n,...			
	Cd_sdec_pcharge,...				
	Cg_sdec_inv_p,...
	Cg_sdec_inv_n,...
	Req_sdec_inv_p,...
	Cd_sdec_inv_p,...
	Cd_sdec_inv_n,...
	Req_rdec_n,...
	Cd_rdec_pcharge,...
	Cg_rdec_inv_p,...
	Cg_rdec_inv_n,...
	Req_rdec_inv_p,...
	Cd_rdec_inv_p,...
	Cd_rdec_inv_n,...
	Cd_cdec_pcharge,...
	Cg_cdec_inv_p,...
	Cg_cdec_inv_n,...
	Cd_sa_p,...
	Cd_sa_n,...
	Cg_sa_p,...
	Cg_sa_n,...
	Req_sa_mod_parallel,...
	K_SA,...	
	Req_slice,...
	Cd_slice,...
	Cg_slice,...
	Req_rowpass,...
	Cg_rowpass,...
	Cd_rowpass,...
	Req_colpass,...
	Cg_colpass,...
	Cd_colpass,...
	N_erase,... 	
	Tr_n_Area,...
	Tr_p_Area,...
	Pitch_pp,...
	Pitch_contact_PT,...
	Pitch_FGT_FGT,...
	Pitch_PT_FGT,...
	H_contact);

Total_delay_array_2(k)=Total_delay;
Total_area_array_2(k)=Total_area;
Total_volume_array_2(k)=Total_volume;
P_read_array_2(k)=P_read;
P_write_array_2(k)=P_write;
P_erase_array_2(k)=P_erase;

end

figure(7)
xq= 32:1:256;
s = interp1(N_slice_array,Total_delay_array_2,xq); %xq coordinate x punti interpolazione, s coordinate y punti interpolazione
plot(N_slice_array,Total_delay_array_2, '*', xq, s)
title('Total delay')
xlabel('N_{slice}')
ylabel('Delay')
grid on

figure(8)
xq= 32:1:256;
s = interp1(N_slice_array,Total_area_array_2,xq); %xq coordinate x punti interpolazione, s coordinate y punti interpolazione
plot(N_slice_array,Total_area_array_2, '*', xq, s)
title('Total area')
xlabel('N_{slice}')
ylabel('Area')
grid on

figure(9)
xq= 32:1:256;
s = interp1(N_slice_array,Total_volume_array_2,xq); %xq coordinate x punti interpolazione, s coordinate y punti interpolazione
plot(N_slice_array,Total_volume_array_2, '*', xq, s)
title('Total volume')
xlabel('N_{slice}')
ylabel('Volume')
grid on

figure(10)
xq= 32:1:256;
s = interp1(N_slice_array,P_read_array_2,xq); %xq coordinate x punti interpolazione, s coordinate y punti interpolazione
plot(N_slice_array,P_read_array_2, '*', xq, s)
title('Read Power')
xlabel('N_{slice}')
ylabel('Power')
grid on

figure(11)
xq= 32:1:256;
s = interp1(N_slice_array,P_write_array_2,xq); %xq coordinate x punti interpolazione, s coordinate y punti interpolazione
plot(N_slice_array,P_write_array_2, '*', xq, s)
title('Write Power')
xlabel('N_{slice}')
ylabel('Power')
grid on

figure(12)
xq= 32:1:256;
s = interp1(N_slice_array,P_erase_array_2,xq); %xq coordinate x punti interpolazione, s coordinate y punti interpolazione
plot(N_slice_array,P_erase_array_2, '*', xq, s)
title('Erase Power')
xlabel('N_{slice}')
ylabel('Power')
grid on