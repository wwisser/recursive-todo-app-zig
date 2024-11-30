const Build = @import("std").zig.build;

pub fn build(b: *Build.Context) void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    const exe = b.addExecutable(.{
        .name = "todo",
        .root_source_file = .{ .path = "main.zig" },
        .target = target,
        .build_mode = mode,
    });

    b.installArtifact(exe);
}
