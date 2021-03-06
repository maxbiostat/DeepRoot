#### .:Scripts for a simulation study used in [Bielejec et al. (2014)](http://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-15-133):

**DEPENDENCIES**
- compiled BEAST jar with PIBUSS core and parsers enabled.

**USAGE**

There are two scripts. One is set up for a desktop type of workstation, second will run on a PBS/TORQUE cluster.
Adjust the simulation settings and paths and simply do:

> ./run_deep_root

or reserve your time on the cluster and do:

> ./run_deep_root.pbs

There is also an R script for analysis the output.

**LICENSE**

  "THE BEER-WARE LICENSE" (Revision 42):
  <filip.bielejec(sorry_spybots)rega.kuleuve.be> wrote this software. As long as you retain this notice you
  can do whatever you want with this stuff. If we meet some day, and you think
  this stuff is worth it, you can buy me a beer in return. Filip Bielejec
