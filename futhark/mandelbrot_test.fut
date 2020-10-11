import "./mandelbrot"

-- Iterations
-- ==
-- entry: test_iterations
-- input { 100 2.0 [0.0, 0.0] [0.0, 0.0]}
-- output {100}
-- input { 100 2.0 [1.0, 0.0] [0.5, 0.0]}
-- output {2}

entry test_iterations (max_iterations: i32) (upper_bound: f64) (z: [2]f64) (c: [2]f64): i32 =
    let it = iterations
                (u32.i32 max_iterations)
                upper_bound
                { real = c[0], imaginary = c[1] }
                { real = z[0], imaginary = z[1] }
    in
        i32.u32 it

