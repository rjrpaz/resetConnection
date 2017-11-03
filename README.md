# resetConnection
Batch script that resets connection for wifi interface in Windows.

Something odd happens on a few embedded equipments with Windows 10.
Wifi interface just stop working. AP was working fine, but interface
just stop sending or receiveng data.

After a few manual tests I could confirm a few facts:

* Host didn't hang.
* Host operating system didn't log anything about this event.
* AP didn't log anything in particular at that moment.
* Windows command from console can't renew IP (ipconfig /release, ipconfig /renew)

I did make it working again when I used command to disable/enable wifi controller. 

I built a batch script that can be run periodically using task manager.
It checks if there is network connectivity. If not, then just restart interface.

Windows "ping.exe" command was not very usefull.
When host is down, it returns exit code different from 0, but
when host is unreachable, it returns 0.
I had to use "fping" tool to detect network connectivity status in
a useful manner for what I intended.

There are some manually defined variables in the batch file:

RUNDIR: folder where script and complementary files are located.
DELAY: time in seconds that waits to enable interface, after disable it.
TESTINGHOST: host used to test connectivity.

The script assumes wifi interface name is "Wi-Fi". This is used internally
with command "netsh". Wifi interface name can be determined running the
following command:

netsh interface show interface

I also built an xml file ("resetConnection.xml") to easily add batch script to task manager.

It is defined to run every 5 minutes. There is an internal reference
for batch script path inside that file, so if you change destination folder
you must modify <Command> entry in xml file.

To add batch file to task manager, start command prompt with
administator permissions and run:

schtasks /create /XML resetConnection.xml /TN "resetConnection"

There's a log file you could check after every run ("resetConnection.log").


References:
https://superuser.com/questions/403905/ping-from-windows-7-get-no-reply-but-sets-errorlevel-to-0
http://forums.whirlpool.net.au/archive/1663110#r28580508
http://www.softpedia.com/get/Network-Tools/IP-Tools/Fping.shtml
https://superuser.com/questions/696270/how-to-turn-on-wifi-via-cmd
https://stackoverflow.com/questions/28855087/how-to-schedule-a-task-for-every-5-minutes-in-windows-command-prompt

