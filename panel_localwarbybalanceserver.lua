Panel_LocalwarByBalanceServer:SetShow(false)
local localwarWidget = UI.getChildControl(Panel_LocalwarByBalanceServer, "Static_LocalWar")
local txt_LocalwarIcon = UI.getChildControl(localwarWidget, "StaticText_1")
function PaGlobal_Panel_LocalwarByBalanceServer_Init()
  txt_LocalwarIcon:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_LOCALWAR_INFO"))
  localwarWidget:addInputEvent("Mouse_LUp", "PaGlobal_Panel_LocalwarByBalanceServer_ClickMessage()")
  localwarWidget:SetVertexAniRun("Ani_Color_Reset", true)
  Panel_LocalwarByBalanceServer:SetPosX(getScreenSizeX() - Panel_Radar:GetSizeX() - Panel_Radar:GetSizeX() / 2)
  Panel_LocalwarByBalanceServer:SetPosY(Panel_Radar:GetPosY() + Panel_Radar:GetSizeY() / 2)
end
function PaGlobal_Panel_LocalwarByBalanceServer_ClickMessage()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CURRENTCHANNELJOIN")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = PaGlobal_Panel_LocalwarByBalanceServer_Click,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Panel_LocalwarByBalanceServer_Click()
  audioPostEvent_SystemUi(1, 6)
  local playerWrapper = getSelfPlayer()
  local player = playerWrapper:get()
  local hp = player:getHp()
  local maxHp = player:getMaxHp()
  local isGameMaster = ToClient_SelfPlayerIsGM()
  if 0 == ToClient_GetMyTeamNoLocalWar() then
    if hp == maxHp or isGameMaster then
      ToClient_JoinLocalWar()
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_MAXHP_CHECK"))
    end
  elseif hp == maxHp or isGameMaster then
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_MAXHP_CHECK"))
  end
end
function PaGlobal_Panel_LocalwarByBalanceServer_Position()
  Panel_LocalwarByBalanceServer:SetPosX(getScreenSizeX() - Panel_Radar:GetSizeX() - Panel_Radar:GetSizeX() / 2)
  Panel_LocalwarByBalanceServer:SetPosY(Panel_Radar:GetPosY() + Panel_Radar:GetSizeY() / 2)
end
function PaGlobal_Panel_LocalwarByBalanceServer_Open()
  local curChannelData = getCurrentChannelServerData()
  local isBalanceServer = curChannelData._isBalanceChannel
  if true == isBalanceServer then
    if 0 == ToClient_GetMyTeamNoLocalWar() then
      Panel_LocalwarByBalanceServer:SetShow(true)
    else
      Panel_LocalwarByBalanceServer:SetShow(false)
    end
  else
    Panel_LocalwarByBalanceServer:SetShow(false)
  end
end
PaGlobal_Panel_LocalwarByBalanceServer_Init()
PaGlobal_Panel_LocalwarByBalanceServer_Open()
registerEvent("onScreenResize", "PaGlobal_Panel_LocalwarByBalanceServer_Position")
