--__lua__
-- meander_cannon/animation.p8

local animation = {}
animation.__index = animation

function animation:new(sprites, n_delta_frames)
 local ret = setmetatable({}, self)

 ret.sprites = sprites
 ret.time = 0
 -- number of frames between steps
 ret.delta_frames = n_delta_frames

 -- 1-indexed
 current_sprite = 1
 return ret
end

function animation:update(frame)
 self.time += frame
 if self.time >= self.delta_frames then
  self.time -= self.delta_frames
 end

 self.current_sprite = ((self.current_sprite + 1) % #self.sprites) + 1
end

function animation:draw(x, y)
 local num = self.sprites[self.current_sprite]
 spr(num, x-4, y-4, 1, 1)
end