#!/bin/bash

# Exit on error
set -e


##########################
###                    ###
### write the namelist ###
###                    ###
##########################

cat > ${dir}NAMELIST <<EOF
 &version
  ver="v1.0.2"
 /

 &model
  nxp =   ${nxp:-204}
  nyp =   ${nyp:-204}
  nzp =   ${nzp:-200}
  deltax = ${deltax:-50.}
  deltay = ${deltay:-50.}
  deltaz = ${deltaz:-20.}
  nxpart = ${nxpart:-.true.}
  dzmax  = ${dzmax:-3500.}
  dzrat  = ${dzrat:-1.0}
  dtlong = ${dtlong:-2.}
  distim = ${distim:-100.}
  timmax = ${timmax:-12600.}
  Tspinup = ${Tspinup:-5400.}
  runtype = ${runtype:-'"INITIAL"'}
  level = ${level:-4}
  CCN = ${CCN:-600.e6}
  prndtl = ${prndtl:--0.3333333}
  filprf = ${filprf:-"'emul'"}
  hfilin = ${hfilin:-"'emul.rst'"}
  ssam_intvl = ${ssam_intvl:-120.}
  savg_intvl = ${savg_intvl:-120.}
  mcflg = ${mcflg:-.FALSE.}
  frqhis  = ${frqhis:30000.}
  lbinanl = ${lbinanl:-.false.}
  frqanl = ${frqanl:-5400.}
  corflg = ${corflg:-.false.}
  itsflg = ${itsflg:-1}
  strtim = ${strtim:-180.0}
  sed_aero = ${sed_aero:-.FALSE.}
  sed_cloud = ${sed_cloud:-.TRUE.}
  sed_precp = ${sed_precp:-.TRUE.}
  sed_ice = ${sed_ice:-.FALSE.}
  sed_snow = ${sed_snow:-.FALSE.}
  iradtyp = ${iradtyp:-3}                ! 1 = no radiation, only large-scale forcing, 3 = radiation + large-scale forcing 
  case_name = ${case_name:-"'default'"}            ! Case-specific large-scale forcing: none = not used, 
                                      ! default = simple divergence forcing with specified div 
  div = ${div:-1.5e-6}              ! Divergence for e.g. case_name = 'default'
  sfc_albedo = ${sfc_albedo:-0.05}
  radsounding = ${radsounding:-"'datafiles/kmls.lay'"} 

  isfctyp = ${isfctyp:-2}
  sst = ${sst:-271.35}

!  dthcon = ${dthcon:-20.} ! heat flux
!  drtcon = ${drtcon:-0.}  ! latent

  ubmin  = ${ubmin:--0.25}
  zrough = ${zrough:-0.01}
  th00 = ${th00:-289.}
  umean =  ${umean:-0.1}
  vmean = ${vmean:--0.1}
 /

 &salsa	
   nlcoag = ${nlcoag:-.TRUE.}       ! Master coagulation switch
   nlcgcc = ${nlcgcc:-.TRUE.}       ! Self-collection of cloud droplets
   nlcgpp = ${nlcgpp:-.TRUE.}       ! Self-collection of rain drops
   nlcgpc = ${nlcgpc:-.TRUE.}       ! Rain collection of cloud droplets
   nlcgaa = ${nlcgaa:-.FALSE.}      ! Aerosol coagulation
   nlcgca = ${nlcgca:-.TRUE.}       ! Cloud collection of aerosols
   nlcgpa = ${nlcgpa:-.TRUE.}       ! Rain collection of aerosols
   nlcgia = ${nlcgia:-.TRUE.}       ! Ice collection of aerosols
   nlcgic = ${nlcgic:-.TRUE.}       ! Ice collection of cloud droplets
   nlcgii = ${nlcgii:-.TRUE.}       ! Self-collection of ice
   nlcgip = ${nlcgip:-.TRUE.}       ! Ice collection of rain drops
   nlcgsa = ${nlcgsa:-.TRUE.}       ! Snow collection of aerosols
   nlcgsc = ${nlcgsc:-.TRUE.}       ! Snow collection of cloud droplets
   nlcgsi = ${nlcgsi:-.TRUE.}       ! Snow collection of ice particles
   nlcgsp = ${nlcgsp:-.TRUE.}       ! Snow collection of rain drops
   nlcgss = ${nlcgss:-.TRUE.}       ! Self-collection of snow

   nlcnd       = ${nlcnd:-.TRUE.}  ! Master condensation switch
   nlcndgas    = ${nlcndgas:-.FALSE.}  ! --Aerosol precursor gas codensation
   nlcndh2oae  = ${nlcndh2oae:-.TRUE.}  ! --Condensation of water on aerosols (if FALSE, equilibrium assumed)
   nlcndh2ocl  = ${nlcndh2ocl:-.TRUE.}  ! --Condensation of water on cloud droplets (and drizzle)
   nlcndh2oic  = ${nlcndh2oic:-.TRUE.}  ! --Condensation of water on ice particles
   nlauto      = ${nlauto:-.TRUE.}  ! Master autoconversion switch
   nlautosnow  = ${nlautosnow:-.FALSE.} ! Master snow autoconversion switch
   nlactiv     = ${nlactiv:-.TRUE.}  ! Master cloud activation switch
   nlactbase   = ${nlactbase:-.FALSE.}  ! --Switch for parameterized cloud base activation
   nlactintst  = ${nlactintst:-.TRUE.}  ! --Switch for interstitial activation based on host model Smax

   nlichom     = ${nlichom:-.FALSE.}     ! Switch for homogeneous ice nucleation
   nlichet     = ${nlichet:-.FALSE.}     ! Switch for heterogeneous ice nucleation
   nlicimmers  = ${nlicimmers:-.FALSE.}   ! Switch for ice nucleation by immersion
   nlicmelt    = ${nlicmelt:-.FALSE.}    ! Switch for ice'n' snow melting

   rhlim = ${rhlim:-1.2}          ! RH limit for SALSA during initialization and spinup

   isdtyp = ${isdtyp:-0}
   nspec = ${nspec:-1}
   listspec = ${listspec:-"'SO4','','','','','',''"}            !!!! "'SO4','DU','OC','','','',''"
   volDistA = ${volDistA:-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}   
   volDistB = ${volDistB:-0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}
   nf2a = ${nf2a:-1.0}

   sigmag = ${sigmag:-1.2, 1.7, 2.0, 2.0, 2.0, 2.0, 2.0}  ! Stdev for initial aerosol size distribution for isdtyp == 0 (uniform)  
   dpg    = ${dpg:-0.022, 0.12, 0.2, 0.2, 0.2, 0.2, 0.2}     ! Mode mean diameters in micrometers
   n      = ${n:-0., 46.2502241367474 , 0., 0., 0., 0., 0.}  ! Mode number concentrations in #/cm^3
 /

EOF
 
exit
