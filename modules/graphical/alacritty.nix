{
  env = {
    TERM = "xterm-256color";
  };

  window = {
    # Window dimensions in character columns and lines
    # Falls back to size specified by window manager if set to 0x0.
    # (changes require restart)
    dimensions = {
      columns = 80;
      lines = 24;
    };

    padding = {
      x = 0;
      y = 0;
    };

    decorations = "full";
  };

  scrolling = {
    # How many lines of scrollback to keep,
    # "0" will disable scrolling.
    history = 100000;

    # Number of lines the viewport will move for every line
    # scrolled when scrollback is enabled (history > 0).
    multiplier = 3;
  };

  # When true, bold text is drawn using the bright variant of colors.
  draw_bold_text_with_bright_colors = true;

  font = {
    # The normal (roman) font face to use.
    normal = {
      family = "Hack"; # should be "Menlo" or something on macOS.
      # Style can be specified to pick a specific face.
      style = "Regular";
    };

    # The bold font face
    bold = {
      family = "Hack"; # should be "Menlo" or something on macOS.
      # Style can be specified to pick a specific face.
      style = "Bold";
    };

    # The italic font face
    italic = {
      family = "Hack"; # should be "Menlo" or something on macOS.
      # Style can be specified to pick a specific face.
      style = "Italic";
    };

    size = 16.0;

    offset = {
      x = 0;
      y = 0;
    };

    glyph_offset = {
      x = 0;
      y = 0;
    };

    use_thin_strokes = true;
  };

  key_bindings = [
    { key = "V"; mods = "Control|Alt"; action = "Paste"; }
    { key = "C"; mods = "Control|Alt"; action = "Copy"; }
    { key = "Paste"; action = "Paste"; }
    { key = "Copy"; action = "Copy"; }
    { key = "Q"; mods = "Command"; action = "Quit"; }
    { key = "W"; mods = "Command"; action = "Quit"; }
    { key = "Insert"; mods = "Shift"; action = "PasteSelection"; }
    { key = "Key0"; mods = "Control"; action = "ResetFontSize"; }
    { key = "Equals"; mods = "Control"; action = "IncreaseFontSize"; }
    { key = "PageUp"; mods = "Shift"; action = "ScrollPageUp"; }
    { key = "PageDown"; mods = "Shift"; action = "ScrollPageDown"; }
    { key = "Minus"; mods = "Control"; action = "DecreaseFontSize"; }
    { key = "H"; mode = "Vi|~Search"; action = "ScrollToBottom"; }
    { key = "H"; mode = "Vi|~Search"; action = "ToggleViMode"; }
    { key = "I"; mode = "Vi|~Search"; action = "Up"; }
    { key = "K"; mode = "Vi|~Search"; action = "Down"; }
    { key = "J"; mode = "Vi|~Search"; action = "Left"; }
    { key = "L"; mode = "Vi|~Search"; action = "Right"; }
  ];

  # Base16 Burn 256 - alacritty color config
  # Benjamin Bädorf
  colors = {
    # Default colors
    primary = {
      background = "0x1a181a";
      foreground = "0xe3e1e4";
    };

    # Colors the cursor will use if `custom_cursor_colors` is true
    cursor = {
      text = "0x1a181a";
      cursor = "0xe3e1e4";
    };

    # Normal colors
    normal = {
      black = "0x1a181a";
      red = "0xf85e84";
      green = "0x9ecd6f";
      yellow = "0xe5c463";
      blue = "0x7accd7";
      magenta = "0xab9df2";
      cyan = "0xef9062";
      white = "0xe3e1e4";
    };

    # Bright colors
    bright = {
      black = "0x949494";
      red = "0xf85e84";
      green = "0x9ecd6f";
      yellow = "0xe5c463";
      blue = "0x7accd7";
      magenta = "0xab9df2";
      cyan = "0xef9062";
      white = "0xff5f5f";
    };

    indexed_colors = [
      { index = 16; color = "0xdf5923"; }
      { index = 17; color = "0xd70000"; }
      { index = 18; color = "0x2d2a2e"; }
      { index = 19; color = "0x303030"; }
      { index = 20; color = "0xd3d1d4"; }
      { index = 21; color = "0x303030"; }
    ];
  };
}
