{ lib, pkgs, ... }:

let
  assign = app: types: lib.genAttrs types (_: app);

  spreadsheetTypes = [
    "application/vnd.oasis.opendocument.spreadsheet" # .ods
    "application/vnd.oasis.opendocument.spreadsheet-template" # .ots
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" # .xlsx
    "application/vnd.ms-excel" # .xls
    "application/vnd.ms-excel.sheet.macroEnabled.12" # .xlsm
    "text/csv"
    "text/tab-separated-values"
  ];

  textTypes = [
    "text/plain"
    "text/markdown"
    "text/x-shellscript"
    "text/x-python"
    "text/x-csrc"
    "application/json"
    "application/x-yaml"
    "application/toml"
    "application/x-nix"
  ];
in
{
  # System-level mime applications options in NixOS
  xdg.mime.defaultApplications =
    assign "libreoffice-calc.desktop" spreadsheetTypes
    // assign "google-chrome.desktop" [ "application/pdf" ]
    // assign "nvim-kitty.desktop" textTypes;
}
