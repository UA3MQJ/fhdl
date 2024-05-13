include string.fs
include ~/fmix/forth-packages/f/0.2.4/compat-gforth.4th


variable arg-param1
variable arg-param1-size
variable arg-param2
variable arg-param2-size

create hdl-module-name 255 allot

: get_param1 arg-param1 @ arg-param1-size @ ;
: get_param2 arg-param2 @ arg-param2-size @ ;

0 Value fd-out


: fopen ( c-addr u – wfileid ) w/o create-file throw ;

: fwrite fd-out write-file throw ;
: fwriteln fd-out write-line throw ;

: fclose 
    dup
    flush-file throw
    close-file throw
;


: read_args
    next-arg drop drop \ drop -e
    next-arg arg-param1-size ! arg-param1 !
    next-arg arg-param2-size ! arg-param2 !
;

: hdl-module
    parse-name hdl-module-name $!
;

: end-hdl-module
;

: fhdl ( -- )
    read_args

    s" Generate Verilog HDL file" type cr
    s" Input  file: " type get_param1 type cr
    s" Output file: " type get_param2 type cr



    get_param1 included

    get_param2 fopen to fd-out

    s" module " fwrite

    s" " hdl-module-name $@ s+ fwriteln

    s" endmodule" fwriteln

    fd-out fclose

;

fhdl cr bye

