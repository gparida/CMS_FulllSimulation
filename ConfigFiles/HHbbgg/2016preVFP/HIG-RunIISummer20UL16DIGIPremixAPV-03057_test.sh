#!/bin/bash

export SCRAM_ARCH=slc7_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_6_17_patch1/src ] ; then
  echo release CMSSW_10_6_17_patch1 already exists
else
  scram p CMSSW CMSSW_10_6_17_patch1
fi
cd CMSSW_10_6_17_patch1/src
eval `scram runtime -sh`

cp -r ../../Configuration .
scram b
cd ../..

# Maximum validation duration: 28800s
# Margin for validation duration: 30%
# Validation duration with margin: 28800 * (1 - 0.30) = 20160s
# Time per event for each sequence: 8.0842s
# Threads for each sequence: 4
# Time per event for single thread for each sequence: 4 * 8.0842s = 32.3368s
# Which adds up to 32.3368s per event
# Single core events that fit in validation duration: 20160s / 32.3368s = 623
# Produced events limit in McM is 10000
# According to 1.0000 efficiency, validation should run 10000 / 1.0000 = 10000 events to reach the limit of 10000
# Take the minimum of 623 and 10000, but more than 0 -> 623
# It is estimated that this validation will produce: 623 * 1.0000 = 623 events
EVENTS=623


# cmsDriver command
cmsDriver.py  --python_filename HIG-RunIISummer20UL16DIGIPremixAPV-03057_1_cfg.py --eventcontent PREMIXRAW --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM-DIGI --fileout file:HIG-RunIISummer20UL16DIGIPremixAPV-03057.root --pileup_input "dbs:/Neutrino_E-10_gun/RunIISummer20ULPrePremix-UL16_106X_mcRun2_asymptotic_v13-v1/PREMIX" --conditions 106X_mcRun2_asymptotic_preVFP_v8 --step DIGI,DATAMIX,L1,DIGI2RAW --procModifiers premix_stage2 --geometry DB:Extended --filein file:HIG-RunIISummer20UL16SIMAPV-03078.root --datamix PreMix --era Run2_2016_HIPM --runUnscheduled --no_exec --mc -n $EVENTS || exit $? ;

# End of HIG-RunIISummer20UL16DIGIPremixAPV-03057_test.sh file
