local CT2S = CppEnums.ClassType2String
local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local UCT = CppEnums.PA_UI_CONTROL_TYPE
local UI_TM = CppEnums.TextMode
local IM = CppEnums.EProcessorInputMode
local UI_VT = CppEnums.VehicleType
Panel_Window_Guild:SetShow(false)
Panel_Window_Guild:setMaskingChild(true)
Panel_Window_Guild:setGlassBackground(true)
Panel_Window_Guild:SetDragAll(true)
Panel_Window_Guild:RegisterShowEventFunc(true, "guild_ShowAni()")
Panel_Window_Guild:RegisterShowEventFunc(false, "guild_HideAni()")
local isGuildBattle = ToClient_IsContentsGroupOpen("280")
local isProtectGuildMember = ToClient_IsContentsGroupOpen("52")
local isContentsGuildDuel = ToClient_IsContentsGroupOpen("69") and not isGuildBattle
local isContentsGuildInfo = ToClient_IsContentsGroupOpen("206")
local isContentsArsha = ToClient_IsContentsGroupOpen("227")
local isContentsGuildHouse = ToClient_IsContentsGroupOpen("36")
local isCanDoReservation = ToClient_IsCanDoReservationArsha()
local lifeType = {
  [0] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_GATHERING"),
  [1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_FISHING"),
  [2] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_HUNTING"),
  [3] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_COOKING"),
  [4] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_ALCHEMY"),
  [5] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_PROCESSING"),
  [6] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_OBEDIENCE"),
  [7] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_TRADE"),
  [8] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_GROWTH"),
  [9] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_WEALTH"),
  [10] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_COMBAT")
}
local tabNumber = 99
local btn_GuildMasterMandateBG = UI.getChildControl(Panel_Window_Guild, "Static_GuildMandateBG")
local btn_GuildMasterMandate = UI.getChildControl(Panel_Window_Guild, "Button_GuildMandate")
local notice_title = UI.getChildControl(Panel_Window_Guild, "StaticText_NoticeTitle")
local notice_edit = UI.getChildControl(Panel_Window_Guild, "Edit_Notice")
local notice_btn = UI.getChildControl(Panel_Window_Guild, "Button_Notice")
local promote_btn = UI.getChildControl(Panel_Window_Guild, "Button_Promote")
local introduce_btn = UI.getChildControl(Panel_Window_Guild, "Button_Introduce")
local introduce_Reset = UI.getChildControl(Panel_Window_Guild, "Button_IntroReset")
local introduce_edit = UI.getChildControl(Panel_Window_Guild, "MultilineEdit_Introduce")
local introduce_edit_TW = UI.getChildControl(Panel_Window_Guild, "MultilineEdit_Introduce_TW")
local checkPopUp = UI.getChildControl(Panel_Window_Guild, "CheckButton_PopUp")
local _urlCache = ""
local isPopUpContentsEnable = ToClient_IsContentsGroupOpen("240")
checkPopUp:SetShow(isPopUpContentsEnable)
function guild_ShowAni()
  Panel_Window_Guild:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_Window_Guild, 0, 0.3)
end
function guild_HideAni()
  local ani1 = UIAni.AlphaAnimation(0, Panel_Window_Guild, 0, 0.2)
  ani1:SetHideAtEnd(true)
end
local constCreateWarInfoCount = 4
local keyUseCheck = true
local guildCommentsWebUrl
local GuildInfoPage = {}
function GuildInfoPage:initialize()
  self._guildMainBG = UI.getChildControl(Panel_Window_Guild, "Static_Menu_BG_0")
  self._windowTitle = UI.getChildControl(Panel_Window_Guild, "StaticText_Title")
  self._textGuildInfoTitle = UI.getChildControl(Panel_Window_Guild, "StaticText_Title_Info")
  self._txtGuildName = UI.getChildControl(Panel_Window_Guild, "StaticText_GuildName")
  self._iconOccupyTerritory = UI.getChildControl(Panel_Window_Guild, "Static_GuildIcon_BG")
  self._iconGuildMark = UI.getChildControl(Panel_Window_Guild, "Static_Guild_Icon")
  self._txtMaster = UI.getChildControl(Panel_Window_Guild, "StaticText_Master")
  self._txtRGuildName = UI.getChildControl(Panel_Window_Guild, "StaticText_R_GuildName")
  self._txtRMaster = UI.getChildControl(Panel_Window_Guild, "StaticText_R_Master")
  self._txtRRank_Title = UI.getChildControl(Panel_Window_Guild, "StaticText_GuildRank")
  self._txtRRank = UI.getChildControl(Panel_Window_Guild, "StaticText_GuildRank_Value")
  self._txtUnpaidTax = UI.getChildControl(Panel_Window_Guild, "StaticText_UnpaidTax")
  self._btnGuildDel = UI.getChildControl(Panel_Window_Guild, "Button_GuildDispersal")
  self._btnChangeMark = UI.getChildControl(Panel_Window_Guild, "Button_GuildMark")
  self._btnIncreaseMember = UI.getChildControl(Panel_Window_Guild, "Button_IncreaseMember")
  self._btnTaxPayment = UI.getChildControl(Panel_Window_Guild, "Button_TaxPayment")
  self._txtGuildPoint = UI.getChildControl(Panel_Window_Guild, "StaticText_Point")
  self._txtGuildPointValue = UI.getChildControl(Panel_Window_Guild, "StaticText_Point_Value")
  self._txtGuildPointPercent = UI.getChildControl(Panel_Window_Guild, "StaticText_Point_Percent")
  self._txtGuildMpValue = UI.getChildControl(Panel_Window_Guild, "StaticText_GuildMp_Value")
  self._txtGuildMpPercent = UI.getChildControl(Panel_Window_Guild, "StaticText_GuildMp_Percent")
  self._progressMpPoint = UI.getChildControl(Panel_Window_Guild, "Progress2_GuildMp")
  self._guildIntroduce_Title = UI.getChildControl(Panel_Window_Guild, "StaticText_Title_GuildIntroduce")
  self._guildIntroduce_BG = UI.getChildControl(Panel_Window_Guild, "Static_GuildIntroduce_BG")
  self._guildBbs_Title = UI.getChildControl(Panel_Window_Guild, "StaticText_Title_Bbs")
  self._guildBbs_BG = UI.getChildControl(Panel_Window_Guild, "Static_GuildBbs_BG")
  self._planning = UI.getChildControl(Panel_Window_Guild, "StaticText_1")
  self._planning:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TODAY_COMMENT"))
  self._txtProtect = UI.getChildControl(Panel_Window_Guild, "StaticText_Protect")
  self._txtProtectValue = UI.getChildControl(Panel_Window_Guild, "StaticText_ProtectValue")
  self._btnProtectAdd = UI.getChildControl(Panel_Window_Guild, "Button_ProtectAdd")
  self._txtGuildMoneyTitle = UI.getChildControl(Panel_Window_Guild, "StaticText_GuildMoneyTitle")
  self._txtGuildMoney = UI.getChildControl(Panel_Window_Guild, "StaticText_GuildMoneyValue")
  self._txtGuildTerritoryTitle = UI.getChildControl(Panel_Window_Guild, "StaticText_TerritoryArea")
  self._txtGuildTerritoryValue = UI.getChildControl(Panel_Window_Guild, "StaticText_TerritoryAreaValue")
  self._txtGuildTerritoryValue:SetTextMode(UI_TM.eTextMode_LimitText)
  self._txtGuildServantTitle = UI.getChildControl(Panel_Window_Guild, "StaticText_GuildServant")
  self._txtGuildServantValue = UI.getChildControl(Panel_Window_Guild, "StaticText_GuildServantValue")
  self._txtGuildServantValue:SetTextMode(UI_TM.eTextMode_LimitText)
  self._btnGuildWebInfo = UI.getChildControl(Panel_Window_Guild, "Button_GuildInfo_Web")
  self._btnGuildWarehouse = UI.getChildControl(Panel_Window_Guild, "Button_GuildInfo_Warehouse")
  self._btnGetArshaHost = UI.getChildControl(Panel_Window_Guild, "Button_GetArshaHost")
  if not isContentsGuildInfo then
    self._btnGuildWebInfo:SetShow(false)
  end
  if ToClient_IsConferenceMode() then
    self._btnGuildWebInfo:SetIgnore(true)
    self._btnGuildWebInfo:SetMonoTone(true)
  end
  if not isProtectGuildMember then
    self._btnProtectAdd:SetShow(false)
  end
  if false == isContentsArsha or false == isCanDoReservation then
    self._btnGetArshaHost:SetShow(false)
  end
  if not isContentsGuildHouse then
    self._btnGuildWarehouse:SetShow(false)
  end
  function self:SetShow(isShow)
  end
  function self:GetShow()
    return self._btnGuildDel:GetShow()
  end
  if isGameTypeEnglish() then
    self._txtGuildName:SetShow(false)
    self._txtMaster:SetShow(false)
  else
    self._txtGuildName:SetShow(false)
    self._txtMaster:SetShow(false)
  end
  if isGameTypeTH() or isGameTypeID() then
    promote_btn:SetSize(115, 30)
    promote_btn:SetSpanSize(410, 365)
  else
    promote_btn:SetSize(100, 30)
    promote_btn:SetSpanSize(425, 365)
  end
  self:SetShow(false)
  self._btnGuildDel:addInputEvent("Mouse_LUp", "HandleClickedGuildDel()")
  self._btnChangeMark:addInputEvent("Mouse_LUp", "HandleClickedChangeMark()")
  self._btnTaxPayment:addInputEvent("Mouse_LUp", "HandleClicked_TaxPayment()")
  self._btnIncreaseMember:addInputEvent("Mouse_LUp", "HandleClickedIncreaseMember()")
  self._btnIncreaseMember:addInputEvent("Mouse_On", "Panel_Guild_Tab_ToolTip_Func( 6, true )")
  self._btnIncreaseMember:addInputEvent("Mouse_Out", "Panel_Guild_Tab_ToolTip_Func( 6, false )")
  self._btnProtectAdd:addInputEvent("Mouse_LUp", "HandleClickedIncreaseProtectMember()")
  self._btnProtectAdd:addInputEvent("Mouse_On", "Panel_Guild_Tab_ToolTip_Func( 8, true )")
  self._btnProtectAdd:addInputEvent("Mouse_Out", "Panel_Guild_Tab_ToolTip_Func( 8, false )")
  self._btnChangeMark:addInputEvent("Mouse_On", "GuildSimplTooltips(true, 2)")
  self._btnChangeMark:addInputEvent("Mouse_Out", "GuildSimplTooltips(false, 2)")
  self._btnGuildDel:addInputEvent("Mouse_On", "GuildSimplTooltips(true, 3)")
  self._btnGuildDel:addInputEvent("Mouse_Out", "GuildSimplTooltips(false, 3)")
  self._btnGuildWebInfo:addInputEvent("Mouse_LUp", "FGlobal_GuildWebInfoFromGuildMain_Open()")
  self._btnGuildWebInfo:addInputEvent("Mouse_On", "GuildSimplTooltips( true, 6 )")
  self._btnGuildWebInfo:addInputEvent("Mouse_Out", "GuildSimplTooltips( false, 6 )")
  self._btnGuildWarehouse:addInputEvent("Mouse_LUp", "GuildWarehouseOpen()")
  self._btnGuildWarehouse:addInputEvent("Mouse_On", "GuildSimplTooltips( true, 7 )")
  self._btnGuildWarehouse:addInputEvent("Mouse_Out", "GuildSimplTooltips( false, 7 )")
  if true == isContentsArsha and true == isCanDoReservation then
    self._btnGetArshaHost:addInputEvent("Mouse_LUp", "HandleClickedGetArshaHost()")
    self._btnGetArshaHost:addInputEvent("Mouse_On", "GuildSimplTooltips( true, 8 )")
    self._btnGetArshaHost:addInputEvent("Mouse_Out", "GuildSimplTooltips( false, 8 )")
  end
  btn_GuildMasterMandate:addInputEvent("Mouse_On", "GuildSimplTooltips( true, 0 )")
  btn_GuildMasterMandate:addInputEvent("Mouse_Out", "GuildSimplTooltips( false, 0 )")
  btn_GuildMasterMandateBG:addInputEvent("Mouse_On", "GuildSimplTooltips( true, 1 )")
  btn_GuildMasterMandateBG:addInputEvent("Mouse_Out", "GuildSimplTooltips( false, 1 )")
  checkPopUp:addInputEvent("Mouse_LUp", "HandleClickedGuild_PopUp()")
  checkPopUp:addInputEvent("Mouse_On", "Guild_PopUp_ShowIconToolTip( true )")
  checkPopUp:addInputEvent("Mouse_Out", "Guild_PopUp_ShowIconToolTip( false )")
  if not isGameTypeEnglish() then
    self._txtRGuildName:addInputEvent("Mouse_On", "GuildSimplTooltips( true, 4 )")
    self._txtRGuildName:addInputEvent("Mouse_Out", "GuildSimplTooltips( false, 4 )")
    self._txtRMaster:addInputEvent("Mouse_On", "GuildSimplTooltips( true, 5 )")
    self._txtRMaster:addInputEvent("Mouse_Out", "GuildSimplTooltips( false, 5 )")
    self._txtRGuildName:SetIgnore(false)
    self._txtRMaster:SetIgnore(false)
  else
    self._txtRGuildName:SetIgnore(true)
    self._txtRMaster:SetIgnore(true)
  end
  notice_title:addInputEvent("Mouse_On", "GuildSimplTooltips(true, 9)")
  notice_title:addInputEvent("Mouse_Out", "GuildSimplTooltips(false)")
  notice_btn:addInputEvent("Mouse_On", "GuildSimplTooltips(true, 10)")
  notice_btn:addInputEvent("Mouse_Out", "GuildSimplTooltips(false)")
end
local _Web = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_WEBCONTROL, Panel_Window_Guild, "WebControl_EventNotify_WebLink")
_Web:SetShow(true)
_Web:SetPosX(410)
_Web:SetPosY(430)
_Web:SetSize(323, 272)
_Web:ResetUrl()
Panel_Window_Guild:SetChildIndex(_Web, 9999)
local HandleClickedGuildDelContinue = function()
  ToClient_RequestDestroyGuild()
  HandleClickedGuildHideButton()
end
local HandleClickedGuildLeaveContinue = function()
  ToClient_RequestDisjoinGuild()
  HandleClickedGuildHideButton()
end
function HandleClickedGuild_PopUp()
  if checkPopUp:IsCheck() then
    Panel_Window_Guild:OpenUISubApp()
  else
    Panel_Window_Guild:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function HandleClickedGuildDel()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    _PA_ASSERT(false, "ResponseGuildInviteForGuildGrade \236\151\144\236\132\156 \234\184\184\235\147\156 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  local guildGrade = myGuildInfo:getGuildGrade()
  local messageboxData
  if true == getSelfPlayer():get():isGuildMaster() then
    if myGuildInfo:getMemberCount() <= 1 then
      messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_GUILD"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_GUILD_ASK"),
        functionYes = HandleClickedGuildDelContinue,
        functionNo = MessageBox_Empty_function,
        priority = UCT.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_CANT_DISPERSE"))
    end
  else
    local tempText
    if 0 == guildGrade then
      tempText = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLANLIST_CLANOUT_ASK")
    else
      tempText = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WITHDRAW_GUILD_ASK") .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_MENTINFO")
    end
    messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WITHDRAW_GUILD"),
      content = tempText,
      functionYes = HandleClickedGuildLeaveContinue,
      functionNo = MessageBox_Empty_function,
      priority = UCT.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function HandleClickedChangeMark()
  messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ADDMARK_MESSAGEBOX_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ADDMARK_MESSAGEBOX_TEXT"),
    functionYes = HandleClickedChangeMark_Continue,
    functionNo = MessageBox_Empty_function,
    priority = UCT.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData, "top")
end
function HandleClickedChangeMark_Continue()
  guildMarkUpdate()
end
function HandleClickedOpenSiegeGate()
  ToClient_RequestOpenSiegeGate()
end
function HandleClicked_TaxPayment()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local taxValue = Int64toInt32(myGuildInfo:getAccumulateTax())
  local costValue = Int64toInt32(myGuildInfo:getAccumulateGuildHouseCost())
  if taxValue > 0 then
    local msgBox_Title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_GUILDLAWTAX")
    local msgBox_Content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_GUILDLAWTAX_ASK", "taxValue", taxValue)
    messageboxData = {
      title = msgBox_Title,
      content = msgBox_Content,
      functionYes = Guild_DoTaxPayment,
      functionNo = MessageBox_Empty_function,
      priority = UCT.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData, "middle")
  elseif costValue > 0 then
    local msgBox_Title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_HOUSECOSTS_PAY")
    local msgBox_Content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_HOUSECOSTS_PAY_ASK", "taxValue", costValue)
    messageboxData = {
      title = msgBox_Title,
      content = msgBox_Content,
      functionYes = Guild_DoGuildHouseCost,
      functionNo = MessageBox_Empty_function,
      priority = UCT.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData, "middle")
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_UNPAID_CONFIRM"))
    return
  end
end
function Guild_DoTaxPayment()
  ToClient_PayComporateTax()
end
function Guild_DoGuildHouseCost()
  ToClient_PayGuildHouseCost()
end
function HandleClickedIncreaseMember()
  local skillPointInfo = ToClient_getSkillPointInfo(3)
  if skillPointInfo._remainPoint < 2 then
    local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_NEED_GUILDSKILLPOINT") .. tostring(skillPointInfo._remainPoint) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EXPAND_POINT_LACK")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EXPAND_MAX_COUNT"),
      content = messageContent,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EXPAND_MAX_COUNT_EXECUTE") .. tostring(skillPointInfo._remainPoint)
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EXPAND_MAX_COUNT"),
      content = messageContent,
      functionYes = Guild_IncreaseMember_Confirm,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData, "top")
  end
end
function Guild_IncreaseMember_Confirm()
  ToClient_RequestVaryJoinableGuildMemeberCount()
end
function HandleClickedIncreaseProtectMember()
  local skillPointInfo = ToClient_getSkillPointInfo(3)
  if 3 > skillPointInfo._remainPoint then
    local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROTECTADD_MOREPOINT") .. tostring(skillPointInfo._remainPoint) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EXPAND_POINT_LACK")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROTECTADD_TITLE"),
      content = messageContent,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROTECTADD_POINT") .. tostring(skillPointInfo._remainPoint)
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROTECTADD_TITLE"),
      content = messageContent,
      functionYes = Guild_IncreaseProtectMember_Confirm,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData, "top")
  end
end
function Guild_IncreaseProtectMember_Confirm()
  ToClient_RequestVaryProtectGuildMemeberCount()
end
function GuildWarehouseOpen()
  warehouse_requestGuildWarehouseInfo()
end
local maxGuildMp = 1500
function GuildInfoPage:UpdateData()
  SetDATAByGuildGrade()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if myGuildInfo ~= nil then
    local guildRank = myGuildInfo:getMemberCountLevel()
    local guildRankString = ""
    if 1 == guildRank then
      guildRankString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_SMALL")
    elseif 2 == guildRank then
      guildRankString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_MIDDLE")
    elseif 3 == guildRank then
      guildRankString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIG")
    elseif 4 == guildRank then
      guildRankString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIGGEST")
    end
    local skillPointInfo = ToClient_getSkillPointInfo(3)
    local skillPointPercent = string.format("%.0f", skillPointInfo._currentExp / skillPointInfo._nextLevelExp * 100)
    if 100 < tonumber(skillPointPercent) then
      skillPointPercent = 100
    end
    self._txtRGuildName:SetText(myGuildInfo:getName())
    self._txtRRank:SetText(guildRankString .. "(" .. myGuildInfo:getMemberCount() .. "/" .. myGuildInfo:getJoinableMemberCount() .. ")")
    self._txtRRank:SetSpanSize(self._txtRRank_Title:GetSpanSize().x + self._txtRRank_Title:GetTextSizeX() + 10, self._txtRRank:GetSpanSize().y)
    self._btnIncreaseMember:SetPosX(self._txtRRank:GetPosX() + self._txtRRank:GetTextSizeX() + 50)
    self._txtRMaster:SetText(myGuildInfo:getGuildMasterName())
    self._txtProtectValue:SetText(myGuildInfo:getProtectGuildMemberCount() .. "/" .. myGuildInfo:getAvaiableProtectGuildMemberCount())
    self._txtProtectValue:SetSpanSize(self._txtProtect:GetSpanSize().x + self._txtProtect:GetTextSizeX(), self._txtProtectValue:GetSpanSize().y)
    self._btnProtectAdd:SetPosX(self._txtProtectValue:GetPosX() + self._txtProtectValue:GetTextSizeX() + 50)
    self._txtGuildPointValue:SetText(tostring(skillPointInfo._remainPoint) .. "/" .. tostring(skillPointInfo._acquirePoint - 1))
    self._txtGuildPointPercent:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_SKILLPOINTPERCENT_SUBTITLE", "skillPointPercent", skillPointPercent))
    self._txtGuildPointPercent:SetSpanSize(self._txtGuildPointValue:GetSpanSize().x + self._txtGuildPointValue:GetTextSizeX() + 25, self._txtGuildPointPercent:GetSpanSize().y)
    self._txtGuildPointValue:SetSpanSize(self._txtGuildPoint:GetSpanSize().x + self._txtGuildPoint:GetTextSizeX(), self._txtGuildPointValue:GetSpanSize().y)
    self._txtGuildPointPercent:SetSpanSize(self._txtGuildPointValue:GetSpanSize().x + self._txtGuildPointValue:GetTextSizeX() + 20, self._txtGuildPointPercent:GetSpanSize().y)
    local currentGuildMp = myGuildInfo:getGuildMp()
    self._txtGuildMpValue:SetText(currentGuildMp)
    local guildMpGrade = ""
    if currentGuildMp < 300 then
      guildMpGrade = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GULDGRADE_1")
    elseif currentGuildMp >= 300 and currentGuildMp < 600 then
      guildMpGrade = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GULDGRADE_2")
    elseif currentGuildMp >= 600 and currentGuildMp < 900 then
      guildMpGrade = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GULDGRADE_3")
    elseif currentGuildMp >= 900 and currentGuildMp < 1200 then
      guildMpGrade = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GULDGRADE_4")
    elseif currentGuildMp >= 1200 and currentGuildMp < 1500 then
      guildMpGrade = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GULDGRADE_5")
    elseif currentGuildMp >= 1500 then
      guildMpGrade = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GULDGRADE_6")
    end
    self._txtGuildMpPercent:SetText(guildMpGrade)
    if currentGuildMp < 0 then
      currentGuildMp = 0
    end
    self._progressMpPoint:SetProgressRate(currentGuildMp / maxGuildMp * 100)
    local getGuildMoney = myGuildInfo:getGuildBusinessFunds_s64()
    self._txtGuildMoney:SetText(makeDotMoney(getGuildMoney))
    self._txtGuildMoney:SetSpanSize(self._txtGuildMoneyTitle:GetSpanSize().x + self._txtGuildMoneyTitle:GetTextSizeX() + 10, self._txtGuildMoney:GetSpanSize().y)
    self._txtGuildTerritoryValue:SetText("-")
    self._txtGuildTerritoryValue:SetSpanSize(self._txtGuildTerritoryTitle:GetSpanSize().x + self._txtGuildTerritoryTitle:GetTextSizeX() + 10, self._txtGuildTerritoryValue:GetSpanSize().y)
    self._txtGuildServantValue:SetText("-")
    self._txtGuildServantValue:SetSpanSize(self._txtGuildServantTitle:GetSpanSize().x + self._txtGuildServantTitle:GetTextSizeX() + 10, self._txtGuildServantValue:GetSpanSize().y)
    local guildArea1 = ""
    local territoryKey = ""
    local territoryWarName = ""
    if 0 < myGuildInfo:getTerritoryCount() then
      for idx = 0, myGuildInfo:getTerritoryCount() - 1 do
        territoryKey = myGuildInfo:getTerritoryKeyAt(idx)
        if territoryKey >= 0 then
          local territoryInfoWrapper = getTerritoryInfoWrapperByIndex(territoryKey)
          if nil ~= territoryInfoWrapper then
            guildArea1 = territoryInfoWrapper:getTerritoryName()
            local territoryComma = ", "
            if "" == territoryWarName then
              territoryComma = ""
            end
            territoryWarName = territoryWarName .. territoryComma .. guildArea1
          end
          self._txtGuildTerritoryValue:SetText(territoryWarName)
        end
      end
    end
    local guildArea2 = ""
    local regionKey = ""
    local siegeWarName = ""
    if 0 < myGuildInfo:getSiegeCount() then
      for idx = 0, myGuildInfo:getSiegeCount() - 1 do
        regionKey = myGuildInfo:getSiegeKeyAt(idx)
        if regionKey > 0 then
          local regionInfoWrapper = getRegionInfoWrapper(regionKey)
          if nil ~= regionInfoWrapper then
            guildArea2 = regionInfoWrapper:getAreaName()
            local siegeComma = ", "
            if "" == siegeWarName then
              siegeComma = ""
            end
            siegeWarName = siegeWarName .. siegeComma .. guildArea2
          end
          self._txtGuildTerritoryValue:SetText(siegeWarName)
        end
      end
    end
    if self._txtGuildTerritoryValue:GetTextSizeX() + 30 < self._txtGuildTerritoryValue:GetSizeX() then
      self._txtGuildTerritoryValue:SetIgnore(true)
    else
      self._txtGuildTerritoryValue:SetIgnore(false)
    end
    self._txtGuildTerritoryValue:addInputEvent("Mouse_On", "HandleClicked_TerritoryNameOnEvent( true )")
    self._txtGuildTerritoryValue:addInputEvent("Mouse_Out", "HandleClicked_TerritoryNameOnEvent( false )")
    local guildServantElephantCount = guildStable_getServantCount(UI_VT.Type_Elephant)
    local guildServantShipCount = guildStable_getServantCount(UI_VT.Type_SailingBoat)
    local guilServantValueCount = ""
    if guildServantElephantCount > 0 then
      guilServantValueCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_SERVANTCOUNT_ELEPHANT_ONLY", "guildServantElephantCount", guildServantElephantCount)
    end
    if guildServantShipCount > 0 then
      if guildServantElephantCount > 0 then
        guilServantValueCount = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_SERVANTCOUNT_GUILDVEHICLE_BOTH", "guilServantValueCount", guilServantValueCount, "guildServantShipCount", guildServantShipCount)
      else
        guilServantValueCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_SERVANTCOUNT_SAILBOAT_ONLY", "guildServantShipCount", guildServantShipCount)
      end
    end
    self._txtGuildServantValue:SetText(guilServantValueCount)
    if self._txtGuildServantValue:GetTextSizeX() + 30 < self._txtGuildServantValue:GetSizeX() then
      self._txtGuildServantValue:SetIgnore(true)
    else
      self._txtGuildServantValue:SetIgnore(false)
    end
    self._txtGuildServantValue:addInputEvent("Mouse_On", "HandleClicked_GuildServantCountOnEvent( true )")
    self._txtGuildServantValue:addInputEvent("Mouse_Out", "HandleClicked_GuildServantCountOnEvent( false )")
    if toInt64(0, 0) < myGuildInfo:getAccumulateTax() then
      self._txtUnpaidTax:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_UNPAIDTAX", "getAccumulateTax", tostring(myGuildInfo:getAccumulateTax())))
    elseif toInt64(0, 0) < myGuildInfo:getAccumulateGuildHouseCost() then
      self._txtUnpaidTax:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_UNPAIDTAX_HOUSE", "getAccumulateGuildHouseCost", tostring(myGuildInfo:getAccumulateGuildHouseCost())))
    end
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    if true == isGuildMaster then
      self:SetShow(true)
      if 0 == myGuildInfo:getGuildGrade() then
      end
      local skillPointInfo = ToClient_getSkillPointInfo(3)
      local isEnable = ToClient_GetGuildSkillPointPerIncreaseMember() <= skillPointInfo._remainPoint
      self._btnIncreaseMember:SetMonoTone(not isEnable)
    else
      self:SetShow(false)
      if 0 == myGuildInfo:getGuildGrade() then
      end
    end
    local isSet = setGuildTextureByGuildNo(myGuildInfo:getGuildNo_s64(), GuildInfoPage._iconGuildMark)
    if false == isSet then
      GuildInfoPage._iconGuildMark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(GuildInfoPage._iconGuildMark, 183, 1, 188, 6)
      GuildInfoPage._iconGuildMark:getBaseTexture():setUV(x1, y1, x2, y2)
      GuildInfoPage._iconGuildMark:setRenderTexture(GuildInfoPage._iconGuildMark:getBaseTexture())
    else
      GuildInfoPage._iconGuildMark:getBaseTexture():setUV(0, 0, 1, 1)
      GuildInfoPage._iconGuildMark:setRenderTexture(GuildInfoPage._iconGuildMark:getBaseTexture())
    end
  else
    HandleClickedGuildHideButton()
  end
end
local GuildLetsWarPage = {}
function GuildLetsWarPage:initialize()
  self._letsWarBG = UI.getChildControl(Panel_Guild_Declaration, "Static_Menu_BG_2")
  self._txtLetsWarTitle = UI.getChildControl(Panel_Guild_Declaration, "StaticText_Title")
  self._btnLetsWarDoWar = UI.getChildControl(Panel_Guild_Declaration, "Button_LetsWar")
  self._editLetsWarInputName = UI.getChildControl(Panel_Guild_Declaration, "Edit_InputGuild")
  self._txtLetsWarHelp = UI.getChildControl(Panel_Guild_Declaration, "StaticText_WarDesc_help")
  self._btnCose = UI.getChildControl(Panel_Guild_Declaration, "Button_Close")
  function self:SetShow(isShow)
    self._letsWarBG:SetShow(isShow)
    self._btnLetsWarDoWar:SetShow(isShow)
    self._editLetsWarInputName:SetShow(isShow)
    self._txtLetsWarHelp:SetShow(isShow)
  end
  function self:GetShow()
    return self._letsWarBG:GetShow()
  end
  self:SetShow(false)
  self._txtLetsWarHelp:SetTextMode(UI_TM.eTextMode_AutoWrap)
  if CppEnums.GuildWarType.GuildWarType_Normal == ToClient_GetGuildWarType() then
    self._txtLetsWarHelp:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_LETSWARHELP"))
  elseif CppEnums.GuildWarType.GuildWarType_Both == ToClient_GetGuildWarType() then
    self._txtLetsWarHelp:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_LETSWARHELP_JP"))
  else
    self._txtLetsWarHelp:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_LETSWARHELP"))
  end
  Panel_Guild_Declaration:SetSize(Panel_Guild_Declaration:GetSizeX(), self._txtLetsWarHelp:GetTextSizeY() + 10 + self._txtLetsWarTitle:GetSizeY() + self._btnLetsWarDoWar:GetSizeY() + 50)
  self._letsWarBG:SetSize(self._letsWarBG:GetSizeX(), self._txtLetsWarHelp:GetTextSizeY() + 50)
  self._txtLetsWarHelp:SetSize(self._txtLetsWarHelp:GetSizeX(), self._txtLetsWarHelp:GetTextSizeY() + 10)
  self._btnLetsWarDoWar:addInputEvent("Mouse_LUp", "HandleClickedLetsWar()")
  self._editLetsWarInputName:addInputEvent("Mouse_LUp", "HandleClickedLetsWarEditName()")
  self._btnCose:addInputEvent("Mouse_LUp", "HandleClicked_LetsWarHide()")
  self._editLetsWarInputName:RegistReturnKeyEvent("HandleClickedLetsWar()")
end
function HandleClickedLetsWar()
  local guildName = GuildLetsWarPage._editLetsWarInputName:GetEditText()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local myGuildName = myGuildInfo:getName()
  local accumulateTax_s32 = Int64toInt32(myGuildInfo:getAccumulateTax())
  local accumulateCost_s32 = Int64toInt32(myGuildInfo:getAccumulateGuildHouseCost())
  local close_function = function()
    CheckChattingInput()
  end
  if accumulateTax_s32 > 0 or accumulateCost_s32 > 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_RECRUITMENT_TAXFIRST"))
    ClearFocusEdit()
    close_function()
    return
  end
  if guildName == myGuildName then
    local messageboxData = {
      title = "",
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_LETSWARFAIL"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  elseif CppEnums.GuildWarType.GuildWarType_Both == ToClient_GetGuildWarType() then
    local messageboxData = {
      title = "",
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DECLAREWAR_DECREASEMONEY"),
      functionYes = ConfirmDeclareGuildWar,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData, nil, nil)
  else
    ConfirmDeclareGuildWar()
  end
  ClearFocusEdit()
  close_function()
end
function ConfirmDeclareGuildWar()
  local guildName = GuildLetsWarPage._editLetsWarInputName:GetEditText()
  ToClient_RequestDeclareGuildWar(0, guildName, false)
  GuildLetsWarPage._editLetsWarInputName:SetEditText("", true)
end
function HandleClickedLetsWarEditName()
  SetFocusEdit(GuildLetsWarPage._editLetsWarInputName)
  GuildLetsWarPage._editLetsWarInputName:SetEditText("", true)
end
function FGlobal_CheckGuildLetsWarUiEdit(targetUI)
  return nil ~= targetUI and targetUI:GetKey() == GuildLetsWarPage._editLetsWarInputName:GetKey()
end
function FGlobal_GuildLetsWarClearFocusEdit()
  GuildLetsWarPage._editLetsWarInputName:SetText("", true)
  ClearFocusEdit()
  CheckChattingInput()
end
function GuildLetsWarPage:UpdateData()
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  if true == isGuildMaster or true == isGuildSubMaster then
    self:SetShow(true)
  else
    self:SetShow(false)
  end
end
function HandleClicked_LetsWarShow()
  Panel_Guild_Declaration:SetShow(true)
end
function HandleClicked_LetsWarHide()
  Panel_Guild_Declaration:SetShow(false)
end
local GuildWarInfoPage = {
  _list = {},
  _list2 = {},
  slotMaxCount = 4,
  _listCount = 0,
  _startIndex = 0
}
function GuildWarInfoPage:initialize()
  local constStartY = 450
  self._txtWarInfoTitle = UI.getChildControl(Panel_Window_Guild, "StaticText_Title_WarInfo")
  self._static_WarInfoBG = UI.getChildControl(Panel_Window_Guild, "Static_Menu_BG_1")
  self._txtNoWar = UI.getChildControl(Panel_Window_Guild, "StaticText_NoWar")
  self._txtWarHelp = UI.getChildControl(Panel_Window_Guild, "StaticText_WarInfo_help")
  self._btnWarList1 = UI.getChildControl(Panel_Window_Guild, "RadioButton_WarList1")
  self._btnWarList2 = UI.getChildControl(Panel_Window_Guild, "RadioButton_WarList2")
  self._btnDeclaration = UI.getChildControl(Panel_Window_Guild, "Button_Declaration")
  self._scroll = UI.getChildControl(Panel_Window_Guild, "Scroll_DeclareGuildWar")
  local copyWarBG = UI.getChildControl(Panel_Window_Guild, "Static_C_WarBG")
  local copyGuildIconBG = UI.getChildControl(Panel_Window_Guild, "Static_C_EnemyGuild_IconBG")
  local copyGuildIcon = UI.getChildControl(Panel_Window_Guild, "Static_C_EnemyGuild_Icon")
  local copyGuildName = UI.getChildControl(Panel_Window_Guild, "StaticText_C_EnemyGuild_Name")
  local copyKill = UI.getChildControl(Panel_Window_Guild, "StaticText_C_Kill")
  local copyDeath = UI.getChildControl(Panel_Window_Guild, "StaticText_C_Death")
  local copyStopWar = UI.getChildControl(Panel_Window_Guild, "Button_C_WarStop")
  local copyShowbu = UI.getChildControl(Panel_Window_Guild, "Button_C_Showbu")
  local copyWarIcon = UI.getChildControl(Panel_Window_Guild, "Static_WarIcon")
  Panel_Window_Guild:RemoveControl(self._static_WarInfoBG)
  Panel_Window_Guild:RemoveControl(self._btnWarList1)
  Panel_Window_Guild:RemoveControl(self._btnWarList2)
  Panel_Window_Guild:RemoveControl(self._btnDeclaration)
  self._txtWarInfoTitle:AddChild(self._static_WarInfoBG)
  self._txtWarInfoTitle:AddChild(self._btnWarList1)
  self._txtWarInfoTitle:AddChild(self._btnWarList2)
  self._txtWarInfoTitle:AddChild(self._btnDeclaration)
  self._static_WarInfoBG:SetSpanSize(0, self._txtWarInfoTitle:GetSizeY() + 25)
  self._static_WarInfoBG:ComputePos()
  if isGameTypeEnglish() or isGameTypeTH() or isGameTypeID() then
    self._btnWarList1:SetSize(100, 23)
    self._btnWarList2:SetSize(100, 23)
    self._btnDeclaration:SetSize(120, 23)
    self._btnDeclaration:SetSpanSize(220, 22)
  else
    self._btnWarList1:SetSize(70, 23)
    self._btnWarList2:SetSize(70, 23)
    self._btnDeclaration:SetSize(100, 23)
    self._btnDeclaration:SetSpanSize(240, 22)
  end
  self._btnWarList1:SetPosX(10)
  self._btnWarList1:SetPosY(23)
  self._btnWarList2:SetPosX(self._btnWarList1:GetPosX() + self._btnWarList1:GetSizeX())
  self._btnWarList2:SetPosY(23)
  self._btnDeclaration:ComputePos()
  self._static_WarInfoBG:AddChild(self._txtNoWar)
  self._static_WarInfoBG:AddChild(self._txtWarHelp)
  self._static_WarInfoBG:AddChild(self._scroll)
  Panel_Window_Guild:RemoveControl(self._txtNoWar)
  Panel_Window_Guild:RemoveControl(self._txtWarHelp)
  Panel_Window_Guild:RemoveControl(self._scroll)
  self._txtNoWar:SetSpanSize(30, 120)
  self._txtNoWar:ComputePos()
  self._txtWarHelp:SetSpanSize(5, 230)
  self._txtWarHelp:ComputePos()
  self._scroll:ComputePos()
  self._btnWarList1:addInputEvent("Mouse_LUp", "HandleClicked_WarInfoUpdate( " .. 1 .. " )")
  self._btnWarList2:addInputEvent("Mouse_LUp", "HandleClicked_WarInfoUpdate( " .. 2 .. " )")
  self._btnDeclaration:addInputEvent("Mouse_LUp", "HandleClicked_LetsWarShow()")
  self._static_WarInfoBG:SetIgnore(false)
  self._static_WarInfoBG:addInputEvent("Mouse_UpScroll", "GuildWarInfoPage_ScrollEvent( true )")
  self._static_WarInfoBG:addInputEvent("Mouse_DownScroll", "GuildWarInfoPage_ScrollEvent( false )")
  function createWarinfo(pIndex)
    local rtGuildWarInfo = {}
    rtGuildWarInfo._warBG = UI.createControl(UCT.PA_UI_CONTROL_STATIC, self._static_WarInfoBG, "Static_WarBG_" .. pIndex)
    rtGuildWarInfo._guildIconBG = UI.createControl(UCT.PA_UI_CONTROL_STATIC, rtGuildWarInfo._warBG, "Static_GuildIconBG_" .. pIndex)
    rtGuildWarInfo._guildIcon = UI.createControl(UCT.PA_UI_CONTROL_STATIC, rtGuildWarInfo._warBG, "Static_GuildIcon_" .. pIndex)
    rtGuildWarInfo._txtGuildName = UI.createControl(UCT.PA_UI_CONTROL_STATICTEXT, rtGuildWarInfo._warBG, "StaticText_GuildName_" .. pIndex)
    rtGuildWarInfo._guildWarScore = UI.createControl(UCT.PA_UI_CONTROL_STATICTEXT, rtGuildWarInfo._warBG, "StaticText_Kill_" .. pIndex)
    rtGuildWarInfo._guildShowbuScore = UI.createControl(UCT.PA_UI_CONTROL_STATICTEXT, rtGuildWarInfo._warBG, "StaticText_Death_" .. pIndex)
    rtGuildWarInfo._txtStopWar = UI.createControl(UCT.PA_UI_CONTROL_BUTTON, rtGuildWarInfo._warBG, "Button_WarStop_" .. pIndex)
    rtGuildWarInfo._txtShowbu = UI.createControl(UCT.PA_UI_CONTROL_BUTTON, rtGuildWarInfo._warBG, "Button_Showbu_" .. pIndex)
    rtGuildWarInfo._WarIcon = UI.createControl(UCT.PA_UI_CONTROL_STATIC, rtGuildWarInfo._warBG, "Static_WarIcon_" .. pIndex)
    rtGuildWarInfo._PenaltyType = 0
    CopyBaseProperty(copyWarBG, rtGuildWarInfo._warBG)
    CopyBaseProperty(copyGuildIconBG, rtGuildWarInfo._guildIconBG)
    CopyBaseProperty(copyGuildIcon, rtGuildWarInfo._guildIcon)
    CopyBaseProperty(copyGuildName, rtGuildWarInfo._txtGuildName)
    CopyBaseProperty(copyKill, rtGuildWarInfo._guildWarScore)
    CopyBaseProperty(copyDeath, rtGuildWarInfo._guildShowbuScore)
    CopyBaseProperty(copyStopWar, rtGuildWarInfo._txtStopWar)
    CopyBaseProperty(copyShowbu, rtGuildWarInfo._txtShowbu)
    CopyBaseProperty(copyWarIcon, rtGuildWarInfo._WarIcon)
    rtGuildWarInfo._warBG:SetSize(315, rtGuildWarInfo._warBG:GetSizeY())
    rtGuildWarInfo._warBG:ComputePos()
    rtGuildWarInfo._guildIconBG:ComputePos()
    rtGuildWarInfo._guildIcon:ComputePos()
    rtGuildWarInfo._txtGuildName:ComputePos()
    rtGuildWarInfo._guildWarScore:ComputePos()
    rtGuildWarInfo._guildShowbuScore:ComputePos()
    rtGuildWarInfo._txtStopWar:ComputePos()
    rtGuildWarInfo._txtShowbu:ComputePos()
    rtGuildWarInfo._WarIcon:ComputePos()
    rtGuildWarInfo._warBG:SetPosY(pIndex * 51 + 5)
    rtGuildWarInfo._guildIconBG:SetPosY(pIndex + 4)
    rtGuildWarInfo._guildIcon:SetPosY(pIndex + 5)
    rtGuildWarInfo._txtGuildName:SetPosY(pIndex + 7)
    rtGuildWarInfo._guildWarScore:SetPosY(pIndex + 25)
    rtGuildWarInfo._guildShowbuScore:SetPosY(pIndex + 25)
    rtGuildWarInfo._txtStopWar:SetPosY(pIndex + 5)
    rtGuildWarInfo._WarIcon:SetPosY(pIndex + 6)
    rtGuildWarInfo._txtStopWar:SetShow(false)
    rtGuildWarInfo._txtShowbu:SetShow(false)
    function rtGuildWarInfo:SetShow(isShow)
      rtGuildWarInfo._warBG:SetShow(isShow)
      rtGuildWarInfo._guildIconBG:SetShow(isShow)
      rtGuildWarInfo._guildIcon:SetShow(isShow)
      rtGuildWarInfo._txtGuildName:SetShow(isShow)
      rtGuildWarInfo._guildWarScore:SetShow(isShow)
      rtGuildWarInfo._WarIcon:SetShow(isShow)
      rtGuildWarInfo._txtStopWar:SetShow(isShow)
      if isContentsGuildDuel then
        rtGuildWarInfo._txtShowbu:SetShow(isShow)
        rtGuildWarInfo._guildShowbuScore:SetShow(isShow)
      end
    end
    function rtGuildWarInfo:GetShow()
      return rtGuildWarInfo._warBG:GetShow()
    end
    function rtGuildWarInfo:SetData(pWarringGuild, gIdx)
      local isSet = false
      local guildNo_s64 = pWarringGuild:getGuildNo()
      if pWarringGuild:isExist() then
        isSet = setGuildTextureByGuildNo(guildNo_s64, rtGuildWarInfo._guildIcon)
      end
      if false == isSet then
        rtGuildWarInfo._guildIcon:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(rtGuildWarInfo._guildIcon, 183, 1, 188, 6)
        rtGuildWarInfo._guildIcon:getBaseTexture():setUV(x1, y1, x2, y2)
        rtGuildWarInfo._guildIcon:setRenderTexture(rtGuildWarInfo._guildIcon:getBaseTexture())
      else
        rtGuildWarInfo._guildIcon:getBaseTexture():setUV(0, 0, 1, 1)
        rtGuildWarInfo._guildIcon:setRenderTexture(rtGuildWarInfo._guildIcon:getBaseTexture())
      end
      if pWarringGuild:isExist() then
        rtGuildWarInfo._txtGuildName:SetMonoTone(false)
        rtGuildWarInfo._txtGuildName:SetText(pWarringGuild:getGuildName())
      else
        rtGuildWarInfo._txtGuildName:SetMonoTone(true)
        rtGuildWarInfo._txtGuildName:SetText(" " .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DISSOLUTION"))
      end
      local guildWarKillScore = tostring(Uint64toUint32(pWarringGuild:getKillCount()))
      local guildWarDeathScore = tostring(Uint64toUint32(pWarringGuild:getDeathCount()))
      rtGuildWarInfo._guildWarScore:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_GUILDWARSCORE", "killCount", guildWarKillScore, "deathCount", guildWarDeathScore))
      rtGuildWarInfo._guildShowbuScore:EraseAllEffect()
      if isContentsGuildDuel then
        if ToClient_IsGuildDuelingGuild(guildNo_s64) then
          local guildDuelKillScore = tostring(ToClient_GetGuildDuelKillCount(guildNo_s64))
          local guildDuelDeathScore = tostring(ToClient_GetGuildDuelDeathCount(guildNo_s64))
          rtGuildWarInfo._guildShowbuScore:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_GUILDDUELSCORE", "killCount", guildDuelKillScore, "deathCount", guildDuelDeathScore))
          rtGuildWarInfo._guildShowbuScore:SetPosX(rtGuildWarInfo._guildWarScore:GetPosX() + rtGuildWarInfo._guildWarScore:GetTextSizeX() + 10)
          local deadline = ToClient_GetGuildDuelDeadline_s64(guildNo_s64)
          if deadline < toInt64(0, 3600) then
            rtGuildWarInfo._guildShowbuScore:AddEffect("UI_Quest_Complete_GoldAura", true, 0, 0)
          end
        else
          rtGuildWarInfo._guildShowbuScore:addInputEvent("Mouse_On", "")
          rtGuildWarInfo._guildShowbuScore:addInputEvent("Mouse_Out", "")
          rtGuildWarInfo._guildShowbuScore:SetShow(false)
        end
      end
      local penaltyCount = pWarringGuild:getPenaltyCount()
      if 0 == penaltyCount then
        rtGuildWarInfo._WarIcon:SetShow(false)
      else
        rtGuildWarInfo._WarIcon:ChangeTextureInfoName("New_UI_Common_forLua/Window/Guild/Guild_WarPenaltyIcon.dds")
        rtGuildWarInfo._WarIcon:SetShow(true)
      end
      rtGuildWarInfo._txtShowbu:SetIgnore(false)
      rtGuildWarInfo._txtShowbu:SetMonoTone(false)
      rtGuildWarInfo._txtStopWar:addInputEvent("Mouse_LUp", "HandleClickedStopWar(" .. gIdx .. ")")
      rtGuildWarInfo._txtShowbu:addInputEvent("Mouse_LUp", "HandleClickedGuildDuel(" .. gIdx .. ")")
      if ToClient_IsGuildDuelingGuild(guildNo_s64) then
        rtGuildWarInfo._txtShowbu:SetIgnore(true)
        rtGuildWarInfo._txtShowbu:SetMonoTone(true)
        rtGuildWarInfo._txtShowbu:addInputEvent("Mouse_LUp", "")
      end
      rtGuildWarInfo._PenaltyType = 7
    end
    return rtGuildWarInfo
  end
  for index = 0, constCreateWarInfoCount - 1 do
    self._list[index] = createWarinfo(index)
  end
  function createWarinfo2(pIndex)
    local rtGuildWarInfo = {}
    rtGuildWarInfo._warBG = UI.createAndCopyBasePropertyControl(Panel_Window_Guild, "Static_C_WarBG", self._static_WarInfoBG, "Static_WarBG2_" .. pIndex)
    rtGuildWarInfo._guildIconBG = UI.createAndCopyBasePropertyControl(Panel_Window_Guild, "Static_C_EnemyGuild_IconBG", rtGuildWarInfo._warBG, "Static_GuildIconBG2_" .. pIndex)
    rtGuildWarInfo._guildIcon = UI.createAndCopyBasePropertyControl(Panel_Window_Guild, "Static_C_EnemyGuild_Icon", rtGuildWarInfo._warBG, "Static_GuildIcon2_" .. pIndex)
    rtGuildWarInfo._txtGuildName = UI.createAndCopyBasePropertyControl(Panel_Window_Guild, "StaticText_C_EnemyGuild_Name", rtGuildWarInfo._warBG, "StaticText_GuildName2_" .. pIndex)
    rtGuildWarInfo._txtGuildMaster = UI.createAndCopyBasePropertyControl(Panel_Window_Guild, "StaticText_C_Kill", rtGuildWarInfo._warBG, "StaticText_GuildShowbuScore2_" .. pIndex)
    rtGuildWarInfo._warBG:ComputePos()
    rtGuildWarInfo._guildIconBG:ComputePos()
    rtGuildWarInfo._guildIcon:ComputePos()
    rtGuildWarInfo._txtGuildName:ComputePos()
    rtGuildWarInfo._txtGuildMaster:ComputePos()
    rtGuildWarInfo._warBG:SetSize(315, rtGuildWarInfo._warBG:GetSizeY())
    rtGuildWarInfo._warBG:SetPosY(pIndex * 51 + 5)
    rtGuildWarInfo._guildIconBG:SetPosY(pIndex + 4)
    rtGuildWarInfo._guildIcon:SetPosY(pIndex + 5)
    rtGuildWarInfo._txtGuildName:SetPosY(pIndex + 7)
    rtGuildWarInfo._txtGuildMaster:SetPosY(pIndex + 27)
    function rtGuildWarInfo:SetShow(isShow)
      rtGuildWarInfo._warBG:SetShow(isShow)
      rtGuildWarInfo._guildIconBG:SetShow(isShow)
      rtGuildWarInfo._guildIcon:SetShow(isShow)
      rtGuildWarInfo._txtGuildName:SetShow(isShow)
      rtGuildWarInfo._txtGuildMaster:SetShow(isShow)
    end
    function rtGuildWarInfo:GetShow()
      return rtGuildWarInfo._warBG:GetShow()
    end
    function rtGuildWarInfo:SetData(guildWrapper)
      if nil ~= guildWrapper then
        local guildNo_s64 = tostring(guildWrapper:getGuildNo_s64())
        local isSet = setGuildTextureByGuildNo(guildWrapper:getGuildNo_s64(), rtGuildWarInfo._guildIcon)
        if false == isSet then
          rtGuildWarInfo._guildIcon:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(rtGuildWarInfo._guildIcon, 183, 1, 188, 6)
          rtGuildWarInfo._guildIcon:getBaseTexture():setUV(x1, y1, x2, y2)
          rtGuildWarInfo._guildIcon:setRenderTexture(rtGuildWarInfo._guildIcon:getBaseTexture())
        else
          rtGuildWarInfo._guildIcon:getBaseTexture():setUV(0, 0, 1, 1)
          rtGuildWarInfo._guildIcon:setRenderTexture(rtGuildWarInfo._guildIcon:getBaseTexture())
        end
        rtGuildWarInfo._txtGuildName:SetText(guildWrapper:getName())
        rtGuildWarInfo._txtGuildMaster:SetText(guildWrapper:getGuildMasterName())
      end
    end
    rtGuildWarInfo._warBG:SetIgnore(false)
    rtGuildWarInfo._guildIconBG:SetIgnore(false)
    rtGuildWarInfo._guildIcon:SetIgnore(false)
    rtGuildWarInfo._txtGuildName:SetIgnore(false)
    rtGuildWarInfo._warBG:addInputEvent("Mouse_UpScroll", "GuildWarInfoPage_ScrollEvent( true )")
    rtGuildWarInfo._warBG:addInputEvent("Mouse_DownScroll", "GuildWarInfoPage_ScrollEvent( false )")
    rtGuildWarInfo._guildIcon:addInputEvent("Mouse_UpScroll", "GuildWarInfoPage_ScrollEvent( true )")
    rtGuildWarInfo._guildIcon:addInputEvent("Mouse_DownScroll", "GuildWarInfoPage_ScrollEvent( false )")
    rtGuildWarInfo._txtGuildName:addInputEvent("Mouse_UpScroll", "GuildWarInfoPage_ScrollEvent( true )")
    rtGuildWarInfo._txtGuildName:addInputEvent("Mouse_DownScroll", "GuildWarInfoPage_ScrollEvent( false )")
    UIScroll.InputEvent(self._scroll, "GuildWarInfoPage_ScrollEvent")
    return rtGuildWarInfo
  end
  for index = 0, constCreateWarInfoCount - 1 do
    self._list2[index] = createWarinfo2(index)
  end
  self._txtNoWar:SetTextMode(UI_TM.eTextMode_AutoWrap)
  self._txtNoWar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_NOWAR"))
  self._txtNoWar:SetShow(false)
  self._txtWarHelp:SetTextMode(UI_TM.eTextMode_AutoWrap)
  self._txtWarHelp:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_WARHELP"))
  self._scroll:SetShow(false)
  UI.deleteControl(copyWarBG)
  UI.deleteControl(copyGuildIcon)
  UI.deleteControl(copyGuildName)
  UI.deleteControl(copyKill)
  UI.deleteControl(copyDeath)
  UI.deleteControl(copyStopWar)
  UI.deleteControl(copyShowbu)
  copyWarBG = nil
  copyGuildIcon, copyGuildName, copyKill, copyDeath = nil, nil, nil, nil
  copyWarBG = nil
  self._txtWarInfoTitle:SetSpanSize(50, 395)
  self._txtWarInfoTitle:ComputePos()
  self._scroll:SetControlTop()
end
function GuildWarInfoPage_ScrollEvent(isUp)
  local self = GuildWarInfoPage
  self._startIndex = UIScroll.ScrollEvent(self._scroll, isUp, self.slotMaxCount, self._listCount, self._startIndex, 1)
  self:UpdateData()
end
function HandleClickedStopWar(index)
  ToClient_RequestStopGuildWar(index)
end
function GuildWarInfoPage:UpdateData()
  for index = 0, constCreateWarInfoCount - 1 do
    self._list[index]:SetShow(false)
  end
  for index = 0, constCreateWarInfoCount - 1 do
    self._list2[index]:SetShow(false)
  end
  self._listCount = 0
  self._scroll:SetShow(false)
  ToClient_RequestDeclareGuildWarToMyGuild()
  if self._btnWarList1:IsCheck() then
    self._listCount = ToClient_GetWarringGuildListCount()
    UIScroll.SetButtonSize(self._scroll, self.slotMaxCount, self._listCount)
    if 0 == self._listCount then
      self._txtNoWar:SetShow(true)
    else
      if constCreateWarInfoCount < self._listCount then
        self._scroll:SetShow(true)
      end
      local uiIdx = 0
      for index = self._startIndex, self._listCount - 1 do
        if uiIdx >= constCreateWarInfoCount then
          break
        end
        if index < self._listCount then
          self._txtNoWar:SetShow(false)
          self._list[uiIdx]:SetShow(true)
          self._list[uiIdx]:SetData(ToClient_GetWarringGuildListAt(index), index)
          self._list[uiIdx]._WarIcon:addInputEvent("Mouse_On", "Panel_Guild_Tab_ToolTip_Func( " .. self._list[uiIdx]._PenaltyType .. ", true, " .. uiIdx .. " )")
          self._list[uiIdx]._WarIcon:addInputEvent("Mouse_Out", "Panel_Guild_Tab_ToolTip_Func( " .. self._list[uiIdx]._PenaltyType .. ", false, " .. uiIdx .. " )")
          self._list[uiIdx]._txtStopWar:addInputEvent("Mouse_On", "Panel_Guild_Tab_ToolTip_Func( " .. 9 .. ", true, " .. uiIdx .. " )")
          self._list[uiIdx]._txtStopWar:addInputEvent("Mouse_Out", "Panel_Guild_Tab_ToolTip_Func( " .. 9 .. ", false, " .. uiIdx .. " )")
          self._list[uiIdx]._txtShowbu:addInputEvent("Mouse_On", "Panel_Guild_Tab_ToolTip_Func( " .. 10 .. ", true, " .. uiIdx .. " )")
          self._list[uiIdx]._txtShowbu:addInputEvent("Mouse_Out", "Panel_Guild_Tab_ToolTip_Func( " .. 10 .. ", false, " .. uiIdx .. " )")
          if isContentsGuildDuel then
            self._list[uiIdx]._guildShowbuScore:addInputEvent("Mouse_On", "HandleOnOut_GuildDuelInfo_Tooltip( true,\t" .. index .. ", " .. uiIdx .. " )")
            self._list[uiIdx]._guildShowbuScore:addInputEvent("Mouse_Out", "HandleOnOut_GuildDuelInfo_Tooltip( false,\t" .. index .. ", " .. uiIdx .. " )")
          end
          local isGuildMaster = getSelfPlayer():get():isGuildMaster()
          local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
          if true == isGuildMaster or true == isGuildSubMaster then
            self._list[uiIdx]._txtStopWar:SetShow(true)
            self._list[uiIdx]._txtShowbu:SetShow(isContentsGuildDuel)
          else
            self._list[uiIdx]._txtStopWar:SetShow(false)
            self._list[uiIdx]._txtShowbu:SetShow(false)
          end
        else
          self._list[uiIdx]:SetShow(false)
        end
        uiIdx = uiIdx + 1
      end
    end
  else
    self._listCount = ToClient_GetCountDeclareGuildWarToMyGuild()
    UIScroll.SetButtonSize(self._scroll, self.slotMaxCount, self._listCount)
    if 0 == self._listCount then
      self._txtNoWar:SetShow(true)
    else
      for index = 0, constCreateWarInfoCount - 1 do
        self._list2[index]:SetShow(false)
      end
      if constCreateWarInfoCount < self._listCount then
        self._scroll:SetShow(true)
      end
      local uiIdx = 0
      for index = self._startIndex, self._listCount - 1 do
        if uiIdx >= constCreateWarInfoCount then
          break
        end
        self._txtNoWar:SetShow(false)
        local guildNo = ToClient_GetDeclareGuildWarToMyGuild_s64(index)
        local guildWrapper = ToClient_GetGuildInfoWrapperByGuildNo(guildNo)
        self._list2[uiIdx]:SetShow(true)
        self._list2[uiIdx]:SetData(guildWrapper)
        uiIdx = uiIdx + 1
      end
    end
  end
end
local warInfoTypeIsMine = true
function HandleClicked_WarInfoUpdate(typeNo)
  local self = GuildWarInfoPage
  if 1 == typeNo then
    if true == warInfoTypeIsMine then
      return
    end
    warInfoTypeIsMine = true
    self._startIndex = 0
    self._scroll:SetControlTop()
  else
    if false == warInfoTypeIsMine then
      return
    end
    warInfoTypeIsMine = false
    self._startIndex = 0
    self._scroll:SetControlTop()
  end
  self:UpdateData()
end
GuildManager = {
  _mainTagName = UI.getChildControl(Panel_Window_Guild, "StaticText_MenuTag"),
  _doHaveSeige = false
}
local _txt_Help_History = UI.getChildControl(Panel_Window_Guild, "StaticText_Help_History")
local _txt_Help_GuildMember = UI.getChildControl(Panel_Window_Guild, "StaticText_Help_GuildMember")
local _txt_Help_GuildQuest = UI.getChildControl(Panel_Window_Guild, "StaticText_Help_GuildQuest")
local _txt_Help_GuildSkill = UI.getChildControl(Panel_Window_Guild, "StaticText_Help_GuildSkill")
local _txt_Help_WarInfo = UI.getChildControl(Panel_Window_Guild, "StaticText_Help_WarInfo")
function GuildManager:initialize()
  self.mainBtn_Main = UI.getChildControl(Panel_Window_Guild, "Button_Tab_Main")
  self.mainBtn_History = UI.getChildControl(Panel_Window_Guild, "Button_Tab_History")
  self.mainBtn_Info = UI.getChildControl(Panel_Window_Guild, "Button_Tab_GuildInfo")
  self.mainBtn_Quest = UI.getChildControl(Panel_Window_Guild, "Button_Tab_GuildQuest")
  self.mainBtn_Tree = UI.getChildControl(Panel_Window_Guild, "Button_Tab_Skill")
  self.mainBtn_Warfare = UI.getChildControl(Panel_Window_Guild, "Button_Tab_Warfare")
  self.mainBtn_Recruitment = UI.getChildControl(Panel_Window_Guild, "Button_Tab_Recruitment")
  self.mainBtn_CraftInfo = UI.getChildControl(Panel_Window_Guild, "Button_Tab_CraftInfo")
  self.mainBtn_GuildBattle = UI.getChildControl(Panel_Window_Guild, "Button_Tab_GuildBattle")
  self.closeButton = UI.getChildControl(Panel_Window_Guild, "Button_Close")
  self._buttonQuestion = UI.getChildControl(Panel_Window_Guild, "Button_Question")
  self.mainBtn_Main:addInputEvent("Mouse_LUp", "GuildManager:TabToggle( 99 )")
  self.mainBtn_History:addInputEvent("Mouse_LUp", "GuildManager:TabToggle( 0 )")
  self.mainBtn_Info:addInputEvent("Mouse_LUp", "GuildManager:TabToggle( 1 )")
  self.mainBtn_Quest:addInputEvent("Mouse_LUp", "GuildManager:TabToggle( 2 )")
  self.mainBtn_Tree:addInputEvent("Mouse_LUp", "GuildManager:TabToggle( 3 )")
  self.mainBtn_Warfare:addInputEvent("Mouse_LUp", "GuildManager:TabToggle( 4 )")
  self.mainBtn_Recruitment:addInputEvent("Mouse_LUp", "GuildManager:TabToggle( 5 )")
  self.mainBtn_CraftInfo:addInputEvent("Mouse_LUp", "GuildManager:TabToggle( 6 )")
  self.mainBtn_GuildBattle:addInputEvent("Mouse_LUp", "GuildManager:TabToggle( 7 )")
  self.closeButton:addInputEvent("Mouse_LUp", "HandleClickedGuildHideButton()")
  self._buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelGuild\" )")
  self._buttonQuestion:addInputEvent("Mouse_On", "HelpMessageQuestion_Show( \"PanelGuild\", \"true\")")
  self._buttonQuestion:addInputEvent("Mouse_Out", "HelpMessageQuestion_Show( \"PanelGuild\", \"false\")")
  self.mainBtn_Main:addInputEvent("Mouse_On", "Panel_Guild_Tab_ToolTip_Func( 99, true )")
  self.mainBtn_History:addInputEvent("Mouse_On", "Panel_Guild_Tab_ToolTip_Func( 5, true )")
  self.mainBtn_Info:addInputEvent("Mouse_On", "Panel_Guild_Tab_ToolTip_Func( 0, true )")
  self.mainBtn_Quest:addInputEvent("Mouse_On", "Panel_Guild_Tab_ToolTip_Func( 1, true )")
  self.mainBtn_Tree:addInputEvent("Mouse_On", "Panel_Guild_Tab_ToolTip_Func( 2, true )")
  self.mainBtn_Warfare:addInputEvent("Mouse_On", "Panel_Guild_Tab_ToolTip_Func( 3, true )")
  self.mainBtn_Recruitment:addInputEvent("Mouse_On", "Panel_Guild_Tab_ToolTip_Func( 4, true )")
  self.mainBtn_CraftInfo:addInputEvent("Mouse_On", "Panel_Guild_Tab_ToolTip_Func( 11, true )")
  self.mainBtn_GuildBattle:addInputEvent("Mouse_On", "Panel_Guild_Tab_ToolTip_Func( 12, true )")
  self.mainBtn_Main:addInputEvent("Mouse_Out", "Panel_Guild_Tab_ToolTip_Func( 99, false )")
  self.mainBtn_History:addInputEvent("Mouse_Out", "Panel_Guild_Tab_ToolTip_Func( 5, false )")
  self.mainBtn_Info:addInputEvent("Mouse_Out", "Panel_Guild_Tab_ToolTip_Func( 0, false )")
  self.mainBtn_Quest:addInputEvent("Mouse_Out", "Panel_Guild_Tab_ToolTip_Func( 1, false )")
  self.mainBtn_Tree:addInputEvent("Mouse_Out", "Panel_Guild_Tab_ToolTip_Func( 2, false )")
  self.mainBtn_Warfare:addInputEvent("Mouse_Out", "Panel_Guild_Tab_ToolTip_Func( 3, false )")
  self.mainBtn_Recruitment:addInputEvent("Mouse_Out", "Panel_Guild_Tab_ToolTip_Func( 4, false )")
  self.mainBtn_CraftInfo:addInputEvent("Mouse_Out", "Panel_Guild_Tab_ToolTip_Func( 11, false )")
  self.mainBtn_GuildBattle:addInputEvent("Mouse_Out", "Panel_Guild_Tab_ToolTip_Func( 12, false )")
  GuildInfoPage:initialize()
  GuildLetsWarPage:initialize()
  GuildWarInfoPage:initialize()
  GuildListInfoPage:initialize()
  GuildQuestInfoPage:initialize()
  GuildWarfareInfoPage:initialize()
  GuildSkillFrame_Init()
  Guild_Recruitment_Initialize()
  FGlobal_Guild_CraftInfo_Init()
  function self:ChangeTab(pText, pX1, pY1, pX2, pY2)
    local x1, y1, x2, y2 = setTextureUV_Func(self._mainTagName, pX1, pY1, pX2, pY2)
    self._mainTagName:SetText(pText)
    self._mainTagName:getBaseTexture():setUV(x1, y1, x2, y2)
    self._mainTagName:setRenderTexture(self._mainTagName:getBaseTexture())
  end
end
function HandleClickedGuildHideButton()
  Panel_Window_Guild:CloseUISubApp()
  checkPopUp:SetCheck(false)
  GuildManager:Hide()
end
function Panel_Guild_Tab_ToolTip_Func(tabNo, isOn, inPut_index)
  if true == isOn then
    local uiControl, name, desc
    if 0 == tabNo then
      uiControl = GuildManager.mainBtn_Info
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDLIST")
      desc = nil
    elseif 1 == tabNo then
      uiControl = GuildManager.mainBtn_Quest
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDQUEST")
      desc = nil
    elseif 2 == tabNo then
      uiControl = GuildManager.mainBtn_Tree
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDSKILL")
      desc = nil
    elseif 3 == tabNo then
      uiControl = GuildManager.mainBtn_Warfare
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDWARFAREINFO")
      desc = nil
    elseif 4 == tabNo then
      uiControl = GuildManager.mainBtn_Recruitment
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_RECRUITMENTGUILD")
      desc = nil
    elseif 5 == tabNo then
      uiControl = GuildManager.mainBtn_History
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDHISTORY")
      desc = nil
    elseif 6 == tabNo then
      uiControl = GuildInfoPage._btnIncreaseMember
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_HELP_WARINFO")
      desc = nil
    elseif 7 == tabNo then
      uiControl = GuildWarInfoPage._list[inPut_index]._WarIcon
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PENALTY")
      desc = nil
    elseif 8 == tabNo then
      uiControl = GuildInfoPage._btnProtectAdd
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_HELP_PROTECTADD")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROTECTADD_DESC")
    elseif 9 == tabNo then
      uiControl = GuildWarInfoPage._list[inPut_index]._txtStopWar
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WARSTOP")
      desc = nil
    elseif 10 == tabNo then
      uiControl = GuildWarInfoPage._list[inPut_index]._txtShowbu
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WARREQUEST")
      desc = nil
    elseif 11 == tabNo then
      uiControl = GuildManager.mainBtn_CraftInfo
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDCRAFTINFO_TITLE")
      desc = nil
    elseif 12 == tabNo then
      uiControl = GuildManager.mainBtn_GuildBattle
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_GUILDBATTLE")
      desc = nil
    elseif 99 == tabNo then
      uiControl = GuildManager.mainBtn_Main
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDINFO_TITLE")
      desc = nil
    end
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function GuildSimplTooltips(isShow, tipType)
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMASTER_MANDATE_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMASTER_MANDATE_TOOLTIP_DESC")
    control = btn_GuildMasterMandate
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMASTER_MANDATE_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMASTER_MANDATE_TOOLTIP_DESC")
    control = btn_GuildMasterMandateBG
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMARK_BTN_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMARK_BTN_TOOLTIP_DESC")
    control = GuildInfoPage._btnChangeMark
  elseif 3 == tipType then
    if getSelfPlayer():get():isGuildMaster() then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_GUILD")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDDEL_BTN_TOOLTIP_DESC")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WITHDRAW_GUILD")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDDEL_BTN_TOOLTIP_DESC2")
    end
    control = GuildInfoPage._btnGuildDel
  elseif 4 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIMPLETOOLTIP_GUILDNAME")
    control = GuildInfoPage._txtRGuildName
  elseif 5 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIMPLETOOLTIP_GUILDNICKNAME")
    control = GuildInfoPage._txtRMaster
  elseif 6 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIMPLETOOLTIP_WEBINFO")
    control = GuildInfoPage._btnGuildWebInfo
  elseif 7 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIMPLETOOLTIP_WAREHOUSE")
    control = GuildInfoPage._btnGuildWarehouse
  elseif 8 == tipType and true == isContentsArsha and true == isCanDoReservation then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIMPLETOOLTIP_GETARSHAHOST")
    control = GuildInfoPage._btnGetArshaHost
  elseif 9 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_LIST_NOTICE_TITLE")
    control = notice_title
  elseif 10 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_LIST_NOTICE_TITLE") .. " " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ITEMMARKET_REGISTITEM_BTN_CONFIRM")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ONLINE_NOTICE_DESC")
    control = notice_btn
  end
  if true == isShow then
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
local _index
function GuildManager:TabToggle(index)
  self._mainTagName:ChangeTextureInfoName("New_UI_Common_forLua/Window/Guild/Guild_00.dds")
  tabNumber = 99
  self.mainBtn_Main:SetCheck(index == 99)
  self.mainBtn_History:SetCheck(index == 0)
  self.mainBtn_Info:SetCheck(index == 1)
  self.mainBtn_Quest:SetCheck(index == 2)
  self.mainBtn_Tree:SetCheck(index == 3)
  self.mainBtn_Warfare:SetCheck(index == 4)
  self.mainBtn_Recruitment:SetCheck(index == 5)
  self.mainBtn_CraftInfo:SetCheck(index == 6)
  self.mainBtn_GuildBattle:SetCheck(index == 7)
  if getSelfPlayer():get():isGuildMaster() and getSelfPlayer():get():isGuildSubMaster() then
    FGlobal_ClearCandidate()
    _Web:ResetUrl()
  end
  if 0 == index then
    self:ChangeTab(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDHISTORY"), 92, 1, 104, 15)
    FGlobal_GuildHistory_Show(true)
    GuildListInfoPage:Hide()
    GuildQuestInfoPage:Hide()
    GuildWarfareInfoPage:Hide()
    GuildSkillFrame_Hide()
    Guild_Recruitment_Close()
    GuildMainInfo_Hide()
    btn_GuildMasterMandateBG:SetShow(false)
    btn_GuildMasterMandate:SetShow(false)
    PaGlobal_GuildBattle:Close()
    tabNumber = 0
  elseif 1 == index then
    local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
    local guildGrade
    if nil ~= myGuildInfo then
      guildGrade = myGuildInfo:getGuildGrade()
    end
    if 0 == guildGrade then
      self:ChangeTab(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLAN_MEMBERINFO"), 107, 1, 119, 15)
    else
      self:ChangeTab(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDLIST"), 107, 1, 119, 15)
    end
    FGlobal_GuildHistory_Show(false)
    GuildListInfoPage:Show()
    GuildQuestInfoPage:Hide()
    GuildWarfareInfoPage:Hide()
    GuildSkillFrame_Hide()
    Guild_Recruitment_Close()
    GuildMainInfo_Hide()
    btn_GuildMasterMandateBG:SetShow(false)
    btn_GuildMasterMandate:SetShow(false)
    PaGlobal_GuildBattle:Close()
    tabNumber = 1
  elseif 2 == index then
    self:ChangeTab(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDQUEST"), 122, 1, 134, 15)
    FGlobal_GuildHistory_Show(false)
    GuildListInfoPage:Hide()
    GuildQuestInfoPage:Show()
    GuildWarfareInfoPage:Hide()
    GuildSkillFrame_Hide()
    GuildMainInfo_Hide()
    Guild_Recruitment_Close()
    btn_GuildMasterMandateBG:SetShow(false)
    btn_GuildMasterMandate:SetShow(false)
    PaGlobal_GuildBattle:Close()
    tabNumber = 2
  elseif 3 == index then
    self:ChangeTab(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDSKILL"), 137, 1, 149, 15)
    FGlobal_GuildHistory_Show(false)
    GuildListInfoPage:Hide()
    GuildQuestInfoPage:Hide()
    GuildWarfareInfoPage:Hide()
    GuildSkillFrame_Show()
    GuildMainInfo_Hide()
    Guild_Recruitment_Close()
    btn_GuildMasterMandateBG:SetShow(false)
    btn_GuildMasterMandate:SetShow(false)
    PaGlobal_GuildBattle:Close()
    tabNumber = 3
  elseif 4 == index then
    self:ChangeTab(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDWARFAREINFO"), 152, 1, 164, 15)
    FGlobal_GuildHistory_Show(false)
    GuildListInfoPage:Hide()
    GuildQuestInfoPage:Hide()
    GuildWarfareInfoPage:Show()
    GuildSkillFrame_Hide()
    GuildMainInfo_Hide()
    Guild_Recruitment_Close()
    btn_GuildMasterMandateBG:SetShow(false)
    btn_GuildMasterMandate:SetShow(false)
    PaGlobal_GuildBattle:Close()
    tabNumber = 4
  elseif 5 == index then
    local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
    if nil == myGuildInfo then
      return
    end
    if not getSelfPlayer():get():isGuildMaster() and not getSelfPlayer():get():isGuildSubMaster() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ONLYMASTER"))
      self.mainBtn_Main:SetCheck(_index == 99)
      self.mainBtn_History:SetCheck(_index == 0)
      self.mainBtn_Info:SetCheck(_index == 1)
      self.mainBtn_Quest:SetCheck(_index == 2)
      self.mainBtn_Tree:SetCheck(_index == 3)
      self.mainBtn_Warfare:SetCheck(_index == 4)
      self.mainBtn_Recruitment:SetCheck(_index == 5)
      self.mainBtn_CraftInfo:SetCheck(_index == 6)
      self.mainBtn_GuildBattle:SetCheck(_index == 7)
      return
    end
    self:ChangeTab(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_RECRUITMENTGUILD"), 152, 1, 164, 15)
    FGlobal_GuildHistory_Show(false)
    GuildListInfoPage:Hide()
    GuildQuestInfoPage:Hide()
    GuildWarfareInfoPage:Hide()
    GuildSkillFrame_Hide()
    GuildMainInfo_Hide()
    Guild_Recruitment_Open()
    btn_GuildMasterMandateBG:SetShow(false)
    btn_GuildMasterMandate:SetShow(false)
    PaGlobal_GuildBattle:Close()
    tabNumber = 5
  elseif 99 == index then
    GuildMainInfo_Show()
    FGlobal_GuildHistory_Show(false)
    self:ChangeTab(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDINFO_TITLE"), 107, 1, 119, 15)
    GuildListInfoPage:Hide()
    GuildQuestInfoPage:Hide()
    GuildWarfareInfoPage:Hide()
    GuildSkillFrame_Hide()
    Guild_Recruitment_Close()
    GuildComment_Load()
    PaGlobal_GuildBattle:Close()
    tabNumber = 99
  elseif 6 == index then
    self:ChangeTab(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDCRAFTINFO_TITLE"), 107, 1, 119, 15)
    FGlobal_GuildHistory_Show(false)
    GuildMainInfo_Hide()
    GuildListInfoPage:Hide()
    GuildQuestInfoPage:Hide()
    GuildWarfareInfoPage:Hide()
    GuildSkillFrame_Hide()
    Guild_Recruitment_Close()
    btn_GuildMasterMandateBG:SetShow(false)
    btn_GuildMasterMandate:SetShow(false)
    PaGlobal_GuildBattle:Close()
    tabNumber = 6
  elseif 7 == index then
    self:ChangeTab(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_GUILDBATTLE"), 107, 1, 119, 15)
    FGlobal_GuildBattle_Open()
    FGlobal_GuildHistory_Show(false)
    GuildMainInfo_Hide()
    GuildListInfoPage:Hide()
    GuildQuestInfoPage:Hide()
    GuildWarfareInfoPage:Hide()
    GuildSkillFrame_Hide()
    Guild_Recruitment_Close()
    btn_GuildMasterMandateBG:SetShow(false)
    btn_GuildMasterMandate:SetShow(false)
    tabNumber = 7
  end
  FGlobal_Guild_CraftInfo_Open(6 == index)
  FGlobal_GuildMenuButtonHide()
  _index = index
end
function GuildManager:Hide()
  if false == Panel_Window_Guild:IsShow() then
    return
  end
  if Panel_Window_Guild:IsUISubApp() then
    return
  end
  Panel_Window_Guild:SetShow(false, true)
  FGlobal_ShowRewardList(false)
  HelpMessageQuestion_Out()
  FGlobal_AgreementGuild_Close()
  agreementGuild_Master_Close()
  Panel_GuildIncentiveOption_Close()
  HandleClicked_LetsWarHide()
  FGlobal_GuildMenuButtonHide()
  TooltipSimple_Hide()
  TooltipGuild_Hide()
  FGlobal_GetDailyPay_Hide()
  if false == CheckChattingInput() then
    ClearFocusEdit()
  end
  FGlobal_ClearCandidate()
  _Web:ResetUrl()
end
function GuildManager:Show()
  if false == Panel_Window_Guild:IsShow() then
    local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
    if myGuildInfo ~= nil then
      GuildManager._doHaveSeige = myGuildInfo:doHaveOccupyingSiege()
    end
    local isAdmin = 0
    if isGuildMaster or isGuildSubMaster then
      isAdmin = 1
    end
    self.mainBtn_Main:SetCheck(true)
    self.mainBtn_Info:SetCheck(false)
    self.mainBtn_Quest:SetCheck(false)
    self.mainBtn_Tree:SetCheck(false)
    self.mainBtn_Warfare:SetCheck(false)
    self.mainBtn_History:SetCheck(false)
    self.mainBtn_Recruitment:SetCheck(false)
    self.mainBtn_Main:SetIgnore(false)
    self.mainBtn_Info:SetIgnore(false)
    self.mainBtn_Quest:SetIgnore(false)
    self.mainBtn_Tree:SetIgnore(false)
    self.mainBtn_Warfare:SetIgnore(false)
    self.mainBtn_History:SetIgnore(false)
    self.mainBtn_Recruitment:SetIgnore(false)
    self.mainBtn_CraftInfo:SetIgnore(false)
    self.mainBtn_GuildBattle:SetIgnore(false)
    self.mainBtn_Main:SetMonoTone(false)
    self.mainBtn_Info:SetMonoTone(false)
    self.mainBtn_Quest:SetMonoTone(false)
    self.mainBtn_Tree:SetMonoTone(false)
    self.mainBtn_Warfare:SetMonoTone(false)
    self.mainBtn_History:SetMonoTone(false)
    if getSelfPlayer():get():isGuildMaster() or getSelfPlayer():get():isGuildSubMaster() then
      self.mainBtn_Recruitment:SetMonoTone(false)
    else
      self.mainBtn_Recruitment:SetMonoTone(true)
    end
    self.mainBtn_CraftInfo:SetMonoTone(false)
    GuildWarInfoPage._btnWarList1:SetCheck(true)
    GuildWarInfoPage._btnWarList2:SetCheck(false)
    GuildWarInfoPage._startIndex = 0
    GuildWarInfoPage._scroll:SetControlPos(0)
    if isDeadInWatchingMode() and not Panel_DeadMessage:GetShow() then
      GuildManager:TabToggle(4)
      self.mainBtn_Main:SetCheck(false)
      self.mainBtn_Info:SetCheck(false)
      self.mainBtn_Quest:SetCheck(false)
      self.mainBtn_Tree:SetCheck(false)
      self.mainBtn_Warfare:SetCheck(true)
      self.mainBtn_History:SetCheck(false)
      self.mainBtn_Recruitment:SetCheck(false)
      self.mainBtn_CraftInfo:SetCheck(false)
      self.mainBtn_GuildBattle:SetCheck(false)
      self.mainBtn_Main:SetIgnore(true)
      self.mainBtn_Info:SetIgnore(true)
      self.mainBtn_Quest:SetIgnore(true)
      self.mainBtn_Tree:SetIgnore(true)
      self.mainBtn_Warfare:SetIgnore(false)
      self.mainBtn_History:SetIgnore(true)
      self.mainBtn_Recruitment:SetIgnore(true)
      self.mainBtn_CraftInfo:SetIgnore(true)
      self.mainBtn_GuildBattle:SetIgnore(true)
      self.mainBtn_Main:SetMonoTone(true)
      self.mainBtn_Info:SetMonoTone(true)
      self.mainBtn_Quest:SetMonoTone(true)
      self.mainBtn_Tree:SetMonoTone(true)
      self.mainBtn_Warfare:SetMonoTone(true)
      self.mainBtn_History:SetMonoTone(true)
      self.mainBtn_Recruitment:SetMonoTone(true)
      self.mainBtn_CraftInfo:SetMonoTone(true)
      self.mainBtn_GuildBattle:SetMonoTone(true)
    else
      GuildManager:TabToggle(99)
    end
    GuildMainInfo_MandateBtn()
    GuildInfoPage:UpdateData()
    GuildListInfoPage:UpdateData()
    GuildLetsWarPage:UpdateData()
    GuildWarInfoPage:UpdateData()
    GuildSkillFrame_Update()
    FGlobal_Notice_Update()
    GuildIntroduce_Update()
    FromClient_ResponseGuildNotice()
    FGlobal_GuildListScrollTop()
    guildQuest_ProgressingGuildQuest_UpdateRemainTime()
    Panel_Window_Guild:SetShow(true, true)
    ToClient_RequestGuildUnjoinedPlayerList()
    GuildComment_Load()
  end
end
function GuildComment_Load()
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  local guildNo_s64 = guildWrapper:getGuildNo_s64()
  local myUserNo = getSelfPlayer():get():getUserNo()
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  guildCommentsWebUrl = PaGlobal_URL_Check(worldNo)
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  local isAdmin = 0
  if isGuildMaster or isGuildSubMaster then
    isAdmin = 1
  end
  if nil ~= guildCommentsWebUrl then
    FGlobal_SetCandidate()
    local url = guildCommentsWebUrl .. "/guild?guildNo=" .. tostring(guildNo_s64) .. "&userNo=" .. tostring(myUserNo) .. "&certKey=" .. tostring(cryptKey) .. "&isMaster=" .. tostring(isAdmin)
    _urlCache = url
    _Web:SetUrl(323, 272, url, false, true)
    _Web:SetIME(true)
  end
end
function GuildMainInfo_MandateBtn()
  if 99 ~= tabNumber then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  if toInt64(0, -1) == myGuildInfo:getGuildMasterUserNo() then
    if not isGuildMaster then
      btn_GuildMasterMandate:SetShow(true)
      btn_GuildMasterMandateBG:SetShow(false)
      btn_GuildMasterMandate:SetEnable(true)
      btn_GuildMasterMandate:SetMonoTone(false)
      btn_GuildMasterMandate:SetFontColor(UI_color.C_FF00C0D7)
    end
  elseif isGuildSubMaster then
    if ToClient_IsAbleChangeMaster() then
      if myGuildInfo:getGuildBusinessFunds_s64() < toInt64(0, 20000000) then
        btn_GuildMasterMandate:SetShow(true)
        btn_GuildMasterMandateBG:SetShow(true)
        btn_GuildMasterMandate:SetEnable(false)
        btn_GuildMasterMandate:SetMonoTone(true)
        btn_GuildMasterMandate:SetFontColor(UI_color.C_FFC4BEBE)
      else
        btn_GuildMasterMandate:SetShow(true)
        btn_GuildMasterMandateBG:SetShow(false)
        btn_GuildMasterMandate:SetEnable(true)
        btn_GuildMasterMandate:SetMonoTone(false)
        btn_GuildMasterMandate:SetFontColor(UI_color.C_FF00C0D7)
      end
    else
      btn_GuildMasterMandate:SetShow(true)
      btn_GuildMasterMandate:SetEnable(false)
      btn_GuildMasterMandateBG:SetShow(true)
      btn_GuildMasterMandate:SetMonoTone(true)
    end
  else
    btn_GuildMasterMandate:SetShow(false)
    btn_GuildMasterMandateBG:SetShow(false)
    TooltipSimple_Hide()
  end
end
function GuildMainInfo_Show()
  if 99 ~= tabNumber then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local hasOccupyTerritory = myGuildInfo:getHasSiegeCount()
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  GuildWarInfoPage._txtWarInfoTitle:SetShow(true)
  if isGuildMaster then
    GuildInfoPage._btnChangeMark:SetShow(true)
    notice_btn:SetShow(true)
    promote_btn:SetShow(true)
    introduce_btn:SetShow(true)
    introduce_Reset:SetShow(true)
    GuildWarInfoPage._btnDeclaration:SetShow(true)
    GuildInfoPage._btnIncreaseMember:SetShow(true)
    if isProtectGuildMember then
      GuildInfoPage._btnProtectAdd:SetShow(true)
    end
    if isGameTypeTaiwan() then
      introduce_edit_TW:SetEnable(true)
    else
      introduce_edit:SetEnable(true)
    end
  elseif isGuildSubMaster then
    GuildInfoPage._btnChangeMark:SetShow(false)
    notice_btn:SetShow(true)
    promote_btn:SetShow(true)
    introduce_btn:SetShow(true)
    introduce_Reset:SetShow(true)
    GuildWarInfoPage._btnDeclaration:SetShow(true)
    GuildInfoPage._btnIncreaseMember:SetShow(false)
    GuildInfoPage._btnProtectAdd:SetShow(false)
    if isGameTypeTaiwan() then
      introduce_edit_TW:SetEnable(true)
    else
      introduce_edit:SetEnable(true)
    end
  else
    GuildInfoPage._btnChangeMark:SetShow(false)
    notice_btn:SetShow(false)
    promote_btn:SetShow(false)
    introduce_btn:SetShow(false)
    introduce_Reset:SetShow(false)
    GuildWarInfoPage._btnDeclaration:SetShow(false)
    GuildInfoPage._btnIncreaseMember:SetShow(false)
    GuildInfoPage._btnProtectAdd:SetShow(false)
    if isGameTypeTaiwan() then
      introduce_edit_TW:SetEnable(false)
    else
      introduce_edit:SetEnable(false)
    end
  end
  if 0 ~= hasOccupyTerritory then
    GuildInfoPage._iconOccupyTerritory:SetShow(true)
  else
    GuildInfoPage._iconOccupyTerritory:SetShow(false)
  end
  notice_title:SetShow(true)
  notice_edit:SetShow(true)
  if isGameTypeTaiwan() then
    introduce_edit_TW:SetShow(true)
    introduce_edit:SetShow(false)
  else
    introduce_edit:SetShow(true)
    introduce_edit_TW:SetShow(false)
  end
  if isGameTypeEnglish() then
    GuildInfoPage._txtMaster:SetShow(false)
    GuildInfoPage._txtGuildName:SetShow(false)
  else
    GuildInfoPage._txtMaster:SetShow(true)
    GuildInfoPage._txtGuildName:SetShow(true)
  end
  GuildInfoPage._textGuildInfoTitle:SetShow(true)
  GuildInfoPage._guildMainBG:SetShow(true)
  GuildInfoPage._iconGuildMark:SetShow(true)
  GuildInfoPage._txtRGuildName:SetShow(true)
  GuildInfoPage._txtRMaster:SetShow(true)
  GuildInfoPage._txtRRank_Title:SetShow(true)
  GuildInfoPage._txtRRank:SetShow(true)
  GuildInfoPage._txtGuildPoint:SetShow(true)
  GuildInfoPage._txtGuildPointValue:SetShow(true)
  GuildInfoPage._txtGuildPointPercent:SetShow(true)
  GuildInfoPage._txtGuildMpValue:SetShow(false)
  GuildInfoPage._txtGuildMpPercent:SetShow(false)
  GuildInfoPage._progressMpPoint:SetShow(false)
  GuildInfoPage._btnGuildDel:SetShow(true)
  GuildInfoPage._guildIntroduce_Title:SetShow(true)
  GuildInfoPage._guildIntroduce_BG:SetShow(true)
  GuildInfoPage._guildBbs_Title:SetShow(true)
  GuildInfoPage._guildBbs_BG:SetShow(true)
  GuildInfoPage._planning:SetShow(true)
  GuildInfoPage._txtProtect:SetShow(true)
  GuildInfoPage._txtProtectValue:SetShow(true)
  GuildInfoPage._txtGuildMoneyTitle:SetShow(true)
  GuildInfoPage._txtGuildMoney:SetShow(true)
  GuildInfoPage._txtGuildTerritoryTitle:SetShow(true)
  GuildInfoPage._txtGuildTerritoryValue:SetShow(true)
  GuildInfoPage._txtGuildServantTitle:SetShow(true)
  GuildInfoPage._txtGuildServantValue:SetShow(true)
  if isContentsGuildHouse then
    GuildInfoPage._btnGuildWarehouse:SetShow(true)
  else
    GuildInfoPage._btnGuildWarehouse:SetShow(false)
  end
  if isContentsGuildInfo then
    GuildInfoPage._btnGuildWebInfo:SetShow(true)
  else
    GuildInfoPage._btnGuildWebInfo:SetShow(false)
    GuildInfoPage._btnGuildWarehouse:SetPosX(GuildInfoPage._btnGuildWebInfo:GetPosX())
  end
  GuildInfoPage._btnGetArshaHost:SetShow(false)
  if (isGuildMaster or isGuildSubMaster) and true == isContentsArsha and true == isCanDoReservation then
    GuildInfoPage._btnGetArshaHost:SetShow(true)
  end
  GuildMainInfo_MandateBtn()
  if isGameTypeKR2() then
    GuildInfoPage._btnChangeMark:SetShow(false)
  end
  if nil ~= guildCommentsWebUrl then
    _Web:SetShow(true)
  end
end
function guildCommentsUrlByServiceType()
  local url
  if CppEnums.CountryType.DEV == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_KOR_DEV")
  elseif CppEnums.CountryType.KOR_ALPHA == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_KOR_ALPHA")
  elseif CppEnums.CountryType.KOR_REAL == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_KOR_REAL")
  elseif CppEnums.CountryType.NA_ALPHA == getGameServiceType() then
    if 0 == getServiceNationType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_URL_NA_ALPHA_NA", "port", worldNo)
    elseif 1 == getServiceNationType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_URL_NA_ALPHA_EU", "port", worldNo)
    end
  elseif CppEnums.CountryType.NA_REAL == getGameServiceType() then
    if 0 == getServiceNationType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_URL_NA_REAL_NA", "port", worldNo)
    elseif 1 == getServiceNationType() then
      url = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_URL_NA_REAL_EU", "port", worldNo)
    end
  elseif CppEnums.CountryType.JPN_ALPHA == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_JP_ALPHA")
  elseif CppEnums.CountryType.JPN_REAL == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_JP_REAL")
  elseif CppEnums.CountryType.RUS_ALPHA == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_RUS_ALPHA")
  elseif CppEnums.CountryType.RUS_REAL == getGameServiceType() then
    if isServerFixedCharge() then
      url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_RUS_REAL_P2P")
    else
      url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_RUS_REAL_F2P")
    end
  elseif CppEnums.CountryType.TW_ALPHA == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_TW_ALPHA")
  elseif CppEnums.CountryType.TW_REAL == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_TW_REAL")
  elseif CppEnums.CountryType.SA_ALPHA == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_SA_ALPHA")
  elseif CppEnums.CountryType.SA_REAL == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_SA_REAL")
  elseif CppEnums.CountryType.KR2_ALPHA == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_KR2_ALPHA")
  elseif CppEnums.CountryType.KR2_REAL == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_KR2_REAL")
  elseif CppEnums.CountryType.TR_ALPHA == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_TR_ALPHA")
  elseif CppEnums.CountryType.TR_REAL == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_TR_REAL")
  elseif CppEnums.CountryType.TH_ALPHA == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_TH_ALPHA")
  elseif CppEnums.CountryType.TH_REAL == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_TH_REAL")
  elseif CppEnums.CountryType.ID_ALPHA == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_ID_ALPHA")
  elseif CppEnums.CountryType.ID_REAL == getGameServiceType() then
    url = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_URL_ID_REAL")
  end
  return url
end
function GuildMainInfo_Hide()
  GuildWarInfoPage._txtWarInfoTitle:SetShow(false)
  _Web:SetShow(false)
  notice_title:SetShow(false)
  notice_edit:SetShow(false)
  notice_btn:SetShow(false)
  promote_btn:SetShow(false)
  introduce_btn:SetShow(false)
  introduce_Reset:SetShow(false)
  introduce_edit_TW:SetShow(false)
  introduce_edit:SetShow(false)
  GuildInfoPage._txtMaster:SetShow(false)
  GuildInfoPage._textGuildInfoTitle:SetShow(false)
  GuildInfoPage._guildMainBG:SetShow(false)
  GuildInfoPage._iconOccupyTerritory:SetShow(false)
  GuildInfoPage._iconGuildMark:SetShow(false)
  GuildInfoPage._txtGuildName:SetShow(false)
  GuildInfoPage._txtRGuildName:SetShow(false)
  GuildInfoPage._txtRMaster:SetShow(false)
  GuildInfoPage._txtRRank_Title:SetShow(false)
  GuildInfoPage._txtRRank:SetShow(false)
  GuildInfoPage._btnIncreaseMember:SetShow(false)
  GuildInfoPage._txtGuildPoint:SetShow(false)
  GuildInfoPage._txtGuildPointValue:SetShow(false)
  GuildInfoPage._txtGuildPointPercent:SetShow(false)
  GuildInfoPage._txtGuildMpValue:SetShow(false)
  GuildInfoPage._txtGuildMpPercent:SetShow(false)
  GuildInfoPage._progressMpPoint:SetShow(false)
  GuildInfoPage._btnGuildDel:SetShow(false)
  GuildInfoPage._btnChangeMark:SetShow(false)
  GuildInfoPage._guildIntroduce_Title:SetShow(false)
  GuildInfoPage._guildIntroduce_BG:SetShow(false)
  GuildInfoPage._guildBbs_Title:SetShow(false)
  GuildInfoPage._guildBbs_BG:SetShow(false)
  GuildInfoPage._planning:SetShow(false)
  GuildInfoPage._txtProtect:SetShow(false)
  GuildInfoPage._txtProtectValue:SetShow(false)
  GuildInfoPage._btnProtectAdd:SetShow(false)
  GuildInfoPage._txtGuildMoneyTitle:SetShow(false)
  GuildInfoPage._txtGuildMoney:SetShow(false)
  GuildInfoPage._txtGuildTerritoryTitle:SetShow(false)
  GuildInfoPage._txtGuildTerritoryValue:SetShow(false)
  GuildInfoPage._txtGuildServantTitle:SetShow(false)
  GuildInfoPage._txtGuildServantValue:SetShow(false)
  GuildInfoPage._btnGuildWebInfo:SetShow(false)
  GuildInfoPage._btnGuildWarehouse:SetShow(false)
  GuildInfoPage._btnGetArshaHost:SetShow(false)
  GuildMainInfo_MandateBtn()
end
function HandleClicked_TerritoryNameOnEvent(isShow)
  local self = GuildInfoPage
  local name, desc, control
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local guildArea1 = ""
  local territoryKey = ""
  local territoryWarName = ""
  if 0 < myGuildInfo:getTerritoryCount() then
    for idx = 0, myGuildInfo:getTerritoryCount() - 1 do
      territoryKey = myGuildInfo:getTerritoryKeyAt(idx)
      local territoryInfoWrapper = getTerritoryInfoWrapperByIndex(territoryKey)
      if nil ~= territoryInfoWrapper then
        guildArea1 = territoryInfoWrapper:getTerritoryName()
        local territoryComma = ", "
        if "" == territoryWarName then
          territoryComma = ""
        end
        territoryWarName = territoryWarName .. territoryComma .. guildArea1
      end
    end
    name = territoryWarName
    control = self._txtGuildTerritoryValue
  end
  local guildArea2 = ""
  local regionKey = ""
  local siegeWarName = ""
  if 0 < myGuildInfo:getSiegeCount() then
    for idx = 0, myGuildInfo:getSiegeCount() - 1 do
      regionKey = myGuildInfo:getSiegeKeyAt(idx)
      local regionInfoWrapper = getRegionInfoWrapper(regionKey)
      if nil ~= regionInfoWrapper then
        guildArea2 = regionInfoWrapper:getAreaName()
        local siegeComma = ", "
        if "" == siegeWarName then
          siegeComma = ""
        end
        siegeWarName = siegeWarName .. siegeComma .. guildArea2
      end
    end
    name = siegeWarName
    control = self._txtGuildTerritoryValue
  end
  if isShow then
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleClicked_GuildServantCountOnEvent(isShow)
  local self = GuildInfoPage
  local name, desc, control
  local guildServantElephantCount = guildStable_getServantCount(UI_VT.Type_Elephant)
  local guildServantShipCount = guildStable_getServantCount(UI_VT.Type_SailingBoat)
  local guilServantValueCount = ""
  if guildServantElephantCount > 0 then
    guilServantValueCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_SERVANTCOUNT_ELEPHANT_ONLY", "guildServantElephantCount", guildServantElephantCount)
  end
  if guildServantShipCount > 0 then
    if guildServantElephantCount > 0 then
      guilServantValueCount = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_SERVANTCOUNT_GUILDVEHICLE_BOTH", "guilServantValueCount", guilServantValueCount, "guildServantShipCount", guildServantShipCount)
    else
      guilServantValueCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_SERVANTCOUNT_SAILBOAT_ONLY", "guildServantShipCount", guildServantShipCount)
    end
  end
  if nil ~= guilServantValueCount then
    name = guilServantValueCount
    control = self._txtGuildServantValue
  end
  if isShow then
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function FromClient_ResponseGuildUpdate()
  if true == Panel_Window_Guild:GetShow() then
    GuildInfoPage:UpdateData()
    GuildListInfoPage:UpdateData()
    GuildWarInfoPage:UpdateData()
    GuildSkillFrame_Update()
    guildQuest_ProgressingGuildQuest_UpdateRemainTime()
  elseif true == Panel_ClanList:GetShow() then
    FGlobal_ClanList_Update()
  end
end
function FromClient_GuildListUpdate(userNo)
  if true == Panel_Window_Guild:GetShow() then
    GuildListInfoPage:UpdateVoiceDataByUserNo(userNo)
  end
end
function FromClient_EventActorChangeGuildInfo()
  GuildInfoPage:UpdateData()
end
local messageBox_guild_accept = function()
  ToClient_RequestAcceptGuildInvite()
end
local messageBox_guild_refuse = function()
  ToClient_RequestRefuseGuildInvite()
end
function FromClient_ResponseGuild_refuse(questName, s64_joinableTime)
  if s64_joinableTime > toInt64(0, 0) then
    local lefttimeText = convertStringFromDatetime(getLeftSecond_TTime64(s64_joinableTime))
    local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_MSGBOX_JOINWAITTIME_CONTENT", "questName", questName, "lefttimeText", lefttimeText)
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_INVITE"),
      content = contentString,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
    if nil == myGuildInfo then
      _PA_ASSERT(false, "FromClient_ResponseGuild_refuse \236\151\144\236\132\156 \234\184\184\235\147\156 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
    end
    local textGuild = ""
    local guildGrade = myGuildInfo:getGuildGrade()
    if 0 == guildGrade then
      textGuild = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLAN")
    else
      textGuild = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD")
    end
    local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_REFUSE_GUILDINVITE", "name", questName, "guild", textGuild)
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_INVITE"),
      content = contentString,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function FromClient_ResponseGuild_invite(s64_guildNo, hostUsername, hostName, guildName, guildGrade, periodDay, benefit, penalty)
  if 0 == guildGrade then
    local luaGuildTextGuildInviteMsg = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLAN_INVITE_MSG")
    local luaGuildTextGuildInvite = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLAN_INVITE")
    local contentString = hostUsername .. "(" .. hostName .. ")" .. luaGuildTextGuildInviteMsg
    local messageboxData = {
      title = luaGuildTextGuildInvite,
      content = contentString,
      functionYes = messageBox_guild_accept,
      functionCancel = messageBox_guild_refuse,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  elseif 1 == guildGrade then
    FGlobal_AgreementGuild_Open(true, hostUsername, hostName, guildName, periodDay, benefit, penalty, s64_guildNo)
  end
end
function messageBox_guildAlliance_accept()
  ToClient_RequestAcceptGuildAllianceInvite()
end
function messageBox_guildAlliance_refuse()
  ToClient_RequestRefuseGuildAllianceInvite()
end
function FromClient_ResponseGuildAlliance_invite(hostName)
  local luaGuildTextGuildAllianceInviteMsg = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDALLIANCE_INVITE_MSG")
  local luaGuildTextGuildAllianceInvite = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDALLIANCE_INVITE")
  local contentString = hostName .. luaGuildTextGuildAllianceInviteMsg
  local messageboxData = {
    title = luaGuildTextGuildAllianceInvite,
    content = contentString,
    functionYes = messageBox_guildAlliance_accept,
    functionCancel = messageBox_guildAlliance_refuse,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_ResponseGuildAlliance_refuse(guestName)
  local luaGuildTextGuildAllianceRefuseMsg = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDALLIANCE_REFUSE_MSG")
  local luaGuildTextGuildAllianceRefuse = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDALLIANCE_REFUSE")
  local contentString = guestName .. luaGuildTextGuildAllianceRefuseMsg
  local messageboxData = {
    title = luaGuildTextGuildAllianceRefuse,
    content = contentString,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_ResponseUpdateGuildContract(notifyType, userNickName, characterName, strParam1, strParam2, s64_param1, s64_param2, s64_param3)
  local param1 = Int64toInt32(s64_param1)
  local param2 = Int64toInt32(s64_param2)
  local param3 = Int64toInt32(s64_param3)
  if 0 == notifyType then
    local tempStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_PENSION")
    local guildWrapper = ToClient_GetMyGuildInfoWrapper()
    if nil == guildWrapper then
      return
    end
    local guildGrade = guildWrapper:getGuildGrade()
    if 1 == guildGrade then
      Proc_ShowMessage_Ack(tempStr)
    end
  elseif 1 == notifyType then
    local tempStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_MONEY_DEPOSIT", "userNickName", userNickName, "money", tostring(param1))
    Proc_ShowMessage_Ack(tempStr)
  elseif 2 == notifyType then
    local isWarehouseGet = FGlobal_GetDailyPay_WarehouseCheckReturn()
    local tempStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_MONEY_COLLECTION_INVEN", "money", makeDotMoney(param1))
    if true == isWarehouseGet then
      tempStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_MONEY_COLLECTION_WAREHOUSE", "money", makeDotMoney(param1))
    else
      tempStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_MONEY_COLLECTION_INVEN", "money", makeDotMoney(param1))
    end
    if 1 == param2 then
      Proc_ShowMessage_Ack(tempStr)
    end
  elseif 3 == notifyType then
    local tempStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_HIRE_RENEWAL", "userNickName", userNickName)
    Proc_ShowMessage_Ack(tempStr)
  elseif 4 == notifyType then
    local tempStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_EXPIRATION", "userNickName", userNickName)
    Proc_ShowMessage_Ack(tempStr)
  elseif 5 == notifyType then
    local periodDay = getTemporaryInformationWrapper():getContractedPeriodDay()
    local benefit = getTemporaryInformationWrapper():getContractedBenefit()
    local penalty = getTemporaryInformationWrapper():getContractedPenalty()
    local guildWrapper = ToClient_GetMyGuildInfoWrapper()
    if nil == guildWrapper then
      _PA_ASSERT(false, "\234\184\184\235\147\156\236\155\144\236\157\180 \234\179\160\236\154\169\234\179\132\236\149\189\236\132\156\235\165\188 \235\176\155\235\138\148\235\141\176 \234\184\184\235\147\156 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
      return
    end
    local guildName = guildWrapper:getName()
    FGlobal_AgreementGuild_Open(false, userNickName, characterName, guildName, periodDay, benefit, penalty, guildWrapper:getGuildNo_s64())
  elseif 6 == notifyType then
    local tempTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_PAYMENTS", "typeMoney", tostring(param2))
    if 0 ~= param1 then
      tempTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_UNPAID", "typeMoney", tostring(param2))
    end
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_INCOMETAX", "type", tempTxt))
  elseif 7 == notifyType then
    local tempTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_LEAVE", "userNickName", userNickName)
    if param1 > 0 then
      tempTxt = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_PENALTIES", "tempTxt", tempTxt, "money", tostring(param1))
    end
    Proc_ShowMessage_Ack(tempTxt)
    Panel_Window_Guild:SetShow(false, true)
  elseif 8 == notifyType then
    local tempTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_FIRE", "userNickName", userNickName)
    if param1 > 0 then
      tempTxt = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_BONUS", "tempTxt", tempTxt, "money", tostring(param1))
    end
    Proc_ShowMessage_Ack(tempTxt)
  elseif 9 == notifyType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_UPGRADES"))
  elseif 10 == notifyType then
  elseif 11 == notifyType then
    local text = ""
    if 1 == param3 then
      text = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_BESTMONEY", "money", makeDotMoney(s64_param1))
    else
      text = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_NOTBESTMONEY", "money", makeDotMoney(s64_param1))
    end
    Proc_ShowMessage_Ack(text)
  elseif 12 == notifyType then
    local text
    if 1 == param1 then
      text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_BIDCANCEL")
    else
      text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_BIDSUCCESS")
    end
    Proc_ShowMessage_Ack(text)
  elseif 13 == notifyType then
    if toInt64(0, 0) == s64_param1 then
      Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_USEGUILDSHOP_BUY", "userNickName", tostring(userNickName), "param2", makeDotMoney(s64_param2)))
    end
    if Panel_Window_NpcShop:IsShow() and npcShop_isGuildShopContents() then
      NpcShop_UpdateMoneyWarehouse()
      return
    end
  elseif 14 == notifyType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_INCENTIVE"))
  elseif 15 == notifyType then
    local tempTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_PAYMENTS", "typeMoney", tostring(param2))
    if 0 ~= param1 then
      tempTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_UNPAID", "typeMoney", tostring(param2))
    end
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_HOUSECOSTS", "tempTxt", tempTxt))
  elseif 16 == notifyType then
    local text = ""
    if 0 == param1 then
      text = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_CREATE_CLAN", "name", userNickName)
    else
      text = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_CREATE_GUILD", "name", userNickName)
    end
    Proc_ShowMessage_Ack(text)
  elseif 17 == notifyType then
    if false == ToClient_GetMessageFilter(9) then
      local text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ACCEPT_GUILDQUEST")
      Proc_ShowMessage_Ack(text)
    end
  elseif 18 == notifyType then
    if false == ToClient_GetMessageFilter(9) then
      local text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_COMPLETE_GUILDQUEST")
      Proc_ShowMessage_Ack(text)
    end
  elseif 19 == notifyType then
    local regionInfoWrapper = getRegionInfoWrapper(param2)
    if nil == regionInfoWrapper then
      _PA_ASSERT(false, "\236\132\177\236\163\188\234\176\128 \235\167\136\236\157\132\236\132\184\234\184\136\236\157\132 \236\136\152\234\184\136\237\150\136\235\138\148\235\141\176 \235\167\136\236\157\132 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
      return
    end
    local text = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_LORD_MOVETAX_TO_GUILDMONEY", "region", regionInfoWrapper:getAreaName(), "silver", makeDotMoney(s64_param1))
    Proc_ShowMessage_Ack(text)
  elseif 20 == notifyType then
  elseif 21 == notifyType then
    if CppEnums.GuildWarType.GuildWarType_Normal == ToClient_GetGuildWarType() then
      if param3 == 1 then
        local text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ACCEPT_BATTLE_NO_RESOURCE")
        Proc_ShowMessage_Ack(text)
      else
        local tendency = param1
        local text = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_DECLARE_WAR_CONSUME", "silver", makeDotMoney(s64_param2))
        Proc_ShowMessage_Ack(text)
      end
    end
  elseif 22 == notifyType then
  elseif 23 == notifyType then
  elseif 24 == notifyType then
  elseif 25 == notifyType then
    if Panel_GuildWarInfo:GetShow() then
    end
  elseif 26 == notifyType then
    GuildQuestInfoPage:UpdateData()
  elseif 27 == notifyType then
  elseif 28 == notifyType then
    if 0 == param1 then
      local text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMP_DOWN")
      Proc_ShowMessage_Ack(userNickName .. text)
    else
      local text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMP_UP")
      Proc_ShowMessage_Ack(userNickName .. text)
    end
    if Panel_GuildWarInfo:GetShow() then
      FromClient_WarInfoContent_Set()
    end
  elseif 29 == notifyType then
    if 0 == param1 then
      local text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_CHEER_GUILD")
      Proc_ShowMessage_Ack(userNickName .. text)
      FromClient_NotifySiegeScoreToLog()
    else
      FromClient_NotifySiegeScoreToLog()
    end
    if Panel_GuildWarInfo:GetShow() then
      FromClient_WarInfoContent_Set()
    end
  elseif 30 == notifyType then
    local text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DONOT_GUILDQUEST")
    Proc_ShowMessage_Ack(text)
  elseif 31 == notifyType then
  elseif 32 == notifyType then
    local regionInfoWrapper = getRegionInfoWrapper(param3)
    local areaName = ""
    if nil ~= regionInfoWrapper then
      areaName = regionInfoWrapper:getAreaName()
    end
    local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(param2)
    local characterName = ""
    if nil ~= characterStaticStatusWarpper then
      characterName = characterStaticStatusWarpper:getName()
    end
    local msg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BUILDING_AUTODESTROYBUILD", "areaName", areaName, "characterName", characterName)
    Proc_ShowMessage_Ack(msg)
  elseif 38 == notifyType then
    local tempTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDE_PAYPROPERTYTAX", "typeMoney", makeDotMoney(s64_param1))
    Proc_ShowMessage_Ack(tempTxt)
  elseif 39 == notifyType then
    local tempTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_GETWELFARE", "typeMoney", makeDotMoney(s64_param1))
    Proc_ShowMessage_Ack(tempTxt)
  elseif 43 == notifyType then
    local tempTxt = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_NOTIFYWELFARE")
    Proc_ShowMessage_Ack(tempTxt)
  end
  FromClient_ResponseGuildUpdate()
end
function FromClient_NotifyGuildMessage(msgType, strParam1, strParam2, s64_param1, s64_param2, s64_param3)
  local param1 = Int64toInt32(s64_param1)
  local param2 = Int64toInt32(s64_param2)
  local param3 = Int64toInt32(s64_param3)
  if 0 == msgType then
    local message = ""
    if 0 == param1 then
      message = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_CLAN_OUT")
    else
      message = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_GUILD_OUT")
    end
    Proc_ShowMessage_Ack(message)
  elseif 1 == msgType then
    local message = ""
    if 0 == param1 then
      message = PAGetStringParam1(Defines.StringSheet_GAME, "GAME_MESSAGE_CLANMEMBER_OUT", "familyName", strParam1)
    else
      message = PAGetStringParam1(Defines.StringSheet_GAME, "GAME_MESSAGE_GUILDMEMBER_OUT", "familyName", strParam1)
    end
    Proc_ShowMessage_Ack(message)
  elseif 2 == msgType then
    local message = ""
    if 0 == param1 then
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_JOIN_GUILD", "name", strParam1)
    else
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_JOIN_GUILD", "name", strParam1)
    end
    Proc_ShowMessage_Ack(message)
  elseif 3 == msgType then
    local message = ""
    if 0 == param1 then
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_WHO_JOIN_CLAN", "name", strParam1)
    else
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_WHO_JOIN_GUILD", "name", strParam1)
    end
    Proc_ShowMessage_Ack(message)
  elseif 4 == msgType then
    local message = ""
    if 0 == param1 then
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_CLAN_MSG", "name", strParam1)
    else
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_GUILD_MSG", "name", strParam1)
    end
    Proc_ShowMessage_Ack(message)
  elseif 5 == msgType then
    local textGrade = ""
    if 0 == param1 then
      textGrade = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLAN")
    else
      textGrade = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD")
    end
    local message = ""
    if 0 == param2 then
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_EXPEL_SELF", "guild", strParam2)
    else
      message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_EXPEL_OTHER", "name", strParam1, "guild", strParam2)
    end
    Proc_ShowMessage_Ack(message)
  elseif 6 == msgType then
    local message = ""
    if param1 <= 30 and param2 > 30 then
      message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_COMPORATETAX_GUILDMEMBERCOUNT", "membercount", "30", "silver", PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBERCOUNT_10"))
    elseif param1 <= 50 and param2 > 50 then
      message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_COMPORATETAX_GUILDMEMBERCOUNT", "membercount", "50", "silver", PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBERCOUNT_25"))
    elseif param1 <= 75 and param2 > 75 then
      message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_COMPORATETAX_GUILDMEMBERCOUNT", "membercount", "75", "silver", PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBERCOUNT_50"))
    else
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_INCREASE_GUILDMEMBERCOUNT", "membercount", param2)
    end
    Proc_ShowMessage_Ack(message)
  elseif 7 == msgType then
    local message = ""
    local characterName = strParam1
    local userNickName = strParam2
    if true == GameOption_ShowGuildLoginMessage() then
      if 0 == param1 then
        message = PAGetStringParam2(Defines.StringSheet_GAME, "GAME_MESSAGE_LOGIN_GUILD_MEMBER", "familyName", userNickName, "characterName", characterName)
      elseif 1 == param1 then
        message = PAGetStringParam2(Defines.StringSheet_GAME, "GAME_MESSAGE_LOGOUT_GUILD_MEMBER", "familyName", userNickName, "characterName", characterName)
      end
      Proc_ShowMessage_Ack(message)
    end
  elseif 8 == msgType then
    local message = ""
    local characterName = strParam1
    local userNickName = strParam2
    if 1 == param1 then
      message = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_LOGOUT_GUILD_ALLIANCE_MEMBER") .. " " .. userNickName .. " " .. characterName
    end
    Proc_ShowMessage_Ack(message)
  elseif 9 == msgType then
    local message = {}
    if param1 > 15 then
      message.main = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBERLEVELUP_MAIN", "strParam1", strParam1, "param1", param1)
      message.sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBER_CHEER")
      message.addMsg = ""
      Proc_ShowMessage_Ack_For_RewardSelect(message, 3.2, 22)
    end
  elseif 10 == msgType then
    local message = {}
    if param1 <= 8 then
      local lifeLevel
      if isNewCharacterInfo() == false then
        lifeLevel = FGlobal_CraftLevel_Replace(param2, param1)
      else
        lifeLevel = FGlobal_UI_CharacterInfo_Basic_Global_CraftLevelReplace(param2)
      end
      message.main = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBERLIFELEVELUP_MAIN", "strParam1", strParam1, "param1", lifeType[param1], "lifeLevel", lifeLevel)
      message.sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBER_CHEER")
      message.addMsg = ""
      Proc_ShowMessage_Ack_For_RewardSelect(message, 3.2, 22)
    end
  elseif 11 == msgType then
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(param1))
    if itemSSW == nil then
      return
    end
    local itemName = itemSSW:getName()
    local itemClassify = itemSSW:getItemClassify()
    local enchantLevel = itemSSW:get()._key:getEnchantLevel()
    local enchantLevelHigh = 0
    if nil ~= enchantLevel and 0 ~= enchantLevel then
      if enchantLevel >= 16 then
        enchantLevelHigh = HighEnchantLevel_ReplaceString(enchantLevel)
      elseif CppEnums.ItemClassifyType.eItemClassify_Accessory == itemClassify then
        enchantLevelHigh = HighEnchantLevel_ReplaceString(enchantLevel + 15)
      else
        enchantLevelHigh = "+ " .. enchantLevel
      end
    end
    local message = {}
    message.main = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBERENCHANTSUCCESS_MAIN1", "strParam1", strParam1, "param1", enchantLevelHigh, "strParam2", itemName)
    message.sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBER_CHEER")
    message.addMsg = ""
    Proc_ShowMessage_Ack_For_RewardSelect(message, 3.2, 22)
  elseif 12 == msgType then
    local message = ""
    message = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDDUELWILLBEEND")
    Proc_ShowMessage_Ack(message)
  end
end
function FromClient_NotifyGuildMemberDoPk(attackerGuildName, attackerUserNickName, attackerCharacterName, deadGuildName, deadUserNickName, deadCharacterName)
  local text = ""
  local myGuildMember = attackerUserNickName .. "(" .. attackerCharacterName .. ")"
  local deadUser = deadUserNickName .. "(" .. deadCharacterName .. ")"
  if "" ~= deadGuildName then
    text = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GUILD_MEMBER_PK_DO_OTHER_GUILD_MEMBER", "username", myGuildMember, "GuildName", deadGuildName, "targetUserName", deadUser)
  else
    text = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_MEMBER_PK_DO", "username", myGuildMember, "deadUser", deadUser)
  end
  Proc_ShowMessage_Ack(text)
end
function FromClient_NotifyGuildMemberKilledOtherPlayer(attackerGuildName, attackerUserNickName, attackerCharacterName, deadGuildName, deadUserNickName, deadCharacterName)
  local text = ""
  local myGuildMember = attackerUserNickName .. "(" .. attackerCharacterName .. ")"
  local deadUser = deadUserNickName .. "(" .. deadCharacterName .. ")"
  do return end
  if "" ~= deadGuildName then
    text = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GUILD_MEMBER_KILLEDBY_OTHER_GUILD_MEMBER", "username", myGuildMember, "GuildName", deadGuildName, "targetUserName", deadUser)
  else
    text = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_MEMBER_KILLEDBY_PC", "username", myGuildMember, "deadUser", deadUser)
  end
  Proc_ShowMessage_Ack(text)
end
function FromClient_ResponseGuildInviteForGuildGrade(targetActorKeyRaw, targetName, preGuildActivity)
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    _PA_ASSERT(false, "ResponseGuildInviteForGuildGrade \236\151\144\236\132\156 \234\184\184\235\147\156 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  if nil == targetName then
    _PA_ASSERT(false, "targetName \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  local guildGrade = myGuildInfo:getGuildGrade()
  if 0 == guildGrade then
    toClient_RequestInviteGuild(targetName, 0, 0, 0)
  else
    FGlobal_AgreementGuild_Master_Open_ForJoin(targetActorKeyRaw, targetName, preGuildActivity)
  end
end
function FromClient_ResponseDeclareGuildWarToMyGuild()
  if Panel_Window_Guild:GetShow() and GuildWarInfoPage._btnWarList2:IsCheck() then
    GuildWarInfoPage:UpdateData()
  end
end
function SetDATAByGuildGrade()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local guildGrade = myGuildInfo:getGuildGrade()
  local memberData
  local memberCount = myGuildInfo:getMemberCount()
  for memberIdx = 0, memberCount - 1 do
    memberData = myGuildInfo:getMember(memberIdx)
    if memberData:isSelf() then
      break
    end
  end
  if nil == memberData then
    return
  end
  if 0 == guildGrade then
    GuildManager.mainBtn_Info:SetEnable(true)
    GuildManager.mainBtn_History:SetEnable(false)
    GuildManager.mainBtn_Quest:SetEnable(false)
    GuildManager.mainBtn_Tree:SetEnable(false)
    GuildManager.mainBtn_Warfare:SetEnable(false)
    GuildInfoPage._btnChangeMark:SetEnable(false)
    GuildLetsWarPage._btnLetsWarDoWar:SetEnable(false)
    GuildLetsWarPage._editLetsWarInputName:SetEnable(false)
    GuildManager.mainBtn_Info:SetMonoTone(false)
    GuildManager.mainBtn_History:SetMonoTone(true)
    GuildManager.mainBtn_Quest:SetMonoTone(true)
    GuildManager.mainBtn_Tree:SetMonoTone(true)
    GuildManager.mainBtn_Warfare:SetMonoTone(true)
    GuildInfoPage._btnChangeMark:SetMonoTone(true)
    GuildLetsWarPage._btnLetsWarDoWar:SetMonoTone(true)
    GuildLetsWarPage._editLetsWarInputName:SetMonoTone(true)
    GuildInfoPage._btnTaxPayment:SetShow(false)
    GuildInfoPage._txtUnpaidTax:SetShow(false)
    GuildInfoPage._btnIncreaseMember:SetShow(false)
    GuildListInfoPage._btnPaypal:SetShow(false)
    GuildListInfoPage._btnGiveIncentive:SetShow(false)
    GuildListInfoPage._btnDeposit:SetShow(false)
    GuildListInfoPage._textBusinessFundsBG:SetShow(false)
    GuildListInfoPage.decoIcon_Guild:SetShow(false)
    GuildListInfoPage.decoIcon_Clan:SetShow(true)
    GuildInfoPage._windowTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_CLANNAME"))
    GuildInfoPage._textGuildInfoTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_CLANINFO"))
    GuildInfoPage._txtGuildName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_CLANNAMING"))
  else
    GuildManager.mainBtn_Info:SetEnable(true)
    GuildManager.mainBtn_History:SetEnable(true)
    GuildManager.mainBtn_Quest:SetEnable(true)
    GuildManager.mainBtn_Tree:SetEnable(true)
    GuildManager.mainBtn_Warfare:SetEnable(true)
    GuildInfoPage._btnChangeMark:SetEnable(true)
    GuildManager.mainBtn_Info:SetMonoTone(false)
    GuildManager.mainBtn_History:SetMonoTone(false)
    if isGameTypeEnglish() then
      GuildManager.mainBtn_Quest:SetMonoTone(true)
    else
      GuildManager.mainBtn_Quest:SetMonoTone(false)
    end
    GuildManager.mainBtn_Tree:SetMonoTone(false)
    GuildManager.mainBtn_Warfare:SetMonoTone(false)
    GuildInfoPage._btnChangeMark:SetMonoTone(false)
    GuildListInfoPage._btnDeposit:SetMonoTone(true)
    local accumulateTax_s64 = myGuildInfo:getAccumulateTax()
    local accumulateCost_s64 = myGuildInfo:getAccumulateGuildHouseCost()
    local businessFunds_s64 = myGuildInfo:getGuildBusinessFunds_s64()
    if accumulateTax_s64 > toInt64(0, 0) or accumulateCost_s64 > toInt64(0, 0) then
      GuildInfoPage._txtUnpaidTax:SetShow(true)
      if accumulateTax_s64 > businessFunds_s64 or accumulateCost_s64 > businessFunds_s64 then
        GuildListInfoPage._btnDeposit:SetMonoTone(false)
        GuildListInfoPage._btnDeposit:SetEnable(true)
      else
        GuildListInfoPage._btnDeposit:SetMonoTone(true)
        GuildListInfoPage._btnDeposit:SetEnable(false)
      end
    else
      GuildInfoPage._txtUnpaidTax:SetShow(false)
      GuildListInfoPage._btnDeposit:SetMonoTone(true)
      GuildListInfoPage._btnDeposit:SetEnable(false)
    end
    if getSelfPlayer():get():isGuildMaster() then
      GuildWarInfoPage._txtWarInfoTitle:SetSpanSize(50, 395)
      if accumulateTax_s64 > toInt64(0, 0) or accumulateCost_s64 > toInt64(0, 0) then
        GuildInfoPage._btnTaxPayment:SetShow(true)
      else
        GuildInfoPage._btnTaxPayment:SetShow(false)
      end
      if GuildManager._doHaveSeige then
        GuildListInfoPage._btnGiveIncentive:SetShow(true)
      else
        GuildListInfoPage._btnGiveIncentive:SetShow(false)
      end
    elseif getSelfPlayer():get():isGuildSubMaster() then
      GuildWarInfoPage._txtWarInfoTitle:SetSpanSize(50, 395)
      GuildInfoPage._btnIncreaseMember:SetShow(false)
      if accumulateTax_s64 > toInt64(0, 0) or accumulateCost_s64 > toInt64(0, 0) then
        GuildInfoPage._btnTaxPayment:SetShow(true)
      else
        GuildInfoPage._btnTaxPayment:SetShow(false)
      end
      GuildListInfoPage._btnGiveIncentive:SetShow(false)
    else
      GuildWarInfoPage._txtWarInfoTitle:SetSpanSize(50, 395)
      GuildInfoPage._btnIncreaseMember:SetShow(false)
      GuildInfoPage._btnTaxPayment:SetShow(false)
      GuildListInfoPage._btnGiveIncentive:SetShow(false)
    end
    if memberData:isCollectableBenefit() and false == memberData:isFreeAgent() and toInt64(0, 0) < memberData:getContractedBenefit() then
      GuildListInfoPage._btnPaypal:SetEnable(true)
      GuildListInfoPage._btnPaypal:SetMonoTone(false)
      if toInt64(0, 0) == businessFunds_s64 then
        GuildListInfoPage._btnPaypal:SetFontColor(UI_color.C_FFF26A6A)
      else
        GuildListInfoPage._btnPaypal:SetFontColor(UI_color.C_FFC4A68A)
      end
    else
      GuildListInfoPage._btnPaypal:SetEnable(false)
      GuildListInfoPage._btnPaypal:SetMonoTone(true)
    end
    GuildListInfoPage._btnPaypal:SetShow(true)
    GuildListInfoPage._textBusinessFundsBG:SetShow(true)
    GuildListInfoPage.decoIcon_Guild:SetShow(true)
    GuildListInfoPage.decoIcon_Clan:SetShow(false)
    GuildInfoPage._windowTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_GUILDNAME"))
    GuildInfoPage._textGuildInfoTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_GUILDINFO"))
    GuildInfoPage._txtGuildName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_GUILDNAMING"))
  end
end
function Guild_onScreenResize()
  Panel_Window_Guild:SetPosX(getScreenSizeX() / 2 - Panel_Window_Guild:GetSizeX() / 2)
  Panel_Window_Guild:SetPosY(getScreenSizeY() / 2 - Panel_Window_Guild:GetSizeY() / 2)
end
local targetUserNo, targetGuildNo, targetGuildName
function FromClient_RequestGuildWar(userNo, guildNo, guildName)
  if MessageBox.isPopUp() and targetGuildNo == guildNo then
    return
  end
  if isGameTypeJapan() or isGameTypeKR2() then
    keyUseCheck = false
  end
  targetUserNo = userNo
  targetGuildNo = guildNo
  targetGuildName = guildName
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_DECLAREWAR", "guildName", targetGuildName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = FGlobal_AcceptGuildWar,
    functionNo = FGlobal_RefuseGuildWar,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, nil, nil, keyUseCheck)
end
function FGlobal_AcceptGuildWar()
  ToClient_RequestDeclareGuildWar(targetGuildNo, targetGuildName, true)
  targetUserNo = nil
  targetGuildNo = nil
  targetGuildName = nil
end
function FGlobal_RefuseGuildWar()
  ToClient_RequestRefuseGuildWar(targetUserNo, targetGuildName)
  targetUserNo = nil
  targetGuildNo = nil
  targetGuildName = nil
end
function HandleClickedGuildDuel(index)
  local guildWrapper = ToClient_GetWarringGuildListAt(index)
  local guildNo_s64 = guildWrapper:getGuildNo()
  FGlobal_GuildDuel_Open(guildNo_s64)
end
function HandleOnOut_GuildDuelInfo_Tooltip(isShow, gIdx, uiIdx)
  if isShow then
    local guildwarWrapper = ToClient_GetWarringGuildListAt(gIdx)
    local guildNo_s64 = guildwarWrapper:getGuildNo()
    local deadline = ToClient_GetGuildDuelDeadline_s64(guildNo_s64)
    local lefttimeText = convertStringFromDatetime(getLeftSecond_TTime64(deadline))
    local targetKillCount = ToClient_GetGuildDuelTargetKillByGuild(guildNo_s64)
    local fightMoney_s64 = ToClient_GetGuildDuelPrizeByGuild_s64(guildNo_s64)
    local control = GuildWarInfoPage._list[uiIdx]._guildShowbuScore
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDDUEL_INFOTOOLTIP_TITLE")
    local desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GUILD_GUILDDUEL_INFOTOOLTIP_DESC", "targetKillCount", targetKillCount, "fightMoney", makeDotMoney(fightMoney_s64), "time", lefttimeText)
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function Notice_Init()
  notice_edit:SetMaxInput(40)
  notice_btn:addInputEvent("Mouse_LUp", "Notice_Regist()")
  notice_edit:addInputEvent("Mouse_LUp", "HandleClicked_NoticeEditSetFocus()")
  notice_edit:RegistReturnKeyEvent("Notice_Regist()")
end
function Notice_Regist()
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  if false == isGuildMaster and false == isGuildSubMaster then
    return
  end
  local close_function = function()
    CheckChattingInput()
  end
  ToClient_RequestSetGuildNotice(tostring(notice_edit:GetEditText()))
  close_function()
  ClearFocusEdit()
end
function HandleClicked_NoticeEditSetFocus()
  SetFocusEdit(notice_edit)
  notice_edit:SetEditText(notice_edit:GetEditText(), true)
end
function FromClient_ResponseGuildNotice()
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  local guildNotice = guildWrapper:getGuildNotice()
  notice_edit:SetEditText(guildNotice, false)
end
function FGlobal_Notice_Update()
  FGlobal_Notice_AuthorizationUpdate()
end
function FGlobal_Notice_AuthorizationUpdate()
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  if true == isGuildMaster or true == isGuildSubMaster then
    notice_edit:SetIgnore(false)
  else
    notice_edit:SetIgnore(true)
  end
end
function FGlobal_GuildNoticeClearFocusEdit()
  ClearFocusEdit()
  CheckChattingInput()
end
function FGlobal_CheckGuildNoticeUiEdit(targetUI)
  return nil ~= targetUI and targetUI:GetKey() == notice_edit:GetKey()
end
function Introduce_Init()
  if isGameTypeTaiwan() then
    introduce_edit_TW:SetMaxEditLine(7)
  else
    introduce_edit:SetMaxEditLine(10)
  end
  introduce_edit:SetMaxInput(200)
  introduce_edit_TW:SetMaxInput(200)
  promote_btn:addInputEvent("Mouse_LUp", "Guild_Promote_Confirm()")
  promote_btn:addInputEvent("Mouse_On", "Promote_Tooltip(true)")
  promote_btn:addInputEvent("Mouse_Out", "Promote_Tooltip(false)")
  introduce_btn:addInputEvent("Mouse_LUp", "Introduce_Regist()")
  introduce_Reset:addInputEvent("Mouse_LUp", "Introduce_Reset()")
  introduce_edit:addInputEvent("Mouse_LUp", "HandleClicked_IntroduceEditSetFocus()")
  introduce_edit_TW:addInputEvent("Mouse_LUp", "HandleClicked_IntroduceEditSetFocus()")
end
function HandleClicked_IntroduceEditSetFocus()
  if isGameTypeTaiwan() then
    SetFocusEdit(introduce_edit_TW)
    introduce_edit_TW:SetEditText(introduce_edit_TW:GetEditText(), true)
  else
    SetFocusEdit(introduce_edit)
    introduce_edit:SetEditText(introduce_edit:GetEditText(), true)
  end
end
function FGlobal_GuildIntroduceClearFocusEdit()
  ClearFocusEdit()
  CheckChattingInput()
end
function Guild_Promote_Confirm()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROMOTE_BTN_MESSAGE_DESC")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = Guild_Promote,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function Guild_Promote()
  local selfProxy = getSelfPlayer():get()
  local isGuildMaster = selfProxy:isGuildMaster()
  local isGuildSubMaster = selfProxy:isGuildSubMaster()
  if false == isGuildMaster and false == isGuildSubMaster then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  local guildIntroduce = guildWrapper:getGuildIntrodution()
  ToClient_SetLinkedGuildInfoByGuild()
  chatting_sendMessageNoMatterEmpty("", guildIntroduce, CppEnums.ChatType.World)
end
function Promote_Tooltip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROMOTE_BTN_TITLE")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROMOTE_BTN_DESC")
  control = promote_btn
  TooltipSimple_Show(control, name, desc)
end
function Introduce_Regist()
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  if false == isGuildMaster and false == isGuildSubMaster then
    return
  end
  local close_function = function()
    CheckChattingInput()
  end
  if isGameTypeTaiwan() then
    ToClient_RequestSetIntrodution(tostring(introduce_edit_TW:GetEditText()))
  else
    ToClient_RequestSetIntrodution(tostring(introduce_edit:GetEditText()))
  end
  close_function()
  ClearFocusEdit()
end
function Introduce_Reset()
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  if false == isGuildMaster and false == isGuildSubMaster then
    return
  end
  if isGameTypeTaiwan() then
    introduce_edit_TW:SetEditText("", true)
  else
    introduce_edit:SetEditText("", true)
  end
  ToClient_RequestSetIntrodution(tostring(""))
end
function GuildIntroduce_Update()
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  local guildIntroduce = guildWrapper:getGuildIntrodution()
  if isGameTypeTaiwan() then
    introduce_edit_TW:SetEditText(guildIntroduce, false)
  else
    introduce_edit:SetEditText(guildIntroduce, false)
  end
end
function FGlobal_CheckGuildIntroduceUiEdit(targetUI)
  if isGameTypeTaiwan() then
    return nil ~= targetUI and targetUI:GetKey() == introduce_edit_TW:GetKey()
  else
    return nil ~= targetUI and targetUI:GetKey() == introduce_edit:GetKey()
  end
end
function FromWeb_WebPageError(url, statusCode)
  if 200 ~= statusCode then
    return
  end
  if _urlCache ~= url then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local startIndex = string.find(url, "?")
  if nil ~= startIndex then
    local _url = string.sub(url, 1, startIndex - 1)
    if PaGlobal_URL_Check(worldNo) == _url then
      _Web:SetShow(true)
      return
    end
  end
  _Web:SetShow(false)
end
function HandleClickedGetArshaHost()
  if false == isContentsArsha or false == isCanDoReservation then
    return
  end
  local isHost = ToClient_IsCompetitionHost()
  local messageBoxMemo = ""
  local func = function()
    ToClient_RequestGetHostByReservationInfo()
  end
  if false == isHost then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_LENT_ARSHAHOST")
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_RELEASE_ARSHAHOST")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = func,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function Guild_PopUp_ShowIconToolTip(isShow)
  if isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if checkPopUp:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(checkPopUp, name, desc)
  else
    TooltipSimple_Hide()
  end
end
registerEvent("FromClient_ResponseGuildUpdate", "FromClient_ResponseGuildUpdate")
registerEvent("ResponseGuild_invite", "FromClient_ResponseGuild_invite")
registerEvent("ResponseGuild_refuse", "FromClient_ResponseGuild_refuse")
registerEvent("ResponseGuildAlliance_invite", "FromClient_ResponseGuildAlliance_invite")
registerEvent("ResponseGuildAlliance_refuse", "FromClient_ResponseGuildAlliance_refuse")
registerEvent("EventChangeGuildInfo", "FromClient_EventActorChangeGuildInfo")
registerEvent("FromClient_UpdateGuildContract", "FromClient_ResponseUpdateGuildContract")
registerEvent("FromClient_NotifyGuildMessage", "FromClient_NotifyGuildMessage")
registerEvent("FromClient_GuildInviteForGuildGrade", "FromClient_ResponseGuildInviteForGuildGrade")
registerEvent("FromClient_ResponseDeclareGuildWarToMyGuild ", "FromClient_ResponseDeclareGuildWarToMyGuild")
registerEvent("FromClient_RequestGuildWar", "FromClient_RequestGuildWar")
registerEvent("FromClient_ResponseGuildNotice", "FromClient_ResponseGuildNotice")
registerEvent("FromClient_GuildListUpdate", "FromClient_GuildListUpdate")
registerEvent("FromWeb_WebPageError", "FromWeb_WebPageError")
registerEvent("onScreenResize", "Guild_onScreenResize")
registerEvent("FromClient_luaLoadComplete", "Guild_Init")
function Guild_Init()
  GuildManager:initialize()
  GuildMainInfo_Show()
  Notice_Init()
  Introduce_Init()
  GuildManager.mainBtn_GuildBattle:SetShow(isGuildBattle)
end
function Test_GiveMeGuildWelfare()
  ToClient_RequestguildWelfare()
end
