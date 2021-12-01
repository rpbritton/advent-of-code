use std::fs;

fn main() {
    let total = fs::read_to_string("input.txt")
        .expect("file not found")
        .split("\n")
        .filter_map(|depth| depth.parse().ok())
        .collect::<Vec<u32>>()
        .windows(2)
        .filter(|depths| depths[0] < depths[1])
        .count();
    println!("{}", total);
}
