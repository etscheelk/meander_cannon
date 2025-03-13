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

 -- 0-indexed
 ret.current_sprite = 0
 return ret
end

function animation:update(frame)
 if self == nil then return end

 self.time += frame
 -- print("anim update")
 -- printh("self.time:"..self.time, "my_log.txt")
 if self.time >= self.delta_frames then
--   printh("t:"..self.time.." df:"..self.delta_frames, "my_log.txt", false)
  self.time = 0
  self.current_sprite = (self.current_sprite + 1) % #self.sprites
 end

end

function animation:draw(x, y)
 -- print(self.current_sprite)
 local num = self.sprites[self.current_sprite+1]
 spr(num, x-4, y-4, 1, 1)
end