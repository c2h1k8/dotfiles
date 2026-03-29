# dotfiles

## WezTerm

macOS / Windows 両対応のターミナルエミュレータ設定。

### 前提条件

- [WezTerm](https://wezfurlong.org/wezterm/installation.html) がインストール済みであること（nightly 推奨、下記参照）
- フォント [HackGen35 Console NF](https://github.com/yuru7/HackGen/releases) がインストール済みであること
- **Windows のみ**: WSL に Ubuntu がインストール済みであること（`wsl --install` で導入可能）

> **Stable vs Nightly**: 一部の設定（`show_close_tab_button_in_tabs` 等）は nightly 版でのみ有効です。最新の stable（20240203）以降新しい stable リリースが出ていないため、すべての機能を使うには [nightly 版](https://wezfurlong.org/wezterm/installation.html) のインストールを推奨します。stable 版でも該当設定は無視されるだけで動作に支障はありません。

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
| 基本操作キー | `Cmd` | `Ctrl + Shift` |
| Leader キー | `Cmd + ;` | `Alt + ;` |
| フォントサイズ | 13.0 | 11.0 |
| 透過効果 | macOS Blur | Win32 Acrylic |

### キーバインド一覧

#### 基本操作

| 操作 | macOS | Windows |
|---|---|---|
| コピー | `Cmd + c` | `Ctrl + Shift + c` |
| ペースト | `Cmd + v` | `Ctrl + Shift + v` |
| 検索 | `Cmd + f` | `Ctrl + Shift + f` |
| 設定リロード | `Cmd + r` | `Ctrl + Shift + r` |

#### Leader キー (`Cmd + ;` / `Alt + ;`) の後に入力

> Leader キー押下中はステータスバー右側にショートカット一覧が表示されます。

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

---

## Starship

クロスプラットフォーム対応のシェルプロンプト設定。

### 前提条件

- フォント [HackGen35 Console NF](https://github.com/yuru7/HackGen/releases) がインストール済みであること（Nerd Font アイコンで使用）

### インストール

#### macOS

```sh
brew install starship
```

#### Windows (WSL)

WSL の Ubuntu 内で実行:

```sh
curl -sS https://starship.rs/install.sh | sh
```

### セットアップ

#### macOS

```sh
# 設定ディレクトリを作成
mkdir -p ~/.config

# シンボリックリンクを作成
ln -sf $(pwd)/starship/starship.toml ~/.config/starship.toml
```

シェルの初期化ファイル（`~/.zshrc`）に以下を追記:

```sh
eval "$(starship init zsh)"
```

#### Windows (WSL)

WSL の Ubuntu 内で実行:

```sh
# 設定ディレクトリを作成
mkdir -p ~/.config

# シンボリックリンクを作成
# dotfiles を WSL 側に clone している場合
ln -sf $(pwd)/starship/starship.toml ~/.config/starship.toml

# dotfiles が Windows 側にある場合（例: /mnt/c/Users/<ユーザー名>/workspace/dotfiles）
# ln -sf /mnt/c/Users/<ユーザー名>/workspace/dotfiles/starship/starship.toml ~/.config/starship.toml
```

シェルの初期化ファイルに以下を追記:

```sh
# bash (~/.bashrc)
eval "$(starship init bash)"

# zsh (~/.zshrc)
eval "$(starship init zsh)"
```

> **注意**: WSL から Windows 側のファイル（`/mnt/c/...`）へのシンボリックリンクはI/Oが遅くなる場合があります。可能であれば dotfiles を WSL 側のファイルシステム（`~/` 以下）に clone することを推奨します。
