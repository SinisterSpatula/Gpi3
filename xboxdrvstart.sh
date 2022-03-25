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
### Basic Configurations - Standard controller mappings 
basicGPI="/opt/retropie/supplementary/xboxdrv/bin/xboxdrv \
    --evdev $joystick \
    --detach-kernel-driver \
    --silent \
    --force-feedback \
    --deadzone-trigger 15% \
    --deadzone 4000 \
    --mimic-xpad \
    --trigger-as-button \
    --no-extra-events \
    --evdev-absmap ABS_X=x1,ABS_Y=y1,ABS_RX=x2,ABS_RY=y2,ABS_Z=lt,ABS_RZ=rt,ABS_HAT0X=dpad_x,ABS_HAT0Y=dpad_y \
    --evdev-keymap BTN_DPAD_DOWN=dd,BTN_DPAD_UP=du,BTN_DPAD_LEFT=dl,BTN_DPAD_RIGHT=dr \
    --evdev-keymap BTN_SOUTH=a,BTN_EAST=b,BTN_NORTH=x,BTN_WEST=y,BTN_TL=lb,BTN_TR=rb \
    --evdev-keymap BTN_THUMBL=tl,BTN_THUMBR=tr,BTN_MODE=guide,BTN_SELECT=back,BTN_START=start"

### Line unedited due to how the D-pad was mapped to an analog stick for the most retarded of reasons
### Many thanks to gtaforever00 for pointing this out, makes the GPi2 a bit more viable -- Tayle
### --evdev-absmap ABS_X=x1,ABS_Y=y1,ABS_RX=x2,ABS_RY=y2,ABS_Z=lt,ABS_RZ=rt \

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

#Openbor
openbor="--ui-buttonmap x=KEY_F,a=KEY_D,b=KEY_A,Y=KEY_S,lb=KEY_L,rb=KEY_R \
    --ui-buttonmap start=KEY_ENTER,back=KEY_BACKSPACE,back+start=KEY_F10,start+back=KEY_F10"

#gpsp
gpsp="--ui-buttonmap x=KEY_S,a=KEY_Z,b=KEY_X,lb=KEY_A,Y=KEY_A,rb=KEY_S \
    --ui-buttonmap start=KEY_ENTER,back=KEY_BACKSPACE,back+x=KEY_F10,back+start=KEY_ESC,start+back=KEY_ESC"

#pico8
pico8="--ui-buttonmap back+start=KEY_LEFTCTRL+KEY_Q,start+back=KEY_LEFTCTRL+KEY_Q"

#mame4all
mame4all="--ui-buttonmap back+start=KEY_ESC,start+back=KEY_ESC,y+lb=KEY_TAB,y+rb=KEY_ENTER \
          --ui-buttonmap start=KEY_1,back=KEY_5"

#advmame0-94
#Not needed.  You should configure it's controls within it's UI, use start+select as UI Cancel.

#pifba
pifba="--ui-buttonmap back+start=KEY_ESC,start+back=KEY_ESC"

#fbacapcom alternate map for capcom fighting games
fbacapcom="--ui-buttonmap b=KEY_LEFTSHIFT,y=KEY_LEFTCTRL,a=KEY_Z,x=KEY_LEFTALT,lb=KEY_SPACE,rb=KEY_X \
	   --ui-buttonmap start=KEY_ENTER,back=KEY_TAB,back+start=KEY_ESC"

daphne="--ui-buttonmap x=KEY_LEFTSHIFT,a=KEY_LEFTALT,b=KEY_LEFTCTRL \
        --ui-buttonmap start=KEY_1,back=KEY_5,back+start=KEY_ESC"

pcsx="--ui-buttonmap x=KEY_D,a=KEY_X,b=KEY_Z+KEY_ENTER,Y=KEY_S,lb=KEY_W,y+lb=KEY_E,rb=KEY_R,y+rb=KEY_T,start=KEY_V,back=KEY_C, \
    --ui-buttonmap back+x=KEY_ESC,back+start=exec:/opt/retropie/supplementary/xboxdrv/bin/quit.sh,back+lb=KEY_F2,back+rb=KEY_F1"

eduke32="--ui-buttonmap x=KEY_RIGHTCTRL,a=KEY_E,b=KEY_SPACE,y=KEY_LEFTSHIFT,lb=KEY_A,rb=KEY_D,a+lb=KEY_SEMICOLON,a+rb=KEY_APOSTROPHE,lb+rb=KEY_LEFTCTRL,rb+lb=KEY_LEFTCTRL \
    --ui-buttonmap start=KEY_ENTER+KEY_M,back=KEY_ESC,back+start=KEY_F10 \
    --ui-buttonmap du=KEY_UP+KEY_W,du+a=rel:REL_Y:-5:5,a+du=rel:REL_Y:-5:5,dd=KEY_DOWN+KEY_S,dd+a=rel:REL_Y:5:5,a+dd=rel:REL_Y:5:5,dl=KEY_LEFT,dr=KEY_RIGHT \
    --ui-buttonmap start+y=KEY_J,start+b=KEY_N,start+x=KEY_H,start+a=KEY_TAB"
        
minecraft="--ui-buttonmap x=KEY_X:KEY_E:1000,a=KEY_LEFTSHIFT,b=KEY_SPACE,lb=BTN_LEFT,y+lb=rel:REL_WHEEL:1:250,rb=BTN_RIGHT,y+rb=rel:REL_WHEEL:-1:250 \
    --ui-buttonmap back=KEY_ESC,start=KEY_ENTER,back+start=exec:/opt/retropie/supplementary/xboxdrv/bin/quit.sh \
    --ui-buttonmap du=KEY_W,y+du=rel:REL_Y:-2:5,dd=KEY_S,y+dd=rel:REL_Y:2:5,dl=KEY_A,y+dl=rel:REL_X:-2:5,dr=KEY_D,y+dr=rel:REL_X:2:5"

dosbox="--ui-buttonmap x=KEY_LEFTALT,a=KEY_SPACE,b=KEY_LEFTCTRL,lb=BTN_LEFT,y+lb=BTN_LEFT,rb=BTN_RIGHT,y+rb=BTN_RIGHT \
    --ui-buttonmap back=KEY_ESC,back+start=KEY_LEFTCTRL+KEY_F9 \
    --ui-buttonmap du=KEY_UP,y+du=REL_Y:-1:20,dd=KEY_DOWN,y+dd=REL_Y:1:20,dl=KEY_LEFT,y+dl=REL_X:-1:20,dr=KEY_RIGHT,y+dr=REL_X:1:20 \
    --ui-buttonmap y+x=KEY_1,y+a=KEY_ENTER,y+b=KEY_Y"

quake3="--ui-buttonmap x=rel:REL_Y:-9:5,b=rel:REL_Y:9:5,y=rel:REL_X:-12:5,a=rel:REL_X:12:5,lb=KEY_LEFTALT:KEY_C:300,rb=BTN_LEFT \
    --ui-buttonmap start=KEY_ENTER,back=KEY_TAB,lb+rb=KEY_SPACE,back+dl=KEY_LEFT,back+dr=KEY_RIGHT,back+b=KEY_1,back+x=KEY_E \
    --ui-buttonmap back+y=KEY_LEFTBRACE,back+a=KEY_RIGHTBRACE,back+start=KEY_ESC \
    --ui-buttonmap lb+x=rel:REL_Y:-20:5,lb+b=rel:REL_Y:20:5,lb+y=rel:REL_X:-20:5,lb+a=rel:REL_X:20:5 \
    --ui-buttonmap x+lb=rel:REL_Y:-20:5,b+lb=rel:REL_Y:20:5,y+lb=rel:REL_X:-20:5,a+lb=rel:REL_X:20:5 \
    --ui-buttonmap du=KEY_UP,dd=KEY_DOWN,dl=KEY_A,dr=KEY_D"

smw="--ui-buttonmap a=KEY_UP,b=KEY_RIGHTCTRL,x=KEY_SPACE,lb=KEY_LEFTSHIFT,rb=KEY_RIGHTSHIFT,back=KEY_ESC,start=KEY_ENTER"

#
# BRAND NEW BUTTONS LAYOUTS FROM THIS POINT ON
# (I might write a script that lets people change those on the fly, but no promises)
#

# EDuke32 (simplified everything, separate button for the Mighty Boot, view centering, buttons to zoom the map in and out)
eduke32tayle="--ui-buttonmap du=KEY_UP+KEY_W,dd=KEY_DOWN+KEY_S,dl=KEY_LEFT,dr=KEY_RIGHT,lb=KEY_A,rb=KEY_D \
	--ui-buttonmap a=KEY_RIGHTCTRL,y=KEY_E,x=KEY_Q,b=KEY_SPACE,start=KEY_ENTER \
	--ui-buttonmap back+start=KEY_ESC,back+b=KEY_TAB,back+y=KEY_MINUS,back+x=KEY_EQUAL,back+du=KEY_APOSTROPHE,back+dd=KEY_SEMICOLON,back+dl=KEY_LEFTBRACE,back+dr=KEY_RIGHTBRACE,lb+rb=KEY_LEFTCTRL+KEY_KP5,rb+lb=KEY_LEFTCTRL+KEY_KP5,y+du=KEY_HOME,y+dd=KEY_END"

# PCSX-ReARMed (L2 is now Select+L, R2 is now Select+R, Select is now Select+Start to avoid input conflicts)
pcsxtayle="--ui-buttonmap x=KEY_D,a=KEY_X,b=KEY_Z+KEY_ENTER,Y=KEY_S,lb=KEY_W,back+lb=KEY_E,rb=KEY_R,back+rb=KEY_T,start=KEY_V,back+start=KEY_C, \
    --ui-buttonmap back+x=KEY_ESC,start+lb=KEY_F1,start+rb=KEY_F2"

#every map should be using either nograb, passthrough, or a variant of passthrough if swapping buttons around.

#grab is implied unless you use nograb. grab means emulator does not see the physical pad.  nograb means it does.
nograb="--evdev-no-grab"

#Sometimes we want to pass everything straight through.
passthrough="--buttonmap a=a,b=b,x=x,y=y,back=back,start=start,lb=lb,rb=rb \
      --axismap=X1=X1,Y1=Y1"
      
#For games that need D-pad to arrow key's.
dpad="--dpad-as-button \
      --evdev-absmap ABS_X=dpad_x,ABS_Y=dpad_y \
      --ui-buttonmap du=KEY_UP,dd=KEY_DOWN,dl=KEY_LEFT,dr=KEY_RIGHT"

### Kill Command
xboxkill="sudo killall xboxdrv > /dev/null 2>&1"

### Daemonize xboxdrv with background disown, saves 2MB runtime when sudo exits
### NB: don't launch until joy2key.py exits otherwise it conflicts with the launcher menu
### NB: the [] trick is because runcommand also uses pgrep and would match on us
function daemonize {
	sudo -b bash -c "sleep 5 ; while pgrep joy[2]key.py ; do sleep 1 ; done ; $* & disown %1"
}

### Execute the driver with the configuration you need
# $2 is the name of the core
case $2 in

	cannonball)
		$xboxkill
		daemonize $basicGPI $nograb $cannonball
	;;

	scummvm)
		$xboxkill
		daemonize $basicGPI $nograb $scummvm
	;;
	
	sorr)
		$xboxkill
		daemonize $basicGPI $nograb $sorr
	;;
	
	openbor|openbor-6xxx)
		$xboxkill
		daemonize $basicGPI $dpad $openbor
	;;
	
	gpsp)
		$xboxkill
		daemonize $basicGPI $dpad $gpsp
	;;
	quake3)
		$xboxkill
		daemonize $basicGPI $dpad $quake3
	;;
	pico8|splore)
		$xboxkill
		daemonize $basicGPI $nograb $pico8
	;;
	mame4all)
		$xboxkill
		daemonize $basicGPI $nograb $dpad $mame4all
	;;
	daphne)
		$xboxkill
		daemonize $basicGPI $dpad $daphne
	;;
	pcsx-rearmed)
		$xboxkill
		daemonize $basicGPI $dpad $pcsxtayle
	;;
	eduke32)
		$xboxkill
		daemonize $basicGPI $dpad $eduke32tayle
	;;
	minecraft)
		$xboxkill
		daemonize $basicGPI $dpad $minecraft
	;;
	smw)
		$xboxkill
		daemonize $basicGPI $dpad $smw $nograb
	;;
	dosbox)
		case $rom in
			"test1.zip"|"test2.zip"|"test3.zip") # Configuration used only for these ROMs
				$xboxkill
				daemonize $basicGPI $dpad $dosbox
			;;
			*) # Configuration for every other ROMs on this emulator
				$xboxkill
				daemonize $basicGPI $dpad $dosbox
			;;
		esac
	;;
	pifba)
		case $rom in
			"cybots.zip"|"dstlk.zip"|"hsf2.zip"|"hsf2j.zip"|"msh.zip"|"mshvsf.zip"|"mshvsfj.zip"|"mvsc.zip"|"mvscu.zip"|"nwarr.zip"|"sfa2.zip"|"sfa3.zip"|"sfa.zip"|"sfz3jr1.zip"|"sf2ce.zip"|"sf2hf.zip"|"sf2rb.zip"|"sf2.zip"|"sgemf.zip"|"ssf2t.zip"|"ssf2.zip"|"vhunt2.zip"|"vsav2.zip"|"vsav.zip"|"xmvsf.zip"|"xmcota.zip") # Configuration used only for these ROMs
				$xboxkill
				daemonize $basicGPI $dpad $fbacapcom
			;;
			*) # Configuration for every other ROMs on this emulator
				$xboxkill
				daemonize $basicGPI $nograb $pifba
			;;
		esac
	;;
esac
