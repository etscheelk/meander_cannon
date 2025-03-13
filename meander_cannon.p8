pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- meander cannon

#include table.p8
#include animation.p8

function _init()
end

local pi = 3.141592

local dt = 1/30

local cannon = {}
cannon.rot = 0
cannon.pos = {x=65, y=65}
cannon.len = 12
cannon.tip = {x=77, y=65}
cannon.color = 2

function cannon:rotate(d_rot)
 self.rot += d_rot
 local nx = cos(self.rot) * self.len
 local ny = -sin(self.rot) * self.len
 self.tip = {x=nx+self.pos.x, y=ny+self.pos.y}
end

function cannon:draw()
 plot_line(self.pos, self.len, self.rot, self.color)
 circfill(self.tip.x, self.tip.y, 2, self.color)
end

function print_table(t)
 for k,v in pairs(t) do
  print(k..":"..v.." ")
 end
end

-- Draw the 128x128 frame of the window in a given color
function draw_frame(color)
 rect(0, 0, 127, 127, color)
end

local fire = false
local cannonball = {}
-- setmetatable(cannonball.__index, cannonball)
cannonball.__index = cannonball
function cannonball:new(position, velocity)
 local cb = setmetatable({}, self)
 cb.pos = position
 cb.vel = velocity
 cb.sprite = 2
 cb.discard = false

 return cb
end

-- update position
function cannonball:update()
 if self == nil then return end

 self.pos.x += dt * self.vel.x
 self.pos.y += dt * self.vel.y

 if self.pos.x > 128 or self.pos.x < 0 then self.discard = true end
 if self.pos.y > 128 or self.pos.y < 0 then self.discard = true end
end

local cannonballs = {}
-- cannonballs.__index = cannonballs
-- function cannonballs:discard()
--  local d = {}
--  for i,v in pairs(self) do
--   if v and v.discard then add(d, i) end
--  end

--  for i in all(d) do
--   deli(self, i)
--  end
-- end

function cannonball:draw()
 if self == nil then return end

 spr(2, self.pos.x-4, self.pos.y-4)
end

function _update()
 -- run discard
 -- cannonballs:discard()
 -- if btn(0) then rot -= 0.01 end
 -- if btn(1) then rot += 0.01 end
 if btn(0) then cannon:rotate(-0.01) end
 if btn(1) then cannon:rotate(0.01)  end

 
 

 if btnp(2) then
  -- printh("button pressed", "log.txt")
--   local cb = cannonball:new({x=cannon.tip.x, y=cannon.tip.y}, {x=25*cos(cannon.rot), y=-25*sin(cannon.rot)})
  local cb = cannonball:new(table.deepcopy(cannon.tip), {x=25*cos(cannon.rot), y=-25*sin(cannon.rot)})
  add(cannonballs, cb)
 end

 -- print("fire!!")
 if btnp(5) then fire = true end
 if fire then 
  -- print("fire!")
  fire = false
 end

 for _,cb in ipairs(cannonballs) do
  cb:update()
 end

end

function create_line(pos, len, rot)
 local ret = {}
 ret.x0 = pos.x
 ret.y0 = pos.y
 ret.x1 = len * cos(rot) + pos.x
 ret.y1 = -len * sin(rot) + pos.y

 return ret
end

function plot_line(pos, len, rot, color)
 local p = create_line(pos, len, rot)
 -- print_table(p)
 line(p.x0, p.y0, p.x1, p.y1, color)
end

function _draw()
 cls()
 draw_frame(1)
 -- pset(x, y, 2)
 spr(0, 57, 57, 2, 2)
 -- line(63, 63)
 cannon:draw()

 for _,cb in pairs(cannonballs) do
  cb:draw()
 end

 print(#cannonballs)
 -- ?t()

 
end

__gfx__
00000767667000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077666666ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0076666666666f0000098000000a9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07666666666666f0009aaa00008aa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07666666666666f000aaa900009aa800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7666666666666665000890000009a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76666666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d666666666666500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d666666666666500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00d66666666665000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000dd666666550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
