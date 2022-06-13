-- hopes; print vector to terminal
-- takes; x: table[3]
function repr_vec(x)
    print(x[1], x[2], x[3])
end

-- hopes; print matrix to terminal
-- takes; A: table[3][3]
function repr_mat(A)
    print(A[1][1], A[1][2], A[1][3])
    print(A[2][1], A[2][2], A[2][3])
    print(A[3][1], A[3][2], A[3][3])
end

-- takes; A: table[3][3], x: table[3]
-- gives; x transformed by A: table[3]
function transform_vec(A, x)
    y = {}
    y[1] = A[1][1]*x[1] + A[1][2]*x[2] + A[1][3]*x[3]
    y[2] = A[2][1]*x[1] + A[2][2]*x[2] + A[2][3]*x[3]
    y[3] = A[3][1]*x[1] + A[3][2]*x[2] + A[3][3]*x[3]
    return y
end

-- takes; A: table[3][3], B: table[3][3]
-- gives; B transformed by A: table[3][3]
function transform_mat(A, B)
    C = { {}, {}, {} }
    C[1] = transform_vec(A, B[1])
    C[2] = transform_vec(A, B[2])
    C[3] = transform_vec(A, B[3])
    return C
end

-- takes; x: table[3], y: table[3]
-- gives; sum of x and y: table[3]
function add(x, y)
    return { x[1] + y[1], x[2] + y[2], x[3] + y[3] }
end

-- takes; x: table[3], y: table[3]
-- gives; difference of x and y: table[3]
function sub(x, y)
    return { x[1] - y[1], x[2] - y[2], x[3] - y[3] }
end

-- takes; x: table[3], y: table[3]
-- gives; dot-product of x and y: float
function dot(x, y)
    return x[1]*y[1] + x[2]*y[2] + x[3]*y[3]
end

-- takes; x: table[3], y: table[3]
-- gives; cross-product of x and y: table[3]
function cross(x, y)
    return { x[2]*y[3] - x[3]*y[2], x[3]*y[1] - x[1]*y[3], x[1]*y[2] - x[2]*y[1]}
end

-- takes; matrix: table[3][3]
-- gives; transpose: table[3][3]
function transpose(A)
    B = { {}, {}, {} }
    B[1][1] = A[1][1]
    B[1][2] = A[2][1]
    B[1][3] = A[3][1]
    B[2][1] = A[1][2]
    B[2][2] = A[2][2]
    B[2][3] = A[3][2]
    B[3][1] = A[1][3]
    B[3][2] = A[2][3]
    B[3][3] = A[3][3]
    return B
end

-- takes; matrix: table[3][3]
-- gives; determinant: float
function det(A)
    return A[1][1] * (A[2][2] * A[3][3] - A[3][2] * A[2][3]) + A[1][2] * (A[2][3] * A[3][1] - A[3][3] * A[2][1]) + A[1][3] * (A[2][1] * A[3][2] - A[3][1] * A[2][2])
end

-- takes; matrix: table[3][3]
-- gives; inverse: table[3][3], det == 0 (successfull inversion?): bool
function inv(A)
    B = { {}, {}, {} }
    D = det(A)
    if D*D < 0.001 then
        return A, false
    else
        D = 1/det(A)
        B[1][1] = D * (A[2][2]*A[3][3] - A[3][2]*A[2][3])
        B[1][2] = D * (A[2][3]*A[3][1] - A[3][3]*A[2][1])
        B[1][3] = D * (A[2][1]*A[3][2] - A[3][1]*A[2][2])
        B[2][1] = D * (A[1][3]*A[3][2] - A[1][2]*A[3][3])
        B[2][2] = D * (A[1][1]*A[3][3] - A[1][3]*A[3][1])
        B[2][3] = D * (A[1][2]*A[3][1] - A[1][1]*A[3][2])
        B[3][1] = D * (A[1][2]*A[2][3] - A[2][2]*A[1][3])
        B[3][2] = D * (A[1][3]*A[2][1] - A[2][3]*A[1][1])
        B[3][3] = D * (A[1][1]*A[2][2] - A[2][1]*A[1][2])
        return B, true
    end
end

-- takes; distance between nodes: int, recorded distances from rigin: table[4]
-- gives; position: table[3], success: bool
function quad(k, _d)
    local od, xd, yd, zd
    local x = {}

    xd = _d['x'] * _d['x']
    yd = _d['y'] * _d['y']
    zd = _d['z'] * _d['z']
    od = _d['o'] * _d['o']

    x[1] = (od - xd + k * k) / (2 * k)
    x[2] = (od - yd + k * k) / (2 * k)
    x[3] = (od - zd + k * k) / (2 * k)

    return x
end

-- takes; distance between nodes: int, position: table[4]
-- gives; distances: table[4]
function invquad(k, _x)
    local d = {}
    local x, y, z
    x = _x[1]
    y = _x[2]
    z = _x[3]

    d['x'] = math.sqrt((x-k)*(x-k) + y*y + z*z)
    d['y'] = math.sqrt(x*x + (y-k)*(y-k) + z*z)
    d['z'] = math.sqrt(x*x + y*y + (z-k)*(z-k))
    d['o'] = math.sqrt(x*x + y*y + z*z)

    return d
end


x = { 100.5, 20.5, -400.5 }

d = invquad(2, x)
y = quad(2, d)

print(repr_vec(x))
print(repr_vec(y))