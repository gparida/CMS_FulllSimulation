#!/bin/bash

echo "Job started..."
echo "Starting job on " $(date)
echo "Running on: $(uname -a)"
echo "System software: $(cat /etc/redhat-release)"
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc7_amd64_gcc700
echo "###################################################"
echo "#    List of Input Arguments: "
echo "###################################################"
echo "Input Arguments (Cluster ID): $1"
echo "Input Arguments (Proc ID): $2"
echo "Input Arguments (Output Dir): $3"
echo "Input Arguments (Gridpack with path): $4"
echo "Input Arguments (maxEvents): $5"
echo "Input Arguments (output file): $6"
echo ""

# Setting up CMSSW versions and configuration files
step1=CMSSW_10_6_25
step1_cfg=HIG-RunIISummer20UL16wmLHEGEN-01655_1_cfg.py
step2=CMSSW_10_6_17_patch1
step2_cfg=HIG-RunIISummer20UL16SIM-01023_1_cfg.py
step3=CMSSW_10_6_17_patch1
step3_cfg=HIG-RunIISummer20UL16DIGIPremix-01018_1_cfg.py
step4=CMSSW_8_0_33_UL
step4_cfg=HIG-RunIISummer20UL16HLT-01023_1_cfg.py
step5=CMSSW_10_6_17_patch1
step5_cfg=HIG-RunIISummer20UL16RECO-01023_1_cfg.py
step6=CMSSW_10_6_25
step6_cfg=HIG-RunIISummer20UL16MiniAODv2-01078_1_cfg.py
step7=CMSSW_13_0_13
step7_cfg=HIG-RunIISummer20UL16NanoAODv9-01056_1_cfg.py

seed=$(($1 + $2))

echo "###################################################"
echo "Running step1..."
export SCRAM_ARCH=slc7_amd64_gcc700
if [ -r ${step1}/src ] ; then
    echo release ${step1} already exists
    echo deleting release ${step1}
    rm -rf ${step1}
    scram p CMSSW ${step1}
else
    scram p CMSSW ${step1}
fi
echo list files inside ${step1}
ls ${step1}
echo "--------"
cd ${step1}/src
eval `scram runtime -sh`
scram b
cd -
cmsRun ${step1_cfg} seedval=${seed} maxEvents=${5} gridpack=${4}
echo "list all files"
ls -ltrh
echo "###################################################"
echo "Running step2..."
export SCRAM_ARCH=slc7_amd64_gcc700
if [ -r ${step2}/src ] ; then
    echo release ${step2} already exists
    echo deleting release ${step2}
    rm -rf ${step2}
    scram p CMSSW ${step2}
else
    scram p CMSSW ${step2}
fi
echo list files inside ${step2}
ls ${step2}
echo "--------"
cd ${step2}/src
eval `scram runtime -sh`
scram b
cd -
cmsRun ${step2_cfg}
echo "list all files"
ls -ltrh
echo "###################################################"
echo "Running step3..."
export SCRAM_ARCH=slc7_amd64_gcc700
if [ -r ${step3}/src ] ; then
    echo release ${step3} already exists
    echo deleting release ${step3}
    rm -rf ${step3}
    scram p CMSSW ${step3}
else
    scram p CMSSW ${step3}
fi
echo list files inside ${step3}
ls ${step3}
echo "--------"
cd ${step3}/src
eval `scram runtime -sh`
scram b
cd -
cmsRun ${step3_cfg}
echo "list all files"
ls -ltrh
echo "###################################################"
echo "Running step4..."
export SCRAM_ARCH=slc7_amd64_gcc530
if [ -r ${step4}/src ] ; then
    echo release ${step4} already exists
    echo deleting release ${step4}
    rm -rf ${step4}
    scram p CMSSW ${step4}
else
    scram p CMSSW ${step4}
fi
echo list files inside ${step4}
ls ${step4}
echo "--------"
cd ${step4}/src
eval `scram runtime -sh`
scram b
cd -
cmsRun ${step4_cfg}
echo "list all files"
ls -ltrh
echo "###################################################"
echo "Running step5..."
export SCRAM_ARCH=slc7_amd64_gcc700
if [ -r ${step5}/src ] ; then
    echo release ${step5} already exists
    echo deleting release ${step5}
    rm -rf ${step5}
    scram p CMSSW ${step5}
else
    scram p CMSSW ${step5}
fi
echo list files inside ${step5}
ls ${step5}
echo "--------"
cd ${step5}/src
eval `scram runtime -sh`
scram b
cd -
cmsRun ${step5_cfg}
echo "list all files"
ls -ltrh
echo "###################################################"
echo "Running step6..."
export SCRAM_ARCH=slc7_amd64_gcc700
if [ -r ${step6}/src ] ; then
    echo release ${step6} already exists
    echo deleting release ${step6}
    rm -rf ${step6}
    scram p CMSSW ${step6}
else
    scram p CMSSW ${step6}
fi
echo list files inside ${step6}
ls ${step6}
echo "--------"
cd ${step6}/src
eval `scram runtime -sh`
scram b
cd -
cmsRun ${step6_cfg}
echo "list all files"
ls -ltrh
echo "###################################################"
echo "Running step7..."
export SCRAM_ARCH=slc7_amd64_gcc11
if [ -r ${step7}/src ] ; then
    echo release ${step7} already exists
    echo deleting release ${step7}
    rm -rf ${step7}
    scram p CMSSW ${step7}
else
    scram p CMSSW ${step7}
fi
echo list files inside ${step7}
ls ${step7}
echo "--------"
pushd ${step7}/src
eval `scram runtime -sh`
git cms-addpkg PhysicsTools/NanoAOD
git cms-addpkg RecoTauTag/RecoTau
git clone https://github.com/cms-data/RecoTauTag-TrainingFiles.git RecoTauTag/TrainingFiles/data
pushd RecoTauTag/TrainingFiles/data/DeepTauId
wget https://github.com/gparida/HeavyMassResonanceHH/raw/main/DeepBoostedTrainingModels/LatestInUse/deepTau_2018v2p7_core.pb
wget https://github.com/gparida/HeavyMassResonanceHH/raw/main/DeepBoostedTrainingModels/LatestInUse/deepTau_2018v2p7_inner.pb
wget https://github.com/gparida/HeavyMassResonanceHH/raw/main/DeepBoostedTrainingModels/LatestInUse/deepTau_2018v2p7_outer.pb
wget https://github.com/gparida/HeavyMassResonanceHH/raw/main/DeepBoostedTrainingModels/LatestInUse/full_model_June8_postBUGfx.pb
popd
git remote add ganesh https://github.com/gparida/cmssw
git fetch ganesh
git checkout -b renanoHHbbtt_13_0_13  ganesh/renanoHHbbtt_13_0_13
mkdir bbtautauAnalysisScripts
pushd bbtautauAnalysisScripts
git init
git remote add -f origin https://github.com/gparida/bbtautauAnalysisScripts.git
git config core.sparseCheckout true
git sparse-checkout init
git sparse-checkout set boostedTauLeadingLeptonIso TauLeadingLeptonIso utilities CRABSubmission
git pull origin master
popd
scram b
popd
cmsRun ${step7_cfg}
echo "list all files"
ls -ltrh

# Copy output nanoAOD file to output directory
echo "Copying output nanoAOD file to output directory"
ls -ltrh
echo "cp -r HIG-RunIISummer20UL17NanoAODv9-03735.root $3/nanoAOD_$1_$2.root"
cp -r $6 $3/nanoAOD_$1_$2.root
echo "Job finished on " $(date)
