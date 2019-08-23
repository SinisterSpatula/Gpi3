### Place icons in: 

`/home/pi/RetroPie/retropiemenu/icons`

### Edit your: 

`/opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml`

### And add

```
<?xml version="1.0"?>
<gameList>

	<game>
		<path>./gpitools/theme_menu.sh</path>
		<name>GPi Theme Menu</name>
        	<desc>Theme Menu for GPi by bebeidon</desc>
        	<image>./icons/theme_menu.png</image>
	</game>
	<game>
		<path>./gpitools</path>
		<name>GPi-Tools</name>
		<desc>Various tools for GPi</desc>
        	<image>./icons/gpitools.png</image>
	</game>
	<game>
		<path>./gpitools/control_updater_menu.sh</path>
		<name>Control Updater Menu</name>
		<desc>Xboxdrv - Advanced Framework Updater by Adam.</desc>
        	<image>./icons/controllertools.png</image>
	</game>
	<game>
		<path>./gpitools/Kernel_Boot_Logo.sh</path>
		<name>Kernel Boot Logo</name>
        	<desc>Change the Boot Logo before the splashscreen/video, by Adam</desc>
        	<image>./icons/kernelbootlogo.png</image>
	</game>
</gameList>

```
