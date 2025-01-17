classdef ppu < nand2
    % ppu class describes a sequential circuit capable of performing in a
    % chain the three operation of relu, pooling and rounding. The
    % component is modeled with W relu blocks, W/2 pool blocks, W/2 round
    % blocks, two multiplexers and a single register.
	% Everything is obtained with nand2 gates,
    % thus the class inherits properties and methods nand2. The class
    % describes the circuit in terms of delay,power and area. It starts
    % from technological parameters of HP, LOP and LSTP devices, present in
    % IRDS 2010. The user need to specify the pull-down width Wn, followed
    % by N, BG and W, where (N+BG)*W is the input parallelism and N*W the
    % output one. The class models the corresponding ppu.vhd component.
    
    properties
        N  {mustBeInteger}; % activation bits
        BG {mustBeInteger}; % bit growth
        W  {mustBeInteger}; % npu array dimension
        relu; % relu object
        pool; % pool object
        round; % round object
        reg; % register object
        mux; % mux object
    end
    
    methods
        % Constructor
        function obj = ppu(nMOS_width, n_bit, bit_growth, w_size)
            % Constructor of father class nand2
            obj             = obj@nand2(nMOS_width);
            obj.N           = n_bit;
            obj.BG          = bit_growth;
            obj.W           = w_size;
            obj.relu        = relu(nMOS_width, n_bit, bit_growth);
            obj.pool        = pool(nMOS_width, n_bit);
            obj.round       = round_class(nMOS_width, n_bit+2, n_bit);
            obj.reg         = register(nMOS_width, n_bit*w_size);
            obj.mux         = muxnto1_nbit(nMOS_width, 2, n_bit*w_size);
        end
        
        % Delay evaluation
        function [Tdp_HP_ppu, Tdp_LOP_ppu, Tdp_LSTP_ppu] = delay(obj)
            %[Tdp_HP_nd2, Tdp_LOP_nd2, Tdp_LSTP_nd2]     = delay@nand2(obj);
            [Tdp_HP_relu,       Tdp_LOP_relu,       Tdp_LSTP_relu]      = obj.relu.delay;
            [Tdp_HP_pool,       Tdp_LOP_pool,       Tdp_LSTP_pool]      = obj.pool.delay;
            [Tdp_HP_round,      Tdp_LOP_round,      Tdp_LSTP_round]     = obj.round.delay;
            [Tdp_HP_pool_add1,  Tdp_LOP_pool_add1,  Tdp_LSTP_pool_add1] = obj.pool.add1.delay;
            [Tdp_HP_mux,        Tdp_LOP_mux,        Tdp_LSTP_mux]       = obj.mux.delay;
            [Tdp_HP_reg,        Tdp_LOP_reg,        Tdp_LSTP_reg]       = obj.reg.delay;
            % HP
            Tdp_HP_ppu     = max(max(Tdp_HP_relu + Tdp_HP_pool_add1, ...
                Tdp_HP_relu + Tdp_HP_mux), Tdp_HP_round + 2*Tdp_HP_mux) ...
                + Tdp_HP_reg;% [s]
            % LOP
            Tdp_LOP_ppu     = max(max(Tdp_LOP_relu + Tdp_LOP_pool_add1, ...
                Tdp_LOP_relu + Tdp_LOP_mux), Tdp_LOP_round + 2*Tdp_LOP_mux) ...
                + Tdp_LOP_reg;% [s]
            % LSTP
            Tdp_LSTP_ppu     = max(max(Tdp_LSTP_relu + Tdp_LSTP_pool_add1, ...
                Tdp_LSTP_relu + Tdp_LSTP_mux), Tdp_LSTP_round + 2*Tdp_LSTP_mux) ...
                + Tdp_LSTP_reg;% [s]
		end
		
		% Area evaluation
        function [A_HP_ppu, A_LOP_ppu, A_LSTP_ppu] = area(obj)
			[A_HP_relu,       A_LOP_relu,       A_LSTP_relu]      = obj.relu.area;
            [A_HP_pool,       A_LOP_pool,       A_LSTP_pool]      = obj.pool.area;
            [A_HP_round,      A_LOP_round,      A_LSTP_round]     = obj.round.area;
            [A_HP_mux,        A_LOP_mux,        A_LSTP_mux]       = obj.mux.area;
            [A_HP_reg,        A_LOP_reg,        A_LSTP_reg]       = obj.reg.area;
            % HP
            A_HP_ppu    = (obj.W * A_HP_relu) + ((obj.W/2) * A_HP_pool) + ...
                ((obj.W/2) * A_HP_round) + (2 * A_HP_mux) + A_HP_reg; % [um^2]
            % LOP
            A_LOP_ppu    = (obj.W * A_LOP_relu) + ((obj.W/2) * A_LOP_pool) + ...
                ((obj.W/2) * A_LOP_round) + (2 * A_LOP_mux) + A_LOP_reg; % [um^2]
            % LSTP
            A_LSTP_ppu    = (obj.W * A_LSTP_relu) + ((obj.W/2) * A_LSTP_pool) + ...
                ((obj.W/2) * A_LSTP_round) + (2 * A_LSTP_mux) + A_LSTP_reg; % [um^2]
		end
        
		
        % Dynamic power evaluation
        function [Pdyn_HP_ppu, Pdyn_LOP_ppu, Pdyn_LSTP_ppu] = power_dyn(obj)
			[Pdyn_HP_relu,       Pdyn_LOP_relu,       Pdyn_LSTP_relu]      = obj.relu.power_dyn;
            [Pdyn_HP_pool,       Pdyn_LOP_pool,       Pdyn_LSTP_pool]      = obj.pool.power_dyn;
            [Pdyn_HP_round,      Pdyn_LOP_round,      Pdyn_LSTP_round]     = obj.round.power_dyn;
            [Pdyn_HP_mux,        Pdyn_LOP_mux,        Pdyn_LSTP_mux]       = obj.mux.power_dyn;
            [Pdyn_HP_reg,        Pdyn_LOP_reg,        Pdyn_LSTP_reg]       = obj.reg.power_dyn;
            % HP
            Pdyn_HP_ppu    = (obj.W * Pdyn_HP_relu) + ((obj.W/2) * Pdyn_HP_pool) + ...
                ((obj.W/2) * Pdyn_HP_round) + (2 * Pdyn_HP_mux) + Pdyn_HP_reg; % [W]
            % LOP
            Pdyn_LOP_ppu    = (obj.W * Pdyn_LOP_relu) + ((obj.W/2) * Pdyn_LOP_pool) + ...
                ((obj.W/2) * Pdyn_LOP_round) + (2 * Pdyn_LOP_mux) + Pdyn_LOP_reg; % [W]
            % LSTP
            Pdyn_LSTP_ppu    = (obj.W * Pdyn_LSTP_relu) + ((obj.W/2) * Pdyn_LSTP_pool) + ...
                ((obj.W/2) * Pdyn_LSTP_round) + (2 * Pdyn_LSTP_mux) + Pdyn_LSTP_reg; % [W]
		end
        
        % Static power evaluation
        function [Pstat_HP_ppu, Pstat_LOP_ppu, Pstat_LSTP_ppu] = power_stat(obj)
			[Pstat_HP_relu,       Pstat_LOP_relu,       Pstat_LSTP_relu]      = obj.relu.power_stat;
            [Pstat_HP_pool,       Pstat_LOP_pool,       Pstat_LSTP_pool]      = obj.pool.power_stat;
            [Pstat_HP_round,      Pstat_LOP_round,      Pstat_LSTP_round]     = obj.round.power_stat;
            [Pstat_HP_mux,        Pstat_LOP_mux,        Pstat_LSTP_mux]       = obj.mux.power_stat;
            [Pstat_HP_reg,        Pstat_LOP_reg,        Pstat_LSTP_reg]       = obj.reg.power_stat;
            % HP
            Pstat_HP_ppu    = (obj.W * Pstat_HP_relu) + ((obj.W/2) * Pstat_HP_pool) + ...
                ((obj.W/2) * Pstat_HP_round) + (2 * Pstat_HP_mux) + Pstat_HP_reg; % [W]
            % LOP
            Pstat_LOP_ppu    = (obj.W * Pstat_LOP_relu) + ((obj.W/2) * Pstat_LOP_pool) + ...
                ((obj.W/2) * Pstat_LOP_round) + (2 * Pstat_LOP_mux) + Pstat_LOP_reg; % [W]
            % LSTP
            Pstat_LSTP_ppu    = (obj.W * Pstat_LSTP_relu) + ((obj.W/2) * Pstat_LSTP_pool) + ...
                ((obj.W/2) * Pstat_LSTP_round) + (2 * Pstat_LSTP_mux) + Pstat_LSTP_reg; % [W]
		end
    end
end

