Total <- 0
FOR Row <- 1 TO MaxRow
    RowTotal <- 0
    FOR Column <- 1 TO 10
        RowTotal <- RowTotal + Amount[Row,Column]
    NEXT Column
    OUTPUT "Total for Row ", Row, " is ", RowTotal
    Total <- Total + RowTotal
NEXT Row
OUTPUT "The grand total is ", Total