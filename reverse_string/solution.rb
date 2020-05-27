def reverse_string(s)
    length = s.length
    start_pointer = 0
    end_pointer = length - 1
    until start_pointer >= end_pointer
        buffer = s[start_pointer]
        s[start_pointer] = s[end_pointer]
        s[end_pointer] = buffer
        start_pointer += 1
        end_pointer -= 1
    end
end

# Submitted solution was 96th percentile at time of submission.