Keys = {}
Keys.__index = Keys

function Keys.create(id)
    local self = {}
    
    self.id = id

    return setmetatable(self, Keys)  
end

function Keys:onPress(methode)
    if IsControlJustReleased(1, self.id) then
        if methode then
            methode()
        else
            print("No function on pressed keys")
        end
    end
end

ESC = Keys.create(322)
F1 = Keys.create(288)
F2 = Keys.create(289)
F3 = Keys.create(170)
F5 = Keys.create(166)
F6 = Keys.create(167)
F7 = Keys.create(168)
F8 = Keys.create(169)
F9 = Keys.create(56)
F10 = Keys.create(57)
BACKSPACE = Keys.create(177)
TAB = Keys.create(37) 
Q = Keys.create(44)
W = Keys.create(32)
E = Keys.create(38)
R = Keys.create(45)
T = Keys.create(245)
Y = Keys.create(246)
U = Keys.create(303)
P = Keys.create(199)
ENTER = Keys.create(18)
CAPS = Keys.create(137)
A = Keys.create(34)
S = Keys.create(8)
D = Keys.create(9)
F = Keys.create(23)
G = Keys.create(47)
H = Keys.create(74)
K = Keys.create(311)
L = Keys.create(18)
LEFTSHIFT = Keys.create(21)
Z = Keys.create(20)
X = Keys.create(73)
C = Keys.create(26)
V = Keys.create(0)
B = Keys.create(29)
N = Keys.create(249)
M = Keys.create(244)
LEFTCTRL = Keys.create(36)
LEFTALT = Keys.create(19)
SPACE = Keys.create(22)
RIGHTCTRL = Keys.create(70)
HOME = Keys.create(213)
PAGEUP = Keys.create(10)
PAGEDOWN = Keys.create(11)
DELETE = Keys.create(178)
LEFT = Keys.create(174)
RIGHT = Keys.create(175)
TOP = Keys.create(27)
DOWN = Keys.create(173)
NENTER = Keys.create(201)
N4 = Keys.create(108)
N5 = Keys.create(60)
N6 = Keys.create(107)
N7 = Keys.create(117)
N8 = Keys.create(61)
N9 = Keys.create(118)
