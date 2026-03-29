local wezterm = require "wezterm"
local act = wezterm.action

-- =========================================================
-- keybinds.lua
-- 目的: デフォルトの大量キーバインドを捨てて、Leader中心にする
-- 前提: wezterm.lua 側で
--   config.disable_default_key_bindings = true
--   config.leader = { key=";", mods=mod, timeout_milliseconds=2000 }
--   config.keys = require("keybinds").keys(mod)
--   config.key_tables = require("keybinds").key_tables
-- =========================================================

local function make_keys(mod)
  return {
    -- -----------------------------
    -- 基本操作（OS修飾キーを使用）
    -- -----------------------------
    { key = "c", mods = mod, action = act.CopyTo("Clipboard") },
    { key = "v", mods = mod, action = act.PasteFrom("Clipboard") },
    { key = "f", mods = mod, action = act.Search("CurrentSelectionOrEmptyString") },
    { key = "r", mods = mod, action = act.ReloadConfiguration },

    -- -----------------------------
    -- タブ操作（Leader）
    -- -----------------------------
    { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") }, -- 新規タブ
    { key = "x", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) }, -- タブ閉じる
    { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) }, -- 次タブ
    { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) }, -- 前タブ

    -- -----------------------------
    -- ペイン分割（Leader）
    -- -----------------------------
    { key = "d", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },   -- 縦分割
    { key = "r", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) }, -- 横分割
    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState }, -- ズーム

    -- ペイン移動（vim風）
    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

    -- ペインサイズ調整（Leader + Shift + hjkl）
    { key = "H", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Left", 3 }) },
    { key = "J", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Down", 3 }) },
    { key = "K", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Up", 3 }) },
    { key = "L", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Right", 3 }) },

    -- ペイン閉じる
    { key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

    -- -----------------------------
    -- コピーモード（Leader + [）
    -- -----------------------------
    { key = "[", mods = "LEADER", action = act.ActivateCopyMode },

    -- -----------------------------
    -- コマンドパレット（Leader + Space）
    -- -----------------------------
    { key = "Space", mods = "LEADER", action = act.ActivateCommandPalette },
  }
end

-- copy_mode/search_mode はデフォルト寄りで OK（vimキー追加）
local key_tables = {
  copy_mode = {
    { key = "q", mods = "NONE", action = act.CopyMode("Close") },
    { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },

    -- vim移動
    { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
    { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
    { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
    { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },

    -- ワード移動
    { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
    { key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },

    -- 半ページスクロール
    { key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
    { key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },

    -- 選択
    { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
    { key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },

    -- コピーして終了（y）
    {
      key = "y",
      mods = "NONE",
      action = act.Multiple({
        act.CopyTo("ClipboardAndPrimarySelection"),
        act.CopyMode("Close"),
        act.ScrollToBottom,
      }),
    },

    -- 検索
    { key = "/", mods = "NONE", action = act.Search("CurrentSelectionOrEmptyString") },
  },

  search_mode = {
    { key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
    { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
    { key = "n", mods = "NONE", action = act.CopyMode("NextMatch") },
    { key = "N", mods = "SHIFT", action = act.CopyMode("PriorMatch") },
  },
}

return {
  keys = make_keys,
  key_tables = key_tables,
}
