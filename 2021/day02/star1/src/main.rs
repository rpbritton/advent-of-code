use std::fs;

fn main() {
    let commands = fs::read_to_string("input.txt")
        .expect("file not found")
        .lines()
        .map(|line| line.split_whitespace().collect::<Vec<&str>>())
        .filter(|command| command.len() == 2)
        .map(|command| (command[0], command[1].parse().unwrap()))
        .fold((0, 0), |counts, command: (&str, i32)| match command.0 {
            "forward" => (counts.0 + command.1, counts.1),
            "down" => (counts.0, counts.1 + command.1),
            "up" => (counts.0, counts.1 - command.1),
            _ => counts,
        });

    println!("{}", commands.0 * commands.1);
}
