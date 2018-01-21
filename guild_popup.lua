Panel_CreateGuild:SetShow(false)
Panel_CreateClan:SetShow(false, false)
Panel_CreateClan:RegisterShowEventFunc(true, "CreateClanShowAni()")
Panel_CreateClan:RegisterShowEventFunc(false, "CreateClanHideAni()")
Panel_CreateClan:setGlassBackground(true)
Panel_ClanToGuild:SetShow(false, false)
Panel_ClanToGuild:RegisterShowEventFunc(true, "ClanToGuildShowAni()")
Panel_ClanToGuild:RegisterShowEventFunc(false, "ClanToGuildHideAni()")
Panel_ClanToGuild:setGlassBackground(true)
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local UI_TM = CppEnums.TextMode
local IM = CppEnums.EProcessorInputMode
local CreateClan = {
  selectedClan = UI.getChildControl(Panel_CreateClan, "RadioButton_Clan"),
  selectedGuild = UI.getChildControl(Panel_CreateClan, "RadioButton_Guild"),
  create = UI.getChildControl(Panel_CreateClan, "Button_Confirm"),
  createDescBG = UI.getChildControl(Panel_CreateClan, "Static_CreateClanDescBG"),
  guideMainBaseBG = UI.getChildControl(Panel_CreateClan, "Static_BaseBG"),
  guideMainBG = UI.getChildControl(Panel_CreateClan, "Static_SelectedTypeDescBG"),
  guideTitle = UI.getChildControl(Panel_CreateClan, "StaticText_SelectedTypeTitle"),
  guideDesc = UI.getChildControl(Panel_CreateClan, "StaticText_SelectedTypeDesc"),
  help = UI.getChildControl(Panel_CreateClan, "Button_Question"),
  close = UI.getChildControl(Panel_CreateClan, "Button_Win_Close")
}
local ClanToGuild = {
  convert = UI.getChildControl(Panel_ClanToGuild, "Button_Convert"),
  help = UI.getChildControl(Panel_ClanToGuild, "Button_Question"),
  close = UI.getChildControl(Panel_ClanToGuild, "Button_Win_Close")
}
function CreateClanShowAni()
end
function CreateClanHideAni()
end
function ClanToGuildShowAni()
end
function ClanToGuildHideAni()
end
local GuildCreateManager = {
  _createGuildBG = UI.getChildControl(Panel_CreateGuild, "Static_BG"),
  _buttonApply = UI.getChildControl(Panel_CreateGuild, "Button_Confirm"),
  _buttonCancel = UI.getChildControl(Panel_CreateGuild, "Button_Cancel"),
  _editGuildNameInput = UI.getChildControl(Panel_CreateGuild, "Edit_GuildName"),
  _txt_NameDesc = UI.getChildControl(Panel_CreateGuild, "StaticText_NameDesc"),
  _staticCreateServantNameBG = UI.getChildControl(Panel_CreateGuild, "Static_NamingPolicyBG"),
  _staticCreateServantNameTitle = UI.getChildControl(Panel_CreateGuild, "StaticText_NamingPolicyTitle"),
  _staticCreateServantName = UI.getChildControl(Panel_CreateGuild, "StaticText_NamingPolicy")
}
function GuildCreateManager:initialize()
  GuildCreateManager._buttonApply:addInputEvent("Mouse_LUp", "handleClicked_GuildCreateApply()")
  GuildCreateManager._buttonCancel:addInputEvent("Mouse_LUp", "handleClicked_GuildCreateCancel()")
  GuildCreateManager._editGuildNameInput:RegistReturnKeyEvent("handleClicked_GuildCreateApply()")
  if isGameTypeEnglish() or isGameTypeTaiwan() or isGameTypeTR() or isGameTypeTH() or isGameTypeID() then
    GuildCreateManager._staticCreateServantName:SetTextMode(UI_TM.eTextMode_AutoWrap)
    GuildCreateManager._staticCreateServantName:SetShow(true)
    GuildCreateManager._staticCreateServantNameBG:SetShow(true)
    GuildCreateManager._staticCreateServantNameTitle:SetShow(true)
  else
    GuildCreateManager._staticCreateServantName:SetShow(false)
    GuildCreateManager._staticCreateServantNameBG:SetShow(false)
    GuildCreateManager._staticCreateServantNameTitle:SetShow(false)
  end
  if isGameTypeEnglish() or isGameTypeTaiwan() then
    GuildCreateManager._staticCreateServantName:SetText(PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_EN"))
  elseif isGameTypeTR() then
    GuildCreateManager._staticCreateServantName:SetText(PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_TR"))
  elseif isGameTypeTH() then
    GuildCreateManager._staticCreateServantName:SetText(PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_TH"))
  elseif isGameTypeID() then
    GuildCreateManager._staticCreateServantName:SetText(PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_ID"))
  end
end
function CreateClan:initialize()
  self.guideDesc:SetTextMode(UI_TM.eTextMode_AutoWrap)
  self.guideTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CREATECLAN_GUIDETITLE_CLAN"))
  self.guideDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CREATECLAN_GUIDEDESC_CLAN"))
  if isGameTypeEnglish() or isGameTypeTaiwan() or isGameTypeTR() or isGameTypeTH() or isGameTypeID() then
    GuildCreateManager._staticCreateServantName:SetTextMode(UI_TM.eTextMode_AutoWrap)
    GuildCreateManager._staticCreateServantName:SetShow(true)
    GuildCreateManager._staticCreateServantNameBG:SetShow(true)
    GuildCreateManager._staticCreateServantNameTitle:SetShow(true)
  else
    GuildCreateManager._staticCreateServantName:SetShow(false)
    GuildCreateManager._staticCreateServantNameBG:SetShow(false)
    GuildCreateManager._staticCreateServantNameTitle:SetShow(false)
  end
  if isGameTypeEnglish() or isGameTypeTaiwan() then
    GuildCreateManager._staticCreateServantName:SetText(PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_EN"))
  elseif isGameTypeTR() then
    GuildCreateManager._staticCreateServantName:SetText(PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_TR"))
  elseif isGameTypeTH() then
    GuildCreateManager._staticCreateServantName:SetText(PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_TH"))
  elseif isGameTypeID() then
    GuildCreateManager._staticCreateServantName:SetText(PAGetString(Defines.StringSheet_GAME, "COMMON_CHARACTERCREATEPOLICY_ID"))
  end
end
function FGlobal_CehckedGuildEditUI(uiEdit)
  if nil == uiEdit then
    return false
  end
  return uiEdit:GetKey() == GuildCreateManager._editGuildNameInput:GetKey()
end
function handleClickedShowGuildCreateComment()
  local luaGuildTextGuildCreateMsg = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_CREATE_MSG")
  if GuildCreateManager._buttonCreateGuild:IsChecked() then
    GuildCreateManager._textCommentTitle:SetText(GuildCreateManager._titleGuild)
    GuildCreateManager._textComment:SetTextMode(UI_TM.eTextMode_AutoWrap)
    GuildCreateManager._textComment:SetText(GuildCreateManager._commentGuild)
    GuildCreateManager._textBottomText:SetText(luaGuildTextGuildCreateMsg)
  end
end
function handleClickedGuildCreateCancel()
  Panel_GuildManager:SetShow(false, false)
end
function Guild_PopupCreate(guildGrade)
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  local playerLevel = getSelfPlayer():get():getLevel()
  local function showInputGuildName()
    Panel_CreateGuild:SetShow(true)
    GuildCreateManager._editGuildNameInput:SetEditText("", true)
    GuildCreateManager._editGuildNameInput:SetMaxInput(getGameServiceTypeGuildNameLength())
    SetFocusEdit(GuildCreateManager._editGuildNameInput)
    GuildCreateManager._editGuildNameInput:SetEnable(true)
    GuildCreateManager._editGuildNameInput:SetMonoTone(false)
    GuildCreateManager._txt_NameDesc:SetTextMode(UI_TM.eTextMode_AutoWrap)
    GuildCreateManager._txt_NameDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_POPUP_1"))
    GuildCreateManager._createGuildBG:SetSize(GuildCreateManager._createGuildBG:GetSizeX(), GuildCreateManager._txt_NameDesc:GetTextSizeY() + GuildCreateManager._editGuildNameInput:GetSizeY() + 40)
    Panel_CreateGuild:SetSize(Panel_CreateGuild:GetSizeX(), GuildCreateManager._txt_NameDesc:GetTextSizeY() + GuildCreateManager._editGuildNameInput:GetSizeY() + 140)
    GuildCreateManager._buttonApply:SetSpanSize(GuildCreateManager._buttonApply:GetSpanSize().x, 10)
    GuildCreateManager._buttonCancel:SetSpanSize(GuildCreateManager._buttonCancel:GetSpanSize().x, 10)
    GuildCreateManager._buttonApply:SetText(PAGetString(Defines.StringSheet_RESOURCE, "EXCHANGE_NUMBER_BTN_APPLY"))
    GuildCreateManager._buttonCancel:SetText(PAGetString(Defines.StringSheet_RESOURCE, "EXCHANGE_NUMBER_BTN_CANCEL"))
    GuildCreateManager._staticCreateServantName:ComputePos()
    GuildCreateManager._staticCreateServantNameBG:ComputePos()
    GuildCreateManager._staticCreateServantNameTitle:ComputePos()
  end
  if nil ~= myGuildListInfo then
    local myGuildGrade = myGuildListInfo:getGuildGrade()
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    if 0 == guildGrade then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_ALREADYCLAN_ACK"))
      return
    elseif 1 == guildGrade then
      if 0 ~= myGuildGrade then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_CURRENT_ACK"))
        return
      end
      if not isGuildMaster then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_ONLYGUILDMASTER_ACK"))
        return
      end
      if isGuildMaster and 0 == myGuildGrade then
        local myGuildName = myGuildListInfo:getName()
        ToClient_RequestRaisingGuildGrade(1, 100000)
      end
    end
  elseif 0 == guildGrade then
    showInputGuildName()
  elseif 1 == guildGrade then
    if playerLevel >= 1 then
      showInputGuildName()
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_NOLEVEL_ACK"))
      return
    end
  end
end
function handleClicked_GuildCreateApply()
  if GuildCreateManager._editGuildNameInput:GetEditText() == "" then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_POPUP_ENTER_GUILDNAME"))
    ClearFocusEdit()
    return
  end
  local self = CreateClan
  local isRaisingGuildGrade = false
  local guildGrade = 0
  local guildName = GuildCreateManager._editGuildNameInput:GetEditText()
  local businessFunds = 100000
  if self.selectedClan:IsCheck() then
    guildGrade = 0
  elseif self.selectedGuild:IsCheck() then
    guildGrade = 1
    local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
    if nil ~= myGuildListInfo then
      local myGuildGrade = myGuildListInfo:getGuildGrade()
      if 0 ~= myGuildGrade then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_NOGUILD_NOUPGRADE_ACK"))
        ClearFocusEdit()
        return
      end
      isRaisingGuildGrade = true
    end
  end
  if false == isRaisingGuildGrade then
    ToClient_RequestCreateGuild(guildName, guildGrade, businessFunds)
  else
    ToClient_RequestRaisingGuildGrade(guildGrade, businessFunds)
  end
  Panel_CreateGuild:SetShow(false)
  ClearFocusEdit()
  CreateClan_Close()
end
function handleClicked_GuildCreateCancel()
  CreateClan_Close()
end
function FGlobal_GuildCreateManagerPopup()
  CreateClan_Open()
end
function CreateClan_PressCreate()
  local self = CreateClan
  if self.selectedClan:IsCheck() then
    Guild_PopupCreate(0)
  elseif self.selectedGuild:IsCheck() then
    if getSelfPlayer():get():getLevel() < 1 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_NOLEVEL_ACK"))
      return
    end
    Guild_PopupCreate(1)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_CLANORGUILD_SELECT_ACK"))
  end
end
function CreateClan_SelectGroupType()
  local self = CreateClan
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  local title, desc
  if self.selectedClan:IsCheck() then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_CREATECLAN_GUIDETITLE_CLAN")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CREATECLAN_GUIDEDESC_CLAN")
  elseif self.selectedGuild:IsCheck() then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_CREATECLAN_GUIDETITLE_GUILD")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CREATECLAN_GUIDEDESC_GUILD")
  end
  self.guideTitle:SetText(title)
  self.guideDesc:SetText(desc)
  self.guideMainBaseBG:SetSize(self.guideMainBaseBG:GetSizeX(), self.guideDesc:GetTextSizeY() + self.guideTitle:GetTextSizeY() + self.createDescBG:GetSizeY() + self.selectedClan:GetSizeY() + 100)
  self.guideMainBG:SetSize(self.guideMainBG:GetSizeX(), self.guideDesc:GetTextSizeY() + self.guideTitle:GetTextSizeY() + 20)
  Panel_CreateClan:SetSize(Panel_CreateClan:GetSizeX(), self.guideDesc:GetTextSizeY() + self.guideTitle:GetTextSizeY() + self.selectedClan:GetSizeY() + 260)
  self.create:SetSpanSize(self.create:GetSpanSize().x, 20)
end
function CreateClan_Open()
  local self = CreateClan
  self.selectedClan:SetCheck(true)
  self.selectedGuild:SetCheck(false)
  self.create:SetMonoTone(false)
  self.selectedClan:SetMonoTone(false)
  self.selectedGuild:SetMonoTone(false)
  self.create:SetEnable(true)
  self.selectedClan:SetEnable(true)
  self.selectedGuild:SetEnable(true)
  if false == ToClient_CanMakeGuild() then
    CreateClan.selectedGuild:SetEnable(false)
    CreateClan.selectedGuild:SetMonoTone(true)
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil ~= myGuildListInfo then
    local guildGrade = myGuildListInfo:getGuildGrade()
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    if 0 ~= guildGrade then
      self.selectedClan:SetMonoTone(true)
      self.selectedClan:SetEnable(false)
      self.selectedGuild:SetMonoTone(true)
      self.selectedGuild:SetEnable(false)
      self.create:SetMonoTone(true)
      self.create:SetEnable(false)
    elseif isGuildMaster then
      self.selectedClan:SetCheck(false)
      self.selectedClan:SetMonoTone(true)
      self.selectedClan:SetEnable(false)
      self.selectedGuild:SetCheck(true)
      self.selectedGuild:SetMonoTone(false)
      self.selectedGuild:SetEnable(true)
    else
      self.selectedClan:SetCheck(true)
      self.selectedClan:SetMonoTone(false)
      self.selectedClan:SetEnable(true)
      self.selectedGuild:SetCheck(false)
      self.selectedGuild:SetMonoTone(false)
      self.selectedGuild:SetEnable(true)
    end
  end
  local title = ""
  local desc = ""
  self.guideDesc:SetTextMode(UI_TM.eTextMode_AutoWrap)
  if self.selectedClan:IsCheck() then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_CREATECLAN_GUIDETITLE_CLAN")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CREATECLAN_GUIDEDESC_CLAN")
  else
    title = PAGetString(Defines.StringSheet_GAME, "LUA_CREATECLAN_GUIDETITLE_GUILD")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CREATECLAN_GUIDEDESC_GUILD")
  end
  self.guideTitle:SetText(title)
  self.guideDesc:SetText(desc)
  self.guideMainBaseBG:SetSize(self.guideMainBaseBG:GetSizeX(), self.guideDesc:GetTextSizeY() + self.guideTitle:GetTextSizeY() + self.createDescBG:GetSizeY() + self.selectedClan:GetSizeY() + 100)
  self.guideMainBG:SetSize(self.guideMainBG:GetSizeX(), self.guideDesc:GetTextSizeY() + self.guideTitle:GetTextSizeY() + 20)
  Panel_CreateClan:SetSize(Panel_CreateClan:GetSizeX(), self.guideDesc:GetTextSizeY() + self.guideTitle:GetTextSizeY() + self.selectedClan:GetSizeY() + 260)
  self.create:SetSpanSize(self.create:GetSpanSize().x, 20)
  Panel_CreateClan:SetShow(true)
end
function CreateClan_Close()
  Panel_CreateGuild:SetShow(false)
  Panel_CreateClan:SetShow(false)
  ClearFocusEdit()
end
function CreateClan:registEventHandler()
  self.selectedClan:addInputEvent("Mouse_LUp", "CreateClan_SelectGroupType()")
  self.selectedGuild:addInputEvent("Mouse_LUp", "CreateClan_SelectGroupType()")
  self.create:addInputEvent("Mouse_LUp", "CreateClan_PressCreate()")
  self.close:addInputEvent("Mouse_LUp", "CreateClan_Close()")
  self.help:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelClan\" )")
  self.help:addInputEvent("Mouse_On", "HelpMessageQuestion_Show( \"PanelClan\", \"true\")")
  self.help:addInputEvent("Mouse_Out", "HelpMessageQuestion_Show( \"PanelClan\", \"false\")")
  registerEvent("onScreenResize", "FromClient_CreateGuild_onScreenResize")
end
function CreateClan:registMessageHandler()
end
function GuildTotClan_Convert()
end
function HandleClicked_GuildTotClanClose()
  Panel_ClanToGuild:SetShow(false, false)
end
function FGlobal_GuildTotClanOpen()
  Panel_ClanToGuild:SetShow(true, true)
end
function FGlobal_GuildTotClanClose()
  Panel_ClanToGuild:SetShow(false, false)
end
function ClanToGuild:registEventHandler()
  self.convert:addInputEvent("Mouse_LUp", "GuildTotClan_Convert()")
  self.help:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelClan\" )")
  self.help:addInputEvent("Mouse_On", "HelpMessageQuestion_Show( \"PanelClan\", \"true\")")
  self.help:addInputEvent("Mouse_Out", "HelpMessageQuestion_Show( \"PanelClan\", \"false\")")
  self.close:addInputEvent("Mouse_LUp", "HandleClicked_GuildTotClanClose()")
end
function ClanToGuild:registMessageHandler()
end
function Guild_CreateGuild()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local myGuildGrade = myGuildListInfo:getGuildGrade()
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  if isGuildMaster and 0 == myGuildGrade then
    local strTemp1 = PAGetString(Defines.StringSheet_GAME, "LUA_CREATE_GUILD_MESSAGEBOX_TITLE")
    local strTemp2 = PAGetString(Defines.StringSheet_GAME, "LUA_CREATE_GUILD_MESSAGEBOX_MESSAGE")
    local messageboxData = {
      title = strTemp1,
      content = strTemp2,
      functionYes = Guild_CreateGuild_ConfirmFromMessageBox,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  elseif not isGuildMaster then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_ALREADY_JOIN_CLAN_OR_GUILD"))
    return
  elseif 1 == myGuildGrade then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_NOMORE_UPGRADE"))
    return
  end
end
function Guild_CreateGuild_ConfirmFromMessageBox()
  local guildGrade = 1
  local businessFunds = 300000
  ToClient_RequestRaisingGuildGrade(guildGrade, businessFunds)
  Panel_CreateGuild:SetShow(false)
  CreateClan_Close()
end
function FromClient_CreateGuild_onScreenResize()
  local createClanPosY = (getScreenSizeY() - Panel_Npc_Dialog:GetSizeY()) / 2 - Panel_CreateClan:GetSizeY() / 2
  if createClanPosY < -10 then
    createClanPosY = 0
  end
  Panel_CreateClan:SetPosY(createClanPosY)
end
GuildCreateManager:initialize()
CreateClan:initialize()
CreateClan:registEventHandler()
CreateClan:registMessageHandler()
ClanToGuild:registEventHandler()
ClanToGuild:registMessageHandler()
