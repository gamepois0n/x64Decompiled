Panel_Guild_IncentiveOption:SetShow(false)
Panel_Guild_IncentiveOption:ActiveMouseEventEffect(true)
Panel_Guild_IncentiveOption:setMaskingChild(true)
Panel_Guild_IncentiveOption:setGlassBackground(true)
Panel_Guild_IncentiveOption:SetDragEnable(true)
Panel_Guild_IncentiveOption:SetDragAll(true)
Panel_Guild_Incentive_Foundation:SetDragEnable(true)
Panel_Guild_Incentive_Foundation:SetDragAll(true)
local UI_TM = CppEnums.TextMode
local UCT = CppEnums.PA_UI_CONTROL_TYPE
local IM = CppEnums.EProcessorInputMode
local maxGuildList = 20
local maxIncentiveGrade = 4
local _guildList = {}
local _selectedMemberIndex = 0
local _selectSortType = -1
local _listSort = {name = false}
local tempGuildIncentive = {}
local tempGuildList = {}
local _frameGuildList = UI.getChildControl(Panel_Guild_IncentiveOption, "Frame_GuildList")
local _contentGuildList = UI.getChildControl(_frameGuildList, "Frame_1_Content")
local _scroll = UI.getChildControl(_frameGuildList, "VerticalScroll")
local _guildFoundationValue = UI.getChildControl(Panel_Guild_IncentiveOption, "StaticText_GuildMoney")
local _guildMoney = UI.getChildControl(Panel_Guild_IncentiveOption, "StaticText_GuildMoney_Value")
local _totalIncentiveValue = UI.getChildControl(Panel_Guild_IncentiveOption, "StaticText_Incentive_Value")
local _leftTime = UI.getChildControl(Panel_Guild_IncentiveOption, "StaticText_Incentive_LeftTime")
local _leftTimeValue = UI.getChildControl(Panel_Guild_IncentiveOption, "StaticText_Incentive_LeftTimeValue")
local _btnIncentive = UI.getChildControl(Panel_Guild_IncentiveOption, "Button_Incentive")
local _btnClose = UI.getChildControl(Panel_Guild_IncentiveOption, "Button_WinClose")
local _btnQuestion = UI.getChildControl(Panel_Guild_IncentiveOption, "Button_Question")
local guildIncentiveMoneyValue = {
  _btn_Apply = UI.getChildControl(Panel_Guild_Incentive_Foundation, "Button_Apply"),
  _btn_Close = UI.getChildControl(Panel_Guild_Incentive_Foundation, "Button_Cancel"),
  _txt_Desc = UI.getChildControl(Panel_Guild_Incentive_Foundation, "StaticText_Desc"),
  _txt_Founds = UI.getChildControl(Panel_Guild_Incentive_Foundation, "StaticText_Founds"),
  _edit_MoneyValue = UI.getChildControl(Panel_Guild_Incentive_Foundation, "Edit_MoneyValue")
}
_btnIncentive:addInputEvent("Mouse_LUp", "Give_Incentive()")
_btnClose:addInputEvent("Mouse_LUp", "Panel_GuildIncentiveOption_Close()")
_btnQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelGuild\" )")
_btnQuestion:addInputEvent("Mouse_On", "HelpMessageQuestion_Show( \"PanelGuild\", \"true\")")
_btnQuestion:addInputEvent("Mouse_Out", "HelpMessageQuestion_Show( \"PanelGuild\", \"false\")")
local Guild_Incentive = {
  _memberGrade = UI.getChildControl(Panel_Guild_IncentiveOption, "StaticText_C_Grade"),
  _memberName = UI.getChildControl(Panel_Guild_IncentiveOption, "StaticText_C_CharName"),
  _memberContribution = UI.getChildControl(Panel_Guild_IncentiveOption, "StaticText_C_ContributedTendency"),
  _memberIncentiveValue = UI.getChildControl(Panel_Guild_IncentiveOption, "StaticText_C_IncentiveValue"),
  _comboboxRank = UI.getChildControl(Panel_Guild_IncentiveOption, "Combobox_Destination"),
  _radio_Level1 = UI.getChildControl(Panel_Guild_IncentiveOption, "RadioButton_Level1"),
  _radio_Level2 = UI.getChildControl(Panel_Guild_IncentiveOption, "RadioButton_Level2"),
  _radio_Level3 = UI.getChildControl(Panel_Guild_IncentiveOption, "RadioButton_Level3"),
  _radio_Level4 = UI.getChildControl(Panel_Guild_IncentiveOption, "RadioButton_Level4"),
  _txt_Level = UI.getChildControl(Panel_Guild_IncentiveOption, "StaticText_Level"),
  _title_CharName = UI.getChildControl(Panel_Guild_IncentiveOption, "StaticText_M_CharName"),
  _title_Ap = UI.getChildControl(Panel_Guild_IncentiveOption, "StaticText_M_ContributedTendency")
}
Guild_Incentive._memberGrade:SetShow(false)
Guild_Incentive._memberName:SetShow(false)
Guild_Incentive._memberContribution:SetShow(false)
Guild_Incentive._memberIncentiveValue:SetShow(false)
Guild_Incentive._comboboxRank:SetShow(false)
Guild_Incentive._radio_Level1:SetShow(false)
Guild_Incentive._radio_Level2:SetShow(false)
Guild_Incentive._radio_Level3:SetShow(false)
Guild_Incentive._radio_Level4:SetShow(false)
Guild_Incentive._txt_Level:SetShow(false)
local _ySize = Guild_Incentive._memberGrade:GetSizeY()
local frameTextGap = 10
local _memberCtrlCount = 0
function Guild_Incentive:ResetControl()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  _guildMoney:SetText(0 .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_INCENTIVE_MONEY"))
  _memberCtrlCount = myGuildListInfo:getMemberCount()
  if maxGuildList < _memberCtrlCount then
    _scroll:SetShow(true)
  else
    _scroll:SetShow(false)
  end
  _contentGuildList:DestroyAllChild()
  for i = 1, _memberCtrlCount do
    local index = i - 1
    _guildList[index] = {}
    _guildList[index]._memberGrade = UI.createControl(UCT.PA_UI_CONTROL_STATICTEXT, _contentGuildList, "StaticText_Grade_" .. i)
    _guildList[index]._memberName = UI.createControl(UCT.PA_UI_CONTROL_STATICTEXT, _contentGuildList, "StaticText_MemberName_" .. i)
    _guildList[index]._memberContribution = UI.createControl(UCT.PA_UI_CONTROL_STATICTEXT, _contentGuildList, "StaticText_MemberContribution_" .. i)
    _guildList[index]._memberIncentiveValue = UI.createControl(UCT.PA_UI_CONTROL_STATICTEXT, _contentGuildList, "StaticText_memberIncentiveValue_" .. i)
    _guildList[index]._comboboxRank = UI.createControl(UCT.PA_UI_CONTROL_COMBOBOX, _contentGuildList, "Combobox_Rank_" .. i)
    _guildList[index]._level1 = UI.createControl(UCT.PA_UI_CONTROL_RADIOBUTTON, _contentGuildList, "Radiobutton_Level1_" .. i)
    _guildList[index]._level2 = UI.createControl(UCT.PA_UI_CONTROL_RADIOBUTTON, _contentGuildList, "Radiobutton_Level2_" .. i)
    _guildList[index]._level3 = UI.createControl(UCT.PA_UI_CONTROL_RADIOBUTTON, _contentGuildList, "Radiobutton_Level3_" .. i)
    _guildList[index]._level4 = UI.createControl(UCT.PA_UI_CONTROL_RADIOBUTTON, _contentGuildList, "Radiobutton_Level4_" .. i)
    _guildList[index]._level = UI.createControl(UCT.PA_UI_CONTROL_STATICTEXT, _contentGuildList, "StaticText_Level_" .. i)
    CopyBaseProperty(Guild_Incentive._memberGrade, _guildList[index]._memberGrade)
    CopyBaseProperty(Guild_Incentive._memberName, _guildList[index]._memberName)
    CopyBaseProperty(Guild_Incentive._memberContribution, _guildList[index]._memberContribution)
    CopyBaseProperty(Guild_Incentive._memberIncentiveValue, _guildList[index]._memberIncentiveValue)
    CopyBaseProperty(Guild_Incentive._comboboxRank, _guildList[index]._comboboxRank)
    CopyBaseProperty(Guild_Incentive._radio_Level1, _guildList[index]._level1)
    CopyBaseProperty(Guild_Incentive._radio_Level2, _guildList[index]._level2)
    CopyBaseProperty(Guild_Incentive._radio_Level3, _guildList[index]._level3)
    CopyBaseProperty(Guild_Incentive._radio_Level4, _guildList[index]._level4)
    CopyBaseProperty(Guild_Incentive._txt_Level, _guildList[index]._level)
    _guildList[index]._level1:SetGroup(i)
    _guildList[index]._level2:SetGroup(_guildList[index]._level1:GetGroupNumber())
    _guildList[index]._level3:SetGroup(_guildList[index]._level1:GetGroupNumber())
    _guildList[index]._level4:SetGroup(_guildList[index]._level1:GetGroupNumber())
    local guildMemberInfo = myGuildListInfo:getMember(i - 1)
    local gradeType = guildMemberInfo:getGrade()
    local gradeValue = ""
    if 0 == gradeType then
      gradeValue = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDMASTER")
    elseif 1 == gradeType then
      gradeValue = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDSUBMASTER")
    elseif 2 == gradeType then
      gradeValue = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDMEMBER")
    elseif 3 == gradeType then
      gradeValue = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_SUPPLYOFFICER")
    end
    _guildList[index]._memberGrade:SetText(gradeValue)
    _guildList[index]._memberName:SetText(guildMemberInfo:getName() .. " (" .. guildMemberInfo:getCharacterName() .. ")")
    local tempActivityText = "0"
    _guildList[index]._memberContribution:SetText(tempActivityText)
    local posY = 0
    posY = (_ySize + frameTextGap / 2) * index + frameTextGap
    _guildList[index]._memberGrade:SetPosY(posY)
    _guildList[index]._memberGrade:SetShow(true)
    _guildList[index]._memberName:SetPosY(posY)
    _guildList[index]._memberName:SetShow(true)
    _guildList[index]._memberContribution:SetPosY(posY)
    _guildList[index]._memberContribution:SetShow(true)
    _guildList[index]._memberIncentiveValue:SetPosY(posY)
    _guildList[index]._memberIncentiveValue:SetShow(true)
    _guildList[index]._comboboxRank:SetPosY(posY)
    _guildList[index]._level1:SetPosY(posY)
    _guildList[index]._level2:SetPosY(posY)
    _guildList[index]._level3:SetPosY(posY)
    _guildList[index]._level4:SetPosY(posY)
    _guildList[index]._level:SetPosY(posY)
    _guildList[index]._comboboxRank:SetShow(false)
    _guildList[index]._level1:SetShow(true)
    _guildList[index]._level2:SetShow(true)
    _guildList[index]._level3:SetShow(true)
    _guildList[index]._level4:SetShow(true)
    _guildList[index]._level:SetShow(true)
    _guildList[index]._level:SetText("<PAColor0xFFF26A6A>1<PAOldColor> \235\139\168\234\179\132")
    _guildList[index]._comboboxRank:DeleteAllItem()
    for i = 1, maxIncentiveGrade do
      _guildList[index]._comboboxRank:AddItem(i)
    end
    _guildList[index]._level1:addInputEvent("Mouse_LUp", "Set_Incentive_Grade(" .. index .. ")")
    _guildList[index]._level2:addInputEvent("Mouse_LUp", "Set_Incentive_Grade(" .. index .. ")")
    _guildList[index]._level3:addInputEvent("Mouse_LUp", "Set_Incentive_Grade(" .. index .. ")")
    _guildList[index]._level4:addInputEvent("Mouse_LUp", "Set_Incentive_Grade(" .. index .. ")")
    _guildList[index]._comboboxRank:SetText(1)
    _guildList[index]._comboboxRank:addInputEvent("Mouse_LUp", "click_Incentive_GradeList(" .. index .. ")")
    _guildList[index]._comboboxRank:GetListControl():addInputEvent("Mouse_LUp", "Set_Incentive_Grade(" .. index .. ")")
  end
  Panel_Guild_IncentiveOption:SetChildIndex(Guild_Incentive._title_CharName, 9999)
  Panel_Guild_IncentiveOption:SetChildIndex(Guild_Incentive._title_Ap, 9999)
  _frameGuildList:UpdateContentScroll()
  _scroll:SetControlTop()
  _frameGuildList:UpdateContentPos()
end
function Guild_Incentive:UpdateData()
  GuildIncentive_SetGuildIncentive()
  GuildIncentive_updateSort()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local businessFunds = myGuildListInfo:getGuildBusinessFunds_s64()
  local totalMoney64 = ToClient_getGuildTotalIncentiveMoney_s64()
  _guildFoundationValue:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVE_FOUNDATIONVALUE", "businessFunds", makeDotMoney(businessFunds), "totalMoney64", makeDotMoney(totalMoney64)))
  local memberCount = myGuildListInfo:getMemberCount()
  local leftTime = myGuildListInfo:getIncentiveDate()
  if 0 < Int64toInt32(leftTime) then
    local lefttimeText = convertStringFromDatetime(getLeftSecond_TTime64(leftTime))
    _leftTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVE_LEFTTIMETEXT", "lefttimeText", lefttimeText))
    _leftTime:SetShow(true)
    _leftTimeValue:SetShow(false)
  else
    _leftTimeValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVE_LEFTTIMEVALUE"))
    _leftTimeValue:SetShow(true)
    _leftTime:SetShow(false)
  end
  for i = 1, memberCount do
    local index = i - 1
    local dataIdx = tempGuildIncentive[index + 1].idx
    local guildMemberInfo = myGuildListInfo:getMember(dataIdx)
    local gradeType = guildMemberInfo:getGrade()
    local gradeValue = ""
    if 0 == gradeType then
      gradeValue = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDMASTER")
    elseif 1 == gradeType then
      gradeValue = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDSUBMASTER")
    elseif 2 == gradeType then
      gradeValue = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDMEMBER")
    elseif 3 == gradeType then
      gradeValue = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_SUPPLYOFFICER")
    end
    _guildList[index]._memberGrade:SetText(gradeValue)
    if true == guildMemberInfo:isOnline() then
      _guildList[index]._memberName:SetText(guildMemberInfo:getName() .. " (" .. guildMemberInfo:getCharacterName() .. ")")
      local usableActivity = guildMemberInfo:getUsableActivity()
      if usableActivity > 10000 then
        usableActivity = 10000
      end
      local tempActivityText = tostring(guildMemberInfo:getTotalActivity()) .. "(<PAColor0xfface400>+" .. tostring(usableActivity) .. "<PAOldColor>)"
      _guildList[index]._memberContribution:SetText(tempActivityText)
    else
      _guildList[index]._memberName:SetText(guildMemberInfo:getName() .. " ( - )")
      local tempActivityText = tostring(guildMemberInfo:getTotalActivity()) .. "(+" .. tostring(guildMemberInfo:getUsableActivity()) .. ")"
      _guildList[index]._memberContribution:SetText(tempActivityText)
    end
    _guildList[index]._level1:SetCheck(false)
    _guildList[index]._level2:SetCheck(false)
    _guildList[index]._level3:SetCheck(false)
    _guildList[index]._level4:SetCheck(false)
    local grade = ToClient_getGuildMemberIncentiveGrade(dataIdx)
    _guildList[index]._level1:SetCheck(1 == grade)
    _guildList[index]._level2:SetCheck(2 == grade)
    _guildList[index]._level3:SetCheck(3 == grade)
    _guildList[index]._level4:SetCheck(4 == grade)
    local level1 = _guildList[index]._level1:IsCheck()
    local level2 = _guildList[index]._level2:IsCheck()
    local level3 = _guildList[index]._level3:IsCheck()
    local level4 = _guildList[index]._level4:IsCheck()
    _guildList[index]._level:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVE_GRADE_FOR_WHAT", "grade", grade))
    local incentive = ToClient_getGuildMemberIncentiveMoney_s64(dataIdx)
    _guildList[index]._memberIncentiveValue:SetText(makeDotMoney(incentive))
    _guildList[index]._comboboxRank:SetText(tostring(grade))
  end
  _scroll:SetInterval(_contentGuildList:GetSizeY() / 100 * 1.1)
end
function click_Incentive_GradeList(index)
  _selectedMemberIndex = index
  local listCombbox = _guildList[index]._comboboxRank:GetListControl()
  if _frameGuildList:GetSizeY() - _contentGuildList:GetPosY() - listCombbox:GetSizeY() < _guildList[index]._comboboxRank:GetPosY() then
    listCombbox:SetPosY(listCombbox:GetSizeY() * -1)
  else
    listCombbox:SetPosY(_guildList[index]._comboboxRank:GetSizeY())
  end
  _guildList[index]._comboboxRank:ToggleListbox()
  _contentGuildList:SetChildIndex(_guildList[index]._comboboxRank, 9999)
end
function Set_Incentive_Grade(index)
  local dataIdx = tempGuildIncentive[index + 1].idx
  _guildList[index]._comboboxRank:SetSelectItemIndex(_guildList[index]._comboboxRank:GetSelectIndex())
  local grade = 1
  _guildList[index]._comboboxRank:SetText(tostring(grade))
  _guildList[index]._comboboxRank:ToggleListbox()
  local level1 = _guildList[index]._level1:IsCheck()
  local level2 = _guildList[index]._level2:IsCheck()
  local level3 = _guildList[index]._level3:IsCheck()
  local level4 = _guildList[index]._level4:IsCheck()
  if level1 then
    grade = 1
  elseif level2 then
    grade = 2
  elseif level3 then
    grade = 3
  elseif level4 then
    grade = 4
  end
  local editMoney = tonumber64(string.gsub(guildIncentiveMoneyValue._edit_MoneyValue:GetEditText(), ",", ""))
  ToClient_SetGuildMemberIncentiveGrade(dataIdx, grade, editMoney)
  Guild_Incentive:UpdateData()
end
function Give_Incentive()
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_INCENTIVE_PAYMENTS")
  local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_INCENTIVE_PAYMENTS_CONFIRM")
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = PayIncentiveConfirm,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PayIncentiveConfirm()
  ToClient_PayGuildMemberIncentive()
  Panel_GuildIncentiveOption_Close()
  Panel_Guild_Incentive_Foundation_Close()
end
function Panel_GuildIncentiveOption_ShowToggle()
  if Panel_Guild_IncentiveOption:GetShow() then
    Panel_GuildIncentiveOption_Close()
    Panel_Guild_Incentive_Foundation_Close()
  else
    Panel_Guild_Incentive_Foundation_Open()
  end
end
function Panel_GuildIncentiveOption_Close()
  if Panel_Guild_IncentiveOption:GetShow() then
    Panel_Guild_IncentiveOption:SetShow(false)
    Panel_Guild_Incentive_Foundation_Close()
  end
end
function Panel_Guild_IncentiveOption_Resize()
  Panel_Guild_IncentiveOption:SetPosX(getScreenSizeX() / 2 - Panel_Guild_IncentiveOption:GetSizeX() / 2)
  Panel_Guild_IncentiveOption:SetPosY(getScreenSizeY() / 2 - Panel_Guild_IncentiveOption:GetSizeY() / 2 - 50)
end
function Panel_Guild_Incentive_Foundation_Init()
  local self = guildIncentiveMoneyValue
  self._txt_Desc:SetTextMode(UI_TM.eTextMode_AutoWrap)
  self._txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVE_FOUNDATION_DESC"))
  Panel_Guild_Incentive_Foundation:SetSize(Panel_Guild_Incentive_Foundation:GetSizeX(), self._txt_Desc:GetTextSizeY() + 210)
  self._btn_Close:ComputePos()
  self._btn_Apply:ComputePos()
  self._edit_MoneyValue:SetEditText("", true)
  self._btn_Close:addInputEvent("Mouse_LUp", "Panel_Guild_Incentive_Foundation_Close()")
  self._edit_MoneyValue:addInputEvent("Mouse_LUp", "Panel_Guild_Incentive_Foundation_Editing()")
  Guild_Incentive._title_CharName:addInputEvent("Mouse_LUp", "HandleClicked_GuildIncentiveSort(0)")
  Guild_Incentive._title_Ap:addInputEvent("Mouse_LUp", "HandleClicked_GuildIncentiveSort(1)")
end
function Panel_Guild_Incentive_Foundation_Update()
  local self = guildIncentiveMoneyValue
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local businessFunds = myGuildListInfo:getGuildBusinessFunds_s64()
  local businessFunds10 = businessFunds * toInt64(0, 10) / toInt64(0, 100)
  local businessFunds30 = businessFunds * toInt64(0, 30) / toInt64(0, 100)
  self._txt_Founds:SetText(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVE_FOUNDATION_RANGEOFMONEY", "businessFunds", makeDotMoney(businessFunds), "businessFunds10", makeDotMoney(businessFunds10), "businessFunds30", makeDotMoney(businessFunds30)))
  self._btn_Apply:addInputEvent("Mouse_LUp", "Panel_Guild_Incentive_Foundation_MainShowToggle()")
end
function Panel_Guild_Incentive_Foundation_MainShowToggle()
  local self = guildIncentiveMoneyValue
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local businessFunds = myGuildListInfo:getGuildBusinessFunds_s64()
  local businessFunds10 = businessFunds * toInt64(0, 10) / toInt64(0, 100)
  local businessFunds30 = businessFunds * toInt64(0, 30) / toInt64(0, 100)
  local editMoney = tonumber64(string.gsub(self._edit_MoneyValue:GetEditText(), ",", ""))
  if businessFunds10 > editMoney or businessFunds30 < editMoney then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVE_FOUNDATION_RANGEOFMONEY_ALERT"))
    return
  end
  if Panel_Guild_IncentiveOption:GetShow() then
    Panel_GuildIncentiveOption_Close()
    Panel_Guild_Incentive_Foundation_Close()
  else
    ToClient_InitGuildIncentiveList(editMoney)
    Panel_Guild_IncentiveOption:SetShow(true)
    Guild_Incentive:ResetControl()
    Guild_Incentive:UpdateData()
    Panel_Guild_IncentiveOption_Resize()
    Panel_Guild_Incentive_Foundation_Close()
  end
end
function Panel_Guild_Incentive_Foundation_Editing()
  local self = guildIncentiveMoneyValue
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local businessFunds = myGuildListInfo:getGuildBusinessFunds_s64()
  local businessFunds10 = businessFunds * toInt64(0, 10) / toInt64(0, 100)
  local businessFunds30 = businessFunds * toInt64(0, 30) / toInt64(0, 100)
  Panel_NumberPad_Show(true, businessFunds30, nil, Panel_Guild_Incentive_Foundation_ConfirmFunction)
end
function Panel_Guild_Incentive_Foundation_ConfirmFunction(inputNumber, param)
  local self = guildIncentiveMoneyValue
  self._edit_MoneyValue:SetEditText(makeDotMoney(inputNumber), false)
end
function FGlobal_CheckGuildIncentiveUiEdit(targetUI)
  return nil ~= targetUI and targetUI:GetKey() == guildIncentiveMoneyValue._edit_MoneyValue:GetKey()
end
function FGlobal_GuildIncentiveClearFocusEdit()
  ClearFocusEdit()
  CheckChattingInput()
end
function Panel_Guild_Incentive_Foundation_Open()
  Panel_Guild_Incentive_Foundation:SetShow(true)
  guildIncentiveMoneyValue._edit_MoneyValue:SetEditText("0", true)
  Panel_Guild_Incentive_Foundation_Update()
end
function Panel_Guild_Incentive_Foundation_Close()
  Panel_Guild_Incentive_Foundation:SetShow(false)
end
function GuildIncentive_TitleLineReset()
  local self = Guild_Incentive
  self._title_CharName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GUILD_TEXT_CHARNAME"))
  self._title_Ap:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GUILD_TEXT_ACTIVITY"))
end
function GuildIncentive_SetGuildIncentive()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local memberCount = myGuildListInfo:getMemberCount()
  tempGuildIncentive = {}
  for index = 1, memberCount do
    local myGuildMemberInfo = myGuildListInfo:getMember(index - 1)
    tempGuildIncentive[index] = {
      idx = index - 1,
      online = myGuildMemberInfo:isOnline(),
      grade = myGuildMemberInfo:getGrade(),
      level = myGuildMemberInfo:getLevel(),
      class = myGuildMemberInfo:getClassType(),
      name = myGuildMemberInfo:getName(),
      ap = Int64toInt32(myGuildMemberInfo:getTotalActivity()),
      expiration = myGuildMemberInfo:getContractedExpirationUtc(),
      wp = myGuildMemberInfo:getMaxWp(),
      kp = myGuildMemberInfo:getExplorationPoint(),
      userNo = myGuildMemberInfo:getUserNo()
    }
  end
end
local function guildIncentiveCompareName(w1, w2)
  if true == _listSort.name then
    if w1.name < w2.name then
      return true
    end
  elseif w2.name < w1.name then
    return true
  end
end
local function guildIncentiveCompareAp(w1, w2)
  if true == _listSort.ap then
    if w2.ap < w1.ap then
      return true
    end
  elseif w1.ap < w2.ap then
    return true
  end
end
function HandleClicked_GuildIncentiveSort(sortType)
  local self = Guild_Incentive
  GuildIncentive_TitleLineReset()
  _selectSortType = sortType
  if 0 == sortType then
    if false == _listSort.name then
      self._title_CharName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GUILD_TEXT_CHARNAME") .. "\226\150\178")
      _listSort.name = true
    else
      self._title_CharName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GUILD_TEXT_CHARNAME") .. "\226\150\188")
      _listSort.name = false
    end
    table.sort(tempGuildIncentive, guildIncentiveCompareName)
  elseif 1 == sortType then
    if false == _listSort.ap then
      self._title_Ap:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GUILD_TEXT_ACTIVITY") .. "\226\150\178")
      _listSort.ap = true
    else
      self._title_Ap:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GUILD_TEXT_ACTIVITY") .. "\226\150\188")
      _listSort.ap = false
    end
    table.sort(tempGuildIncentive, guildIncentiveCompareAp)
  end
  Guild_Incentive:UpdateData()
end
function GuildIncentive_updateSort()
  local self = Guild_Incentive
  if 0 == _selectSortType then
    table.sort(tempGuildIncentive, guildIncentiveCompareName)
  elseif 1 == _selectSortType then
    table.sort(tempGuildIncentive, guildIncentiveCompareAp)
  end
end
Panel_Guild_Incentive_Foundation_Init()
registerEvent("onScreenResize", "Panel_Guild_IncentiveOption_Resize")
