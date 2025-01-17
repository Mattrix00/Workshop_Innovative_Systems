classdef cnt < flip_flop
	% cnt class describes a synchronous counter with enable signal and
	% asynchronous reset realized with several d-ff in toggle ff
	% configuration, everything is obtained with nand2 gates,
    % thus the class inherits properties and methods from father class
    % flip_flop which inherits properties and methods from father class
    % nand2. The class describes the circuit in terms of delay,power and
    % area. It starts from technological parameters of HP, LOP and LSTP
    % devices, present in IRDS 2010. The user need to specify the pull-down
    % width Wn, followed by  the parallelism of data.
	
	properties
		bit_width {mustBeInteger}; % parallelism
	end
	
	methods
		% Constructor
        function obj = cnt(nMOS_width, n_bit)
            % Constructor of father class flip_flop
            obj             = obj@flip_flop(nMOS_width);
            obj.bit_width   = n_bit;
		end
		
		% Delay evaluation
        function [Tdp_HP_cnt, Tdp_LOP_cnt, Tdp_LSTP_cnt] = delay(obj)
			[Tdp_HP_nd2, Tdp_LOP_nd2, Tdp_LSTP_nd2] = delay@nand2(obj);
            [Tdp_HP_ff, Tdp_LOP_ff, Tdp_LSTP_ff] = delay@flip_flop(obj);
            % HP
            Tdp_HP_cnt      = (2 * obj.bit_width + 1) * Tdp_HP_nd2 + Tdp_HP_ff; % [s]
            % LOP
            Tdp_LOP_cnt     = (2 * obj.bit_width + 1) * Tdp_LOP_nd2 + Tdp_LOP_ff; % [s]
            % LSTP
            Tdp_LSTP_cnt    = (2 * obj.bit_width + 1) * Tdp_LSTP_nd2 + Tdp_LSTP_ff; % [s]
		end
		
		% Area evaluation
        function [A_HP_cnt, A_LOP_cnt, A_LSTP_cnt] = area(obj)
			[A_HP_nd2, A_LOP_nd2, A_LSTP_nd2] = area@nand2(obj);
            [A_HP_ff, A_LOP_ff, A_LSTP_ff] = area@flip_flop(obj);
            % HP
            A_HP_cnt    = ((6 * obj.bit_width - 2) * A_HP_nd2) ...
				+ (obj.bit_width * A_HP_ff); % [um^2]
            % LOP
            A_LOP_cnt   = ((6 * obj.bit_width - 2) * A_LOP_nd2) ...
				+ (obj.bit_width * A_LOP_ff); % [um^2]
            % LSTP
            A_LSTP_cnt  = ((6 * obj.bit_width - 2) * A_LSTP_nd2) ...
				+ (obj.bit_width * A_LSTP_ff); % [um^2]
		end
        
		
        % Dynamic power evaluation
        function [Pdyn_HP_cnt, Pdyn_LOP_cnt, Pdyn_LSTP_cnt] = power_dyn(obj)
			[Pdyn_HP_nd2, Pdyn_LOP_nd2, Pdyn_LSTP_nd2] = power_dyn@nand2(obj);
            [Pdyn_HP_ff, Pdyn_LOP_ff, Pdyn_LSTP_ff] = power_dyn@flip_flop(obj);
            % HP
            Pdyn_HP_cnt     = ((6 * obj.bit_width - 2) * Pdyn_HP_nd2) ...
				+ (obj.bit_width * Pdyn_HP_ff); % [um^2]
            % LOP
            Pdyn_LOP_cnt    = ((6 * obj.bit_width - 2) * Pdyn_LOP_nd2) ...
				+ (obj.bit_width * Pdyn_LOP_ff); % [um^2]
            % LSTP
            Pdyn_LSTP_cnt   = ((6 * obj.bit_width - 2) * Pdyn_LSTP_nd2) ...
				+ (obj.bit_width * Pdyn_LSTP_ff); % [um^2]
        end
        
        % Static power evaluation
        function [Pstat_HP_cnt, Pstat_LOP_cnt, Pstat_LSTP_cnt] = power_stat(obj)
			[Pstat_HP_nd2, Pstat_LOP_nd2, Pstat_LSTP_nd2] = power_stat@nand2(obj);
            [Pstat_HP_ff, Pstat_LOP_ff, Pstat_LSTP_ff] = power_stat@flip_flop(obj);
            % HP
            Pstat_HP_cnt    = ((6 * obj.bit_width - 2) * Pstat_HP_nd2) ...
				+ (obj.bit_width * Pstat_HP_ff); % [um^2]
            % LOP
            Pstat_LOP_cnt   = ((6 * obj.bit_width - 2) * Pstat_LOP_nd2) ...
				+ (obj.bit_width * Pstat_LOP_ff); % [um^2]
            % LSTP
            Pstat_LSTP_cnt  = ((6 * obj.bit_width - 2) * Pstat_LSTP_nd2) ...
				+ (obj.bit_width * Pstat_LSTP_ff); % [um^2]
        end
		
	end
end

