--Version 7

updateloop = 0
updateargs = {...} 
--udlstbl = {"updateprogram", "pastelink", "udloc", "startupls", "strtprg"}

updateprogram = updateargs[1]
pastelink = updateargs[2]
udloc = updateargs[3]
startupls = updateargs[4]
strtprg = updateargs[5]
os.loadAPI("AndysPrograms/api/pastebin_silent/ps")
if errhnd ~= 1 then
    function printud()
        -- term.clear()
        -- term.setCursorPos(1,1)
        -- print("Updating...")
    end
    printud()
    local _, countsl = string.gsub(udloc,"/","")
    countslw = countsl + 1
    for i=1,countslw do
        --shell.run("cd", "//")
        --printud()
    end
    --shell.run("cd", "//")
    numprogargs = 6
    if #updateargs > 5 then
        progargs = {}
        for i=numprogargs,#updateargs do
            table.insert(progargs, updateargs[i])
        end
    end
    while true do
        if errhnd ~= 1 then
            if fs.isDir(udloc) == false then
                fs.makeDir(udloc)
            end
            --shell.run("cd", udloc)
            if fs.exists(udloc.."/"..updateprogram.."new") then
                fs.delete(udloc.."/"..updateprogram.."new")
                --shell.run("delete",updateprogram.."new") 
                --printud()
            end
            ps.get({pastelink,updateprogram.."new",udloc})
            --shell.run("AndysPrograms/api/pastebin_silent/ps","get",pastelink,updateprogram.."new")
            printud()
            --print(udloc.."/"..updateprogram.."new")
            if fs.exists(udloc.."/"..updateprogram.."new") then
                if fs.exists(udloc.."/"..updateprogram.."old") then
                    fs.delete(udloc.."/"..updateprogram.."old")
                    --printud()
                end
                if fs.exists(udloc.."/"..updateprogram) then
                    fs.move(udloc.."/"..updateprogram,udloc.."/"..updateprogram.."old")
                    -- shell.run("rename",updateprogram,updateprogram.."old")
                    -- printud()
                end
                -- shell.run("rename",updateprogram.."new",updateprogram)
                fs.move(udloc.."/"..updateprogram.."new",udloc.."/"..updateprogram)
                if fs.exists(udloc.."/"..updateprogram) then
                    break
                end
            end
            if fs.exists(udloc.."/"..updateprogram) then
                if updateloop > 20 then
                    break
                end
            end
            if fs.exists(udloc.."/"..updateprogram.."old") then
                if updateloop > 30 then
                    --shell.run("rename",updateprogram.."old",updateprogram)
                    fs.move(udloc.."/"..updateprogram.."old",udloc.."/"..updateprogram)
                    if fs.exists(udloc.."/"..updateprogram) then
                        break
                    end
                end
            end
            updateloop = updateloop + 1
            sleep(0)
        end
    end
    if errhnd ~= 1 then
        sleep(0)
        countslw = countsl + 1
        for i=1,countslw do
            --shell.run("cd", "..")
            --printud()
        end
        --print(startupls)
        --sleep(10)
        if startupls ~= "none" and startupls ~= nil then
            local stu = fs.open("startup.lua", "w")
            stu.write(startupls)
            stu.close()
        end
        if strtprg == nil and strtprg == "no" and strtprg == "none" then
        else

        --if progargs ~= nil then
        --    shell.run(udloc.."/"..updateprogram.." "..unpack(progargs))
        --else
        --    shell.run(udloc.."/"..updateprogram)
        --end
        end
    end
end