import FWCore.ParameterSet.Config as cms
#Link to datacards:
#https://github.com/cms-sw/genproductions/tree/master/bin/MadGraph5_aMCatNLO/cards/production/2017/13TeV/exo_diboson/
#Edited by Ganesh to change fragment to: https://cms-pdmv-prod.web.cern.ch/mcm/public/restapi/requests/get_fragment/HIG-RunIIFall17wmLHEGS-04773
externalLHEProducer = cms.EDProducer("ExternalLHEProducer",
    args = cms.vstring('/cvmfs/cms.cern.ch/phys_generator/gridpacks/2017/13TeV/madgraph/V5_2.6.0/GluGluToRadionToHH_M3000/v1/GluGluToRadionToHH_M3000_slc6_amd64_gcc481_CMSSW_7_1_30_tarball.tar.xz'),
    nEvents = cms.untracked.uint32(5000),
    numberOfParameters = cms.uint32(1),
    outputFile = cms.string('cmsgrid_final.lhe'),
    scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh')
)



from Configuration.Generator.Pythia8CommonSettings_cfi import *                                                                                                                                             
from Configuration.Generator.MCTunes2017.PythiaCP5Settings_cfi import *                                                                                                                                     
from Configuration.Generator.PSweightsPythia.PythiaPSweightsSettings_cfi import *                                                                                                                           
                                                                                                                                                                                                            
generator = cms.EDFilter("Pythia8ConcurrentHadronizerFilter",                                                                                                                                                         
                         maxEventsToPrint = cms.untracked.int32(1),                                                                                                                                         
                         pythiaPylistVerbosity = cms.untracked.int32(1),                                                                                                                                    
                         filterEfficiency = cms.untracked.double(1.0),                                                                                                                                      
                         pythiaHepMCVerbosity = cms.untracked.bool(False),                                                                                                                                  
                         comEnergy = cms.double(13000.),                                                                                                                                                    
                         PythiaParameters = cms.PSet(                                                                                                                                                       
        pythia8CommonSettingsBlock,                                                                                                                                                                         
        pythia8CP5SettingsBlock,                                                                                                                                                                            
        pythia8PSweightsSettingsBlock,                                                                                                                                                                      
        processParameters = cms.vstring( 
            '24:mMin = 0.05',
            '24:onMode = on',
            '25:m0 = 125.0',
            '25:onMode = off',
            '25:onIfMatch = 5 -5',
            '25:onIfMatch = 24 -24',
            'ResonanceDecayFilter:filter = on',
            'ResonanceDecayFilter:exclusive = on',          #on: require exactly the specified number of daughters
            'ResonanceDecayFilter:eMuTauAsEquivalent = on', #on: treat electrons, muons, and taus as equivalent
            'ResonanceDecayFilter:allNuAsEquivalent = on',  #on: treat all three neutrino flavours as equivalent
            'ResonanceDecayFilter:udscAsEquivalent = on',   #on: treat udsc quarks as equivalent
            'ResonanceDecayFilter:mothers = 24,25',
            'ResonanceDecayFilter:daughters = 5,5,1,1,11,12'
        ),
        parameterSets = cms.vstring('pythia8CommonSettings',                                                                                                                                                
                                    'pythia8CP5Settings',                                                                                                                                                   
                                    'pythia8PSweightsSettings',                                                                                                                                             
                                    'processParameters'                                                                                                                                                     
                                    )                                                                                                                                                                       
        )                                                                                                                                                                                                   
                         )                                                                                                                                                                                  
                                                                                                                                                                                                            
ProductionFilterSequence = cms.Sequence(generator)   