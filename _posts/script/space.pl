use v5.10;
for (split //, "ABCDEFG") { 
    print $_; 
    say if $_ ==  " ";
}

say "blank string" if "";
say "string with one space" if " ";
say "one space equal one space " if " " == " ";
say "one space equal none space " if " " ==  "";
