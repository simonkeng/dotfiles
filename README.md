# My Dot Files

With some instructions too. 

<img src="rig07062018.png">

## [chunkwm](https://koekeishiya.github.io/chunkwm/) & [skhd](https://github.com/koekeishiya/skhd)

For [reference](http://hde-advent-2017.hatenadiary.jp/entry/2017/12/24/000000).

1. Install with Homebrew:

```bash
brew tap crisidev/homebrew-chunkwm
brew install --HEAD --with-tmp-logging chunkwm
brew install --HEAD --with-logging  koekeishiya/formulae/skhd
```
2. Kickoff at login

```bash
brew services start chunkwm
brew services start skbd
```
3. Clone this repo

```bash
git clone https://github.com/simonkeng/dotfiles.git
```
4. Move `.chunkwmrc` and `.skhdrc` to `~/`.

5. Allow executable `chmod +x ~/.chunkwmrc`

6. Restart machine to start window manager & hotkey daemon
