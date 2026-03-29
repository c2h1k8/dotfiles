# dotfiles

## WezTerm

macOS / Windows 両対応のターミナルエミュレータ設定。

### 前提条件

- [WezTerm](https://wezfurlong.org/wezterm/installation.html) がインストール済みであること
- フォント [HackGen35 Console NF](https://github.com/yuru7/HackGen/releases) がインストール済みであること
- **Windows のみ**: WSL に Ubuntu がインストール済みであること（`wsl --install` で導入可能）

### セットアップ

#### macOS

```sh
# シンボリックリンクを作成
ln -sf $(pwd)/wezterm/wezterm.lua ~/.wezterm.lua
ln -sf $(pwd)/wezterm/keybinds.lua ~/.config/wezterm/keybinds.lua
```

> `~/.config/wezterm/` が存在しない場合は事前に `mkdir -p ~/.config/wezterm` を実行してください。

#### Windows (PowerShell)

```powershell
# 設定ディレクトリを作成
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\wezterm"

# シンボリックリンクを作成（管理者権限が必要）
New-Item -ItemType SymbolicLink -Force -Path "$env:USERPROFILE\.wezterm.lua" -Target "$(Get-Location)\wezterm\wezterm.lua"
New-Item -ItemType SymbolicLink -Force -Path "$env:USERPROFILE\.config\wezterm\keybinds.lua" -Target "$(Get-Location)\wezterm\keybinds.lua"
```

> WSL のディストリビューション名がデフォルトの `Ubuntu` 以外の場合は、`wezterm.lua` 内の `WSL:Ubuntu` を実際の名前に変更してください（`wsl -l` で確認可能）。

### OS ごとの差異

| 項目 | macOS | Windows |
|---|---|---|
| シェル | `/bin/zsh` | WSL (Ubuntu) |
| 修飾キー | `Cmd` | `Alt` |
| Leader キー | `Cmd + ;` | `Alt + ;` |
| フォントサイズ | 13.0 | 11.0 |
| 透過効果 | macOS Blur | Win32 Acrylic |

### キーバインド一覧

#### 基本操作

| 操作 | macOS | Windows |
|---|---|---|
| コピー | `Cmd + c` | `Alt + c` |
| ペースト | `Cmd + v` | `Alt + v` |
| 検索 | `Cmd + f` | `Alt + f` |
| 設定リロード | `Cmd + r` | `Alt + r` |

#### Leader キー (`Cmd + ;` / `Alt + ;`) の後に入力

| キー | 操作 |
|---|---|
| `c` | 新規タブ |
| `x` | タブを閉じる |
| `n` / `p` | 次 / 前のタブ |
| `d` | 縦分割 |
| `r` | 横分割 |
| `h` / `j` / `k` / `l` | ペイン移動 (左/下/上/右) |
| `H` / `J` / `K` / `L` | ペインサイズ調整 |
| `z` | ペインズーム切替 |
| `q` | ペインを閉じる |
| `[` | コピーモード |
| `Space` | コマンドパレット |

#### コピーモード

| キー | 操作 |
|---|---|
| `h` / `j` / `k` / `l` | カーソル移動 |
| `w` / `b` | 次 / 前のワードへ移動 |
| `Ctrl + d` / `Ctrl + u` | 半ページ下 / 上スクロール |
| `v` | 文字選択 |
| `V` | 行選択 |
| `y` | コピーして終了 |
| `/` | 検索 |
| `q` / `Escape` | コピーモード終了 |
