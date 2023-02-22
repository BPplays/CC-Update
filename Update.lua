--Version 7.1
function update(tempargs_base)

    local done_file = false
    local done_try_update = false
    local function update_internal(tempargs)
        updateloop = 0
        --local tempargs = {...} 
        local updateargs = tempargs
        --udlstbl = {"updateprogram", "pastelink", "udloc", "startupls", "strtprg"}
        os.loadAPI("AndysPrograms/api/git/git")

        local updateprogram = updateargs[5]
        local pastelink = updateargs[2]
        local udloc = updateargs[6]
        local startupls = updateargs[4]
        local strtprg = updateargs[5]
        local repo = updateargs[2]
        -- os.loadAPI("AndysPrograms/api/pastebin_silent/ps")
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
            while done_try_update == false do
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
                    -- ps.get({pastelink,updateprogram.."new",udloc})
                    if git.get(updateargs) then
                    else
                        -- print("wrong git: "..table.concat(updateargs,", "))
                    end
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
                            done_file = true
                            done_try_update = true
                            break
                        end
                    end
                    if fs.exists(udloc.."/"..updateprogram) then
                        if updateloop > 20 then
                            done_file = true
                            done_try_update = true
                            break
                        end
                    end
                    if fs.exists(udloc.."/"..updateprogram.."old") then
                        if updateloop > 30 then
                            --shell.run("rename",updateprogram.."old",updateprogram)
                            fs.move(udloc.."/"..updateprogram.."old",udloc.."/"..updateprogram)
                            if fs.exists(udloc.."/"..updateprogram) then
                                done_file = true
                                done_try_update = true
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
                -- if startupls ~= "none" and startupls ~= nil then
                --     local stu = fs.open("startup.lua", "w")
                --     stu.write(startupls)
                --     stu.close()
                -- end
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
    end
    local epoch_mul = 72000
    local prev_time = os.epoch() - 99999
    local timeout_time_base = 15
    local timeout_time = timeout_time_base
    local timeout_time_output = timeout_time * epoch_mul
    local function run_update()
        update_internal(tempargs_base)
    end
    local function timeout_check()
        while os.epoch() < prev_time + timeout_time_output do
            sleep(0.2)
            if done_file == true then
                break
            end
        end
        done_try_update = true
    end
    local loops = 1
    while done_file == false do
        prev_time = os.epoch()
        timeout_time_output = timeout_time * epoch_mul
        done_try_update = false
        parallel.waitForAny(run_update,timeout_check)
        loops = loops + 1
        if loops <= 5 then
            timeout_time = timeout_time_base * loops
        else
            -- print("TimeOut")
        end
        if done_file == true then
            break
        end
    end


end