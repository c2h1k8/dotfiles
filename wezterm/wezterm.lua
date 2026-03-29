local wezterm = require("wezterm")
local config = wezterm.config_builder()
local is_windows = wezterm.target_triple:find("windows") ~= nil

config.automatically_reload_config = true

-- OS別のデフォルトシェル
if is_windows then
  config.default_domain = "WSL:Ubuntu"
else
  config.default_prog = { "/bin/zsh", "-l" }
end

-- 作業しやすいフォントサイズ
config.font = wezterm.font("HackGen35 Console NF")
config.font_size = is_windows and 11.0 or 13.0
config.line_height = 1.1
config.cell_width = 1.0

-- IME（日本語入力）を有効化
config.use_ime = true

-- 透過 & ぼかし
config.window_background_opacity = 0.70
if is_windows then
  config.win32_system_backdrop = "Acrylic"
else
  config.macos_window_background_blur = 20
end

-- スクロールバック行数
config.scrollback_lines = 10000

-- カーソル
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

-- ウィンドウの初期サイズ
config.initial_cols = 140
config.initial_rows = 40

-- タイトルバーを消す
config.window_decorations = "RESIZE"

-- タブ設定
config.show_tabs_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- タブバーの透過（fancy tab bar 前提の書き方）
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}

-- 背景色に合わせる（デフォルト黒）
config.window_background_gradient = {
  colors = { "#000000" },
}

-- タブの + ボタンを消す
config.show_new_tab_button_in_tab_bar = false

-- タブの閉じるボタンを消す（nightly限定）
config.show_close_tab_button_in_tabs = false

-- タブ同士の境界線を消す（後でタブ形をカスタムするため）
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}

-- キーバインドは外部ファイルから読み込む
config.disable_default_key_bindings = true
local mod = is_windows and "ALT" or "SUPER"
config.leader = { key = ";", mods = mod, timeout_milliseconds = 2000 }
local keybinds = require("keybinds")
config.keys = keybinds.keys(mod)
config.key_tables = keybinds.key_tables


-- =========================================
-- タブタイトルをPowerline風に装飾
-- =========================================

local function tab_title(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then
    return title
  end
  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = tab_title(tab)

  -- 長すぎるタイトルは丸める
  if #title > 24 then
    title = title:sub(1, 23) .. "…"
  end

  local bg = "#1d2230"
  local fg = "#a0a9cb"
  local active_bg = "#88C0D0"
  local active_fg = "#2E3440"

  local left_sep = ""
  local right_sep = ""

  if tab.is_active then
    return {
      { Background = { Color = "none" } },
      { Foreground = { Color = active_bg } },
      { Text = left_sep },
      { Background = { Color = active_bg } },
      { Foreground = { Color = active_fg } },
      { Text = " " .. title .. " " },
      { Background = { Color = "none" } },
      { Foreground = { Color = active_bg } },
      { Text = right_sep },
    }
  end

  return {
    { Background = { Color = "none" } },
    { Foreground = { Color = bg } },
    { Text = left_sep },
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = " " .. title .. " " },
    { Background = { Color = "none" } },
    { Foreground = { Color = bg } },
    { Text = right_sep },
  }
end)


-- =========================================
-- Leaderヒント表示
-- Leader押下時に右上にショートカット一覧を表示
-- =========================================

wezterm.on("update-right-status", function(window, pane)
  local leader = window:leader_is_active()

  if leader then
    window:set_right_status(wezterm.format({
      { Foreground = { Color = "#88C0D0" } },
      { Text = "  Split[d/r] Move[hjkl] Tab[c/n/p] Zoom[z]  " },
    }))
  else
    window:set_right_status("")
  end
end)

return config
