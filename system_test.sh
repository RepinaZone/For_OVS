#!/bin/bash

####Colors####

#Red thin font#
R='\e[0;31m'
#Red bold font#
R1='\e[1;31m'
# Orange thin font#
O='\e[0;33m'
# Orange bold font#
O1='\e[1;33m'
# Green thin font#
G='\e[0;32m'
# Green bold font#
G1='\e[1;32m'
# Blue thin font#
BL='\e[0;96m'
# Blue bold font#
BL1='\e[1;96m'
# White thin font#
W='\e[0m'
# White bold font#
W1='\e[1;0m'


NA=`echo -e ${R1} " N/A " ${W}`
#echo "$NA"
######Before Testing########

#apt install ipmitool -y 
#dpkg -i hddtemp_0.3-beta15-53_amd64.deb


#### Information about MotherBoard####

MPM=`dmidecode --type baseboard | grep "Product Name" | awk '{print $3}'`
#if [[ $MPM = '' ]] ; then =$NA; fi
MSN=`dmidecode --type baseboard | grep "Serial Number" | awk '{print $3}'`
#if [[ $MSN = '' ]] ; then =$NA; fi
MBV=`dmidecode --type baseboard | grep  "Version" | awk '{print $2}'`
#if [[ $MBV = '' ]] ; then =$NA; fi

###Information about BIOS####
VENB=`dmidecode -t bios | grep "Vendor" | awk -F "Vendor: " '{print $2}'`
#if [[ $VENB = '' ]] ; then VENB=$NA; fi
BVER=`dmidecode -t bios | grep "Version" | awk -F"Version: " '{print $2}'`
#if [[ $BVER = '' ]] ; then BVER=$NA; fi
BREL=`dmidecode -t bios | grep "Release" | awk -F"Release Date: " '{print $2}'`
#if [[ $BREL = '' ]] ; then BREL=$NA; fi

####Information about Chassis #######

CHM=`dmidecode -t chassis | grep "Manufacturer" | awk -F "Manufacturer:  " '{print $2}'`
#if [[ $CHM = '' ]] ; then CHM=$NA; fi
CHT=`dmidecode -t chassis | grep "Type" | awk -F "Type: " '{print $2}'`
#if [[ $CHT = '' ]] ; then CHT=$NA; fi
CHV=`dmidecode -t chassis | grep "Version" | awk -F "Version: " '{print $2}'`
#if [[ $CHV = '' ]] ; then CHV=$NA; fi
CHSN=`dmidecode -t chassis | grep "Serial Number" | awk -F "Serial Number: " '{print $2}'`
#if [[ $CHSN = '' ]] ; then CHSN=$NA; fi

####Information about Processor ######

CPI=`cat /proc/cpuinfo | grep "model name" | awk '{print $4 " " $5 " "$6 " "$7 " " $8 " " $9 " " $10}' | uniq `
CCP=`cat /proc/cpuinfo | grep "model name" | awk '{print $4 " " $5 " "$6 " "$7 " " $8 " " $9 " " $10}' | wc -l`
#CPT=``
POTOK=`echo 'Threads:' $CCP`

####Information about Memory #####
GMEM=`dmidecode -t memory | grep "GB" | grep -e "Size"`
VMEM=`dmidecode -t memory | grep "Manufacturer: " `
MEM=`dmidecode -t 17 | grep -A 18 'Memory Device' | grep -c 'Configured Memory Speed'`
DIMM2=`dmidecode -t 17 |awk '/Device/{i++;print "DIMM "i}/Size/{print $2 " " $3 " " $4}' | grep -iB1 "No Module Installed"`
FREE=` free -h`
####Information about Cache ######
####Information about Cconnector ######
#####Information about Slot ###

#####Information about USB #########

USB=`lsusb | awk '{print $3 " " $4 " " $8 "  :   " $9 " " $10 " "$11 " "$12 " " $13}'`

#####Information about PCI######

PCIE=`lspci | awk '{print $2 "       " $3 "   " $4 "   " $5 "   " $6 " " $7 " " $8 " " $9 " " $10 " " $11 " " $12 " " $13 " " $14}' | uniq`

#####Information about Network#####

NET=`ip -br a | awk '{print $1 "          " $2 "         " $3}'`
SPEED=` lshw -c net | grep "Ether*\|serial\|size"`
######Information about disk######


DISK=`./disk.sh`
NVME=`lsblk | grep "nvme*"`
########SAVE FILE########

SAVE=$( date '+%Y-%m-%d_%H-%M-%S' )
touch "$SAVE"


########### IPMI SENSORS######

IPMI=`ipmitool sdr`

#########PRINT##########
echo -e ${G}"	             SERVER TESTING FROM $SAVE	              " ${W} >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"

echo -e ${BL1}"		--------INFORMATION ABOUT MOTHERBOARD--------" ${W} >> "$SAVE"
echo " " >> "$SAVE"
echo -e "Product Name		:	$MPM" >> "$SAVE"
echo -e "Serial Number 		:	$MSN" >> "$SAVE"
echo -e "Version			:	$MBV" >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"

echo -e ${BL1}"          --------INFORMATION ABOUT BIOS--------" ${W} >> "$SAVE"
echo " " >> "$SAVE"
echo -e "Vendor			:	$VEBN" >> "$SAVE"
echo -e "Version			:	$BVER" >> "$SAVE"
echo -e "Release			:	$BREL" >> "$SAVE"
echo " " >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"

echo -e ${BL1} "         --------INFORMATION ABOUT CHASSIS--------" ${W} >> "$SAVE"
echo " " >> "$SAVE"
echo -e "Manufacturer		:	$CHM" >> "$SAVE"
echo -e "Type			:	$CHT" >> "$SAVE"
echo -e "Version			:	$CHV" >> "$SAVE"
echo -e "Serial Nimber		:	$CHSN" >> "$SAVE"
echo " " >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"

echo -e ${BL1}"          --------INFORMATION ABOUT PROCESSOR--------" ${W} >> "$SAVE"
echo " " >> "$SAVE"
echo -e "Model			:	$CPI" >> "$SAVE"
echo -e "Threads			:	$CCP" >> "$SAVE"
echo  " " >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"

echo -e ${BL1}"          --------INFORMATION ABOUT MEMORY--------" ${W} >> "$SAVE"
echo " " >> "$SAVE"
echo -e "Manufacturer		:	$VMEM" >> "$SAVE"
echo -e "Size			:	$GMEM" >> "$SAVE"
echo -e "Installed Modules	:	$MEM" >> "$SAVE"
echo -e "Uninstaaled 		:	$DIMM2" >> "$SAVE"
echo -e "Memory usage		: 	$FREE" >>"$SAVE"
echo " " >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"

echo -e ${BL1} "         --------INFORMATION ABOUT USB--------" ${W} >> "$SAVE"
echo " " >> "$SAVE"
echo -e "USB DEVICES		:\n$USB" >> "$SAVE"
echo " " >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"

echo -e ${BL1} "         --------INFORMATION ABOUT PCI--------" ${W} >> "$SAVE"
echo " " >> "$SAVE"
echo -e "PCIe Devices		:\n$PCIE" >> "$SAVE"
echo " " >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"

echo -e ${BL1}"          --------INFORMATION ABOUT NETWORK--------" ${W} >> "$SAVE"
echo " " >> "$SAVE"
echo -e "Network Devices 	:\n $NET" >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"
echo -e "Speed 			:\n $SPEED" >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"


echo -e ${BL1} "         --------INFORMATION ABOUT DISKS--------" ${W} >> "$SAVE"
echo " " >> "$SAVE"
echo -e "Disks          	:\n $DISK" >> "$SAVE"
echo -e "NVME			:\n $NVME " >>"$NVME"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"

echo -e ${BL1}"          --------INFORMATION ABOUT IPMI SENSORS--------" ${W} >> "$SAVE"
echo " " >> "$SAVE"
echo -e " $IPMI" >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"
echo  " "  >> "$SAVE"
cat "$SAVE"
