#[allow(non_camel_case_types)]
pub mod ffi {
    include!(concat!(env!("OUT_DIR"), "/mandelbrot.rs"));
}
