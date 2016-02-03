local localPlayer = getLocalPlayer()
local playerName = getPlayerName(localPlayer)
local sx,sy = guiGetScreenSize()

function createLoginWindow(title, logo, content)
        loginwindow = guiCreateWindow(301, 173, 826, 440, "Left 4 Dead: Login Panel", false)
        guiWindowSetSizable(loginwindow, false)
        guiSetAlpha(loginwindow, 1.00)

        image = guiCreateStaticImage(12, 28, 776, 181, "images/l4t.png", false, loginwindow)
        username_edit = guiCreateEdit(296, 243, 205, 29, "", false, loginwindow)
        password_edit = guiCreateEdit(296, 307, 205, 30, "", false, loginwindow)
        usernamelabel = guiCreateLabel(369, 219, 63, 14, "Username", false, loginwindow)
        guiSetFont(usernamelabel, "default-bold-small")
        passwordlabel = guiCreateLabel(369, 282, 57, 15, "Password", false, loginwindow)
        guiSetFont(passwordlabel, "default-bold-small")
        loginbtn = guiCreateButton(296, 357, 91, 30, "Login", false, loginwindow)
        registerbtn = guiCreateButton(410, 356, 91, 31, "Register", false, loginwindow)    
        guiSetVisible(loginwindow, false) 
        guiEditSetMasked ( password_edit, true )
	addEventHandler("onClientGUIClick", loginbtn, clientSubmitLogin, false)
	addEventHandler("onClientGUIClick", registerbtn, clientSubmitRegister, false)
        setPlayerHudComponentVisible ( "radar", false )
    end



function hideLoginWindow()
	guiSetInputEnabled(false)
	guiSetVisible(loginwindow, false)
	showCursor(false)
	removeEventHandler("onClientRender", root, loginGUILine )
end


function resourceStart()
	createLoginWindow()
	if (loginwindow ~= nil) then
		guiSetVisible(loginwindow, true)
	else
		outputChatBox("An error has occurred.")
	end
	showCursor(true)
	guiSetInputEnabled(true)
end


function unknownError()
	outputChatBox("an unknown error occurred!", 255, 0, 0, false )
end

function loginWrong()
	outputChatBox("Wrong Username or Password!", 255, 0, 0, false )
end

function registerTaken()
outputChatBox("Username already in use!", 255, 0, 0, false )
end



function clientSubmitLogin(button, state)
	if button == "left" and state == "up" then
		local username = guiGetText(username_edit)
		local password = guiGetText(password_edit)
		if username and password then
			triggerServerEvent("submitLogin", getRootElement(), localPlayer, username, password)

		else
			outputChatBox("Enter a Username and Password!", 255, 0, 0, false )
		end
	end
end


function clientSubmitRegister(button, state)
if button == "left" and state == "up" then
		local username = guiGetText(username_edit)
		local password = guiGetText(password_edit)
	if username and password then
			triggerServerEvent("submitRegister", getRootElement(), localPlayer, username, password)
		else
			--	guiSetText(labelRegister, "User/pass in use.")
		end
	end
end

addEvent("logOutOp", true) 
addEvent("hidePasswordWindow", true) 
addEvent("hideLoginWindow1", true)
addEvent("hideLoginWindow", true)
addEvent("unknownError", true)
addEvent("loginWrong", true)
addEvent("registerTaken", true)

addEventHandler("hideLoginWindow1", getRootElement(), hideLoginWindow)
addEventHandler("hideLoginWindow", getRootElement(), hideLoginWindow)

addEventHandler("unknownError", getRootElement(), unknownError)
addEventHandler("loginWrong", getRootElement(), loginWrong)
addEventHandler("registerTaken", getRootElement(), registerTaken)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), resourceStart)

