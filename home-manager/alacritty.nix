{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 1;
        dynamic_title = true;
        dynamic_padding = true;
        decorations = "full";
        dimensions = {
          lines = 0;
          columns = 0;
        };
        padding = {
          x = 5;
          y = 5;
        };
      };
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      mouse = {
        hide_when_typing = true;
      };
      env = {
        TERM = "xterm-256color";
      };
      font = let fontname = "FiraCode Nerd Font"; 
      in {
        normal = {
          family = fontname;
          style = "Bold";
        };
        bold = {
          family = fontname;
          style = "ExtraBold";
        };
        italic = {
          family = fontname;
          style = "ExtraLight";
        };
        size = 14;
      };

      # Catppuccin Frappe Theme
      colors = {
        primary = {
          background = "#303446";
          foreground = "#c6d0f5";
          dim_foreground = "#838ba7";
          bright_foreground = "#c6d0f5";
        };
        cursor = {
          text = "#303446";
          cursor = "#f2d5cf";
        };
        vi_mode_cursor = {
          text = "#303446";
          cursor = "#babbf1";
        };
        search = {
          matches = {
            foreground = "#303446";
            background = "#a5adce";
          };
          focused_match = {
            foreground = "#303446";
            background = "#a6d189";
          };
        };
        footer_bar = {
          foreground = "#303446";
          background = "#a5adce";
        };
        hints = {
          start = {
            foreground = "#303446";
            background = "#e5c890";
          };
          end = {
            foreground = "#303446";
            background = "#a5adce";
          };
        };
        selection = {
          text = "#303446";
          background = "#f2d5cf";
        };
        normal = {
          black = "#51576d";
          red = "#e78284";
          green = "#a6d189";
          yellow = "#e5c890";
          blue = "#8caaee";
          magenta = "#f4b8e4";
          cyan = "#81c8be";
          white = "#b5bfe2";
        };
        bright = {
          black = "#626880";
          red = "#e78284";
          green = "#a6d189";
          yellow = "#e5c890";
          blue = "#8caaee";
          magenta = "#f4b8e4";
          cyan = "#81c8be";
          white = "#a5adce";
        };
        dim = {
          black = "#51576d";
          red = "#e78284";
          green = "#a6d189";
          yellow = "#e5c890";
          blue = "#8caaee";
          magenta = "#f4b8e4";
          cyan = "#81c8be";
          white = "#b5bfe2";
        };
        indexed_colors = [
          {
            index = 16;
            color = "#ef9f76";
          }
          {
            index = 17;
            color = "#f2d5cf";
          }
        ];
      };
    };
  };
}