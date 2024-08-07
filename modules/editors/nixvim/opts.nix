{

  programs.nixvim = {
     opts = {
        number = true; # Show line numbers
        relativenumber = true; # Show relative line numbers
        shiftwidth = 2;
        tabstop = 2;
        clipboard = "unnamedplus";
     };
  };
}
