---
title: 玩Arch遇到的一些问题
date: 2025-05-08
draft: true
categories:
  - 我得
image: 
description:
---
## ArchLinux

### 更改交换分区swap大小

自动安装脚本给我安装的大小只有4G，BYD给我电脑内存用炸了

首先查看自己的交换分区类型 

```shell
sen@SenArch [~] ➜  lsblk                                                                                                  [1:33:03]  
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS  
sda           8:0    0 465.8G  0 disk    
└─sda1        8:1    0 465.8G  0 part    
sdb           8:16   0 931.5G  0 disk    
├─sdb1        8:17   0     1G  0 part /boot  
└─sdb2        8:18   0 930.5G  0 part /home  
                                     /var/cache/pacman/pkg  
                                     /var/log  
                                     /.snapshots  
                                     /  
sdc           8:32   1  58.6G  0 disk    
├─sdc1        8:33   1  1013M  0 part    
└─sdc2        8:34   1   173M  0 part    
zram0       253:0    0    16G  0 disk [SWAP]  
nvme0n1     259:0    0 931.5G  0 disk    
├─nvme0n1p1 259:1    0   100M  0 part    
├─nvme0n1p2 259:2    0    16M  0 part    
├─nvme0n1p3 259:3    0 930.7G  0 part /home/sen/win  
└─nvme0n1p4 259:4    0   705M  0 part    
```

可以看到，我的SWAP分区指向了zram0，
这是因为系统使用了 zram（压缩内存交换设备）

先卸载分区

```shell
swapoff /dev/zram0
```

然后调整分区大小

```shell
sudo zramctl --size 99999999999999999G --algorithm lzo-rle /dev/zram0

#别真填99999999999999999999,改成自己设置的，一般不超过50%实际内存
```

最后格式化+启用

```shell
sudo mkswap /dev/zram0
sudo swapon /dev/zram0
```
## Waydroid

### 脚本推荐

```
 sudo pacman -S lzip
 git clone https://github.com/casualsnek/waydroid_script
 cd waydroid_script
 sudo python3 -m pip install -r requirements.txt
```

无敌了！

```
python -m venv --system-site-packages myenv  # 创建允许访问系统包的虚拟环境
source myenv/bin/activate  # 激活环境
```

如果报错记得用一下虚拟环境，用了虚拟环境就别sudo了

如果注册google环境，记得初始化时加GAPPS

```
 sudo waydroid init -s GAPPS -f
```

### 开启多窗口模式

```
waydroid prop set persist.waydroid.multi_windows true

sudo systemctl restart waydroid-container
```

### 设置宽高

```
waydroid prop set persist.waydroid.width 1000
waydroid prop set persist.waydroid.height 1000
```
记得重启
```
waydroid session stop
waydroid session start
```
### Waydroid 明日方舟闪退问题


<details> 
    <summary>查看引用内容</summary>
引用自


2025-04-13 13:12    

4​

  
04-16 更新：加上了楼下各位推荐的方案和测试结果，感谢大伙的建议  

  
我这两天基本把能尝试的都试了一遍，结果如下：  
  
完全不能用的：

- Genymotion。免费版根本不支持转译 Arm
- Android Emulator (x86_64) 除了 9 和11 以外的任意低版本(即 1~8 加上 10 和 12)。这些 Android 镜像没预装转译层
- Android Emulator (Armv8) 8。Android Logo 转了 30 分钟都没开机完成，放弃

  
打开立刻闪退的：

- Waydroid + [libhoudini_bluestacks](https://github.com/mrvictory1/libhoudini_bluestacks/)
- Waydroid + [waydroid-helper](https://github.com/ayasa520/waydroid-helper) + libhoudini-chromeos

  
播完 Logo / 同意许可协议闪退的：  
这一类是最多的，应该是载入 Unity 引擎时不兼容导致崩溃的。

- Waydroid + [libhoudini / libndk](https://github.com/casualsnek/waydroid_script)，无论打没打 bluearchive 补丁
- Redroid 9~14，预装了 libndk
- Android Emulator (x86_64) 9 和 11

  
播完 Logo 在加载资源页面卡死的：  
从日志里看应该也是引擎崩溃了，和上一类半斤八两。

- Waydroid + libhoudini_bluestacks + bluearchive 补丁
- Waydroid + waydroid-helper + libndk

  
能正常进入游戏，但画面不正常的：

- VMware + Win11 + Mumu。“画面优先”下画面完全错乱，“资源优先”下画面正常但[出现绿色格子](https://mumu.163.com/help/20250410/35048_1226518.html)

  
目前一切正常的：  
a. 基于容器的(理论占用最低，性能最好)：

- Redroid 12 + libhoudini-wsa12.1。测试可用，但 logcat 会猛刷异常，故 CPU 占用异常高，可以通过 stop logd 缓解( [[@63848562]](https://nga.178.com/nuke.php?func=ucp&__inchst=UTF-8&uid=63848562) )

  
b. 基于 Android 虚拟机的(占用较高，性能类似容器)：

- Android Emulator (x86_64) 15。测试可用，但在 NVIDIA 显卡上会有 glitch 和闪退等情况( [[@60543420]](https://nga.178.com/nuke.php?func=ucp&__inchst=UTF-8&uid=60543420) )
- Android Emulator (x86_64) 16。测试可用，但可能会有 WiFi 突然消失导致断网问题( [[@21149675]](https://nga.178.com/nuke.php?func=ucp&__inchst=UTF-8&uid=21149675) )

  
c. 基于 Windows 虚拟机的(占用较高，性能稍差于容器)：

- VMware + Win11 + 雷电。给 VM 分配 4GB 内存不太够，大概 6GB(整个VM)、4GB(雷电模拟器)基本够用。因为我的需求是在 Linux 下跑舟和 MAA，以及 Office，所以基本这个方案能同时 cover 了。MAA 可以直接连接到虚拟机里(adb connect)清日常，清完直接存快照停虚拟机，速度也很快。

  
还有一个终极方案是手机远程 ADB + Scrcpy + 改分辨率，直接在手机上跑![哭笑](https://img4.nga.178.com/ngabbs/post/smile/ac15.png)
</details> 


换了新架构后明日方舟在模拟器会有兼容问题， RIP。

推荐使用Andriod Studio安装Andriod 16 Google api版本。

然后就可以了

## zsh及终端美化

先安装zsh

`sudo pacman -S zsh`

然后安装ohmyzsh

 `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

主题推荐使用haoomz

```shell
sudo wget -O $ZSH_CUSTOM/themes/haoomz.zsh-theme https://cdn.haoyep.com/gh/leegical/Blog_img/zsh/haoomz.zsh-theme
```

记得配置里启用

`nano ~/.zshrc`

```c
ZSH_THEME="haoomz"
```

`source ~/.zshrc`
## 参考文献

[Archlinux+KDE美化记录 \| 彩虹岛](https://mill413.github.io/posts/archlinux%E7%BE%8E%E5%8C%96%E8%AE%B0%E5%BD%95/)

[zsh 安装与配置，使用 oh-my-zsh 美化终端 \| Leehow的小站](https://www.haoyep.com/posts/zsh-config-oh-my-zsh/)

[访客不能直接访问](https://nga.178.com/read.php?tid=43752188&page=3)

