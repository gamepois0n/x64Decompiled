local UI_TM = CppEnums.TextMode
local UI_color = Defines.Color
local UCT = CppEnums.PA_UI_CONTROL_TYPE
local UI_PP = CppEnums.PAUIMB_PRIORITY
local guildDisplayTime = function(timeValue)
  if timeValue >= 60 then
    timeValue2 = timeValue % 60
    timeValue = timeValue / 60
    if 0 == timeValue2 then
      return string.format("%d ", timeValue) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_HOUR")
    else
      return string.format("%d ", timeValue) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_HOUR") .. string.format(" %d ", timeValue2) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_MINUTE")
    end
  else
    return string.format("%d ", timeValue) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_MINUTE")
  end
end
GuildQuestInfoPage = {
  _static_currentPage = 0,
  _lastPage = 0,
  _constGuildQuestMaxCount = 4,
  _constCurrentGuildQuestMaxCount = 5,
  _questListInfo = false,
  _preoccupancy = true,
  _frameDefaultBG_Quest = UI.getChildControl(Panel_Window_Guild, "Static_Frame_QuestBG"),
  _acceptIndex = 0,
  _btnProgressNaviOriginPosX = 0,
  _btnProgressGiveupOriginPosX = 0,
  _btnProgressRewardOriginPosX = 0,
  _RewardPosX = 0,
  _list = {},
  _main_QuestListCount = UI.getChildControl(Panel_Guild_Quest, "StaticText_M_QuestCount"),
  _txtProgressQuestName = UI.getChildControl(Panel_Guild_Quest, "StaticText_Pro_Title"),
  _txtProgressQuestCondition = {},
  _txtProgressLimitTime = UI.getChildControl(Panel_Guild_Quest, "StaticText_Pro_Time"),
  _txtProgressDesc = UI.getChildControl(Panel_Guild_Quest, "StaticText_Pro_Desc"),
  _btnProgressNavi = UI.getChildControl(Panel_Guild_Quest, "Checkbox_Navi"),
  _btnProgressGiveup = UI.getChildControl(Panel_Guild_Quest, "Button_Giveup"),
  _btnProgressReward = UI.getChildControl(Panel_Guild_Quest, "Button_Reward"),
  _btnProgressClear = UI.getChildControl(Panel_Guild_Quest, "Button_Cleared"),
  _txtProgressNoQuest = UI.getChildControl(Panel_Guild_Quest, "StaticText_Pro_NoQuest"),
  _txtProgresshelpAccept = UI.getChildControl(Panel_Guild_Quest, "StaticText_helpAccept"),
  _questCompleteAlert = UI.getChildControl(Panel_Guild_Quest, "StaticText_GuildQuestCompleteAlert"),
  _questIcon = UI.getChildControl(Panel_Guild_Quest, "Static_QuestIcon"),
  _questIconBG = UI.getChildControl(Panel_Guild_Quest, "Static_IconBackground"),
  _btnPreocc = UI.getChildControl(Panel_Guild_Quest, "Button_List_Preocc"),
  _btnWide = UI.getChildControl(Panel_Guild_Quest, "Button_List_Wide"),
  _btnPreoccInfo = UI.getChildControl(Panel_Guild_Quest, "Button_List_PreoccInfo"),
  _btnListLeft = UI.getChildControl(Panel_Guild_Quest, "Button_List_Left"),
  _btnListRight = UI.getChildControl(Panel_Guild_Quest, "Button_List_Right"),
  _txtListNo = UI.getChildControl(Panel_Guild_Quest, "StaticText_List"),
  _txtGuildMoney = UI.getChildControl(Panel_Guild_Quest, "StaticText_GuildMoney")
}
function GuildQuestInfoPage:initialize()
  local main_Progress = UI.getChildControl(Panel_Guild_Quest, "StaticText_M_ProgressQuest")
  local questList_BG = UI.getChildControl(Panel_Guild_Quest, "Static_QuestList_BG")
  local progress_BG = UI.getChildControl(Panel_Guild_Quest, "Static_Progress_BG")
  local copyProgressQuestCondition = UI.getChildControl(Panel_Guild_Quest, "StaticText_Pro_Count")
  for index = 0, self._constCurrentGuildQuestMaxCount - 1 do
    self._txtProgressQuestCondition[index] = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATICTEXT, progress_BG, "StaticText_Pro_Count_" .. index)
    CopyBaseProperty(copyProgressQuestCondition, self._txtProgressQuestCondition[index])
    self._txtProgressQuestCondition[index]:SetIgnore(false)
    self._txtProgressQuestCondition[index]:SetAutoResize(true)
    self._txtProgressQuestCondition[index]:SetTextMode(UI_TM.eTextMode_AutoWrap)
    self._txtProgressQuestCondition[index]:SetSize(450, self._txtProgressQuestCondition[index]:GetSizeY())
  end
  deleteControl(copyProgressQuestCondition)
  copyProgressQuestCondition = nil
  self._btnProgressNavi:addInputEvent("Mouse_LUp", "HandleCliekedGuildQuestNavi()")
  self._btnProgressGiveup:addInputEvent("Mouse_LUp", "HandleCliekedGuildQuestGiveup()")
  self._btnProgressReward:addInputEvent("Mouse_LUp", "HandleCliekedGuildQuestReward()")
  self._btnProgressClear:addInputEvent("Mouse_LUp", "HandleClickedGuildQuestClear()")
  self._btnPreocc:SetTextMode(UI_TM.eTextMode_LimitText)
  self._btnWide:SetTextMode(UI_TM.eTextMode_LimitText)
  self._btnPreoccInfo:SetTextMode(UI_TM.eTextMode_LimitText)
  self._btnPreocc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_QUEST_BTN_LIST_PREOCC"))
  self._btnWide:SetText(PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_QUEST_BTN_LIST_WIDE"))
  self._btnPreoccInfo:SetText(PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_QUEST_BTN_LIST_PREOCCINFO"))
  self._btnPreocc:addInputEvent("Mouse_LUp", "HandleClickedGuildPreQuest()")
  self._btnWide:addInputEvent("Mouse_LUp", "HandleClickedGuildWideQuest()")
  self._btnPreoccInfo:addInputEvent("Mouse_LUp", "HandleClickedGuildPreQuestInfo()")
  self._btnListLeft:addInputEvent("Mouse_LUp", "HandleClickedGuildQuestPrevPageMove()")
  self._btnListRight:addInputEvent("Mouse_LUp", "HandleClickedGuildQuestNextPageMove()")
  if isGameTypeEnglish() then
    self._btnPreocc:addInputEvent("Mouse_On", "GuildQuest_ButtonToolTip( true, 0 )")
    self._btnPreocc:addInputEvent("Mouse_Out", "GuildQuest_ButtonToolTip( false, 0 )")
    self._btnPreocc:setTooltipEventRegistFunc("GuildQuest_ButtonToolTip( true, 0 )")
    self._btnWide:addInputEvent("Mouse_On", "GuildQuest_ButtonToolTip( true, 1 )")
    self._btnWide:addInputEvent("Mouse_Out", "GuildQuest_ButtonToolTip( false, 1 )")
    self._btnWide:setTooltipEventRegistFunc("GuildQuest_ButtonToolTip( true, 1 )")
    self._btnPreoccInfo:addInputEvent("Mouse_On", "GuildQuest_ButtonToolTip( true, 2 )")
    self._btnPreoccInfo:addInputEvent("Mouse_Out", "GuildQuest_ButtonToolTip( false, 2 )")
    self._btnPreoccInfo:setTooltipEventRegistFunc("GuildQuest_ButtonToolTip( true, 2 )")
  end
  self._questCompleteAlert:SetTextMode(UI_TM.eTextMode_AutoWrap)
  self._questCompleteAlert:SetText(PAGetString(Defines.StringSheet_GAME, "UI_GUILD_GUILDQUEST_COMPLETE"))
  self._questCompleteAlert:SetSpanSize(self._questCompleteAlert:GetSpanSize().x, 590)
  self._questCompleteAlert:SetShow(true)
  local copyListBG = UI.getChildControl(Panel_Guild_Quest, "Static_List_BG")
  local copyTitle = UI.getChildControl(Panel_Guild_Quest, "StaticText_C_List_Title")
  local copyDesc = UI.getChildControl(Panel_Guild_Quest, "StaticText_C_List_Desc")
  local copyTime = UI.getChildControl(Panel_Guild_Quest, "StaticText_C_List_Time")
  local copyGold = UI.getChildControl(Panel_Guild_Quest, "StaticText_C_List_Gold")
  local copyAcceptBtn = UI.getChildControl(Panel_Guild_Quest, "Button_List_C_Accept")
  function createQuestListInfo(pIndex)
    local rtGuildQuestListInfo = {}
    rtGuildQuestListInfo._list_BG = UI.createControl(UCT.PA_UI_CONTROL_STATIC, questList_BG, "Static_List_BG_" .. pIndex)
    rtGuildQuestListInfo._list_Title = UI.createControl(UCT.PA_UI_CONTROL_STATICTEXT, rtGuildQuestListInfo._list_BG, "StaticText_C_List_Title_" .. pIndex)
    rtGuildQuestListInfo._list_Desc = UI.createControl(UCT.PA_UI_CONTROL_STATICTEXT, rtGuildQuestListInfo._list_BG, "StaticText_C_List_Desc_" .. pIndex)
    rtGuildQuestListInfo._list_Time = UI.createControl(UCT.PA_UI_CONTROL_STATICTEXT, rtGuildQuestListInfo._list_BG, "StaticText_C_List_Time_" .. pIndex)
    rtGuildQuestListInfo._list_Gold = UI.createControl(UCT.PA_UI_CONTROL_STATICTEXT, rtGuildQuestListInfo._list_BG, "StaticText_C_List_Gold_" .. pIndex)
    rtGuildQuestListInfo._list_AcceptBtn = UI.createControl(UCT.PA_UI_CONTROL_BUTTON, rtGuildQuestListInfo._list_BG, "Button_List_C_Accept_" .. pIndex)
    rtGuildQuestListInfo._list_RewardBtn = UI.createControl(UCT.PA_UI_CONTROL_BUTTON, rtGuildQuestListInfo._list_BG, "Button_Reward_" .. pIndex)
    rtGuildQuestListInfo._list_QuestIcon = UI.createControl(UCT.PA_UI_CONTROL_STATIC, rtGuildQuestListInfo._list_BG, "Static_QuestIcon_" .. pIndex)
    rtGuildQuestListInfo._list_QuestIconBG = UI.createControl(UCT.PA_UI_CONTROL_STATIC, rtGuildQuestListInfo._list_BG, "Static_IconBackground_" .. pIndex)
    CopyBaseProperty(copyListBG, rtGuildQuestListInfo._list_BG)
    CopyBaseProperty(copyTitle, rtGuildQuestListInfo._list_Title)
    CopyBaseProperty(copyDesc, rtGuildQuestListInfo._list_Desc)
    CopyBaseProperty(copyTime, rtGuildQuestListInfo._list_Time)
    CopyBaseProperty(copyGold, rtGuildQuestListInfo._list_Gold)
    CopyBaseProperty(copyAcceptBtn, rtGuildQuestListInfo._list_AcceptBtn)
    CopyBaseProperty(self._btnProgressReward, rtGuildQuestListInfo._list_RewardBtn)
    CopyBaseProperty(self._questIcon, rtGuildQuestListInfo._list_QuestIcon)
    CopyBaseProperty(self._questIconBG, rtGuildQuestListInfo._list_QuestIconBG)
    rtGuildQuestListInfo._list_BG:SetPosY(35 + pIndex * 86)
    rtGuildQuestListInfo._list_Title:SetSize(450, rtGuildQuestListInfo._list_Title:GetSizeY())
    rtGuildQuestListInfo._list_Title:SetIgnore(false)
    rtGuildQuestListInfo._list_Title:SetTextMode(UI_TM.eTextMode_LimitText)
    rtGuildQuestListInfo._list_Desc:setLineCountByLimitAutoWrap(3)
    if 0 < ToClient_getGameOptionControllerWrapper():getUIFontSizeType() then
      rtGuildQuestListInfo._list_Desc:setLineCountByLimitAutoWrap(2)
    end
    rtGuildQuestListInfo._list_Desc:SetTextMode(UI_TM.eTextMode_Limit_AutoWrap)
    rtGuildQuestListInfo._list_AcceptBtn:addInputEvent("Mouse_LUp", "HandleClickedGuildQuest_Accept(" .. pIndex .. ")")
    rtGuildQuestListInfo._list_RewardBtn:addInputEvent("Mouse_LUp", "HandleClickedGuildQuest_Reward(" .. pIndex .. ")")
    return rtGuildQuestListInfo
  end
  for index = 0, self._constGuildQuestMaxCount - 1 do
    self._list[index] = createQuestListInfo(index)
  end
  self._txtProgressQuestName:SetSize(250, self._txtProgressQuestName:GetSizeY())
  self._txtProgressQuestName:SetTextMode(UI_TM.eTextMode_LimitText)
  self._txtProgressDesc:SetLineCount(3)
  self._txtProgressDesc:SetTextMode(UI_TM.eTextMode_Limit_AutoWrap)
  self._btnProgressNaviOriginPosX = self._btnProgressNavi:GetPosX() - 80
  self._btnProgressGiveupOriginPosX = self._btnProgressGiveup:GetPosX() - 80
  self._btnProgressRewardOriginPosX = self._btnProgressReward:GetPosX() - 80
  UI.deleteControl(copyListBG)
  UI.deleteControl(copyTitle)
  UI.deleteControl(copyDesc)
  UI.deleteControl(copyTime)
  UI.deleteControl(copyGold)
  UI.deleteControl(copyAcceptBtn)
  copyListBG, copyTitle, copyDesc, copyTime, copyGold, copyAcceptBtn = nil, nil, nil, nil, nil, nil
  self._frameDefaultBG_Quest:MoveChilds(self._frameDefaultBG_Quest:GetID(), Panel_Guild_Quest)
  UI.deletePanel(Panel_Guild_Quest:GetID())
  Panel_Guild_Quest = nil
end
function GuildQuest_ButtonToolTip(isShow, tipType)
  local name, desc, control
  local self = GuildQuestInfoPage
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_QUEST_BTN_LIST_PREOCC")
    control = self._btnPreocc
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_QUEST_BTN_LIST_WIDE")
    control = self._btnWide
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_QUEST_BTN_LIST_PREOCCINFO")
    control = self._btnPreoccInfo
  end
  registTooltipControl(control, Panel_Tooltip_SimpleText)
  if isShow == true then
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleCliekedGuildQuestNavi()
end
function HandleCliekedGuildQuestGiveup()
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_GIVERUP_MESSAGE_0"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_GIVERUP_MESSAGE_1"),
    functionYes = ToClient_RequestGuildQuestGiveup,
    functionCancel = MessageBox_Empty_function,
    priority = UI_PP.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleCliekedGuildQuestReward()
  local baseCount = ToClient_getCurrentGuildQuestBaseRewardCount()
  local selectCount = ToClient_getCurrentGuildQuestSelectRewardCount()
  local _baseReward = {}
  for index = 1, baseCount do
    local baseReward = ToClient_getCurrentGuildQuestBaseRewardAt(index - 1)
    _baseReward[index] = {}
    _baseReward[index]._type = baseReward:getType()
    if CppEnums.RewardType.RewardType_Exp == _baseReward[index]._type then
      _baseReward[index]._exp = baseReward:getExperience()
    elseif CppEnums.RewardType.RewardType_SkillExp == _baseReward[index]._type then
      _baseReward[index]._exp = baseReward:getSkillExperience()
    elseif CppEnums.RewardType.RewardType_ProductExp == _baseReward[index]._type then
      _baseReward[index]._exp = baseReward:getProductExperience()
    elseif CppEnums.RewardType.RewardType_Item == _baseReward[index]._type then
      _baseReward[index]._item = baseReward:getItemEnchantKey()
      _baseReward[index]._count = baseReward:getItemCount()
    elseif CppEnums.RewardType.RewardType_Intimacy == _baseReward[index]._type then
      _baseReward[index]._character = baseReward:getIntimacyCharacter()
      _baseReward[index]._value = baseReward:getIntimacyValue()
    end
  end
  local _selectReward = {}
  for index = 1, selectCount do
    local selectReward = ToClient_getCurrentGuildQuestSelectRewardAt(index - 1)
    _selectReward[index] = {}
    _selectReward[index]._type = selectReward:getType()
    if CppEnums.RewardType.RewardType_Exp == _selectReward[index]._type then
      _selectReward[index]._exp = selectReward:getExperience()
    elseif CppEnums.RewardType.RewardType_SkillExp == _selectReward[index]._type then
      _selectReward[index]._exp = selectReward:getSkillExperience()
    elseif CppEnums.RewardType.RewardType_ProductExp == _selectReward[index]._type then
      _selectReward[index]._exp = selectReward:getProductExperience()
    elseif CppEnums.RewardType.RewardType_Item == _selectReward[index]._type then
      _selectReward[index]._item = selectReward:getItemEnchantKey()
      _selectReward[index]._count = selectReward:getItemCount()
    elseif CppEnums.RewardType.RewardType_Intimacy == _selectReward[index]._type then
      _selectReward[index]._character = selectReward:getIntimacyCgharacter()
      _selectReward[index]._value = selectReward:getIntimacyValue()
    end
  end
  FGlobal_SetRewardList(_baseReward, _selectReward, nil)
  Panel_Npc_Quest_Reward:SetPosX(getMousePosX() - Panel_Npc_Quest_Reward:GetSizeX() - 10)
  Panel_Npc_Quest_Reward:SetPosY(getMousePosY())
  if true == Panel_Npc_Quest_Reward:GetShow() then
    FGlobal_ShowRewardList(false)
  else
    FGlobal_ShowRewardList(true)
  end
end
function HandleClickedGuildQuestClear()
  local doHaveCashGuildQuestItem = doHaveContentsItem(CppEnums.ContentsEventType.ContentsType_AddGuildQuestReward, 0, false)
  if true == doHaveCashGuildQuestItem then
    local messageboxData = {
      title = "",
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_CLEAR_USEITEM"),
      functionYes = HandleClickedGuildQuestClear_UseItem,
      functionNo = HandleClickedGuildQuestClear_DontUseItem,
      priority = UI_PP.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    HandleClickedGuildQuestClear_DontUseItem()
  end
end
function HandleClickedGuildQuestClear_UseItem()
  ToClient_RequestGuildQuestComplete(true)
end
function HandleClickedGuildQuestClear_DontUseItem()
  ToClient_RequestGuildQuestComplete(false)
end
function HandleClickedGuildPreQuest()
  audioPostEvent_SystemUi(0, 0)
  ToClient_RequestGuildQuestList(true)
  GuildQuestInfoPage._preoccupancy = true
  GuildQuestInfoPage._btnPreocc:SetCheck(true)
  GuildQuestInfoPage._btnWide:SetCheck(false)
  GuildQuestInfoPage._btnPreoccInfo:SetCheck(false)
  GuildQuestInfoPage._questCompleteAlert:SetShow(true)
  GuildQuestInfoPage._static_currentPage = 0
end
function HandleClickedGuildWideQuest()
  audioPostEvent_SystemUi(0, 0)
  ToClient_RequestGuildQuestList(false)
  GuildQuestInfoPage._preoccupancy = false
  GuildQuestInfoPage._btnPreocc:SetCheck(false)
  GuildQuestInfoPage._btnWide:SetCheck(true)
  GuildQuestInfoPage._btnPreoccInfo:SetCheck(false)
  GuildQuestInfoPage._questCompleteAlert:SetShow(false)
  GuildQuestInfoPage._static_currentPage = 0
end
function HandleClickedGuildPreQuestInfo()
  audioPostEvent_SystemUi(0, 0)
  ToClient_RequestOtherGuildQuest()
  GuildQuestInfoPage._btnPreocc:SetCheck(false)
  GuildQuestInfoPage._btnWide:SetCheck(false)
  GuildQuestInfoPage._btnPreoccInfo:SetCheck(true)
  GuildQuestInfoPage._questCompleteAlert:SetShow(true)
  GuildQuestInfoPage._static_currentPage = 0
end
function HandleClickedGuildQuestPrevPageMove()
  GuildQuestInfoPage._static_currentPage = GuildQuestInfoPage._static_currentPage - 1
  if GuildQuestInfoPage._static_currentPage < 0 then
    GuildQuestInfoPage._static_currentPage = 0
  end
  GuildQuestInfoPage:UpdateData()
end
function HandleClickedGuildQuestNextPageMove()
  GuildQuestInfoPage._static_currentPage = GuildQuestInfoPage._static_currentPage + 1
  if GuildQuestInfoPage._lastPage <= GuildQuestInfoPage._static_currentPage then
    GuildQuestInfoPage._static_currentPage = GuildQuestInfoPage._static_currentPage - 1
  end
  GuildQuestInfoPage:UpdateData()
end
function HandleClickedGuildQuest_Accept(index)
  GuildQuestInfoPage._acceptIndex = GuildQuestInfoPage._static_currentPage * 4 + index
  local preGold_s64 = ToClient_RequestGuildQuestAt(GuildQuestInfoPage._acceptIndex):getPreGoldCount()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    _PA_ASSERT(false, "\234\184\184\235\147\156 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  local guildBusinessFunds_s64 = myGuildInfo:getGuildBusinessFunds_s64()
  if preGold_s64 > guildBusinessFunds_s64 then
    if nil == getInventoryItem(0) then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUESTACCEPTFAIL"))
      return
    end
    local myGold_s64 = getInventoryItem(0):get():getCount_s64()
    if preGold_s64 > myGold_s64 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUESTACCEPTFAIL"))
      return
    else
      local messageboxData = {
        title = "",
        content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_QUESTACCEPT_BYINVENTORY"),
        functionYes = HandleClickedGuildQuest_AcceptContinue,
        functionCancel = MessageBox_Empty_function,
        priority = UI_PP.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
      return
    end
  end
  local messageboxData = {
    title = "",
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_QUESTACCEPT"),
    functionYes = HandleClickedGuildQuest_AcceptContinue,
    functionCancel = MessageBox_Empty_function,
    priority = UI_PP.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleClickedGuildQuest_AcceptContinue()
  ToClient_RequestGuildQuestAccept(ToClient_RequestGuildQuestAt(GuildQuestInfoPage._acceptIndex)._questIndex)
end
function HandleClickedGuildQuest_Reward(index)
  guildQuest = ToClient_RequestGuildQuestAt(GuildQuestInfoPage._static_currentPage * 4 + index)
  local baseCount = guildQuest:getGuildQuestBaseRewardCount()
  local selectCount = guildQuest:getGuildQuestSelectRewardCount()
  local _baseReward = {}
  for baseIndex = 1, baseCount do
    local baseReward = guildQuest:getGuildQuestBaseRewardAt(baseIndex - 1)
    _baseReward[baseIndex] = {}
    _baseReward[baseIndex]._type = baseReward:getType()
    if CppEnums.RewardType.RewardType_Exp == _baseReward[baseIndex]._type then
      _baseReward[baseIndex]._exp = baseReward:getExperience()
    elseif CppEnums.RewardType.RewardType_SkillExp == _baseReward[baseIndex]._type then
      _baseReward[baseIndex]._exp = baseReward:getSkillExperience()
    elseif CppEnums.RewardType.RewardType_ProductExp == _baseReward[baseIndex]._type then
      _baseReward[baseIndex]._exp = baseReward:getProductExperience()
    elseif CppEnums.RewardType.RewardType_Item == _baseReward[baseIndex]._type then
      _baseReward[baseIndex]._item = baseReward:getItemEnchantKey()
      _baseReward[baseIndex]._count = baseReward:getItemCount()
    elseif CppEnums.RewardType.RewardType_Intimacy == _baseReward[baseIndex]._type then
      _baseReward[baseIndex]._character = baseReward:getIntimacyCharacter()
      _baseReward[baseIndex]._value = baseReward:getIntimacyValue()
    end
  end
  local _selectReward = {}
  for selectIndex = 1, selectCount do
    local selectReward = guildQuest:getGuildQuestSelectRewardAt(selectIndex - 1)
    _selectReward[selectIndex] = {}
    _selectReward[selectIndex]._type = selectReward:getType()
    if CppEnums.RewardType.RewardType_Exp == _selectReward[selectIndex]._type then
      _selectReward[selectIndex]._exp = selectReward:getExperience()
    elseif CppEnums.RewardType.RewardType_SkillExp == _selectReward[selectIndex]._type then
      _selectReward[selectIndex]._exp = selectReward:getSkillExperience()
    elseif CppEnums.RewardType.RewardType_ProductExp == _selectReward[selectIndex]._type then
      _selectReward[selectIndex]._exp = selectReward:getProductExperience()
    elseif CppEnums.RewardType.RewardType_Item == _selectReward[selectIndex]._type then
      _selectReward[selectIndex]._item = selectReward:getItemEnchantKey()
      _selectReward[selectIndex]._count = selectReward:getItemCount()
    elseif CppEnums.RewardType.RewardType_Intimacy == _selectReward[selectIndex]._type then
      _selectReward[selectIndex]._character = selectReward:getIntimacyCgharacter()
      _selectReward[selectIndex]._value = selectReward:getIntimacyValue()
    end
  end
  FGlobal_SetRewardList(_baseReward, _selectReward, nil)
  Panel_Npc_Quest_Reward:SetPosX(getMousePosX())
  Panel_Npc_Quest_Reward:SetPosY(getMousePosY())
  if true == Panel_Npc_Quest_Reward:GetShow() then
    FGlobal_ShowRewardList(false)
  else
    FGlobal_ShowRewardList(true)
  end
end
function GuildQuestInfoPage:UpdateData()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local boolProgressing = ToClient_isProgressingGuildQuest()
  self._txtProgressQuestName:EraseAllEffect()
  for index = 0, self._constCurrentGuildQuestMaxCount - 1 do
    self._txtProgressQuestCondition[index]:SetShow(false)
    self._txtProgressQuestCondition[index]:SetText("")
    self._txtProgressQuestCondition[index]:SetLineRender(false)
    self._txtProgressQuestCondition[index]:SetFontColor(UI_color.C_FFC4BEBE)
  end
  if true == boolProgressing then
    self._txtProgressNoQuest:SetShow(false)
    self._txtProgresshelpAccept:SetShow(false)
    local currentGuildQuestName = ToClient_getCurrentGuildQuestName()
    local requireGuildRank = ToClient_getCurrentGuildQuestGrade()
    local requireGuildRankStr = ""
    if 1 == requireGuildRank then
      requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_SMALL")
    elseif 2 == requireGuildRank then
      requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_MIDDLE")
    elseif 3 == requireGuildRank then
      requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIG")
    elseif 4 == requireGuildRank then
      requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIGGEST")
    end
    self._txtProgressQuestName:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_LIMIT", "currentGuildQuestName", currentGuildQuestName, "requireGuildRankStr", requireGuildRankStr))
    local remainTime = ToClient_getCurrentGuildQuestRemainedTime()
    local strMinute = math.floor(remainTime / 60)
    if remainTime <= 0 then
      self._txtProgressLimitTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_TIMEOUT"))
    else
      self._txtProgressLimitTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_REMAINTIME", "time_minute", strMinute))
    end
    self._txtProgressDesc:SetText(ToClient_getCurrentGuildQuestDesc())
    local stringLen = string.len(self._txtProgressQuestName:GetText())
    if stringLen > 90 then
      stringLen = 90
    end
    self._btnProgressNavi:SetPosX(self._btnProgressNaviOriginPosX + stringLen * 4.5)
    self._btnProgressGiveup:SetPosX(self._btnProgressGiveupOriginPosX + stringLen * 4.5)
    self._btnProgressReward:SetPosX(self._btnProgressRewardOriginPosX + stringLen * 4.5)
    self._RewardPosX = self._btnProgressReward:GetPosX()
    local questConditionCount = ToClient_getCurrentGuildQuestConditionCount()
    local conditionPosY = 0
    if 1 == questConditionCount then
      conditionPosY = 60
    elseif 2 == questConditionCount then
      conditionPosY = 51
    elseif 3 == questConditionCount then
      conditionPosY = 43
    elseif 4 == questConditionCount then
      conditionPosY = 35
    elseif 5 == questConditionCount then
      conditionPosY = 28
    end
    for index = 0, self._constCurrentGuildQuestMaxCount - 1 do
      if index < questConditionCount then
        local currentGuildQuestInfo = ToClient_getCurrentGuildQuestConditionAt(index)
        self._txtProgressQuestCondition[index]:SetShow(true)
        self._txtProgressQuestCondition[index]:SetText(currentGuildQuestInfo._desc .. " ( " .. currentGuildQuestInfo._currentCount .. " / " .. currentGuildQuestInfo._destCount .. " ) ")
        if currentGuildQuestInfo._destCount <= currentGuildQuestInfo._currentCount then
          self._txtProgressQuestCondition[index]:SetLineRender(true)
          self._txtProgressQuestCondition[index]:SetFontColor(UI_color.C_FF626262)
        else
          self._txtProgressQuestCondition[index]:SetLineRender(false)
          self._txtProgressQuestCondition[index]:SetFontColor(UI_color.C_FFC4BEBE)
        end
        self._txtProgressQuestCondition[index]:SetPosY(conditionPosY + index * self._txtProgressQuestCondition[index]:GetTextSizeY())
        self._txtProgressQuestCondition[index]:addInputEvent("Mouse_On", "guildQuest_ProgressQuestDesc( true )")
        self._txtProgressQuestCondition[index]:addInputEvent("Mouse_Out", "guildQuest_ProgressQuestDesc( false )")
      else
        self._txtProgressQuestCondition[index]:SetShow(false)
      end
    end
    self._txtProgressQuestName:SetShow(true)
    self._txtProgressLimitTime:SetShow(true)
    self._txtProgressDesc:SetShow(false)
    self._btnProgressNavi:SetShow(false)
    self._questIcon:SetShow(true)
    self._questIconBG:SetShow(true)
    self._questIcon:ChangeTextureInfoName(ToClient_getCurrentGuildQuestIconPath())
    if getSelfPlayer():get():isGuildMaster() or getSelfPlayer():get():isGuildSubMaster() then
      self._btnProgressGiveup:SetShow(true)
      self._btnProgressReward:SetPosX(self._RewardPosX)
    else
      self._btnProgressGiveup:SetShow(false)
      self._btnProgressReward:SetPosX(self._btnProgressGiveup:GetPosX())
    end
    if 0 >= ToClient_getCurrentGuildQuestBaseRewardCount() and 0 >= ToClient_getCurrentGuildQuestSelectRewardCount() then
      self._btnProgressReward:SetShow(false)
    else
      self._btnProgressReward:SetShow(true)
    end
    self._btnProgressClear:SetShow(false)
  else
    for index = 0, self._constCurrentGuildQuestMaxCount - 1 do
      self._txtProgressQuestCondition[index]:SetShow(false)
    end
    self._txtProgressQuestName:SetShow(false)
    self._txtProgressLimitTime:SetShow(false)
    self._txtProgressDesc:SetShow(false)
    self._btnProgressNavi:SetShow(false)
    self._btnProgressGiveup:SetShow(false)
    self._btnProgressReward:SetShow(false)
    self._btnProgressClear:SetShow(false)
    self._questIcon:SetShow(false)
    self._questIconBG:SetShow(false)
    self._txtProgressNoQuest:SetShow(true)
    local temporaryWrapper = getTemporaryInformationWrapper()
    local worldNo = temporaryWrapper:getSelectedWorldServerNo()
    local channelName = getChannelName(worldNo, ToClient_getCurrentGuildQuestServerNo())
    if ToClient_isGuildQuestOtherServer() then
      if nil == channelName then
        self._txtProgressNoQuest:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_PROGRESSNOQUEST_ANOTHER"))
      else
        self._txtProgressNoQuest:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_PROGRESSNOQUEST_ANOTHERCHANNEL", "channel", channelName))
      end
    else
      self._txtProgressNoQuest:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_NOCURRENT"))
      self._txtProgresshelpAccept:SetShow(true)
      self._txtProgresshelpAccept:SetAutoResize(true)
      self._txtProgresshelpAccept:SetTextMode(UI_TM.eTextMode_AutoWrap)
      self._txtProgresshelpAccept:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDQUEST_PAYMYMONEY"))
    end
  end
  if true == ToClient_isSatisfyCurrentGuildQuest() then
    if getSelfPlayer():get():isGuildMaster() or getSelfPlayer():get():isGuildSubMaster() then
      self._btnProgressClear:SetShow(true)
    else
      self._btnProgressClear:SetShow(false)
    end
    self._txtProgressLimitTime:SetShow(false)
  else
    self._btnProgressClear:SetShow(false)
  end
  local enableQuestCount = myGuildInfo:getAvaiableGuildQuestCount()
  GuildQuestInfoPage._main_QuestListCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_ENABLEQUESTCOUNT", "enableQuestCount", enableQuestCount))
  local myGuildQuestListCount = ToClient_RequestGuildQuestCount()
  for index = 0, self._constGuildQuestMaxCount - 1 do
    local questIndex = self._static_currentPage * self._constGuildQuestMaxCount + index
    if myGuildQuestListCount > questIndex then
      local guildQuestList = ToClient_RequestGuildQuestAt(questIndex)
      if nil ~= guildQuestList then
        local requireGuildRank = guildQuestList:getGuildQuestGrade()
        local requireGuildRankStr = ""
        if 1 == requireGuildRank then
          requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_SMALL")
        elseif 2 == requireGuildRank then
          requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_MIDDLE")
        elseif 3 == requireGuildRank then
          requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIG")
        elseif 4 == requireGuildRank then
          requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIGGEST")
        end
        self._list[index]._list_Title:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_LIMIT", "currentGuildQuestName", guildQuestList:getTitle(), "requireGuildRankStr", requireGuildRankStr))
        self._list[index]._list_Desc:SetSize(470, self._list[index]._list_Desc:GetSizeY())
        self._list[index]._list_Desc:SetText(guildQuestList:getDesc())
        self._list[index]._list_Desc:SetPosX(70)
        self._list[index]._list_RewardBtn:SetPosX(self._list[index]._list_Title:GetTextSizeX() + 20)
        self._list[index]._list_RewardBtn:SetPosY(5)
        self._list[index]._list_QuestIcon:SetPosY(25)
        self._list[index]._list_QuestIconBG:SetPosY(25)
        self._list[index]._list_QuestIcon:ChangeTextureInfoName(guildQuestList:getIconPath())
        if false == self._questListInfo then
          local remainTime = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_LIMITTIME") .. " " .. guildDisplayTime(guildQuestList:getLimitMinute())
          self._list[index]._list_Time:SetText(remainTime)
          self._list[index]._list_Gold:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_PREGOLD", "pre_gold", Uint64toUint32(guildQuestList:getPreGoldCount())))
          if (getSelfPlayer():get():isGuildMaster() or getSelfPlayer():get():isGuildSubMaster()) and false == boolProgressing then
            self._list[index]._list_AcceptBtn:SetShow(true)
            if enableQuestCount > 0 then
              self._list[index]._list_AcceptBtn:SetEnable(true)
              self._list[index]._list_AcceptBtn:SetMonoTone(false)
            else
              self._list[index]._list_AcceptBtn:SetEnable(false)
              self._list[index]._list_AcceptBtn:SetMonoTone(true)
            end
          else
            self._list[index]._list_AcceptBtn:SetShow(false)
          end
        else
          if nil ~= guildQuestList:getProgressGuildName() then
            self._list[index]._list_Time:SetText("")
            self._list[index]._list_Gold:SetText("")
          else
            self._list[index]._list_Time:SetText("")
            self._list[index]._list_Gold:SetText("")
          end
          self._list[index]._list_AcceptBtn:SetShow(false)
        end
      end
      self._list[index]._list_BG:SetShow(true)
    else
      self._list[index]._list_BG:SetShow(false)
    end
  end
  self._lastPage = math.ceil(ToClient_RequestGuildQuestCount() / GuildQuestInfoPage._constGuildQuestMaxCount)
  if 0 == self._lastPage then
    self._lastPage = 1
  end
  self._txtListNo:SetText(self._static_currentPage + 1 .. "/" .. self._lastPage)
end
function guildQuest_ProgressingGuildQuest_UpdateRemainTime()
  if not ToClient_isProgressingGuildQuest() then
    return
  end
  local remainTime = ToClient_getCurrentGuildQuestRemainedTime()
  local strMinute = math.floor(remainTime / 60)
  if remainTime <= 0 then
    GuildQuestInfoPage._txtProgressLimitTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_TIMEOUT"))
  else
    GuildQuestInfoPage._txtProgressLimitTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_REMAINTIME", "time_minute", strMinute))
  end
end
function guildQuest_ProgressQuestDesc(isShow)
  local self = GuildQuestInfoPage
  if true == isShow then
    TooltipSimple_Show(self._txtProgressQuestCondition[0], ToClient_getCurrentGuildQuestName(), ToClient_getCurrentGuildQuestDesc())
  else
    TooltipSimple_Hide()
  end
end
function GuildQuestInfoPage:Show()
  if false == self._frameDefaultBG_Quest:GetShow() then
    ToClient_RequestGuildQuestList(true)
    self._btnPreocc:SetCheck(true)
    self._btnWide:SetCheck(false)
    self._btnPreoccInfo:SetCheck(false)
    self._static_currentPage = 0
    self._frameDefaultBG_Quest:SetShow(true)
    self:UpdateData()
  end
end
function GuildQuestInfoPage:Hide()
  if true == self._frameDefaultBG_Quest:GetShow() then
    self._frameDefaultBG_Quest:SetShow(false)
  end
end
registerEvent("ResponseGuildQuestList", "FromClient_ResponseGuildQuestList")
registerEvent("ResponseUpdateGuildQuest", "FromClient_ResponseGuildQuestList")
registerEvent("ResponseAcceptGuildQuest", "FromClient_ResponseClickedGuildQuest")
registerEvent("ResponseUpdateGiveupGuildQuest", "FromClient_ResponseClickedGuildQuest")
registerEvent("ResponseCompleteGuildQuest", "FromClient_ResponseClickedGuildQuest")
registerEvent("FromClient_ResponseOtherGuildQuestList", "FromClient_ResponseOtherGuildQuestList")
registerEvent("updateGuildInfo", "FromClient_ResponseOtherGuildQuestList")
function FromClient_ResponseGuildQuestList(actorName, characterName)
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil ~= myGuildInfo then
    local getGuildMoney = myGuildInfo:getGuildBusinessFunds_s64()
    GuildQuestInfoPage._txtGuildMoney:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_GUILDMONEY", "getGuildMoney", makeDotMoney(getGuildMoney)))
  end
  GuildQuestInfoPage._questListInfo = false
  GuildQuestInfoPage:UpdateData()
end
function FromClient_ResponseClickedGuildQuest()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if true == GuildQuestInfoPage._questListInfo then
    GuildQuestInfoPage._questListInfo = true
    GuildQuestInfoPage._btnPreocc:SetCheck(false)
    GuildQuestInfoPage._btnWide:SetCheck(false)
    GuildQuestInfoPage._btnPreoccInfo:SetCheck(true)
    ToClient_RequestOtherGuildQuest()
  elseif true == GuildQuestInfoPage._preoccupancy then
    if nil ~= myGuildInfo then
      ToClient_RequestGuildQuestList(true)
    end
    GuildQuestInfoPage._btnPreocc:SetCheck(true)
    GuildQuestInfoPage._btnWide:SetCheck(false)
    GuildQuestInfoPage._btnPreoccInfo:SetCheck(false)
  else
    if nil ~= myGuildInfo then
      ToClient_RequestGuildQuestList(false)
    end
    GuildQuestInfoPage._btnPreocc:SetCheck(false)
    GuildQuestInfoPage._btnWide:SetCheck(true)
    GuildQuestInfoPage._btnPreoccInfo:SetCheck(false)
  end
  GuildQuestInfoPage:UpdateData()
  FromClient_UpdateQuestSetPos()
end
function FromClient_ResponseOtherGuildQuestList()
  _PA_LOG("luadebug", "FromClient_ResponseOtherGuildQuestList")
  GuildQuestInfoPage._questListInfo = true
  GuildQuestInfoPage:UpdateData()
end
function FromClient_GuildQuest_NotifyComplete(guildName, questName)
  if false == ToClient_GetMessageFilter(9) then
    Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_GUILDQUESTCOMPLETE_ACK", "guildName", guildName, "questName", questName))
  end
end
registerEvent("FromClient_NotifyCompleteGuildQuestToWorld", "FromClient_GuildQuest_NotifyComplete")
