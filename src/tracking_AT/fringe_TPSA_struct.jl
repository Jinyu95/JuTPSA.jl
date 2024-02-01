function QuadFringePassP!(r::Vector{CTPS{T, TPS_Dim, Max_TPS_Degree}}, b2) where {T, TPS_Dim, Max_TPS_Degree}
    # u = tdiv(b2, tmult(12.0, tadd(1.0, r[5])))
    # x2 = tmult(r[1], r[1])
    # z2 = tmult(r[3], r[3])
    # xz = tmult(r[1], r[3])
    # gx = tmult(u, tmult(tadd(x2, tmult(3.0, z2)), r[1]))
    # gz = tmult(u, tmult(tadd(z2, tmult(3.0, x2)), r[3]))
    # r1tmp = zeros(length(r[1]))
    # r3tmp = zeros(length(r[3]))

    # r[1] = tadd(r[1], gx)
    # r1tmp = tmult(3.0, tmult(u, tminus(tmult(tmult(2.0, xz), r[4]), tmult(tadd(x2, z2), r[2]))))

    # r[3] = tminus(r[3], gz)

    # r3tmp = tmult(3.0, tmult(u, tminus(tmult(tmult(2.0, xz), r[2]), tmult(tadd(x2, z2), r[4]))))
    # r[6] = tminus(r[6], tdiv(tminus(tmult(gz, r[4]), tmult(gx, r[2]), tadd(1.0, r[5]))))

    # r[2] = tadd(r[2], r1tmp)
    # r[4] = tminus(r[4], r3tmp)


    u = b2 / (12.0 * (1.0 + r[5]))
    x2 = r[1]^2
    z2 = r[3]^2
    xz = r[1] * r[3]
    gx = u * (x2 + 3.0 * z2) * r[1]
    gz = u * (z2 + 3.0 * x2) * r[3]
    r1tmp = CTPS(0.0, TPS_Dim, Max_TPS_Degree)
    r3tmp = CTPS(0.0, TPS_Dim, Max_TPS_Degree)

    r[1] += gx
    r1tmp = 3.0 * u * (2.0 * xz * r[4] - (x2 + z2) * r[2])
    
    r[3] -= gz
    
    r3tmp = 3.0 * u * (2.0 * xz * r[2] - (x2 + z2) * r[4])
    r[6] -= (gz * r[4] - gx * r[2]) / (1.0 + r[5])
    
    r[2] += r1tmp
    r[4] -= r3tmp
    return nothing
end

function QuadFringePassN!(r::Vector{CTPS{T, TPS_Dim, Max_TPS_Degree}}, b2) where {T, TPS_Dim, Max_TPS_Degree}
    # u = tdiv(b2, tmult(12.0, tadd(1.0, r[5])))
    # x2 = tmult(r[1], r[1])
    # z2 = tmult(r[3], r[3])
    # xz = tmult(r[1], r[3])
    # gx = tmult(u, tmult(tadd(x2, tmult(3.0, z2)), r[1]))
    # gz = tmult(u, tmult(tadd(z2, tmult(3.0, x2)), r[3]))
    # r1tmp = zeros(length(r[1]))
    # r3tmp = zeros(length(r[3]))

    # r[1] = tminus(r[1], gx)
    # r1tmp = tmult(3.0, tmult(u, tminus(tmult(tmult(2.0, xz), r[4]), tmult(tadd(x2, z2), r[2]))))

    # r[3] = tadd(r[3], gz)

    # r3tmp = tmult(3.0, tmult(u, tminus(tmult(tmult(2.0, xz), r[2]), tmult(tadd(x2, z2), r[4]))))
    # r[6] = tadd(r[6], tdiv(tminus(tmult(gz, r[4]), tmult(gx, r[2]), tadd(1.0, r[5]))))

    # r[2] = tminus(r[2], r1tmp)
    # r[4] = tadd(r[4], r3tmp)

    u = b2 / (12.0 * (1.0 + r[5]))
    x2 = r[1]^2
    z2 = r[3]^2
    xz = r[1] * r[3]
    gx = u * (x2 + 3.0 * z2) * r[1]
    gz = u * (z2 + 3.0 * x2) * r[3]
    r1tmp = CTPS(0.0, TPS_Dim, Max_TPS_Degree)
    r3tmp = CTPS(0.0, TPS_Dim, Max_TPS_Degree)

    r[1] -= gx
    r1tmp = 3.0 * u * (2.0 * xz * r[4] - (x2 + z2) * r[2])
    
    r[3] += gz
    
    r3tmp = 3.0 * u * (2.0 * xz * r[2] - (x2 + z2) * r[4])
    r[6] += (gz * r[4] - gx * r[2]) / (1.0 + r[5])
    
    r[2] -= r1tmp
    r[4] += r3tmp
    return nothing
end

# function quadPartialFringeMatrix!(R, K1, inFringe, fringeInt, part)
#     J1x, J2x, J3x, J1y, J2y, J3y = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
#     K1sqr = K1 * K1

#     R[5, 5] = R[6, 6] = 1.0

#     if part == 1
#         J1x = inFringe * (K1 * fringeInt[2] - 2 * K1sqr * fringeInt[4] / 3)
#         J2x = inFringe * (K1 * fringeInt[3])
#         J3x = inFringe * (K1sqr * (fringeInt[3] + fringeInt[5]))

#         K1 = -K1
#         J1y = inFringe * (K1 * fringeInt[2] - 2 * K1sqr * fringeInt[4] / 3)
#         J2y = -J2x
#         J3y = J3x
#     else
#         J1x = inFringe * (K1 * fringeInt[2] + K1sqr * fringeInt[1] * fringeInt[3] / 2)
#         J2x = inFringe * (K1 * fringeInt[3])
#         J3x = inFringe * (K1sqr * (fringeInt[5] - fringeInt[1] * fringeInt[2]))

#         K1 = -K1
#         J1y = inFringe * (K1 * fringeInt[2] + K1sqr * fringeInt[1] * fringeInt[3])
#         J2y = -J2x
#         J3y = J3x
#     end
#     expJ1x = exp(J1x)
#     R[1, 1] = expJ1x
#     R[1, 2] = J2x / expJ1x
#     R[2, 1] = expJ1x * J3x
#     R[2, 2] = (1 + J2x * J3x) / expJ1x

#     expJ1y = exp(J1y)
#     R[3, 3] = expJ1y
#     R[3, 4] = J2y / expJ1y
#     R[4, 3] = expJ1y * J3y
#     R[4, 4] = (1 + J2y * J3y) / expJ1y
#     return nothing
# end

# function linearQuadFringeElegantEntrance!(r6, b2, fringeIntM0, fringeIntP0)
#     R = zeros(6, 6)
#     inFringe = -1.0
#     fringeIntM = fringeIntP0
#     fringeIntP = fringeIntM0
#     delta = r6[5]

#     # determine first linear matrix for this delta
#     quadPartialFringeMatrix!(R, b2 / (1 + delta), inFringe, fringeIntM, 1)
#     r6[1] = R[1, 1] * r6[1] + R[1, 2] * r6[2]
#     r6[2] = R[2, 1] * r6[1] + R[2, 2] * r6[2]
#     r6[3] = R[3, 3] * r6[3] + R[3, 4] * r6[4]
#     r6[4] = R[4, 3] * r6[3] + R[4, 4] * r6[4]

#     # nonlinear fringe field
#     QuadFringePassP!(r6, b2)  

#     # determine and apply second linear matrix, from elegant code
#     quadPartialFringeMatrix!(R, b2 / (1 + delta), inFringe, fringeIntP, 2)
#     r6[1] = R[1, 1] * r6[1] + R[1, 2] * r6[2]
#     r6[2] = R[2, 1] * r6[1] + R[2, 2] * r6[2]
#     r6[3] = R[3, 3] * r6[3] + R[3, 4] * r6[4]
#     r6[4] = R[4, 3] * r6[3] + R[4, 4] * r6[4]
#     return nothing
# end

# function linearQuadFringeElegantExit!(r6, b2, fringeIntM0, fringeIntP0)
#     R = zeros(6, 6)
#     inFringe = 1.0
#     fringeIntM = fringeIntM0
#     fringeIntP = fringeIntP0
#     delta = r6[5]

#     # Determine first linear matrix for this delta
#     quadPartialFringeMatrix!(R, b2 / (1 + delta), inFringe, fringeIntM, 1)
#     r6[1] = R[1, 1] * r6[1] + R[1, 2] * r6[2]
#     r6[2] = R[2, 1] * r6[1] + R[2, 2] * r6[2]
#     r6[3] = R[3, 3] * r6[3] + R[3, 4] * r6[4]
#     r6[4] = R[4, 3] * r6[3] + R[4, 4] * r6[4]

#     # Nonlinear fringe field 
#     QuadFringePassN!(r6, b2)

#     # Determine and apply second linear matrix
#     quadPartialFringeMatrix!(R, b2 / (1 + delta), inFringe, fringeIntP, 2)
#     r6[1] = R[1, 1] * r6[1] + R[1, 2] * r6[2]
#     r6[2] = R[2, 1] * r6[1] + R[2, 2] * r6[2]
#     r6[3] = R[3, 3] * r6[3] + R[3, 4] * r6[4]
#     r6[4] = R[4, 3] * r6[3] + R[4, 4] * r6[4]
#     return nothing
# end

function edge_fringe_entrance!(r::Vector{CTPS{T, TPS_Dim, Max_TPS_Degree}}, inv_rho, edge_angle, fint, gap, method) where {T, TPS_Dim, Max_TPS_Degree}
    #      method 0 no fringe field
    #      method 1 legacy version Brown First Order
    #      method 2 SOLEIL close to second order of Brown
    #      method 3 THOMX

    # Edge Fringe Field for Entrance
    if fint == 0.0 || gap == 0.0 || method == 0
        fringecorr = 0.0
    else
        sedge = sin(edge_angle)
        cedge = cos(edge_angle)
        fringecorr = inv_rho * gap * fint * (1.0 + sedge^2) / cedge
    end

    fx = inv_rho * tan(edge_angle)
    if method == 1
        # fy = tmult(inv_rho, ttan(tminus(edge_angle, tdiv(fringecorr, tadd(1.0, r[5])))))
        fy = inv_rho * tan(edge_angle - fringecorr / (1.0 + r[5]))
    elseif method == 2
        # fy = tmult(inv_rho, tdiv(ttan(tminus(edge_angle, tdiv(fringecorr, tadd(1.0, r[5])))), tadd(1.0, r[5])))
        fy = inv_rho * tan(edge_angle - fringecorr / (1.0 + r[5])) / (1.0 + r[5])
    elseif method == 3
        # fy = tmult(inv_rho, ttan(tadd(tminus(edge_angle, fringecorr), tdiv(r[2], tadd(1.0, r[5])))))
        fy = inv_rho * tan(edge_angle - fringecorr + r[2] / (1.0 + r[5]))
    else  # Fallback to legacy version
        # fy = tmult(inv_rho, ttan(tminus(edge_angle, tdiv(fringecorr, tadd(1.0, r[5])))))
        fy = inv_rho * tan(edge_angle - fringecorr / (1.0 + r[5]))
    end

    # r[2] = tadd(r[2], tmult(r[1], fx))
    # r[4] = tminus(r[4], tmult(r[3], fy))
    r[2] += r[1] * fx
    r[4] -= r[3] * fy
    return nothing
end

function edge_fringe_exit!(r::Vector{CTPS{T, TPS_Dim, Max_TPS_Degree}}, inv_rho, edge_angle, fint, gap, method) where {T, TPS_Dim, Max_TPS_Degree}
    #      method 0 no fringe field
    #      method 1 legacy version Brown First Order
    #      method 2 SOLEIL close to second order of Brown
    #      method 3 THOMX
    
    # Edge Fringe Field for Exit
    if fint == 0.0 || gap == 0.0 || method == 0
        fringecorr = 0.0
    else
        sedge = sin(edge_angle)
        cedge = cos(edge_angle)
        fringecorr = inv_rho * gap * fint * (1.0 + sedge^2) / cedge
    end

    fx = inv_rho * tan(edge_angle)
    if method == 1
        # fy = tmult(inv_rho, ttan(tminus(edge_angle, tdiv(fringecorr, tadd(1.0, r[5])))))
        fy = inv_rho * tan(edge_angle - fringecorr / (1.0 + r[5]))
    elseif method == 2
        # fy = tmult(inv_rho, tdiv(ttan(tminus(edge_angle, tdiv(fringecorr, tadd(1.0, r[5])))), tadd(1.0, r[5])))
        fy = inv_rho * tan(edge_angle - fringecorr / (1.0 + r[5])) / (1.0 + r[5])
    elseif method == 3
        # fy = tmult(inv_rho, ttan(tadd(tminus(edge_angle, fringecorr), tdiv(r[2], tadd(1.0, r[5])))))
        fy = inv_rho * tan(edge_angle - fringecorr - r[2] / (1.0 + r[5]))
    else  # Fallback to legacy version
        # fy = tmult(inv_rho, ttan(tminus(edge_angle, tdiv(fringecorr, tadd(1.0, r[5])))))
        fy = inv_rho * tan(edge_angle - fringecorr / (1.0 + r[5]))
    end

    # r[2] = tadd(r[2], tmult(r[1], fx))
    # r[4] = tminus(r[4], tmult(r[3], fy))
    r[2] += r[1] * fx
    r[4] -= r[3] * fy
    return nothing
end