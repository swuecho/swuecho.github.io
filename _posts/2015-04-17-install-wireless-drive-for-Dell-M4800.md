---
layout: post
title:  Install Wireless Driver for Dell M4800
 
date:   2015-04-17 20:31 
categories: tech 
---
spend a lot of time to do it, finally get it right.

the most important thing I miss is the driver depend on linux kernel, so that means if you upgrade your kernel to a newer version than the offical ubuntu release. you may want to downgrade your kernel.

### check the kernel version (Ubuntu 14.04)

{% highlight bash %}

uname -a

Linux IS 3.16.0-34-generic #47~14.04.1-Ubuntu SMP Fri Apr 10 17:49:16 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

```

### then install driver 

{% highlight bash %}

sudo apt-get install bcmwl-kernel-source

```

## show all the pci information

{% highlight bash %}
lspci -nnk

00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor DRAM Controller [8086:0c04] (rev 06)
	Subsystem: Dell Device [1028:05cc]
00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor PCI Express x16 Controller [8086:0c01] (rev 06)
	Kernel driver in use: pcieport
00:02.0 VGA compatible controller [0300]: Intel Corporation 4th Gen Core Processor Integrated Graphics Controller [8086:0416] (rev 06)
	Subsystem: Dell Device [1028:05cc]
	Kernel driver in use: i915
00:03.0 Audio device [0403]: Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor HD Audio Controller [8086:0c0c] (rev 06)
	Subsystem: Dell Device [1028:05cc]
	Kernel driver in use: snd_hda_intel
00:14.0 USB controller [0c03]: Intel Corporation 8 Series/C220 Series Chipset Family USB xHCI [8086:8c31] (rev 04)
	Subsystem: Dell Device [1028:05cc]
	Kernel driver in use: xhci_hcd
00:16.0 Communication controller [0780]: Intel Corporation 8 Series/C220 Series Chipset Family MEI Controller #1 [8086:8c3a] (rev 04)
	Subsystem: Dell Device [1028:05cc]
	Kernel driver in use: mei_me
00:19.0 Ethernet controller [0200]: Intel Corporation Ethernet Connection I217-LM [8086:153a] (rev 04)
	Subsystem: Dell Device [1028:05cc]
	Kernel driver in use: e1000e
00:1a.0 USB controller [0c03]: Intel Corporation 8 Series/C220 Series Chipset Family USB EHCI #2 [8086:8c2d] (rev 04)
	Subsystem: Dell Device [1028:05cc]
	Kernel driver in use: ehci-pci
00:1b.0 Audio device [0403]: Intel Corporation 8 Series/C220 Series Chipset High Definition Audio Controller [8086:8c20] (rev 04)
	Subsystem: Dell Device [1028:05cc]
	Kernel driver in use: snd_hda_intel
00:1c.0 PCI bridge [0604]: Intel Corporation 8 Series/C220 Series Chipset Family PCI Express Root Port #1 [8086:8c10] (rev d4)
	Kernel driver in use: pcieport
00:1c.2 PCI bridge [0604]: Intel Corporation 8 Series/C220 Series Chipset Family PCI Express Root Port #3 [8086:8c14] (rev d4)
	Kernel driver in use: pcieport
00:1c.3 PCI bridge [0604]: Intel Corporation 8 Series/C220 Series Chipset Family PCI Express Root Port #4 [8086:8c16] (rev d4)
	Kernel driver in use: pcieport
00:1c.4 PCI bridge [0604]: Intel Corporation 8 Series/C220 Series Chipset Family PCI Express Root Port #5 [8086:8c18] (rev d4)
	Kernel driver in use: pcieport
00:1c.6 PCI bridge [0604]: Intel Corporation 8 Series/C220 Series Chipset Family PCI Express Root Port #7 [8086:8c1c] (rev d4)
	Kernel driver in use: pcieport
00:1c.7 PCI bridge [0604]: Intel Corporation 8 Series/C220 Series Chipset Family PCI Express Root Port #8 [8086:8c1e] (rev d4)
	Kernel driver in use: pcieport
00:1d.0 USB controller [0c03]: Intel Corporation 8 Series/C220 Series Chipset Family USB EHCI #1 [8086:8c26] (rev 04)
	Subsystem: Dell Device [1028:05cc]
	Kernel driver in use: ehci-pci
00:1f.0 ISA bridge [0601]: Intel Corporation QM87 Express LPC Controller [8086:8c4f] (rev 04)
	Subsystem: Dell Device [1028:05cc]
	Kernel driver in use: lpc_ich
00:1f.2 RAID bus controller [0104]: Intel Corporation 82801 Mobile SATA Controller [RAID mode] [8086:282a] (rev 04)
	Subsystem: Dell Device [1028:05cc]
	Kernel driver in use: ahci
00:1f.3 SMBus [0c05]: Intel Corporation 8 Series/C220 Series Chipset Family SMBus Controller [8086:8c22] (rev 04)
	Subsystem: Dell Device [1028:05cc]
01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Venus XT [Radeon HD 8870M] [1002:6821]
	Subsystem: Dell FirePro M5100 [1028:05cc]
	Kernel driver in use: radeon
01:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde/Pitcairn HDMI Audio [Radeon HD 7700/7800 Series] [1002:aab0]
	Subsystem: Dell Device [1028:aab0]
	Kernel driver in use: snd_hda_intel
03:00.0 Network controller [0280]: Broadcom Corporation BCM4352 802.11ac Wireless Network Adapter [14e4:43b1] (rev 03)
	Subsystem: Dell Device [1028:0017]
	Kernel driver in use: wl
11:00.0 SD Host controller [0805]: O2 Micro, Inc. SD/MMC Card Reader Controller [1217:8520] (rev 01)
	Subsystem: Dell Device [1028:05cc]
	Kernel driver in use: sdhci-pci

```
