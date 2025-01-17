classdef nandn < nand2
   % nandn class describes a NAND gate with generic fan-in, realized as
   % balanced binary tree of nand2 gates, thus the class inherits
   % properties and methods from father class nand2. The class describes
   % the circuit in terms of delay,power and area. It starts from
   % technological parameters of HP, LOP and LSTP devices, present in IRDS
   % 2010. The user need to specify the pull-down width Wn followed by the
   % fan-in.
    
    % User defined
    properties
        N {mustBeInteger}; % fan-in
    end
    
    methods
        % Constructor
        function obj = nandn(nMOS_width,fan_in)
            % Constructor of father class nand2
            obj     = obj@nand2(nMOS_width);
            obj.N   = fan_in;
        end
        
        % Delay evaluation
        function [Tdp_HP_ndn, Tdp_LOP_ndn, Tdp_LSTP_ndn] = delay(obj)
            [Tdp_HP_nd2, Tdp_LOP_nd2, Tdp_LSTP_nd2] = delay@nand2(obj);
            % HP
            Tdp_HP_ndn      = ceil(log2(obj.N)) * Tdp_HP_nd2; % [s]
            % LOP
            Tdp_LOP_ndn     = ceil(log2(obj.N)) * Tdp_LOP_nd2; % [s]
            % LSTP
            Tdp_LSTP_ndn    = ceil(log2(obj.N)) * Tdp_LSTP_nd2; % [s]
        end
        
        % Area evaluation
        function [A_HP_ndn, A_LOP_ndn, A_LSTP_ndn] = area(obj)
            [A_HP_nd2, A_LOP_nd2, A_LSTP_nd2] = area@nand2(obj);
            % HP
            A_HP_ndn = (obj.N - 1) * A_HP_nd2; % [um^2]
            % LOP
            A_LOP_ndn = (obj.N - 1) * A_LOP_nd2; % [um^2]
            % LSTP
            A_LSTP_ndn = (obj.N - 1) * A_LSTP_nd2; % [um^2]
        end
        
        % Dynamic power evaluation
        function [Pdyn_HP_ndn, Pdyn_LOP_ndn, Pdyn_LSTP_ndn] = power_dyn(obj)
            [Pdyn_HP_nd2, Pdyn_LOP_nd2, Pdyn_LSTP_nd2] = power_dyn@nand2(obj);
            % HP
            Pdyn_HP_ndn     = (obj.N - 1) * Pdyn_HP_nd2; % [W]
            % LOP
            Pdyn_LOP_ndn    = (obj.N - 1) * Pdyn_LOP_nd2; % [W]
            % LSTP
            Pdyn_LSTP_ndn   = (obj.N - 1) * Pdyn_LSTP_nd2; % [W]
        end
        
        % Static power evaluation
        function [Pstat_HP_ndn, Pstat_LOP_ndn, Pstat_LSTP_ndn] = power_stat(obj)
            [Pstat_HP_nd2, Pstat_LOP_nd2, Pstat_LSTP_nd2] = power_stat@nand2(obj);
            % HP
            Pstat_HP_ndn    = (obj.N - 1) * Pstat_HP_nd2; % [W]
            % LOP
            Pstat_LOP_ndn   = (obj.N - 1) * Pstat_LOP_nd2; % [W]
            % LSTP
            Pstat_LSTP_ndn  = (obj.N - 1) * Pstat_LSTP_nd2; % [W]
        end
        
    end
end

