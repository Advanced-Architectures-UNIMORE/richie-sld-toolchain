########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# HWPE attributes
class hwpe_specs:
    def __init__(self):

        # Engineer(-s)
        self.author             = 'Gianluca Bellocchi'
        self.email              = '<gianluca.bellocchi@unimore.it>'

        # Environment
        self.dest_dir           = 'output'

        # Generic
        self.hwpe_target        = 'MMUL_BASELINE'
        self.design_type        = 'hls'

        # HWPE streaming interfaces [ name , data-type , reg-dim ]
        self.list_sink_stream   = [ [ 'in1' , 'int32_t' , 32 ] , [ 'in2' , 'int32_t' , 32 ] ]
        self.list_source_stream = [ [ 'out_r' , 'int32_t' , 32 ] ]
        self.n_sink             = len(self.list_sink_stream)
        self.n_source           = len(self.list_source_stream)

        # HWPE standard regfiles
        self.std_reg_num        = 5       

        # HWPE custom regfiles [ name , data-type , reg-dim , isport ]
        self.custom_reg         = [ [ 'dumb'  , 'int32_t' , 32 , 0 ] ]
        self.custom_reg_num     = len(self.custom_reg)

        # FSM
        self.fsm_trans_size     = [ ['len', 'in1'] , ['len', 'in2'] , ['len', 'out_r'] ]

        # RISC-V firmware stimuli 
        self.input_stimuli      = [ 'arti_stim' , 'arti_stim' ]
        self.output_result      = [ 'res_mmul' ]
        # self.custom_reg_values  = []

