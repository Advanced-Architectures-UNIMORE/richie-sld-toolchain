#!/bin/sh
lli=${LLVMINTERP-lli}
exec $lli \
    /home/gbellocchi/workspace_pulp/genacc/genacc/acc_lib/traffic_gen/hls/proj_traffic_gen/solution1/.autopilot/db/a.g.bc ${1+"$@"}
