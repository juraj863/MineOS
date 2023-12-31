-- SPDX-FileCopyrightText: 2017 Daniel Ratcliffe
--
-- SPDX-License-Identifier: LicenseRef-CCPL

local tArgs = { ... }
if #tArgs < 1 then
    print("Usage: cd <path>")
    return
end

local sNewDir = shell.resolve(tArgs[1])
if fs.isDir(sNewDir) then
    shell.setDir(sNewDir)
else
    printError("Not a directory")
    return
end