const rl = @import("raylib");

const Player = struct {
    x: f32,
    y: f32,
    speed: f32,

    pub fn init(x: f32, y: f32, speed: f32) Player {
        return .{ // We use . instead of Player { }
            .x = x,
            .y = y,
            .speed = speed,
        };
    }

    pub fn update(self: *Player) void {
        if(rl.isKeyDown(rl.KeyboardKey.key_d)){
            self.x += self.speed * rl.getFrameTime();
        }
        else if(rl.isKeyDown(rl.KeyboardKey.key_a)){
            self.x -= self.speed * rl.getFrameTime();
        }

        if(rl.isKeyDown(rl.KeyboardKey.key_w)){
            self.y -= self.speed * rl.getFrameTime();
        }
        else if(rl.isKeyDown(rl.KeyboardKey.key_s)){
            self.y += self.speed * rl.getFrameTime();
        }
    }

    pub fn draw(self: *Player) void {
        rl.drawCircleV(rl.Vector2.init(self.x, self.y), 20, rl.Color.lime);
    }
};

pub fn main() !void {
    const WIN_W: i16 = 500;
    const WIN_H: i16 = 500;

    rl.initWindow(WIN_W, WIN_H, "Hello Raylib from Zig");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    var plr: Player = Player.init(WIN_W / 2, WIN_H / 2, 50.0);

    while(!rl.windowShouldClose()){
        plr.update();

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.orange);

        plr.draw();

        rl.drawText("WASD to move", 10, 30, 20, rl.Color.ray_white);
        rl.drawFPS(10, 10);
    }
}