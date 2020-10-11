type complex = {real: f64, imaginary: f64}

let magnitude (number: complex): f64 =
    let {real=re, imaginary=im} = number
    in
        f64.sqrt (re*re) + (im*im)

let add (first: complex) (second: complex): complex =
    let {real=a, imaginary=b} = first
    let {real=c, imaginary=d} = second
    in
        { real = a+c, imaginary = b+d }

let mul (first: complex) (second: complex): complex =
    let {real=a, imaginary=b} = first
    let {real=c, imaginary=d} = second
    in
        { real = a*c - b * d, imaginary = a*d + b * c}

let square (c: complex): complex = mul c c

let dot (number: complex): f64 =
    let {real=re, imaginary=im} = number
    in
        re*re + im*im


-- How many iterations until the value starts diverging?
let iterations (max_iterations: u32) (upper_bound: f64) (c: complex) (initial_z: complex): u32 =
    let (i, _) = iterate_while
        (\(i, z) -> i < max_iterations && (magnitude z) < upper_bound)
        (\(i, z) -> (i+1, (add (square z) c)))
        (0, initial_z)
    in
        i

type rect = {top: f64, left: f64, width: f64, height: f64}

let upper_bound: f64 = 4.0
let max_iterations: u32 = 200

-- Calculate part of the Mandelbrot set.
entry mandelbrot (width: i32)
                 (height: i32)
                 (viewport: rect)
                 (c: complex) : [width][height]u32 =
    tabulate_2d width height (\i j ->
        let real = viewport.left + (f64.i32 i) * viewport.width / (f64.i32 width)
        let imaginary = viewport.top + (f64.i32 j) * viewport.height / (f64.i32 height)
        in
            iterations max_iterations upper_bound c {real, imaginary}
    )

-- Expose a complex number constructor.
entry complex_new (real: f64) (imaginary: f64): complex = {real, imaginary}

-- Expose a rect constructor.
entry rect_new (top: f64) (left: f64) (width: f64) (height: f64): rect =
    {top, left, width, height}
