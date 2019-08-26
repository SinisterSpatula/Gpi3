#!/bin/sh
## Uncomment one or all of the following if you need to find some information about the emulator or roms
## Name of the emulator
echo "1 is "$1 >> /dev/shm/runcommand.log

## Name of the software used for running the emulation
echo "2 is "$2 >> /dev/shm/runcommand.log

## Name of the rom
echo "3 is "$3 >> /dev/shm/runcommand.log

##Executed command line
#echo $4 >> /dev/shm/runcommand.log

## Find the Retroflag Joystick name
joystick=`find /dev/input/by-id/ -name "*event-joystick*"`
echo "Detected joystick as: "$joystick >> /dev/shm/runcommand.log



### The FUN begins
#Get ROM name striping full path
rom="${3##*/}"

echo "rom is "$rom >> /dev/shm/runcommand.log


### This no longer has dpad as button, use $dpad to add it as needed.
### Basic Configuraions - Standard controller mappings 
basicGPI="sudo /opt/retropie/supplementary/xboxdrv/bin/xboxdrv \
    --evdev $joystick \
    --detach-kernel-driver \
    --silent \
    --force-feedback \
    --deadzone-trigger 15% \
    --deadzone 4000 \
    --mimic-xpad \
    --trigger-as-button \
    --no-extra-events \
    --evdev-absmap ABS_X=x1,ABS_Y=y1,ABS_RX=x2,ABS_RY=y2,ABS_Z=lt,ABS_RZ=rt \
    --evdev-keymap BTN_SOUTH=a,BTN_EAST=b,BTN_NORTH=x,BTN_WEST=y,BTN_TL=lb,BTN_TR=rb \
    --evdev-keymap BTN_THUMBL=tl,BTN_THUMBR=tr,BTN_MODE=guide,BTN_SELECT=back,BTN_START=start \
    --evdev-keymap BTN_TRIGGER_HAPPY3=du,BTN_TRIGGER_HAPPY4=dd,BTN_TRIGGER_HAPPY1=dl,BTN_TRIGGER_HAPPY2=dr \
    --evdev-absmap ABS_X=dpad_x,ABS_Y=dpad_y \
    --evdev-absmap ABS_HAT0X=dpad_x,ABS_HAT0Y=dpad_y"


### Extended Configurations
### Specific emulator configuration or any other parameters you will need only for some emulators

#Outrun Engine - select+start=quit.
cannonball="--ui-buttonmap back+start=KEY_ESC,start+back=KEY_ESC"

#Scummvm Standalone - select+start=quit, select+LB=Load State, select+RB=Save State.
#Select send N for No.  Start sends Enter. Select+X=Keyboard "7"
scummvm="--ui-buttonmap start=KEY_ENTER,back=KEY_N,back+start=KEY_LEFTCTRL+KEY_Q,back+lb=KEY_LEFTCTRL+KEY_0 \
	--ui-buttonmap back+rb=KEY_LEFTALT+KEY_0,back+x=KEY_7,start+back=KEY_LEFTCTRL+KEY_Q"

#Streets of Rage remake
sorr="--ui-buttonmap back+start=KEY_ESC,start+back=KEY_ESC"

#Openbor 3400
openbor="--ui-buttonmap back+start=KEY_F10,start+back=KEY_F10,back=void,start=void \
	--ui-buttonmap a=void,b=void,x=void,y=void,lb=void,rb=void"

#gpsp 
gpsp="--ui-buttonmap back+x=KEY_F10,back+start=KEY_ESC,start+back=KEY_ESC"

#pico8
pico8="--ui-buttonmap back+start=KEY_LEFTCTRL+KEY_Q,start+back=KEY_LEFTCTRL+KEY_Q"

#mame4all
mame4all="--ui-buttonmap back+start=KEY_ESC,start+back=KEY_ESC,y+lb=KEY_TAB,y+rb=KEY_ENTER"

# Tayle's Orbbotron config (quake3)
# Basics: D-pad for movement, face buttons for freelook. More specifically, X looks up,
# B looks down, Y looks left, A looks right. Oh, also the right shoulder button (RB) is
# mapped to the left mouse button, which means it can be used for the menus, and it shoots,
# too. On top of that, Select shows the scoreboard, Start uses the inventory item, while pressing
# both Select and Start brings up the pause menu.
# - LB - strafe / faster turning / (hold for longer) crouch
# - LB then RB - jump
# - SELECT then Y - previous weapon
# - SELECT then A - next weapon
# - SELECT then B - swap to the gauntlet
# - SELECT then X - custom bind (attached to the E key)
# - SELECT then LEFT - left key (for going through the configs)
# - SELECT then RIGHT - right key (for going through the configs)

quake3="--ui-buttonmap x=rel:REL_Y:-2:5,b=rel:REL_Y:2:5,y=rel:REL_X:-3:5,a=rel:REL_X:3:5,lb=KEY_LEFTALT:KEY_C:300,rb=BTN_LEFT \
    --ui-buttonmap start=KEY_ENTER,back=KEY_TAB,lb+rb=KEY_SPACE,back+dl=KEY_LEFT,back+dr=KEY_RIGHT,back+b=KEY_1,back+x=KEY_E \
    --ui-buttonmap back+y=KEY_LEFTBRACE,back+a=KEY_RIGHTBRACE,lb+x=rel:REL_Y:-4:5,lb+b=rel:REL_Y:4:5,lb+y=rel:REL_X:-6:5 \
    --ui-buttonmap lb+a=rel:REL_X:6:5,back+start=KEY_ESC,du=KEY_UP,dd=KEY_DOWN,dl=KEY_LEFT,dr=KEY_RIGHT"


fourway="--four-way-restrictor"
invert="--ui-buttonmap du=KEY_DOWN,dd=KEY_UP"
dpad="--dpad-as-button"
nograb="--evdev-no-grab"

### Kill Command
xboxkill="sudo killall xboxdrv > /dev/null 2>&1"

### Execute the driver with the configuration you need
# $2 is the name of the core
case $2 in

	cannonball)
		$xboxkill
		joycommand="$basicGPI $nograb $cannonball &"
		eval $joycommand
	;;

	scummvm)
		$xboxkill
		joycommand="$basicGPI $nograb $scummvm &"
		eval $joycommand
	;;
	
	sorr)
		$xboxkill
		joycommand="$basicGPI $nograb $sorr &"
		eval $joycommand
	;;
	
	openbor|openbor-6xxx)
		$xboxkill
		joycommand="$basicGPI $nograb $openbor &"
		eval $joycommand
	;;
	
	gpsp)
		$xboxkill
		joycommand="$basicGPI $nograb $gpsp &"
		eval $joycommand
	;;
	quake3)
		$xboxkill
		joycommand="$basicGPI $dpad $quake3 &"
		eval $joycommand
	;;
	pico8|splore)
		$xboxkill
		joycommand="$basicGPI $nograb $pico8 &"
		eval $joycommand
	;;
	mame4all)
		$xboxkill
		joycommand="$basicGPI $nograb $mame4all &"
		eval $joycommand
	;;
esac
