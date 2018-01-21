Panel_AgreementGuild:SetShow(false, false)
Panel_AgreementGuild:RegisterShowEventFunc(true, "AgreementGuildShowAni()")
Panel_AgreementGuild:RegisterShowEventFunc(false, "AgreementGuildHideAni()")
Panel_AgreementGuild:SetDragAll(true)
local UIMode = Defines.UIMode
local IM = CppEnums.EProcessorInputMode
local AgreementGuild = {
  BTN_Confirm = UI.getChildControl(Panel_AgreementGuild, "Button_Confirm"),
  BTN_Refuse = UI.getChildControl(Panel_AgreementGuild, "Button_Refuse"),
  AgreementNotify = UI.getChildControl(Panel_AgreementGuild, "StaticText_AgreementNotify"),
  Content = UI.getChildControl(Panel_AgreementGuild, "StaticText_AgreementContent"),
  ContentTitle = UI.getChildControl(Panel_AgreementGuild, "StaticText_AgreementContentTitle"),
  SummaryTitle = UI.getChildControl(Panel_AgreementGuild, "StaticText_AgreementSummaryTitle"),
  SummaryFocusBG = UI.getChildControl(Panel_AgreementGuild, "Static_AgreementSummaryFocusBG"),
  DailyPayment = UI.getChildControl(Panel_AgreementGuild, "StaticText_DailyPayment"),
  Period = UI.getChildControl(Panel_AgreementGuild, "StaticText_Period"),
  PenaltyCost = UI.getChildControl(Panel_AgreementGuild, "StaticText_PenaltyCost"),
  From = UI.getChildControl(Panel_AgreementGuild, "StaticText_From"),
  To = UI.getChildControl(Panel_AgreementGuild, "StaticText_To"),
  InPutPlayerName = UI.getChildControl(Panel_AgreementGuild, "Edit_PlayerName"),
  GuildMark_Wax = UI.getChildControl(Panel_AgreementGuild, "Static_Wax"),
  GuildMark = UI.getChildControl(Panel_AgreementGuild, "Static_GuildMark"),
  _frame = UI.getChildControl(Panel_AgreementGuild, "Frame_1")
}
_frame_Content = UI.getChildControl(AgreementGuild._frame, "Frame_1_Content")
_frame_Summary = UI.getChildControl(_frame_Content, "StaticText_1")
function AgreementGuildShowAni()
end
function AgreementGuildHideAni()
end
local _inviteGuildName = ""
local _inviteGuildMasterFamilyName = ""
local _inviteGuildMasterCharacterName = ""
local _dailyPayment = 0
local _period = 0
local _penaltyCost = 0
local _s64_guildNo = 0
function AgreementGuild:Initialize()
  self.Content:SetIgnore(true)
  self.ContentTitle:SetIgnore(true)
  self.SummaryTitle:SetIgnore(true)
  self.SummaryFocusBG:SetIgnore(true)
  self.DailyPayment:SetIgnore(true)
  self.Period:SetIgnore(true)
  self.PenaltyCost:SetIgnore(true)
  self.From:SetIgnore(true)
  self.To:SetIgnore(true)
  self.Content:SetAutoResize(true)
  self.Content:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
  _frame_Summary:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
  _frame_Summary:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_3"))
  _frame_Content:SetSize(_frame_Content:GetSizeX(), _frame_Summary:GetTextSizeY())
  self._frame:UpdateContentPos()
  if _frame_Content:GetSizeY() < self._frame:GetSizeY() then
    self._frame:GetVScroll():SetShow(false)
  else
    self._frame:GetVScroll():SetShow(true)
  end
end
local _signCheck = false
local _isJoin = false
function AgreementGuild:SetPosition()
  local scrSizeX = getScreenSizeX()
  local scrSizeY = getScreenSizeY()
  local panelSizeX = Panel_AgreementGuild:GetSizeX()
  local panelSizeY = Panel_AgreementGuild:GetSizeY()
  Panel_AgreementGuild:SetPosX(scrSizeX / 2 - panelSizeX / 2)
  Panel_AgreementGuild:SetPosY(scrSizeY / 2 - panelSizeY / 2)
end
function AgreementGuild:Update()
  local inviteGuildName = _inviteGuildName
  local inviteGuildMasterFamilyName = _inviteGuildMasterFamilyName
  local inviteGuildMasterCharacterName = _inviteGuildMasterCharacterName
  local period = _period
  local dailyPayment = _dailyPayment
  local penaltyCost = _penaltyCost
  self.AgreementNotify:SetText("[" .. inviteGuildName .. "] " .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_1"))
  self.ContentTitle:SetText("[" .. inviteGuildName .. "] " .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_2"))
  self.Content:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_3"))
  self.Content:SetShow(false)
  self.DailyPayment:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_DAILYPAYMENT", "dailyPayment", dailyPayment))
  self.Period:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_PERIOD", "period", period))
  self.PenaltyCost:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_PENALTYCOST", "penaltyCost", penaltyCost))
  self.From:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_FROM", "inviteGuildMasterFamilyName", inviteGuildMasterFamilyName, "inviteGuildMasterCharacterName", inviteGuildMasterCharacterName))
  local isSet = setGuildTextureByGuildNo(_s64_guildNo, self.GuildMark)
  if false == isSet then
    self.GuildMark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self.GuildMark, 183, 1, 188, 6)
    self.GuildMark:getBaseTexture():setUV(x1, y1, x2, y2)
    self.GuildMark:setRenderTexture(self.GuildMark:getBaseTexture())
  else
    self.GuildMark:getBaseTexture():setUV(0, 0, 1, 1)
    self.GuildMark:setRenderTexture(self.GuildMark:getBaseTexture())
  end
  local myNick = getSelfPlayer():getUserNickname()
  self.To:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_TO_DETAIL", "myName", myNick))
end
function FGlobal_AgreementGuild_Open(isJoin, hostUsername, hostname, guildName, period, benefit, penalty, s64_guildNo)
  local self = AgreementGuild
  _s64_guildNo = s64_guildNo
  if getSelfPlayer():get():isGuildMaster() then
    return
  end
  _isJoin = isJoin
  _inviteGuildName = guildName
  _inviteGuildMasterFamilyName = hostUsername
  _inviteGuildMasterCharacterName = hostname
  _period = period
  _dailyPayment = benefit
  _penaltyCost = penalty
  signCheck = false
  self.To:SetText("")
  self:Update()
  self:SetPosition()
  Panel_AgreementGuild:SetShow(true, true)
end
function FGlobal_AgreementGuild_Close()
  if not Panel_AgreementGuild:GetShow() then
    return
  end
  Panel_AgreementGuild:SetShow(false, false)
  ClearFocusEdit()
  CheckChattingInput()
end
function HandleClicked_AgreementGuild_Close()
  FGlobal_AgreementGuild_Close()
end
function HandleClicked_AgreementGuild_Confirm()
  _AgreementGuild_Confirm()
end
function FGlobal_AgreementGuild_Confirm()
  _AgreementGuild_Confirm()
end
function _AgreementGuild_Confirm()
  local self = AgreementGuild
  local inputName = getSelfPlayer():getUserNickname()
  if _isJoin then
    ToClient_RequestAcceptGuildInvite()
  else
    ToClient_RenewGuildContract(true)
  end
  FGlobal_AgreementGuild_Close()
end
function HandleClicked_AgreementGuild_Refuse()
  _AgreementGuild_Refuse()
end
function FGlobal_AgreementGuild_Refuse()
  _AgreementGuild_Refuse()
end
function _AgreementGuild_Refuse()
  if _isJoin then
    ToClient_RequestRefuseGuildInvite()
  else
    ToClient_RenewGuildContract(false)
  end
  FGlobal_AgreementGuild_Close()
end
function AgreementGuild:registEventHandler()
  self.BTN_Confirm:addInputEvent("Mouse_LUp", "HandleClicked_AgreementGuild_Confirm()")
  self.BTN_Refuse:addInputEvent("Mouse_LUp", "HandleClicked_AgreementGuild_Refuse()")
end
function AgreementGuild:registMessageHandler()
end
AgreementGuild:Initialize()
AgreementGuild:registEventHandler()
