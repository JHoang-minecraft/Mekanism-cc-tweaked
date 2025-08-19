local reactor = peripheral.find("fissionReactor")

local function loading()
    term.clear()
    local dots = {[1]="", [2]=".", [3]="..", [4]="..."}
    for i=1,4 do
        term.setCursorPos(1,1)
        term.write("LOADING SYSTEM"..dots[i])
        sleep(0.15)
    end
end

local function install()
    if fs.exists("startup") then
        print("ALREADY INSTALLED!")
        return false
    end
    
    shell.run("wget https://raw.githubusercontent.com/.../mek-control.lua startup")
    print("INSTALLED! RESTART TO USE")
    return true
end

local function uninstall()
    if not fs.exists("startup") then
        print("NOT INSTALLED!")
        return false
    end
    
    fs.delete("startup")
    print("UNINSTALLED! GOODBYE")
    return true
end

local function control()
    while true do
        term.clear()
        print("MEK-CONTROL v3.0")
        print("1.TOGGLE REACTOR")
        print("2.EMERGENCY STOP")
        print("3.STATUS")
        print("9.UNINSTALL")
        print("0.EXIT")
        write(">")

        local c = read()
        if c == "1" then
            reactor.setActive(not reactor.isActivated())
        elseif c == "2" then
            reactor.setActive(false)
            print("FORCED SHUTDOWN!")
            sleep(1)
        elseif c == "3" then
            print("TEMP:",reactor.getTemperature(),"K")
            print("FUEL:",reactor.getFuel())
            sleep(2)
        elseif c == "9" then
            uninstall()
            break
        elseif c == "0" then
            break
        end
    end
end

loading()
if not fs.exists("startup") then
    print("FIRST RUN: INSTALL? (y/n)")
    write(">")
    if read() == "y" then install() end
else
    control()
end
