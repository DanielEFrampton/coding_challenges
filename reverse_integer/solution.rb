def reverse(x)
    reversed = 0
    positive = x >= 0
    stack = x.abs
    until stack == 0
        reversed += stack - stack.floor(-1)
        stack /= 10
        reversed *= 10 unless stack == 0
    end
    return 0 if reversed < -2**31 || reversed > (2**31)-1
    positive ? reversed : -reversed
end