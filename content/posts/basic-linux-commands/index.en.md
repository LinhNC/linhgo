---
weight: 1
title: "Basic Linux commands"
date: 2025-06-09T01:57:40+08:00
lastmod: 2025-06-09T01:57:40+08:00
draft: false
authors: ["Linh"]
description: "The basic Linux commands for beginners, including file management, system information, and process control."
featuredImage: "featured-image.webp"

tags: ["Linux","Commands", "System"]
categories: ["system"]
header:
  number:
    enable: false
---

The basic Linux commands for beginners, including file management, system information, and process control.
<!--more-->
Linux is a powerful and versatile operating system widely used in servers, development environments, and cloud systems. Whether you're a beginner or looking to refresh your skills, mastering basic Linux commands is essential for navigating the file system, managing processes, checking system information, and handling networks or files efficiently. This cheat sheet provides a quick reference to commonly used Linux commands, organized by category for easy access.

{{< image src="/sheet.webp" caption="Linux Commands Sheet" src_s="/sheet.webp" src_l="/sheet.webp" >}}
Here's a list of **all the basic Linux commands** from the image you provided, grouped by category:

---

### **FILES & NAVIGATING**

* `ls` – directory listing
* `ls -l` – formatted listing
* `ls -la` – formatted listing including hidden files
* `cd dir` – change directory to dir
* `cd ..` – change to parent directory
* `cd ./dir` – change to dir in parent directory
* `cd ~` – change to home directory
* `pwd` – show current directory
* `mkdir dir` – create a directory
* `rm file` – delete file
* `rm -f dir` – force remove file
* `rm -rf dir` – delete directory dir
* `rm -r dir` – remove directory dir
* `rm -rf /` – launch some nuclear bombs targeting your system
* `cp file1 file2` – copy file1 to file2
* `mv file1 file2` – rename file1 to file2
* `mv file1 dir/file2` – move file1 to dir as file2
* `touch file` – create or update file
* `cat file` – output contents of file
* `cat > file` – write standard input into file
* `cat >> file` – append standard input into file
* `tail -f file` – output contents of file as it grows

---

### **SYSTEM INFO**

* `date` – show current date/time
* `uptime` – show uptime
* `whoami` – who you're logged in as
* `w` – display who is online
* `cat /proc/cpuinfo` – display CPU info
* `cat /proc/meminfo` – memory info
* `free` – show memory and swap usage
* `du` – show directory space usage
* `du -sh` – displays readable sizes in GB
* `df` – show disk usage
* `uname -a` – show kernel config

---

### **NETWORKING**

* `ping host` – ping host
* `whois domain` – get whois for domain
* `dig domain` – get DNS for domain
* `dig -x host` – reverse lookup host
* `wget file` – download file
* `wget -c file` – continue stopped download
* `wget -r url` – recursively download files from URL
* `curl url` – outputs the webpage from URL
* `curl -o meh1.html url` – writes the page to meh1.html
* `ssh user@host` – connect to host as user
* `ssh -p port user@host` – connect to host on port
* `ssh -D user@host` – connect & use bind port

---

### **COMPRESSING**

* `tar cf file.tar files` – tar files into file.tar
* `tar xf file.tar` – untar into current directory
* `tar tf file.tar` – show contents of archive

#### **tar options:**

* `c` – create archive
* `t` – table of contents
* `x` – extract
* `z` – use zip/gzip
* `f` – specify filename
* `j` – bzip2 compression
* `w` – ask for confirmation
* `k` – do not overwrite
* `T` – files from file
* `v` – verbose

---

### **PERMISSIONS**

* `chmod octal file` – change permissions of file

#### **Permission values:**

* `4` – read (r)
* `2` – write (w)
* `1` – execute (x)

#### **Order:**

* `owner/group/world`

#### **Examples:**

* `chmod 777` – rwx for everyone
* `chmod 755` – rw for owner, rx for group/world

---

### **PROCESSES**

* `ps` – display currently active processes
* `ps aux` – detailed outputs
* `kill pid` – kill process with process id (pid)
* `killall proc` – kill all processes named proc

---

### **SOME OTHERS**

* `grep pattern files` – search in files for pattern
* `grep -r pattern dir` – search for pattern recursively in dir
* `locate file` – find all instances of file
* `whereis app` – show possible locations of app
* `man command` – show manual page for command

