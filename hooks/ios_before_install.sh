#!/bin/bash

########################################################################################
# will copy the nm range slider images to the proper directory
#
# Created January 13th,2015
# @author: Eli
# @version: 1.0
# @copyright: Nerdeez
#######################################################################################

path=`find ../ -name 'Plugins'`
path="$path/"
origin=`find ../ -name 'DefaultTheme'`
cp -r $origin $path
origin=`find ../ -name 'DefaultTheme7'`
cp -r $origin $path
origin=`find ../ -name 'MetalTheme'`
cp -r $origin $path