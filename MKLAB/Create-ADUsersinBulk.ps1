List$ = 1..5 | Foreach-object {
    $First = invoke-generate "[person both first]"
    $Last = invoke-generate "[person both last]"
    $SAM = -join (($First.Substring(0,1)),($Last))

    $nameinfo = [PSCustomObject]@{
        First = $first
        Last = $Last
        SAMAcct = $SAM
    }
    $nameinfo
}