---- Libraries used --
--
--Library IEEE;
--use IEEE.std_logic_1164.all;
--use IEEE.numeric_std.all;
--use IEEE.std_logic_unsigned.all;
--use ieee.fixed_float_types.all;
----!ieee_proposed for fixed point
--use ieee.fixed_pkg.all;
----!ieee_proposed for floating point
--use ieee.float_pkg.all;
--
--entity HH is
--
--generic 
--	(
--		DATA_WIDTH : natural := 56;
--		ADDR_WIDTH : natural := 16;
--		SPIKE:		 natural := 304
--	);
--
--port (clk		: IN std_logic;
--		reset		: IN std_logic;
--		data_ready: IN std_logic;
--		result	: IN	STD_LOGIC_VECTOR (7 downto 0);
--		waddr		: OUT std_logic_vector((ADDR_WIDTH-1) downto 0);
--		data		: OUT std_logic_vector((DATA_WIDTH-1) downto 0);
--		we			: OUT std_logic;
--		queue		: out std_logic_vector((ADDR_WIDTH-1) downto 0);
--		rst		: OUT std_logic;
--		debug		: OUT std_logic_vector (7 downto 0)
--		);
--end HH;
--
---- architecture body --
--architecture HH_arch of HH is
--
--signal 	A:					float32;
--signal 	B:					float32;
--signal 	C:					float32;
--signal 	h1:					float32;
--signal 	h2:					float32;
--signal 	h6:					float32;
--signal 	qstar1:					float32;
--signal 	qstar2:					float32;
--signal	forces:					float32;
--signal	forces_aux:				float32;
--signal	spikeTrain:				std_logic_vector (SPIKE-1 downto 0)	:=(others=>'0');
--signal	spikes: 				float32;
--signal	qAux:					std_logic_vector((ADDR_WIDTH-1) downto 0):=(others =>'0');
--signal	ct:					natural							:=0;
--signal	count:					natural							:=0;
--signal	rst_flag: 				std_logic						:='0';
--signal	conf_flag:				std_logic						:='0';
--signal	cycles:					std_logic_vector (15 downto 0)   :=(others=>'0');
--signal	timestamp:				natural							:=0;
--signal	rk_flag:				std_logic						:='0';
--signal	K1A:					float32;
--signal 	K1B:					float32;
--signal	q1A:					float32;
--signal	q1B:					float32;
--signal	K2A:					float32;
--signal	K2B:					float32;
--signal	q2A:					float32;
--signal	q2B:					float32;
--signal	K3A:					float32;
--signal	K3B:					float32;
--signal	q3A:					float32;
--signal	q3B:					float32;
--signal	K4A:					float32;
--signal	K4B:					float32;
--signal 	countRK:				natural							:=0;
--signal	lnx_flag:			std_logic								:='0';
--signal	expx_flag:			std_logic								:='0';
--signal	power_flag:			std_logic								:='0';
--signal	mathBusy:			std_logic								:='0';
--signal	lnx:				float32;
--signal	expx: 				float32;
--signal	log: 				float32;
--signal	bb:				float32;
--signal	cc:				float32;
--signal	mathSel:			natural							:=0;
--signal	mathRes:			float32;
--signal	mathRes_ready:			std_logic 								:='0';
--signal	mathFlag:			std_logic 								:='0';
--signal 	ENa:					float32;
--signal	EK: 					float32;
--signal	El:					float32;
--signal 	gbarNa:					float32;
--signal	gbarK:					float32;
--signal 	gbarl:					float32;
--signal	Vm_rest:				float32;
--signal	Cm:					float32;	
--signal	w1:					float32;	
--signal	w2:					float32;	
--signal 	aV:					float32;
--signal 	aux:					std_logic_vector (31 downto 0)   :=(others=>'0');
--signal 	aux1:					float32;
--signal 	aux2:					float32;
--signal 	aux3:					float32;
--signal 	aux4:					float32;
--signal 	h:					float32;
--signal 	m:					float32;
--signal 	n:					float32;
--signal 	auxRes:					float32;
--signal 	syn1:					float32;
--signal 	syn2:					float32;
--signal 	csyn1:			natural									:=0;
--signal 	csyn2:			natural									:=0;
--signal	compute_flag:	std_logic 								:='0';
--		--- process ---
--BEGIN
--	process(clk, reset, qstar1, qstar2, rk_flag)
--	begin
--	if clk'event and clk='1' then 
--		if reset='1' then
--			forces<=to_float(0.0,forces);
--			forces_aux<=to_float(0.0,forces_aux);
--			conf_flag<='0';
--			ct<=0;
--			count<=0;
--			rst_flag<='0';
--			cycles<=(others =>'0');
--			timestamp<=0;
--			spikes<=to_float(0.0,spikes);
--			spikeTrain<=(others =>'0');
--			rk_flag<='0';
--			we<='0';
--			data<=(others => '0');
--			waddr<=(others => '0');
--			queue<=(others => '0');
--			Vm_rest<=to_float(0.0,Vm_rest);
--			Cm<=to_float(0.0,Cm);
--			ENa<=to_float(55.17,ENa);
--			EK<=to_float(-72.14,EK);
--			El<=to_float(-49.42,El);
--			gbarNa<=to_float(1.2,gbarNa);
--			gbarK<=to_float(0.36,gbarK); 
--			gbarl<=to_float(0.003,gbarl);
--			time_step<=to_float(0.0,time_step);
--			aux1<=to_float(0.0,aux1);
--			aux2<=to_float(0.0,aux2);
--			aux3<=to_float(0.0,aux3);
--			aux4<=to_float(0.0,aux4);
--			h<=to_float(0.0,h);
--			m<=to_float(0.0,m);
--			n<=to_float(0.0,n);
--			aV<=to_float(0.0,aV);
--			auxRes<=to_float(0.0,auxRes);
--			w1<=to_float(0.0,w1);
--			w2<=to_float(0.0,w2);
--			syn1<=to_float(0.0,syn1);
--			syn2<=to_float(0.0,syn2);
--			csyn1<=0;
--			csyn2<=0;
--			compute_flag<='0';
--			bb<=to_float(0.0,bb);
--			cc<=to_float(0.0,cc);
--			mathSel<=0;
--			mathFlag<='0';
--			aux<=(others=>'0');
--		else
--			
--			if data_ready='1' and result=x"FF" and ct=0 and conf_flag='0' then
--				ct<=ct+1;
--			elsif data_ready='1' and ct=1 then
--				cycles(15 downto 8)<=result;
--				ct<=ct+1;
--			elsif data_ready='1' and ct=2 then
--				cycles(7 downto 0)<=result;
--				ct<=ct+1;
--			elsif data_ready='1' and ct=3 then
--				aux(31 downto 24)<=result;
--				ct<=ct+1;
--			elsif data_ready='1' and ct=4 then
--				aux(23 downto 16)<=result;
--				ct<=ct+1;
--			elsif data_ready='1' and ct=5 then
--				aux(15 downto 8)<=result;
--				ct<=ct+1;
--			elsif data_ready='1' and ct=6 then
--				aux(7 downto 0)<=result;
--				ct<=ct+1;
--			elsif ct=7 then
--				time_step<=to_float(aux,time_step);
--				ct<=0;
--				conf_flag<='1';
--			else
--				-- nothing happens
--			end if;
--			
--			if data_ready='1' and result=x"EE" and ct=0 then
--				rst_flag<='1';
--			elsif rst_flag='1' then
--				rst_flag<='0';
--			else
--				-- nothing happens.
--			end if;
--			
--			if conf_flag='1' and timestamp < cycles and count=0 then
--				if timestamp=0 then
--					mathFlag<='1';
--					mathSel<=2;
--					-- am => 0.1*(v+35.)/(1-exp(-(v+35)/10.))
--					aux1<= to_float(0.1,aux1)*(aV+to_float(35.0,aux1));
--					bb<=-(aV+to_float(35.0,bb))*to_float(0.1,bb);
--				else
--					--TO DO
--				end if;
--				count<=count+1;
--			elsif count =1 then
--				if timestamp=0 then
--					mathFlag<='0';
--				else
--					--TO DO
--				end if;
--				count<=count+1;
--			elsif count=2 then
--				if timestamp=0 and mathRes_ready='1' then
--					aux1<=aux1/(to_float(1.0,aux1)-mathRes);
--					aux2<=aux1/(to_float(1.0,aux1)-mathRes);
--					--bm => 4.0*exp(-0.0556*(v+60.))
--					aux3<=to_float(4.0,aux3);
--					mathFlag<='1';
--					mathSel<=2;
--					bb<=-(to_float(-0.0556,bb)*(aV+to_float(60.0,bb));
--					count<=count+1;
--				else
--					--TO DO
--				end if;
--			elsif count =3 then
--				if timestamp=0 then
--					mathFlag<='0';
--				else
--					--TO DO
--				end if;
--				count<=count+1;
--			elsif count=4 then
--				if timestamp=0 and mathRes_ready='1' then
--					-- m = am/(am+bm)
--					m<=aux1/(aux2+aux3*mathRes);
--					--an => 0.01*(v + 50.)/(1-exp(-(v + 50.)/10.))
--					aux1<=to_float(0.01,aux1)*(aV+to_float(50.0,aux1));
--					mathFlag<='1';
--					mathSel<=2;
--					bb<=-(aV+to_float(50.0,bb))*to_float(0.1,bb);
--					count<=count+1;
--				else
--					--TO DO
--				end if;
--			elsif count =5 then
--				if timestamp=0 then
--					mathFlag<='0';
--				else
--					--TO DO
--				end if;
--				count<=count+1;
--			elsif count=6 then
--				if timestamp=0 and mathRes_ready='1' then
--					aux1<=aux1/(to_float(1.0,aux1)-mathRes);
--					aux2<=aux1/(to_float(1.0,aux1)-mathRes);
--					-- bn => 0.125*exp(-(v + 60.)/80.)
--					aux3<=to_float(0.125,aux3);
--					mathFlag<='1';
--					mathSel<=2;
--					bb<=-(aV+to_float(60.0,bb))*to_float(0.0125,bb);
--					count<=count+1;
--				else
--					--TO DO
--				end if;
--			elsif count =7 then
--				if timestamp=0 then
--					mathFlag<='0';
--				else
--					--TO DO
--				end if;
--				count<=count+1;
--			elsif count=8 then
--				if timestamp=0 and mathRes_ready='1' then
--					-- n = an/(an+bn)
--					n<=aux1/(aux2+aux3*mathRes);
--					-- ah => 0.07*exp(-0.05*(v + 60.))
--					aux1<=to_float(0.07,aux1)
--					mathFlag<='1';
--					mathSel<=2;
--					bb<=-(to_float(-0.05,bb)*(aV+to_float(60.0,bb));
--					count<=count+1;
--				else
--					--TO DO
--				end if;
--			elsif count =9 then
--				if timestamp=0 then
--					mathFlag<='0';
--				else
--					--TO DO
--				end if;
--				count<=count+1;
--			elsif count=10 then
--				if timestamp=0 and mathRes_ready='1' then
--					aux1<=aux1*mathRes;
--					aux2<=aux1*mathRes;
--					-- bh => 1./(1+exp(-(0.1)*(v + 30.)))
--					aux3<=to_float(1.0,aux3);
--					mathFlag<='1';
--					mathSel<=2;
--					bb<=-(to_float(0.1,bb)*(aV+to_float(630.0,bb));
--					count<=count+1;
--				else
--					--TO DO
--				end if;
--			elsif count =11 then
--				if timestamp=0 then
--					mathFlag<='0';
--				else
--					--TO DO
--				end if;
--				count<=count+1;
--			elsif count=12 then
--				if timestamp=0 and mathRes_ready='1' then
--					-- h = ah/(ah+bh)
--					n<=aux1/(aux2+aux3/(aux3+mathRes));
--					count<=count+1;
--				else
--					--TO DO
--				end if;
--			
--			
--			
--			
--			elsif count=1 then
--					we<='1';
--					queue<=qAux+1;
--					waddr<=qAux;
--					qAux<=qAux+1;
--					data(55 downto 40)<=std_logic_vector(to_unsigned(timestamp,16));
--					data(39 downto 8)<=to_slv(forces);
--					data(7 downto 0)<=(others =>'0');
--					count<=count+1;
--				
--			elsif count=2 then
--					we<='0';
--					count<=0;
--					timestamp<=timestamp+1;
--					debug<=std_logic_vector(to_unsigned(timestamp,8));
--					spikes_flag<='0';
--			else
--			-- nothing happens
--			end if;
--			rst<=rst_flag;
--		end if;	
--		else
--			-- nothing happens
--		end if;
--	end process;
--	
--	process(clk, reset, spikes_flag, spikes)
--	begin
--	if clk'event and clk='1' then 
--		if reset='1' then
--			A<=to_float(5.75,A);
--			B<=to_float(65.0,B);
--			C<=to_float(250.0,C);
--			h1<=to_float(0.001,h1);
--			h2<=to_float(0.0005,h2);
--			h6<=to_float(0.00016666666666666666,h6);
--			qstar1<=to_float(0.0,qstar1);
--			qstar2<=to_float(0.0,qstar2);
--			countRK<=0;
--			rk_flag<='0';
--		else
--			if countRK=0 and spikes_flag='1' then
--				K1A<=qstar2;
--				K1B<=A*spikes-B*qstar1-C*qstar2;
--				countRK<=countRK+1;
--			elsif countRK=1 then
--				q1A<=qstar1+K1A*h2;
--				q1B<=qstar2+K1B*h2;
--				countRK<=countRK+1;
--			elsif countRK=2 then
--				K2A<=q1B;
--				K2B<=A*spikes-B*q1A-C*q1B;
--				countRK<=countRK+1;
--			elsif countRK=3 then
--				q2A<=qstar1+K2A*h2;
--				q2B<=qstar2+K2B*h2;
--				countRK<=countRK+1;
--			elsif countRK=4 then
--				K3A<=q2B;
--				K3B<=A*spikes-B*q2A-C*q2B;
--				countRK<=countRK+1;
--			elsif countRK=5 then
--				q3A<=qstar1+K3A*h1;
--				q3B<=qstar2+K3B*h1;
--				countRK<=countRK+1;
--			elsif countRK=6 then
--				K4A<=q3B;
--				K4B<=A*spikes-B*q3A-C*q3B;
--				countRK<=countRK+1;
--			elsif countRK=7 then
--				qstar1<=qstar1+h6*(K1A + 2*K2A + 2*K3A + K4A);
--				qstar2<=qstar2+h6*(K1B + 2*K2B + 2*K3B + K4B);
--				countRK<=countRK+1;
--				rk_flag<='1';
--			elsif countRK=8 then
--				countRK<=countRK+1;
--				rk_flag<='0';
--			elsif countRK>8 and countRK<13 then
--				countRK<=countRK+1;
--			elsif countRK=13 then
--				countRK<=0;
--			else
--				--nothing happens
--			end if;
--		end if;
--	else
--		-- nothing happens
--	end if;
--	end process;
--	
--	process(clk, reset, bb, cc, mathSel)	
--		variable countln: natural:=0;
--		variable countlog: natural:=0;
--		variable countexp: natural:=0;
--		variable countpow: natural:=0;
--		variable xFirst: float32;
--		variable xSecond: float32;
--		variable xThird: float32;
--		variable xFourth: float32;
--		variable xMinusX: float32;
--		variable xMinusX_2: float32;
--		variable xMinusX_3: float32;
--		variable xMinusX_4: float32;
--		variable inv1	  : float32;
--		variable inv2	  : float32;
--		variable inv3	  : float32;
--		variable inv4     : float32;
--		variable expaux	  : float32;
--	begin
--	if clk'event and clk='1' then 
--		if reset='1' then
--			countln:=0;
--			countlog:=0;
--			countexp:=0;
--			xMinusX:= to_float(0.0,xMinusX);
--			xMinusX_2:= to_float(0.0,xMinusX);
--			xMinusX_3:= to_float(0.0,xMinusX);
--			xMinusX_4:= to_float(0.0,xMinusX);
--			xFirst:= to_float(1.0,xFirst);
--			xSecond:= to_float(0.5,xSecond);
--			xThird:= to_float(0.3333333333333333,xThird);
--			xFourth:= to_float(0.25,xFourth);
--			lnx<=to_float(0.0,lnx);
--			log<=to_float(0.0,log);
--			lnx_flag<='0';
--			expx_flag<='0';
--			mathRes<=to_float(0.0,mathRes);
--			mathRes_ready<='0';
--			mathBusy<='0';
--			inv1:= to_float(0.0,inv1);
--			inv2:= to_float(0.0,inv2);
--			inv3:= to_float(0.0,inv3);
--			inv4:= to_float(0.0,inv4);
--			expx<= to_float(0.0,expx);
--			expaux:=to_float(0.0,expaux);
--			power_flag<='0';
--		else
--			-- ln(a) - (x-1) -1/2(x-1)^2+1/3(x-1)^3-1/4(x-1)^4
--			if (mathSel=0 or mathSel=2) and mathFlag = '1' and countln=0 then
--				xFirst:= to_float(1.0,xFirst);
--				xSecond:= to_float(0.5,xSecond);
--				xThird:= to_float(0.3333333333333333,xThird);
--				xFourth:= to_float(0.25,xFourth);
--				xMinusX:=bb-to_float(1.0,xMinusX);
--				xMinusX_2:=bb-to_float(1.0,xMinusX_2);
--				xMinusX_3:=bb-to_float(1.0,xMinusX_3);
--				xMinusX_4:=bb-to_float(1.0,xMinusX_4);
--				countln:=countln+1;
--				if mathSel=0 then
--					mathBusy<='1';
--				else
--					--nothing happens
--				end if;
--			elsif countln=1 then
--				xMinusX:=xMinusX*xFirst;
--				xMinusX_2:=xMinusX_2*xMinusX;
--				xMinusX_3:=xMinusX_3*xMinusX*xMinusX;
--				xMinusX_4:=xMinusX_4*xMinusX*xMinusX*xMinusX;
--				countln:=countln+1;
--			elsif countln=2 then
--				--second iteration ^3
--				xMinusX_2:=xMinusX_2*xSecond;
--				xMinusX_3:=xMinusX_3*xThird;
--				xMinusX_4:=xMinusX_4*xFourth;
--				countln:=countln+1;
--			elsif countln=3 then
--				lnx<=xMinusX-xMinusX_2+xMinusX_3-xMinusX_4;
--				lnx_flag<='1';
--				if mathSel=0 then
--					mathRes<=lnx+xMinusX-xMinusX_2-xMinusX_3-xMinusX_4;
--					mathRes_ready<='1';
--				else
--					-- nothing happens
--				end if;
--				countln:=countln+1;
--			elsif countln=4 then
--				lnx_flag<='0';
--				if mathSel=0 then
--					mathRes_ready<='0';
--					mathBusy<='0';
--				else
--					-- nothing happens
--				end if;
--				countln:=0;
--			else
--			-- nothing happens
--			end if;
--			
--			-- power(a,b) - x^y = e^(y * ln(x))
--			-- a=2, b=x, c=y
--			if mathSel=2 and countpow=0 and mathFlag = '1' then
--				countpow:=countpow+1;
--				mathBusy<='1';
--			elsif countpow=1 and lnx_flag='1' then
--				mathRes<=cc*lnx;
--				power_flag<='1';
--				countpow:=countpow+1;
--			elsif countpow=2 then
--				power_flag<='0';
--				countpow:=0;
--			else
--				-- nothing happens
--			end if;
--				
--				
--				
--
--
--			-- exp(b) - 1 + b/1 + b*b/2 + b*b*b/(3*2) + b*b*b*b/(4*3*2)
--			if (mathSel=1 or mathSel=2) and countexp=0 and power_flag = '1' then
--				if mathSel=1 then				
--					mathBusy<='1';
--					expaux:=bb;
--					countexp:=countexp+1;
--				elsif mathSel=2 then
--					countexp:=countexp+1;
--					expaux:=mathRes;
--				else
--					-- nothing happens
--				end if;
--			elsif countexp=1 then
--				-- first iteration
--				inv1:=expaux;
--				inv2:=expaux*to_float(0.5,inv2);
--				inv3:=expaux*to_float(0.166666667,inv3);
--				inv4:=expaux*to_float(0.041666667,inv4);
--				expx<=to_float(1.0,expx);
--				mathRes<=to_float(1.0,expx);
--				countexp:=countexp+1;
--			elsif countexp=2 then
--				-- second iteration
--				inv2:=expaux*inv2;
--				inv3:=expaux*inv3;
--				inv4:=expaux*inv4;
--				countexp:=countexp+1;
--			elsif countexp=3 then
--				-- third iteration
--				inv3:=expaux*inv3;
--				inv4:=expaux*inv4;
--				countexp:=countexp+1;
--			elsif countexp=4 then
--				-- fourth iteration
--				inv4:=expaux*inv4;
--				countexp:=countexp+1;
--			elsif countexp=5 then
--				-- fourth iteration
--				expx<=expx+inv1+inv2+inv3+inv4;
--				expx_flag<='1';
--				mathRes<=mathRes+inv1+inv2+inv3+inv4;
--				mathRes_ready<='1';
--				countexp:=countexp+1;
--			elsif 	countexp=6 then
--				expx_flag<='0';
--				mathRes_ready<='0';
--				mathBusy<='0';
--				countexp:=0;
--			else
--				-- nothing happens
--			end if;
--		end if;
--	else
--		-- nothing happens
--	end if;
--	end process;
--end HH_arch;