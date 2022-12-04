set subsets 0
while {![eof stdin]} {
    set line [gets stdin]
    if {$line eq ""} break

    scan $line "%d-%d,%d-%d" a0 b0 a1 b1

    if {$a0 <= $a1 && $b0 >= $b1 || $a0 >= $a1 && $b0 <= $b1} {
        incr subsets
    }
}

puts $subsets

