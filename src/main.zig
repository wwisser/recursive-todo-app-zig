const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var todos = std.ArrayList([]const u8).init(allocator);
    defer todos.deinit();

    const stdout = std.io.getStdOut().writer();

    while (true) {
        try stdout.print("\nTODO App:\n", .{});
        try stdout.print("1. Add TODO\n2. List TODOs\n3. Exit\n> ", .{});

        var input = try getInput();
        switch (input[0]) {
            '1' => {
                try stdout.print("Enter TODO: ", .{});
                const todo = try getInput();
                try todos.append(todo);
            },
            '2' => {
                try stdout.print("Your TODOs:\n", .{});
                for (todos.items) |todo, i| {
                    try stdout.print("{d}: {s}\n", .{i + 1, todo});
                }
            },
            '3' => {
                try stdout.print("Goodbye!\n", .{});
                return;
            },
            else => {
                try stdout.print("Invalid option. Try again.\n", .{});
            },
        }
    }
}

fn getInput() ![]const u8 {
    const stdin = std.io.getStdIn().reader();
    var line: [256]u8 = undefined;
    const bytes = try stdin.readUntilDelimiterOrEof(&line, '\n');
    return line[0..bytes].trimRight(u8(0x0a)); // Trim newline
}
