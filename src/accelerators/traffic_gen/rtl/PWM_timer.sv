/* =====================================================================
 * Copyright (C) 2022 ETH Zurich, University of Modena and Reggio Emilia
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * =====================================================================
 *
 * Project:       GenOv
 *
 * Title:         Timer
 *
 * Description:   Hardware timer design.
 *
 * Date:          16.2.2022
 *
 * Author:        Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
 *
 * ===================================================================== */

module PWM_timer #(
    parameter int unsigned WORD_WIDTH = 32
) (
    input logic clk,
    input logic rstn,
    input logic restart,
    output [WORD_WIDTH-1:0] count
);

    logic [WORD_WIDTH-1:0] c;

    always_ff @(posedge clk, negedge rstn)
    begin
        if (~rstn) begin
            c <= 0;
        end
        else if (restart) begin
            c <= 0;
        end
        else begin
            c <= c + 1;
        end
    end

    assign count = c;

endmodule
