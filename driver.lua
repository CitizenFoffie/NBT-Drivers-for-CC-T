
local function readNBTData(file, typ)
    if typ == 1 then
        return((">b"):unpack(file.read(1)))
    elseif typ == 2 then
        return((">h"):unpack(file.read(2)))
    elseif typ == 3 then
        return((">i"):unpack(file.read(4)))
    elseif typ == 4 then
        return((">l"):unpack(file.read(8)))
    elseif typ == 5 then
        return((">f"):unpack(file.read(4)))
    elseif typ == 6 then
        return((">d"):unpack(file.read(8)))
    elseif typ == 7 then
        local length = (">i"):unpack(file.read(4))
        local tab = {}
        for i = 1, length do
            tab[i] = ((">b"):unpack(file.read(1)))
        end
        return(tab)
    elseif typ == 8 then
        local length = (">H"):unpack(file.read(2))
        local str = file.read(length):gsub("\xC0\x80", "\0")
        local resstring = ""
        for _, code in utf8.codes(str) do
            if code < 256 then 
                resstring = resstring..string.char(code) 
                
            else
                resstring = resstring.."?"
            end
        end
        return resstring
    elseif typ == 9 then
        local t = file.read() 
        local length = (">i"):unpack(file.read(4))
        local tab = {}
        for i = 1, length do
            tab[i] = readNBTData(file, t)
        end
        return(tab)
    elseif typ==10 then 
        local tab = {}
        while true do
            local t = file.read()
            if not t or t == 0 then break end
            local nameLength = (">h"):unpack(file.read(2))
            local name = file.read(nameLength)
            tab[name] = readNBTData(file, t)
        end
        return tab
    elseif typ == 11 then 
        local length = (">i"):unpack(file.read(4))
        local tab = {}
        for i = 1, length do
            tab[i] = readNBTData(file, (">i"):unpack(file.read(4)))
        end
        return(tab)
    elseif typ == 12 then 
        local length = (">i"):unpack(file.read(4))
        local tab = {}
        for i = 1, length do
            tab[i] = readNBTData(file, (">i"):unpack(file.read(4)))
        end
        return(tab)
    else error("Invalid tag type " .. typ .. "!", 2) end

 end
