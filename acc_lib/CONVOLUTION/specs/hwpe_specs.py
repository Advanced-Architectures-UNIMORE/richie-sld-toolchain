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

        # Overlay version [ hero_offloading , release_0_2 ]
        self.overlay_version    = [ False , True ]

        # Generic
        self.hwpe_target        = 'CONVOLUTION'
        self.design_type        = 'hls'

        # HWPE streaming interfaces [ name , data-type , reg-dim ]
        self.list_sink_stream   = [ [ 'src_V' , 'int32_t' , 32 ] ]
        self.list_source_stream = [ [ 'dst_V' , 'int32_t' , 32 ] ]
        self.n_sink             = len(self.list_sink_stream)
        self.n_source           = len(self.list_source_stream)

        # HWPE standard regfiles
        self.std_reg_num        = 5       

        # HWPE custom regfiles [ name , data-type , reg-dim , isport ]
        self.custom_reg         = [ [ 'width' , 'int32_t' , 32 , 1 ] , 
                                    [ 'height' , 'int32_t' , 32 , 1 ] ,
                                    [ 'filter_coeffs_0' , 'int32_t' , 32 , 1 ] ,
                                    [ 'filter_coeffs_1' , 'int32_t' , 32 , 1 ] ,
                                    [ 'filter_coeffs_2' , 'int32_t' , 32 , 1 ] ,
                                    [ 'filter_coeffs_3' , 'int32_t' , 32 , 1 ] ,
                                    [ 'filter_coeffs_4' , 'int32_t' , 32 , 1 ] ,
                                    [ 'filter_coeffs_5' , 'int32_t' , 32 , 1 ] ,
                                    [ 'filter_coeffs_6' , 'int32_t' , 32 , 1 ] ,
                                    [ 'filter_coeffs_7' , 'int32_t' , 32 , 1 ] ,
                                    [ 'filter_coeffs_8' , 'int32_t' , 32 , 1 ] ,
                                    [ 'filter_coeffs_9' , 'int32_t' , 32 , 1 ] ,
                                    [ 'filter_coeffs_10' , 'int32_t' , 32 , 1 ] ]

        self.custom_reg_num     = len(self.custom_reg)

        # FSM
        self.fsm_trans_size     = [ ['len', 'src_V'] , ['len', 'dst_V'] ]

        # RISC-V firmware stimuli 
        self.input_stimuli      = [ 'arti_stim' , 'arti_stim' ]
        self.output_result      = [ 'res_mmul' ]

