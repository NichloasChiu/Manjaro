# Manjaro configuration

- #### Replace domestic sources
  pacman is manjaro's library management software, the foreign source is too slow and unstable, switch to the domestic source.
  ```shell
  sudo pacman-mirrors -i -c China -m rank
  ```
  Arrange out the manjaro China open source mirror site and pop up (note the case) of the Tsinghua source I selected
- #### Add an AUR source
  Manjaro is based on Arch, and it is also possible to use Arch's rich and complete source AUR, open the terminal, and enter
  ```shell
  sudo nano /etc/pacman.conf
  ```
  Ctrl + S Save, Ctrl + X Exit  
  Add the following at the end
  ```shell
  [archlinuxcn]
  SigLevel = Optional TrustedOnly
  Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
  ```
- #### Update By AUR

  ```shell
  sudo pacman -Syyu
  ```

- #### Install "archlinuxcn-keyring" Package Import GPG key

  ```shell
  sudo pacman-key --lsign-key "farseerfc@archlinux.org"
  sudo pacman -S archlinuxcn-keyring
  ```

- #### Install yay

  ```shell
  sudo pacman -Sy archlinuxcn-keyring haveged
  sudo systemctl enable haveged
  sudo pacman-key --init
  sudo pacman-key --populate manjaro
  sudo pacman-key --populate archlinux
  sudo pacman-key --populate archlinuxcn
  sudo pacman -S yay
  yay -Syyu && yay -Sys
  ```

- #### Install the input method

  delete Fcitx4

  ```shell
  sudo pacman -Rs $(pacman -Qsq fcitx)
  ```

  Install fcitx5

  ```shell
  sudo pacman -S fcitx5
  sudo pacman -S fcitx5-configtool
  sudo pacman -S fcitx5-qt
  sudo pacman -S fcitx5-gtk
  sudo pacman -S fcitx5-chinese-addons
  sudo pacman -S fcitx5-material-color
  sudo pacman -S kcm-fcitx5
  sudo pacman -S fcitx5-lua
  ```

- #### Configure 'environment'

  ```shell
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

  ```shell
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

  ```shell
  vm.swappiness=10
  ```

  After restarting, you can check the value of swappiness, which is 10: `cat /proc/sys/vm/swappiness`  
  For more information about swap resizing, please refer to "ArchWiki About Swap".

- #### Install PigchaProxy

  Open [the official website](https://pigpigchacha.github.io/officialsite) to download the Linux version deb installation file

  ```shell
  unzip ~/下载/PigchaClient_deb.zip -d ~/下载/
  # Install dpkg
  sudo pacman -S dpkg
  sudo dpkg -i ~/下载/PigchaClient.deb
  rm -rf ~/下载/
  ```

- #### Install ohmyzsh

  ```shell
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  sudo pacman -S autojump
  ```

- #### Install p10k

  ```shell
  git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
  ```

- #### Install tmux
  ```shell
  sudo pacman -S tmux
  ```
- #### Install .tmux(oh my tmux)

  ```shell
  cd
  git clone https://github.com/gpakosz/.tmux.git
  ln -s -f .tmux/.tmux.conf
  cp .tmux/.tmux.conf.local .
  ```

- #### Install neofetch

  ```shell
  sudo  pacman -S neofetch
  ```

- #### Install tree

  ```shell
  sudo pacman -S tree
  ```

- #### Install neovim

  ```shell
  sudo pacman -S neovim
  ```

- #### Install tree-sitter-cli

  ```shell
  sudo pacman -S tree-sitter-cli
  ```

- #### Install ripgrep

  ```shell
  sudo pacman -S ripgrep
  ```

- #### Install go DiskUsage

  ```shell
  curl -L https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | tar xz
  chmod +x gdu_linux_amd64
  sudo mv gdu_linux_amd64 /usr/bin/gdu
  ```

- #### Install bottom

  ```shell
  sudo pacman -S bottom
  ```

- #### Install lazygit

  ```shell
  sudo pacman -S lazygit
  ```

- #### Install python

  ```shell
  sudo pacman -Sy python
  ```

- #### Install nodejs
  ```shell
  yay -S nodejs
  # 或者查询指定lts版后安装
  yay nodejs-lts
  ```
- #### Install npm

  ```shell
  yay -S npm
  # 查看node版本与npm版本
  node --version
  npm --version
  ```

- #### Install Astro

  ```shell
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
  rm -rf ~/.local/state/nvim
  rm -rf ~/.cache/nvim
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
  git clone https://github.com/NichloasChiu/AstroNvim-config.git ~/.config/nvim/lua/user
  nvim
  ```

<!-- - #### Install screenkey -->
<!---->
<!--   ```shell -->
<!--   sudo pacman -S screenkey -->
<!--   ``` -->

- #### Install alacritty

  ```shell
  sudo pacman -S alacritty
  ```

  Manually install references[alacritty-github](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)  
  Configuration references:[alacritty-config](https://github.com/alacritty/alacritty/blob/master/extra/man/alacritty.5.scd)

- #### Install fonts

  ```shell
  sudo pacman -S nerd-fonts-jetbrains-mono
  ```

- #### Install ulauncher-git

  ```shell
  yay -S ulauncher-git
  # Install translate-shell-git
  yay -S translate-shell-git
  # Open your ulauncher once
  cd $HOME/.local/share/ulauncher/extensions
  git clone https://github.com/NastuzziSamy/ulauncher-translate.git
  sudo pacman -S fzf fd
  git clone https://github.com/hillaryychan/ulauncher-fzf.git
  ```

- #### Install joshuto

  ```shell
  sudo pacman -S joshuto bat
  chmod +x ~/.config/joshuto/preview_file.sh
  ```

- #### Configure zsh/tmux/alacritty/p10k themes/joshuto/ulauncher/

  ```shell
  mkdir -p ~/WorkingDocument/
  git clone https://github.com/NichloasChiu/profile.git ~/WorkingDocument/profile/
  cd ~/WorkingDocument/profile/
  sudo chmod +x OverrideConf.sh
  ./OverrideConf.sh
  ```

- #### Install Edge
  ```shell
  sudo pacman -S base-devel
  yay -S microsoft-edge-stable-bin
  ```
- #### Install WPS：

  ```shell
  yay -S ttf-wps-fonts wps-office-mui-zh-cn wps-office-mime-cn wps-office-cn
  yay -S wps-office-fonts ttf-ms-fonts
  ```

  Use the installed application that comes with the system to download `freetype2-wps` or `yay -S freetype2-wps` to solve the problem of bold garbled characters

- #### Install wemeet(腾讯会议)

  ```shell
  yay -S wemeet
  ```

- #### Install dbeaver

  ```shell
  yay -S dbeaver
  ```

- #### Install lx-music

  ```shell
  yay -S lx-music-desktop-git
  # download https://soso.lanzouj.com/b00p9c94f#8mno
  unzip ~/下载/洛雪音乐助手自定义音源\ v1.1.0\ 下载后请先解压.zip -d ~/.config/lx-music-desktop/
  # configuration lx-music-desktop
  ```

---

# Optimized Manjaro

### Uninstall the software

```shell
sudo pacman -Rs firefox manjaro-hello thunderbird webapp-manager gnome-chess gnome-mines iagno gnome-maps quadrapassel gnome-boxes
```

### Beautify Manjaro

```shell
git clone https://github.com/NichloasChiu/Manjaro.git ~/WorkingDocument/Manjaro
chmod +x ~/WorkingDocument/Manjaro/BeautifyManjaro.sh
sh ~/WorkingDocument/Manjaro/BeautifyManjaro.sh
```

**win+a** search for `tweaks`, click **Appearance** to select configuration.  
Or go to `google.com` search for **gnome-look** and download it yourself
