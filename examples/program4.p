INPUT Move
CASE OF Move
    'W': Position <- Position - 10
    'S': Position <- Position + 10
    'A': Position <- Position - 1
    'D': Position <- Position + 1
    OTHERWISE: OUTPUT "BEEP"
ENDCASE