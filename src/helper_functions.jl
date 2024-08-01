function integrate_region(dist, region)
    return hcubature(dist, eachcol(region)[1], eachcol(region)[2], rtol=1e-3)[1]
end

# a two dimensional integral using Simpson's rule
function integrate(f, a, b, n=1000)
    ndim = length(a)
    if ndim != length(b)
        error("a and b must have the same length")
    end
    if ndim == 1
        return simpson(f, a[1], b[1], n)
    end
    if ndim == 2
        return simpson2d(f, a[1], b[1], a[2], b[2], n)
    end
end

function simpson(f, a, b, n=1000)
    h = (b - a) / n
    s = f(a) + f(b)
    for i = 1:n-1
        x = a + i * h
        s += 4 * f(x) + 2 * f(x + h)
    end
    return s * h / 6
end

function simpson2d(f, a, b, c, d, n=1000)
    hx = (b - a) / n
    hy = (d - c) / n
    s = f(a, c) + f(b, d)
    for i = 1:n-1 # x
        x = a + i * hx
        for j = 1:n-1 # y
            y = c + j * hy
            s += 4 * f(x, y) + 2 * f(x + hx, y) + 2 * f(x, y + hy) + 4 * f(x + hx, y + hy)
        end
    end
    return s * hx * hy / 9
end
