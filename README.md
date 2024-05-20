# Manjaro configuration

I think it's the most comfortable software in the world to use and a must-install

<!-- - #### Change the home directory from Chinese to English -->
<!---->
<!--   ```bash -->
<!--   export LANG=en_US -->
<!--   xdg-user-dirs-gtk-update -->
<!--   export LANG=zh_CH -->
<!--   ``` -->

- #### Install PigchaProxy

  Open [the official website](https://pigpigchacha.github.io/officialsite) to download the Linux version deb installation file

  ```bash
  unzip ~/下载/PigchaClient_deb.zip -d ~/下载/
  # Install dpkg
  sudo pacman -S dpkg
  sudo dpkg -i ~/下载/PigchaClient.deb
  rm -rf ~/下载/
  ```

- #### Replace domestic sources
  pacman is manjaro's library management software, the foreign source is too slow and unstable, switch to the domestic source.
  ```bash
  sudo pacman-mirrors -i -c China -m rank
  ```
  Arrange out the manjaro China open source mirror site and pop up (note the case) of the Tsinghua source I selected
- #### Add an AUR source
  Manjaro is based on Arch, and it is also possible to use Arch's rich and complete source AUR, open the terminal, and enter
  ```bash
  sudo nano /etc/pacman.conf
  ```
  Ctrl + S Save, Ctrl + X Exit  
  Add the following at the end
  ```bash
  [archlinuxcn]
  SigLevel = Optional TrustedOnly
  Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
  ```
- #### Update By AUR

  ```bash
  sudo pacman -Syyu
  ```

- #### Install "archlinuxcn-keyring" Package Import GPG key

  ```bash
  sudo pacman-key --lsign-key "farseerfc@archlinux.org"
  sudo pacman -S archlinuxcn-keyring
  ```

- #### Install yay

  ```bash
  sudo pacman -Sy archlinuxcn-keyring haveged
  sudo systemctl enable haveged
  sudo pacman-key --init
  sudo pacman-key --populate manjaro
  sudo pacman-key --populate archlinux
  sudo pacman-key --populate archlinuxcn
  sudo pacman -S yay
  yay -Syyu && yay -Sys
  ```

- #### Install fcitx5

  delete Fcitx4

  ```bash
  sudo pacman -Rs $(pacman -Qsq fcitx)
  ```

  Install fcitx5

  ```bash
  sudo pacman -S fcitx5 fcitx5-configtool fcitx5-qt fcitx5-gtk fcitx5-chinese-addons fcitx5-material-color fcitx5-lua --noconfirm
  ```

  Configure environment

  ```bash
  sudo chmod 777 /etc/environment
  vi  /etc/environment
  ```

  Add these in

  ```text
  GTK_IM_MODULE DEFAULT=fcitx
  QT_IM_MODULE  DEFAULT=fcitx
  XMODIFIERS    DEFAULT=@im=fcitx
  INPUT_METHOD  DEFAULT=fcitx
  SDL_IM_MODULE DEFAULT=fcitx
  ```

  Note: In the KDE desktop environment, Fcitx5 will be launched automatically  
  Note: We need reboot to generate classicui.conf

- #### Optimize the configuration

  TRM  
  If your manjaro root is installed on an SSD, then it is recommended that you enter the following command, TRM will help clean up the blocks in the SSD, thus extending the life of the SSD:

  ```bash
  sudo systemctl enable fstrim.timer
  ```

- #### Configure SWAP

  After the system is turned on, the memory occupies about 1.7G, and usually the computer with
  8-16G memory can reduce the swap usage, which can improve the performance of the computer.  
  Looking at the swap usage, it is generally 60, which means that there is a 60% probability
  that the memory will be sorted into swap: `cat /proc/sys/vm/swappiness`  
  Change the swap usage policy to 10%, that is, there is a 10% probability that the memory
  will be sorted to swap: `sudo sysctl -w vm.swappiness=10`  
  Modify the configuration file `sudo xed /etc/sysctl.d/99-swappiness.conf`  
  Add the following line at the end of the file:

  ```bash
  vm.swappiness=10
  ```

  After restarting, you can check the value of swappiness, which is 10: `cat /proc/sys/vm/swappiness`  
  For more information about swap resizing, please refer to "ArchWiki About Swap".

- #### Install ohmyzsh

  ```bash
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  sudo pacman -S autojump
  ```

- #### Install p10k

  ```bash
  git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
  ```

- #### Install tmux
  ```bash
  sudo pacman -S tmux --noconfirm
  ```
- #### Install .tmux(oh my tmux)

  ```bash
  cd
  git clone https://github.com/gpakosz/.tmux.git
  ln -s -f .tmux/.tmux.conf
  cp .tmux/.tmux.conf.local .
  ```

- #### Install neofetch

  ```bash
  sudo  pacman -S neofetch --noconfirm
  ```

- #### Install neovim

  ```bash
  sudo pacman -S neovim --noconfirm
  ```

- #### Install tree-sitter-cli

  ```bash
  sudo pacman -S tree-sitter-cli --noconfirm
  ```

- #### Install ripgrep

  ```bash
  sudo pacman -S ripgrep --noconfirm
  ```

- #### Install go DiskUsage

  ```bash
  curl -L https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | tar xz
  chmod +x gdu_linux_amd64
  sudo mv gdu_linux_amd64 /usr/bin/gdu
  ```

- #### Install bottom

  ```bash
  sudo pacman -S bottom --noconfirm
  ```

- #### Install lazygit

  ```bash
  sudo pacman -S lazygit --noconfirm
  ```

- #### Install python

  ```bash
  sudo pacman -Sy python --noconfirm
  ```

- #### Install nodejs
  ```bash
  yay -S nodejs --noconfirm
  # Or query the specified LTS version and install it
  yay nodejs-lts
  ```
- #### Install npm

  ```bash
  yay -S npm --noconfirm
  # Check the node version and npm version
  node --version
  npm --version
  ```

- #### Install Astro

  ```bash
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
  rm -rf ~/.local/state/nvim
  rm -rf ~/.cache/nvim
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
  git clone https://github.com/NichloasChiu/Nvim-config.git ~/.config/nvim/lua/user
  nvim
  ```

- #### Install alacritty

  ```bash
  sudo pacman -S alacritty --noconfirm
  ```

  Manually install references[alacritty-github](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)  
  Configuration references:[alacritty-config](https://github.com/alacritty/alacritty/blob/master/extra/man/alacritty.5.scd)

- #### Install fonts

  ```bash
  sudo pacman -S nerd-fonts-jetbrains-mono --noconfirm
  ```

- #### Install joshuto

  ```bash
  sudo pacman -S joshuto bat --noconfirm
  chmod +x ~/.config/joshuto/preview_file.sh
  ```

- #### Configure zsh/tmux/alacritty/p10k themes/joshuto/ulauncher/

  ```bash
  mkdir -p ~/WorkingDocument/
  git clone https://github.com/NichloasChiu/profile.git ~/WorkingDocument/profile/
  cd ~/WorkingDocument/profile/
  sudo chmod +x OverrideConf.sh
  ./OverrideConf.sh
  ```

- #### Install utools

  ```bash
  yay -S utools --noconfirm
  ```

- #### Install Edge

  ```bash
  sudo pacman -S base-devel --noconfirm
  yay -S microsoft-edge-stable-bin --noconfirm
  ```

- #### Install WPS：

  ```bash
  yay -S ttf-wps-fonts wps-office-mui-zh-cn wps-office-mime-cn wps-office-cn wps-office-fonts ttf-ms-fonts libtiff5 freetype2-wps --noconfirm
  ```

  Use the installed application that comes with the system to download `freetype2-wps` or `yay -S freetype2-wps` to solve the problem of bold garbled characters

- #### Install dbeaver

  ```bash
  yay -S dbeaver --noconfirm
  ```

- #### Install Finereport

  Download the Linux installation script from [the official website](https://www.finereport.com/product/download)

  ```bash
  chmod +x ~/下载/linux_amd64_FineReport-CN.sh
  sh ~/下载/linux_amd64_FineReport-CN.sh
  # Enter the activation code
  19c6d140-79de5fa15-c10b-030409846b1d
  ```

- #### Install lx-music

  ```bash
  yay -S lx-music-desktop-git --noconfirm
  # download https://soso.lanzouj.com/b00p9c94f#8mno
  unzip ~/下载/洛雪音乐助手自定义音源\ v1.1.0\ 下载后请先解压.zip -d ~/.config/lx-music-desktop/
  # configuration lx-music-desktop
  ```

  If the yay source download is very slow, you can go to
  [the official website](https://github.com/lyswhut/lx-music-desktop/releases)
  to download the pacman package. Use the `sudo pacman -U <package_name>` command to install lx

- #### Install VLC

  ```bash
  sudo pacman -S vlc --noconfirm
  ```

- #### Install KVM

  ```bash
  sudo pacman -S --needed virt-manager qemu-desktop libvirt edk2-ovmf dnsmasq iptables-nft
  ```

  For TPM support:

  ```bash
  sudo pacman -S --asdeps swtpm
  ```
  Enable and start service

  ```bash
  sudo systemctl enable libvirtd.service
  sudo systemctl start libvirtd.service
  ```

  Add user to libvirt group to use the system-level virtual machines (qemu:///system)

  ```bash
  sudo usermod -a -G libvirt $USER
  ```

  For details, see KVM Configuration

- #### Install byptop

  ```bash
  sudo pacman -S bpytop --noconfirm
  ```

- #### Install XDM

  [Download XDM](https://xtremedownloadmanager.com/#downloads)

  ```bash
  tar -xf ~/下载/xdm-setup-7.2.11.tar.xz -C ~/下载/
  sudo sh ~/下载/install.sh
  rm  -rf ~/下载/xdm-setup-7.2.11.tar.xz ~/下载/install.sh ~/下载/readme.txt
  ```

## Optimized Manjaro

- #### Uninstall the software

  ```bash
  sudo pacman -Rs manjaro-hello webapp-manager gnome-chess gnome-mines iagno gnome-maps quadrapassel gnome-boxes lollypop htop totem gnome-weather gnome-contacts fragments gedit endeavour
  ```

- #### Beautify Manjaro

  ```bash
  git clone https://github.com/NichloasChiu/Manjaro.git ~/WorkingDocument/Manjaro
  chmod +x ~/WorkingDocument/Manjaro/BeautifyManjaro.sh
  sh ~/WorkingDocument/Manjaro/BeautifyManjaro.sh
  ```

  Open `/etc/profile` and insert `export GTK_THEME=WhiteSur-Light` after `export PATH`, and finally reboot to fix the task manager button ignoring theme issue

- #### Install Gnome shell Extension

  | Ext-name                       | Describe                                                                                                                                        |
  | ------------------------------ | ------------------------------                                                                                                                  |
  | Unblank screen saver           | Used to prevent screen protection programs automatically start and lock the screen                                                              |
  | blur-my-shell                  | The effect of the glass of the glass                                                                                                            |
  | Compiz alike magic lamp effect | Users to minimize the window when the window to minimize and maximize the window, similar to the magic lamp effect in the CompIz desktop effect |
  | Astra Monitor                  | Display CPU, GPU, RAM, DISK                                                                                                                     |
  | Input Method Panel             | Input method panel                                                                                                                              |
  | No overview at start-up        | No overview at start-up                                                                                                                         |
  | Panel corners                  | Window rounded                                                                                                                                  |
  | Coverflow Alt-Tab              | Alt-tab beautify                                                                                                                                |
  | Clipboard Indicator            | Top rotten shear plate                                                                                                                          |


  **win+a** search for `tweaks`, click **Appearance** to select configuration.  
  Or go to `google.com` search for **gnome-look** and download it yourself

  **Installation extensions**

  ```bash
  yay -S chrome-gnome-shell --noconfirm
  ```

  Go to [the official website ](https://extensions.gnome.org/)to download the browser plug-in

## Frequently asked Questions

1. **The disk cannot read the error message "wrong fs type,bad option,bad superblock on"**  
   If you have a hard disk fs problem, you can use `sudo ntfsfix -d /dev/sda1`
   to solve it, please click the webpage for details
2. **LINUX and Windows dual system time synchronization**
   ```bash
   sudo ntpdate time.windows.com
   sudo hwclock --localtime --systohc
   ```

## Optional software

- #### Install tree

  ```bash
  sudo pacman -S tree --noconfirm
  ```

- #### Install screenkey

  ```bash
  sudo pacman -S screenkey --noconfirm
  ```

- #### Install wemeet QQ

  ```bash
  yay -S wemeet linuxqq-appimage --noconfirm
  ```

- #### Install pdfEditor

  ```bash
  yay -S scribus --noconfirm
  sudo pacman -S poppler --noconfirm
  # comand : pdfunite pdf1.pdf pdf2.pdf newname.pdf
  ```

- #### .exe-open

  ```bash
  yay -S playonlinux --noconfirm
  ```

- #### Install Mozilla Thunderbird Mail

  ```bash
  yay -S thunderbird --noconfirm
  ```

- #### Install baidunetdisk

  ```bash
  yay -S baidunetdisk-bin
  ```

- #### Install Remote control software

  remote desktop

  - **teamviewer**
    ```bash
    pamac build teamviewer
    systemctl start teamviewerd
    # Uninstall teamviewer
    pamac remove teamviewer
    ```
  - **sunloginclient**
    ```bash
    yay -S sunloginclient
    sudo systemctl start runsunloginclient.service
    sudo systemctl enable runsunloginclient.service
    ```
  - **remmina**
    ```bash
    yay -S remmina --noconfirm
    ```

- #### Install kettle
  Download or copy the Kettle/JDK 1.8 zip file
  ```bash
  # Install gtk2
  sudo pacman -S gtk2
  cd kettle-path
  # Edit the set-pentaho-env.sh in the kettle directory after extraction, and add it
  JAVA_HOME=/Java 1.8 path/
  sudo chmod +x *.sh
  ./spoon.sh
  ```
- #### Install ventoy

  U disk boot mirror

  ```bash
  yay -S ventoy-bin --noconfirm
  ```

- #### Install stacer/bleachbit

  Disk cleaning: Stacer has more functions, but the disk is not strong for Bleachbit. Bleachbit only uses disk cleaning.

  ```bash
  yay -S stacer bleachbit --noconfirm
  ```

- #### Install google

  ```bash
  sudo pacman -S google-chrome --noconfirm
  ```

- #### Install kate

  text editor

  ```bash
  sudo pacman -S kate --noconfirm
  ```

- #### Install pycharm

  ```bash
  sudo pacman -S pycharm --noconfirm
  ```

- #### Install VSCode

  ```bash
  sudo pacman -S visual-studio-code-bin --noconfirm
  ```

- #### Install gimp

  Image Processing

  ```bash
  sudo pacman -S gimp --noconfirm
  ```

- #### Install pinta

  Drawing

  ```bash
  yay -S pinta --noconfirm
  ```

- #### Install obs-studio

  Professional ecording

  ```bash
  yay -S obs-studio --noconfirm
  ```

- #### Install flameshot

  ```bash
  sudo pacman -S flameshot --noconfirm
  ```

  Next, you need to configure the shortcut keys to start Flameshot when pressing the
  shortcut key. In Manjaro, you can complete the configuration through the following steps:

  - Enter the system settings
  - Open the keyboard settings
  - In the shortcut key option, find screenshot related shortcut key settings
  - Modify the corresponding shortcut keys to start Flameshot
  - Add custom shortcut key, name: `Flameshot` | Command: `flameshot gui`

  After completing the above steps, Flameshot will replace your own screenshot tool to become
  your default screenshot tool. Now you can use Flameshot to take a screenshot

  There is a question that I have tried many times that I can't use it in Wayland. I can only use all about the screen on X11. Fucking

- #### Install gparted

  ```bash
  sudo pacman -S gparted --noconfirm
  ```

- #### Install IDEA

  Installation IntelliJ IDEA Community Edition

  ```bash
  sudo pacman -S intellij-idea-community-edition --noconfirm
  ```

  OR Installation IntelliJ IDEA Ultimate,
  Open [the official website](https://www.jetbrains.com/zh-cn/idea/download/download-thanks.html?platform=linux) download

  ```bash
  tar -zcvf <package-name>
  touch ~/.local/share/applications/intellij-idea.desktop && v ~/.local/share/applications/intellij-idea.desktop
  ```

  Add the following information

  ```text
  [Desktop Entry]
  # The name of the program will also be displayed on the starter.
  Name=IntelliJ IDEA
  # The brief description of the program will also be displayed on the launcher
  Comment=IntelliJ IDEA
  # The executable file path of the program
  Exec=/path/to/idea-IU-231.8770.65/bin/idea.sh
  # The icon path of the program.
  Icon=/path/to/idea-IU-231.8770.65/bin/idea.png
  # It means whether the program is running in the terminal. If you set to True, the program will start in the terminal
  Terminal=false
  # Express the type of .desktop file. This is Application, which indicates an application.
  Type=Application
  # The category of the program is separated by segmentation. For example, the development; IDE indicates that the program is a IDE development tool
  Categories=Development;IDE;
  ```

  Continue to execute commands, empowerment

  ```bash
  chmod 700 ~/.local/share/applications/intellij-idea.desktop
  ```

<!-- - #### Install ulauncher-git (Discard, replace it with Utools) -->
<!---->
<!--   ```bash -->
<!--   yay -S ulauncher-git --noconfirm -->
<!--   # Install translate-shell-git -->
<!--   yay -S translate-shell-git --noconfirm -->
<!--   # Open your ulauncher once -->
<!--   cd $HOME/.local/share/ulauncher/extensions -->
<!--   git clone https://github.com/NastuzziSamy/ulauncher-translate.git -->
<!--   sudo pacman -S fzf fd -->
<!--   git clone https://github.com/hillaryychan/ulauncher-fzf.git -->
<!--   ``` -->
<!---->
<!-- - #### Install xpad (Discard, replace it with Utools) -->
<!---->
<!--   Download or copy the Kettle/JDK 1.8 zip file -->
<!---->
<!--   ```bash -->
<!--   sudo pacman -S xpad --noconfirm -->
<!--   ``` -->

<!-- - #### Install easystroke -->
<!---->
<!--   ```bash -->
<!--   yay -S easystroke --noconfirm -->
<!--   ``` -->

---

> **Author:** NichloasChiu  
> **Date of creation:** 2023-11-02  
> **Contact information:** [Email](mailto:NichloasChiu@outlook.com)

---
