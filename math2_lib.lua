R = 'R'
C = 'C'

function matrix(_R, _C, _v)
    _x = {}
    _x[R] = _R
    _x[C] = _C
    for r=1,_R do
        _x[r] = {}
        for c=1,_C do
            _x[r][c] = _v[(r-1)*_C + c] or 0
        end
    end
    return _x
end

function mul(x, y) 
    if x[C] ~= y[R] then
        print("ERROR!")
        print('x:')
        repr(x)
        print('y:')
        repr(y)
        error("incorrect x and y dimensionality taking x*y")
    end

    _z = matrix(x[R], y[C], {})

    for r=1,x[R] do
        for p=1,x[C] do
            for c=1,y[C] do
                _z[r][c] = _z[r][c] + x[r][p] * y[p][c]
            end
        end
    end

    return _z
end

function add(x, y) 
    if x[C] ~= y[C] or x[R] ~= y[C] then
        print("ERROR!")
        print('x:')
        repr(x)
        print('y:')
        repr(y)
        error("incorrect x and y dimensionality when taking x+y")
    end

    _z = matrix(x[R], x[C], {})

    for r=1,x[R] do
        for c=1,x[C] do
            _z[r][c] = x[r][c]+y[r][c]
        end
    end

    return _z
end

function sub(x, y) 
    if x[C] ~= y[C] or x[R] ~= y[C] then
        print("ERROR!")
        print('x:')
        repr(x)
        print('y:')
        repr(y)
        error("incorrect x and y dimensionality when taking x-y")
    end

    _z = matrix(x[R], x[C], {})

    for r=1,x[R] do
        for c=1,x[C] do
            _z[r][c] = x[r][c]-y[r][c]
        end
    end

    return _z
end

function transpose(x) 
    local _z = matrix(x[C], x[R], {})

    for r=1,x[R] do
        for c=1,x[C] do
            _z[r][c] = x[c][r]
        end
    end

    return _z
end

function __det(_x)
    if _x[R] < 2 then
        return _x[1][1]
    else
        local _sum = 0
        for r=1,_x[R] do
            if math.mod(r, 2) == 1 then
                _sum = _sum + __det(__minor(r, 1, _x)) * _x[r][1]
            else
                _sum = _sum - __det(__minor(r, 1, _x)) * _x[r][1]
            end
        end
        return _sum
    end
end

function det(_x)
    if _x[C] ~= _x[R] then
        print("ERROR!")
        print('x:')
        repr(_x)
        error("incorrect x dimensionality when taking det(x)")
    end

    if _x[R] < 2 then
        return _x[1][1]
    else
        local _sum = 0
        for r=1,_x[R] do
            if math.mod(r, 2) == 1 then
                _sum = _sum + __det(__minor(r, 1, _x)) * _x[r][1]
            else
                _sum = _sum - __det(__minor(r, 1, _x)) * _x[r][1]
            end
        end
        return _sum
    end
end


function __minor(_r, _c, _x)
    local _m = matrix(_x[R] - 1, _x[C] - 1, {})
    local i = 0
    local j = 0
    for r = 1,_x[R] do
        j = 0
        if r ~= _r then
            i = i + 1
            for c = 1,_x[C] do
                if c ~= _c then
                    j = j + 1
                    _m[i][j] = _x[r][c]
                end
            end
        end
    end
    return _m
end


function inverse(_x)
    if _x[C] ~= _x[R] then
        print("ERROR!")
        print('x:')
        repr(_x)
        error("incorrect x dimensionality when taking the inverse")
    end

    local _m = matrix(_x[R], _x[C], {})

    local D = __det(_x)

    if D*D < 0.0001 then
        return _m
    end

    D = 1/D

    for r=1,_x[R] do
        for c=1,_x[C] do
            if math.mod(r, 2) == math.mod(c, 2) then
                _m[r][c] = D * __det(__minor(c, r, _x))
            else
                _m[r][c] = -D * __det(__minor(c, r, _x))
            end
        end
    end

    return _m
end

function dot(_x, _y)
    if _x[R] ~= _y[R] or _x[C] ~= _y[C] then
        print("ERROR!")
        print('x:')
        repr(_x)
        print('y:')
        repr(_y)
        error("incorrect x and y dimensionality when taking the dot product")
    end

    local _sum = 0
    for i = 1,_x[R] do
        for j = 1,_x[C] do
            _sum = _sum + _x[i][j]*_y[i][j]
        end
    end
    return _sum
end

function multilaterate(X, D)
    local H = matrix(D[R], 1, {})
    for i = 1,D[C] do
        H[i] = 0.5*(dot(X[i],X[i]) - D[i]*D[i])
    end

    local dX = matrix(X[R]-1, X[C], {})
    local dH = matrix(D[R]-1, 1, {})
    for i = 1,X[R] do
        dX[i] = sub(dX[i], dX[X[R]])
        dH[i] = H[i] - H[X[R]]
    end

    return mul(inverse(mul(transpose(dX), dX)), mul(transpose(dX), dH))
end

function repr(_v) 
    for r=1,_v[R] do
        print(table.concat(_v[r], ", "))
    end
end

