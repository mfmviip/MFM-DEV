redis=dofile("./File/redis.lua").connect("127.0.0.1", 6379)
serpent=dofile("./File/serpent.lua")
JSON=dofile("./File/dkjson.lua")
json=dofile("./File/JSON.lua")
http= require("socket.http")
URL=dofile("./File/url.lua")
https= require("ssl.https")
Server_Done = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_Write = function() 
local Create_Info = function(Token,Sudo)  
local Write_Info_Sudo = io.open("sudo.lua", 'w')
Write_Info_Sudo:write([[

s = "mfmvip"

q = "TOKYO"

token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

]])
Write_Info_Sudo:close()
end  
if not redis:get(Server_Done.."Token_Write") then
print('\n\27[1;41m ارسل توكن البوت الان : \n\27[0;39;49m')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;35m عذرا التوكن خطأ  : \n\27[0;39;49m')
else
io.write('\n\27[1;45m تم حفظ التوكن : \n\27[0;39;49m') 
redis:set(Server_Done.."Token_Write",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
if not redis:get(Server_Done.."UserSudo_Write") then
print('\n\27[1;41m ارسل ايدي مطور البوت الان : \n\27[0;39;49m')
local Id = io.read():gsub(' ','') 
if tostring(Id):match('%d+') then
data,res = https.request("https://boyka-api.ml/index.php?bn=info&id="..Id)
if res == 200 then
muaed = json:decode(data)
if muaed.Info.info == 'Is_Spam' then
io.write('\n\27[1;35m عذرا الايدي محظور من السورس \n\27[0;39;49m') 
os.execute('lua start.lua')
end ---ifBn
if muaed.Info.info == 'Ok' then
io.write('\n\27[1;39m تم حفظ الايدي بنجاح \n\27[0;39;49m') 
redis:set(Server_Done.."UserSudo_Write",Id)
end ---ifok
else
io.write('\n\27[1;31m تم حفظ الايدي يوجد خطأ : \n\27[0;39;49m')
end  ---ifid
os.execute('lua start.lua')
end ---ifnot
end
local function Files_Info_Get()
Create_Info(redis:get(Server_Done.."Token_Write"),redis:get(Server_Done.."UserSudo_Write"))   
local RunBot = io.open("Run", 'w')
RunBot:write([[
#!/usr/bin/env bash
cd $HOME/TOKYO
token="]]..redis:get(Server_Done.."Token_Write")..[["
rm -fr TOKYO.lua
wget "https://raw.githubusercontent.com/mfmvip/TOKYO2/main/TOKYO.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./TOKYO.lua -p PROFILE --bot=$token
done
]])
RunBot:close()
local RunTs = io.open("TK", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/TOKYO
while(true) do
rm -fr ../.telegram-cli
screen -S TOKYO -X kill
screen -S TOKYO ./Run
done
]])
RunTs:close()
end
Files_Info_Get()
redis:del(Server_Done.."Token_Write");redis:del(Server_Done.."UserSudo_Write")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_Write()  
var = true
else   
f:close()  
redis:del(Server_Done.."Token_Write");redis:del(Server_Done.."UserSudo_Write")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()