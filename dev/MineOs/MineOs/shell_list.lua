local completion = require "cc.shell.completion"
local function get_keys(t)
    local keys={}
    for key,_ in pairs(t) do
      table.insert(keys, key)
    end
    return keys
end
-- Setup paths
local sPath = ".:/MineOs/programs:/programs:/rom/programs/http"
if turtle then
    sPath = sPath .. ":/rom/programs/turtle"
else
    sPath = sPath .. ":/rom/programs/rednet:/rom/programs/fun"
    if term.isColor() then
        sPath = sPath .. ":/rom/programs/fun/advanced"
    end
end
if pocket then
    sPath = sPath .. ":/rom/programs/pocket"
end
if commands then
    sPath = sPath .. ":/rom/programs/command"
end
shell.setPath(sPath)
help.setPath("/rom/help")
local OsDir = "MineOs"
os.loadAPI("MineOs/lib.lua")
--FIX
shell.setAlias("ls","list")
shell.setAlias("dir","list")
shell.setAlias("sh","shell")
shell.setAlias("rm","delete")
shell.setAlias("g","/rom/programs/shell.lua")
shell.setCompletionFunction("MineOs/programs/shell.lua", completion.build({ completion.programWithArgs, 2, many = true }))
shell.setCompletionFunction("MineOs/programs/delete.lua", completion.build({ completion.dirOrFile, many = true }))
shell.setCompletionFunction("MineOs/programs/cd.lua", completion.build(completion.dir))
shell.setCompletionFunction("MineOs/programs/list.lua", completion.build(completion.dir))
shell.setCompletionFunction("MineOs/programs/lib.lua", completion.build({ completion.choice, { "install ", "compile ", "url "} }))
shell.setCompletionFunction("printer.lua", completion.build({ completion.choice, { "print", "pastebin" } }))
-- Setup aliases
shell.setAlias("cp", "copy")
shell.setAlias("mv", "move")
shell.setAlias("clr", "clear")
shell.setAlias("rs", "redstone")

-- Setup completion functions


shell.setCompletionFunction("MineOs/programs/alias.lua", completion.build(nil, completion.program))
shell.setCompletionFunction("MineOs/programs/clear.lua", completion.build({ completion.choice, { "screen", "palette", "all" } }))
shell.setCompletionFunction("MineOs/programs/copy.lua", completion.build(
    { completion.dirOrFile, true },
    completion.dirOrFile
))
shell.setCompletionFunction("MineOs/programs/drive.lua", completion.build(completion.dir))
shell.setCompletionFunction("MineOs/programs/edit.lua", completion.build(completion.file))
shell.setCompletionFunction("MineOs/programs/eject.lua", completion.build(completion.peripheral))
shell.setCompletionFunction("MineOs/programs/gps.lua", completion.build({ completion.choice, { "host", "host ", "locate" } }))
shell.setCompletionFunction("MineOs/programs/help.lua", completion.build(completion.help))
shell.setCompletionFunction("MineOs/programs/id.lua", completion.build(completion.peripheral))
shell.setCompletionFunction("MineOs/programs/label.lua", completion.build(
    { completion.choice, { "get", "get ", "set ", "clear", "clear " } },
    completion.peripheral
))
shell.setCompletionFunction("MineOs/programs/mkdir.lua", completion.build({ completion.dir, many = true }))

local complete_monitor_extra = { "scale" }
shell.setCompletionFunction("MineOs/programs/monitor.lua", completion.build(
    function(shell, text, previous)
        local choices = completion.peripheral(shell, text, previous, true)
        for _, option in pairs(completion.choice(shell, text, previous, complete_monitor_extra, true)) do
            choices[#choices + 1] = option
        end
        return choices
    end,
    function(shell, text, previous)
        if previous[2] == "scale" then
            return completion.peripheral(shell, text, previous, true)
        else
            return completion.programWithArgs(shell, text, previous, 3)
        end
    end,
    {
        function(shell, text, previous)
            if previous[2] ~= "scale" then
                return completion.programWithArgs(shell, text, previous, 3)
            end
        end,
        many = true,
    }
))

shell.setCompletionFunction("MineOs/programs/move.lua", completion.build(
    { completion.dirOrFile, true },
    completion.dirOrFile
))
shell.setCompletionFunction("MineOs/programs/redstone.lua", completion.build(
    { completion.choice, { "probe", "set ", "pulse " } },
    completion.side
))
shell.setCompletionFunction("MineOs/programs/rename.lua", completion.build(
    { completion.dirOrFile, true },
    completion.dirOrFile
))
shell.setCompletionFunction("MineOs/programs/type.lua", completion.build(completion.dirOrFile))
--shell.setCompletionFunction("MineOs/programs/set.lua", completion.build({ completion.setting, true }))
shell.setCompletionFunction("MineOs/programs/advanced/bg.lua", completion.build({ completion.programWithArgs, 2, many = true }))
shell.setCompletionFunction("MineOs/programs/advanced/fg.lua", completion.build({ completion.programWithArgs, 2, many = true }))
shell.setCompletionFunction("MineOs/programs/fun/dj.lua", completion.build(
    { completion.choice, { "play", "play ", "stop " } },
    completion.peripheral
))
shell.setCompletionFunction("MineOs/programs/fun/speaker.lua", completion.build(
    { completion.choice, { "play ", "stop " } },
    function(shell, text, previous)
        if previous[2] == "play" then return completion.file(shell, text, previous, true)
        elseif previous[2] == "stop" then return completion.peripheral(shell, text, previous, false)
        end
    end,
    function(shell, text, previous)
        if previous[2] == "play" then return completion.peripheral(shell, text, previous, false)
        end
    end
))
shell.setCompletionFunction("MineOs/programs/fun/advanced/paint.lua", completion.build(completion.file))
shell.setCompletionFunction("MineOs/programs/http/pastebin.lua", completion.build(
    { completion.choice, { "put ", "get ", "run " } },
    completePastebinPut
))
shell.setCompletionFunction("MineOs/programs/rednet/chat.lua", completion.build({ completion.choice, { "host ", "join " } }))
shell.setCompletionFunction("MineOs/programs/command/exec.lua", completion.build(completion.command))
shell.setCompletionFunction("MineOs/programs/http/wget.lua", completion.build({ completion.choice, { "run " } }))

if turtle then
    shell.setCompletionFunction("MineOs/programs/turtle/go.lua", completion.build(
        { completion.choice, { "left", "right", "forward", "back", "down", "up" }, true, many = true }
    ))
    shell.setCompletionFunction("MineOs/programs/turtle/turn.lua", completion.build(
        { completion.choice, { "left", "right" }, true, many = true }
    ))
    shell.setCompletionFunction("MineOs/programs/turtle/equip.lua", completion.build(
        nil,
        { completion.choice, { "left", "right" } }
    ))
    shell.setCompletionFunction("MineOs/programs/turtle/unequip.lua", completion.build(
        { completion.choice, { "left", "right" } }
    ))
end



-- Show MOTD
settings.clear()
settings.load("/MineOs/Boot.dat")
if settings.get("Data")[2].State then
    shell.run("motd")
end
settings.clear()
local nativeReadOnly = fs.isReadOnly
fs.isReadOnly = function (path)
    if not shell.isPathBlocked(path) then
        return nativeReadOnly(path)
    else
        return nativeReadOnly(path)
    end
end
local nativeOpen = fs.open
fs.open = function (path, mode, code)
    if code then
        if code == "Update" then
            return nativeOpen(path, mode)
        elseif code == "dev" then
            return nativeOpen
        end
    else
        if mode == "r" then
            if shell.isReadeble(path) then
                return nativeOpen(path, "r")
            else
                error("This File cannot be read :"..path,0)
            end
        elseif mode == "w" then
            if shell.isPathBlocked(path) then
                print("ok") sleep(1)
                return nativeOpen(path, "w")
            else
                error("This File cannot be write :"..path,0)
            end
        elseif mode == "a" then
            if shell.isPathBlocked(path) then
                return nativeOpen(path, "a")
            else
                error("This File cannot be write :"..path,0)
            end
        else
            error("Error unknown mode",0)
        end
    end
end
local nativeDelete = fs.delete
fs.delete = function (path, code)
    if code then
        if code == "Update" then
            return nativeDelete(path)
        end
    else
        if shell.isReadeble(path) and shell.isPathBlocked(path) then
            return nativeDelete(path)
        else
            error("This File cannot be deleted :"..path,0)
        end
    end
end
local nativeCopy = fs.copy
fs.copy = function (path, dest, code)
    if code then
        if code == "Update" then
            return nativeCopy(path, dest)
        end
    else
        if shell.isReadeble(path) and shell.isPathBlocked(path) then
            return nativeCopy(path, dest)
        else
            error("This File cannot be copy :"..path,0)
        end
    end
end
local nativeMove = fs.move
fs.move = function (path, dest)
    if code then
        if code == "Update" then
            return nativeMove(path)
        end
    else
        if shell.isReadeble(path) and shell.isPathBlocked(path) then
            return nativeMove(path)
        else
            error("This File cannot be moved :"..path,0)
        end
    end
end
settings.clear()
settings.load("/MineOs/Boot.dat")
if settings.get("Data")[1].State and settings.get("Boot") ~= "" then
    term.clear()
    term.setCursorPos(1,1)
    shell.run(settings.get("Boot"))
end