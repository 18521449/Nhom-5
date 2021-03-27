def fpToDec(x):
    if x == '00000000000000000000000000000000':
        return int(0)
    
    sign = x[0]
    exp = x[1:9]
    mantise = '1' + x[9:]
    S = 0
    P = 0

    ## Tìm số mũ
    for i in range (8):
        P += int(exp[7-i])*(2**i)
    P = P - 127
    ## Tìm dạng chuẩn hóa
    for i in range (24):
        S += int(mantise[i])*(2**-i)
    ## Tìm dạng Dec giá trị tuyệt đối
    while (P!=0):
        if P<0:
            S /= 2
            P += 1
        else:
            S *=2
            P -= 1
    
    if sign == '1':
        return int(-S)
    else:
        return int(S)