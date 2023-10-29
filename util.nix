{ lib, ... }:
with lib; {
  toUpperFirst = with strings; s: with builtins; toUpper (substring 0 1 s);
  toLowerRest = with strings; s: with builtins; toLower (substring 1 (-1) s);
  capitalize = with strings; word: (toUpperFirst word) + (toLowerRest word);
}
