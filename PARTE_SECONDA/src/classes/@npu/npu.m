classdef npu < pe
    % npu class describes an array of pe plus logic gates related some
    % elementary gates for clock gating purposes .
	% Everything is obtained with nand2 gates,
    % thus the class inherits properties and methods from father class pe
    % which inherits properties and methods from father class nand2. The
    % class describes the circuit in terms of delay,power and area. It
    % starts from technological parameters of HP, LOP and LSTP devices,
    % present in IRDS 2010. The user need to specify the pull-down width
    % Wn, followed by the input parallelism, the bit growth of data and the
    % size of the array. The class models the corresponding npu.vhd
    % component.
   
    properties
        W  {mustBeInteger}; % array size
        orn_gate; % orn object
    end
    
    methods
        % Constructor
        function obj = npu(nMOS_width, n_bit, bit_growth, array_size)
            % Constructor of father class nand2
            obj             = obj@pe(nMOS_width, n_bit, bit_growth);
            obj.W           = array_size;
            obj.orn_gate    = orn(nMOS_width, 3);
        end
        
        % Delay evaluation
        function [Tdp_HP_npu, Tdp_LOP_npu, Tdp_LSTP_npu] = delay(obj)
            [Tdp_HP_pe, Tdp_LOP_pe, Tdp_LSTP_pe] = delay@pe(obj);
            % HP
            Tdp_HP_npu      = Tdp_HP_pe; % [s]
            % LOP
            Tdp_LOP_npu     = Tdp_LOP_pe; % [s]
            % LSTP
            Tdp_LSTP_npu    = Tdp_LSTP_pe; % [s]
		end
		
		% Area evaluation
        function [A_HP_npu, A_LOP_npu, A_LSTP_npu] = area(obj)
            [A_HP_nd2, A_LOP_nd2, A_LSTP_nd2]  = area@nand2(obj);
			[A_HP_pe,  A_LOP_pe,  A_LSTP_pe]   = area@pe(obj);
            [A_HP_orn, A_LOP_orn, A_LSTP_orn]  = obj.orn_gate.area;
            % HP
            A_HP_npu        = (obj.W * obj.W) * ...
                (A_HP_pe + A_HP_nd2 + A_HP_orn); % [um^2]
            % LOP
            A_LOP_npu        = (obj.W * obj.W) * ...
                (A_LOP_pe + A_LOP_nd2 + A_LOP_orn); % [um^2]
            % LSTP
            A_LSTP_npu        = (obj.W * obj.W) * ...
                (A_LSTP_pe + A_LSTP_nd2 + A_LSTP_orn); % [um^2]
		end
        
		
        % Dynamic power evaluation
        function [Pdyn_HP_npu, Pdyn_LOP_npu, Pdyn_LSTP_npu] = power_dyn(obj)
			[Pdyn_HP_nd2, Pdyn_LOP_nd2, Pdyn_LSTP_nd2]  = power_dyn@nand2(obj);
			[Pdyn_HP_pe,  Pdyn_LOP_pe,  Pdyn_LSTP_pe]   = power_dyn@pe(obj);
            [Pdyn_HP_orn, Pdyn_LOP_orn, Pdyn_LSTP_orn]  = obj.orn_gate.power_dyn;
            % HP
            Pdyn_HP_npu        = (obj.W * obj.W) * ...
                (Pdyn_HP_pe + Pdyn_HP_nd2 + Pdyn_HP_orn); % [W]
            % LOP
            Pdyn_LOP_npu        = (obj.W * obj.W) * ...
                (Pdyn_LOP_pe + Pdyn_LOP_nd2 + Pdyn_LOP_orn); % [W]
            % LSTP
            Pdyn_LSTP_npu        = (obj.W * obj.W) * ...
                (Pdyn_LSTP_pe + Pdyn_LSTP_nd2 + Pdyn_LSTP_orn); % [W]
		end
        
        % Static power evaluation
        function [Pstat_HP_npu, Pstat_LOP_npu, Pstat_LSTP_npu] = power_stat(obj)
			[Pstat_HP_nd2, Pstat_LOP_nd2, Pstat_LSTP_nd2]  = power_stat@nand2(obj);
			[Pstat_HP_pe,  Pstat_LOP_pe,  Pstat_LSTP_pe]   = power_stat@pe(obj);
            [Pstat_HP_orn, Pstat_LOP_orn, Pstat_LSTP_orn]  = obj.orn_gate.power_stat;
            % HP
            Pstat_HP_npu        = (obj.W * obj.W) * ...
                (Pstat_HP_pe + Pstat_HP_nd2 + Pstat_HP_orn); % [W]
            % LOP
            Pstat_LOP_npu        = (obj.W * obj.W) * ...
                (Pstat_LOP_pe + Pstat_LOP_nd2 + Pstat_LOP_orn); % [W]
            % LSTP
            Pstat_LSTP_npu        = (obj.W * obj.W) * ...
                (Pstat_LSTP_pe + Pstat_LSTP_nd2 + Pstat_LSTP_orn); % [W]
        end 
    end
end

