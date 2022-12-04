set overlaps 0
while {![eof stdin]} {
    set line [gets stdin]
    if {$line eq ""} break

    scan $line "%d-%d,%d-%d" a0 b0 a1 b1

    if {$b0 >= $a1 && $b0 <= $b1 || $b1 >= $a0 && $b1 <= $b0} {
       incr overlaps
    }
}

puts $overlaps

