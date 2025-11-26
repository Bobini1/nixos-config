{ pkgs, config, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      window_padding_width = 5;
      font_family = "JetBrainsMono Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = 12;
      disable_ligatures = "never";
      tab_bar_min_tabs = 2;
      tab_bar_edge = "bottom";
      tab_bar_style = "separator";
      tab_separator = "\"\"";
      tab_powerline_style = "slanted";
      tab_title_template = " {index}: {title} ";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";
      confirm_os_window_close = 0;
      cursor_trail = 1;
      shell = "${pkgs.nushell}/bin/nu";
    };
  };
}
