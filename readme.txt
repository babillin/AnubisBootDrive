unRAID Server Version 5.0.5 Release Notes
=========================================
See below for Upgrade and Installation instructions.


Known issues in this release
----------------------------
- slack: the time setting "(UTC+10:00) Brisbane" is wrong: Brisbane does not use daylight savings time like (UTC+10:00) Camberra, Melbourne, Sydney.


Changes from 5.0.4 to 5.0.5
---------------------------
- flash: in make_bootable.bat, include 'f' switch to syslinux invokation to handle devices not marked "removeable"
- linux: added all the netfilter options
- slack: added libcurl mistakenly not included in 5.0.4
- slack: upgrade reiserfsprogs from 3.6.21 to 3.6.24
- webGui: fixes in "indexer" Browse page per forum user "nars" (thank you)


Changes from 5.0.3 to 5.0.4
---------------------------
- flash: added make_bootable_mac (thanks to Kyle at Greenleaf, aka, prostuff1)
- flash: upgraded memtest to version 5.01
- linux: added additional netfilter options:
    CONFIG_NETFILTER_XT_MATCH_LIMIT
    CONFIG_NETFILTER_XT_MATCH_OWNER
    CONFIG_NETFILTER_XT_MATCH_TCPMSS
    CONFIG_NETFILTER_XT_TARGET_LOG
    CONFIG_NETFILTER_XT_TARGET_NFLOG
    CONFIG_NETFILTER_XT_TARGET_TCPMSS
- mover: removed -O switch from rsync command, wasn't doing what I thought
- samba: upgrade to 3.6.21-p (patched with share point mtime fix)
- slack: added curl


Changes from 5.0.2 to 5.0.3
---------------------------
- emhttp: avahi smb service name changed from "%h-SMB" to "%h" (%h is your server hostname)
- emhttp: avahi afp service name changed from "%h" to "%h-AFP"; and generate proper time-machine records
- linux: patch mvsas driver to recognize newer AOC-SAS2LP-MV8 cards with PCI ID 1b4b:9485
- linux: update Realtek-supplied r8168 driver to version r8168-8.037.00
- linux: added numerous additional options to netfilter/iptables subsystems per user request
- netatalk: upgrade to version 2.2.5
- slack: added package nss-mdns-0.10 and modified /etc/nsswitch.conf to resolve *.local hostnames
- unraid: permit "md_write_method" to be set via mdcmd


Changes from 5.0.1 to 5.0.2
---------------------------
- slack: upgrade smartmontools from 5.43 to 6.2 per user request


Changes from 5.0 to 5.0.1
-------------------------
- emhttp: fix Active Directory, fix join operation (winbindd wasn't starting)
- emhttp: for Active Directory, fix assiging initial owner/group (only set once)
- emhttp: for "swap disable" where new disk is factory-cleared, skip clearing remaining space beyond replaced disk size
- emhttp: added missing 'started' event, generated at end of array Start sequence
- linux: upgrade kernel to 3.9.11p (patched)
- linux: added iptables support per user request
- linux: changed frequency scaling drivers from "built-in" to "modules", and added a few more drivers
- other: remove extraneous files in /root and /usr/local/sbin
- slack: for Active Directory, change in /etc/rc.d/rc.samba to eliminate 'WARNING: The "idmap backend" option is deprecated'
- slack: for Active Directory, add "winbind use default domain = Yes" to rc.samba when setting up Active Directory
- slack: upgrade smartmontools from 5.40 to 5.43 per user request
- slack: upgrade hdparm from 9.37 to 9.43 per user request
- unraid driver: support 64-bit builds (no impact on 32-bit build)
- unraid driver: initialized superblock should start out marked "clean"
- unraid driver: prevent crash if disk partition(s) doesn't exist upon array Start
- webGui: for Active Directory, user may explictitly enter the AD short domain name
- webGui: add confirmation checkbox to enable array Stop button
- webGui: offer "Parity is already valid" checkbox only if parity disk has been assigned
- webGui: fix "swap disable" not being presented correctly


Upgrade Instructions
====================

If you are currently running any unRAID Server OS release before 5.0:
---------------------------------------------------------------------

- Please refer to upgrade instructions on our wiki:
  http://lime-technology.com/wiki/index.php/Upgrade_Instructions


If you are currently running unRAID Server OS release 5.0.x
-----------------------------------------------------------

- Starting with release 5.0.4, a new script called 'make_bootable_mac' is included in the
  zip file.  In addition, a new directory called 'syslinux' has been created to contain all of the
  syslinux-specific files.
  
  If all you are doing is upgrading from a previous 5.0.x release, you only need to copy 'bzimage',
  'bzroot', and 'readme.txt' from the release zip file to your Flash and then reboot your server - this
  will still work.  You can also copy 'memtest' if you want the new version.
  
  Alternately, you may set up your flash the same as in the zip file.  Probably the easiest way to
  accomplish this is to back up your 'config' directory and then install this release according to
  "Installation on a New Flash Device" below.  Before ejecting your flash, restore the 'config'
  directory from your back up.


Installation on a New Flash Device
==================================

To make a bootable USB Flash device follow these steps:

If using Windows (XP/Vista/Win7)
--------------------------------
1. Plug your USB Flash device into your Windows PC.

2. Open 'My Computer' (XP) or 'Computer' (Vista/Win7) and right-click your Flash device. Click 'Format...',
   set the volume label to UNRAID and then click 'Start'. Important: the volume label must be set exactly
   to UNRAID (all caps).

3. Click on your Flash device (to open it), click on the zip file (to open it) and drag then entire contents of
   the unRAID Server zip file to the Flash.

4. For Windows XP, click on the file 'make_bootable'.  A DOS window will open and run the 'syslinux' utility on the
   Flash.  For Windows Vista or Windows 7, right-click on the file 'make_bootable' and select 'Run as administrator'.
   The 'syslinux' utility will write the Master Boot Record and create a small hidden file named 'ldlinux.sys' on
   the Flash device, making it bootable.

5. Once again, right-click your Flash device in 'My Computer' or 'Computer' and then click 'Eject'.  Your USB Flash
   device is now ready to boot into unRAID Server OS.

If using Mac OS X
-----------------
1. Plug your USB Flash device into your Mac.

2. Open Disk Utility, select the device and click the Erase tab.  Select Format: MS-DOS (FAT) format, Name: UNRAID
   and then click Erase. Important: the Name (volume label) must be set exactly to UNRAID (all caps).

3. Click on your UNRAID device (to open it), click on the downloaded unRAID Server OS release zip file (to open it),
   click on the un-archived unRAID Server folder that results (to open it), and drag then entire contents
   of the unRAID Server folder to the Flash.

4. Click on the file 'make_bootable_mac' on the device.  A termimal window will open and prompt for your admin
   password.  If the selected device is correct, enter the password and hit return.  The script will proceed to run
   the 'syslinux' utility which will write the Master Boot Record and create a small file named 'ldlinux.sys' on
   the Flash device, making it bootable.  Note: you may see your device disappear and reappear on your
   desktop a few times as the script is running - this is normal.

5. When the script completes, close the terminal window and Eject the device.  Your USB Flash device is now ready
   to boot into unRAID Server OS.

