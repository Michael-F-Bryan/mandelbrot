use futhark_build::{Backend, Build};
use std::path::Path;

fn main() {
    let project_root = std::env::var("CARGO_MANIFEST_DIR").unwrap();
    let src = Path::new(&project_root)
        .join("futhark")
        .join("mandelbrot.fut");
    let out_dir = std::env::var("OUT_DIR").unwrap();

    Build::new(&src)
        .backend(Backend::Cuda)
        .generate(&out_dir)
        .unwrap();
}
