# hacklab
Provides a bleeding edge metasploit-framework community application under docker 
built from a gentoo stage3 distribution. This provides an uptodate exploitation
framework and common debugging/reverse engineering tools for performing vulnerability
analysis. It handles all dependancy and gem building for metasploit-framework giving
you access to the latest exploits during each build.
 
 * metasploit-framework (built from repo)
 * eresi (reversing framework from repo)
 * nmap, curl, wget, dsniff, hydra etc.
 * radare2, gdb, ltrace, strace 

To use the container it will build several components from source code. The container
is built using as small a number of container stages as possible to prevent wasteful
diskspace when building large files.

Todo
====
* add postgres database support yaml for metasploit
* init 0 or containerized postgres install for use
* migrate to alpine linux or a smaller distribution or provide option

Usage
=====
To build the container git clone the repository and run "build.sh" you can
then launch the application using "./run.sh" - metasploit is in the user
home directory. 

Credit
======
This container is provided as-is by Hacker House (https://hacker.house)
