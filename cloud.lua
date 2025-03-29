--

pals={
 "000000111111222222333333444444555555666666777777888888999999aaaaaabbbbbbccccccddddddeeeeeeffffff",
 "242124302a463c3368483d8b854974c2565dff6347ff678fff7b96ff9f5affc41dffdd00ffeb00fff800f6f653e6e6fa",
 "002244002851002e5e00356b0a407e144b921e57a62862ba3570be4682b442c0c653e5d779efe79ff9f7c6fcfff0f8ff"
}

function pal(p)
 for i=0,15 do
  poke(0x3fc0+i*3,tonumber(p:sub(i*6+1,i*6+2),16))
  poke(0x3fc1+i*3,tonumber(p:sub(i*6+3,i*6+4),16))
  poke(0x3fc2+i*3,tonumber(p:sub(i*6+5,i*6+6),16))
 end
end

function chgpal()
 if btnp(0) then
  cpal=(cpal-2)%#pals+1
  pal(pals[cpal])
 elseif btnp(1) then
  cpal=cpal%#pals+1
  pal(pals[cpal])
 end
end

cpal=1
pal(pals[cpal])

t=0
w=240
h=136

n={}
for x=0,w do
 n[x]={}
 for y=0,h do
  n[x][y]=math.random(0,5)
 end
end

function smooth()
 m={}
 for x=0,w do
  m[x]={}
  for y=0,h do
   s=n[x][y] or 0
   c=1        
   if n[x+1] and n[x+1][y] then
    s=s+n[x+1][y] c=c+1
   end
   if n[x-1] and n[x-1][y] then
    s=s+n[x-1][y] c=c+1
   end
   if n[x] and n[x][y+1] then
    s=s+n[x][y+1] c=c+1
   end
   if n[x] and n[x][y-1] then
    s=s+n[x][y-1] c=c+1
   end
   m[x][y]=s/c
  end
 end
 n=m
end

function update()
 for x=0,w do
  for y=0,h do
   if n[x] and n[x][y] then
    n[x][y]=(n[x][y]+math.random(-1,1))%16
   end
  end
 end
end

function TIC()
 cls()

 chgpal()
 
 smooth()
 update()

 for x=0,w do
  for y=0,h do
   if n[x] and n[x][y] then
    pix(x,y,n[x][y]//1)
   end
  end
 end

 t=t+1
 if t%120==0 then
  cpal=cpal%#pals+1
  pal(pals[cpal])
 end
end
