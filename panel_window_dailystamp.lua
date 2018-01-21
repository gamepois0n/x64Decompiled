Panel_Window_DailyStamp:SetShow(false, false)
Panel_Window_DailyStamp:ActiveMouseEventEffect(true)
Panel_Window_DailyStamp:setGlassBackground(true)
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local UI_PUCT = CppEnums.PA_UI_CONTROL_TYPE
local UI_TM = CppEnums.TextMode
local UI_TT = CppEnums.PAUI_TEXTURE_TYPE
local userConnectionType = 0
Panel_Window_DailyStamp:RegisterShowEventFunc(true, "DailyStampShowAni()")
Panel_Window_DailyStamp:RegisterShowEventFunc(false, "DailyStampHideAni()")
function DailyStampShowAni()
  Panel_Window_DailyStamp:ChangeSpecialTextureInfoName("new_ui_common_forlua/Default/Mask_MidHorizon.dds")
  local FadeMaskAni = Panel_Window_DailyStamp:addTextureUVAnimation(0, 0.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  FadeMaskAni:SetTextureType(UI_TT.PAUI_TEXTURE_TYPE_MASK)
  FadeMaskAni:SetStartUV(0, 0, 0)
  FadeMaskAni:SetEndUV(0.6, 0, 0)
  FadeMaskAni:SetStartUV(1, 0, 1)
  FadeMaskAni:SetEndUV(0.4, 0, 1)
  FadeMaskAni:SetStartUV(0, 1, 2)
  FadeMaskAni:SetEndUV(0.6, 1, 2)
  FadeMaskAni:SetStartUV(1, 1, 3)
  FadeMaskAni:SetEndUV(0.4, 1, 3)
  FadeMaskAni.IsChangeChild = true
  dailyStamp.animationTime = 0
end
function DailyStampHideAni()
  Panel_Window_DailyStamp:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_DailyStamp, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function TabSort(lhs, rhs)
  return lhs[2] > rhs[2]
end
local dailyStamp = {
  tempDailySlot = UI.getChildControl(Panel_Window_DailyStamp, "Static_DaySlot"),
  tempDay = UI.getChildControl(Panel_Window_DailyStamp, "StaticText_Day"),
  tempStamp = UI.getChildControl(Panel_Window_DailyStamp, "Static_Stamp"),
  tempName = UI.getChildControl(Panel_Window_DailyStamp, "StaticText_RewardName"),
  eventEntry = UI.getChildControl(Panel_Window_DailyStamp, "Static_EventEntry"),
  dailyStampTap = UI.getChildControl(Panel_Window_DailyStamp, "RadioButton_Tap"),
  entryIcon = {
    [0] = UI.getChildControl(Panel_Window_DailyStamp, "Static_EventEntryComplete1"),
    [1] = UI.getChildControl(Panel_Window_DailyStamp, "Static_EventEntryComplete2"),
    [2] = UI.getChildControl(Panel_Window_DailyStamp, "Static_EventEntryComplete3")
  },
  mainBg = UI.getChildControl(Panel_Window_DailyStamp, "Static_Bg"),
  eventDescBg = UI.getChildControl(Panel_Window_DailyStamp, "Static_EventPeriodBg"),
  eventPeriodTitle = UI.getChildControl(Panel_Window_DailyStamp, "StaticText_EventPeriodTitle"),
  eventPeriod = UI.getChildControl(Panel_Window_DailyStamp, "StaticText_EventPeriodValue"),
  acceptPeriodTitle = UI.getChildControl(Panel_Window_DailyStamp, "StaticText_RewardAcceptPeriodTitle"),
  acceptPeriod = UI.getChildControl(Panel_Window_DailyStamp, "StaticText_RewardAcceptPeriodValue"),
  weekEndDesc = UI.getChildControl(Panel_Window_DailyStamp, "StaticText_WeekEndDesc"),
  attendanceTimeTitle = UI.getChildControl(Panel_Window_DailyStamp, "StaticText_AttendanceTimeCheckTitle"),
  attendanceTime = UI.getChildControl(Panel_Window_DailyStamp, "StaticText_AttendanceTimeCheckValue"),
  eventDesc = UI.getChildControl(Panel_Window_DailyStamp, "StaticText_EventPeriodAlert"),
  btnClose = UI.getChildControl(Panel_Window_DailyStamp, "Button_Win_Close"),
  slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  goodItemSlotConfig = {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  rewardCount = 35,
  tapIndex = 1,
  dayControl = {},
  eventEntryCount = {},
  entryReward = {},
  entryComplete = {},
  tapControl = {},
  prevAttendanceCount = {},
  goodDay = {},
  animationTabIndex = nil,
  animationdayIndex = {},
  animationTime = 0,
  nextDayShow = false,
  secondAttendanceCheck = false
}
function DailyStamp_DescSet()
  local _eventPeriodTitle = dailyStamp.eventPeriodTitle:GetText()
  local _eventPeriod = dailyStamp.eventPeriod:GetText()
  local _acceptPeriodTitle = dailyStamp.acceptPeriodTitle:GetText()
  local _acceptPeriod = dailyStamp.acceptPeriod:GetText()
  local _desc = dailyStamp.eventDesc:GetText()
  local _weekendDesc = dailyStamp.weekEndDesc:GetText()
  dailyStamp.eventPeriod:SetTextMode(UI_TM.eTextMode_AutoWrap)
  dailyStamp.acceptPeriod:SetTextMode(UI_TM.eTextMode_AutoWrap)
  dailyStamp.eventDesc:SetTextMode(UI_TM.eTextMode_AutoWrap)
  dailyStamp.weekEndDesc:SetTextMode(UI_TM.eTextMode_AutoWrap)
  dailyStamp.eventPeriodTitle:SetText(_eventPeriodTitle)
  dailyStamp.eventPeriod:SetText(_eventPeriod)
  dailyStamp.acceptPeriodTitle:SetText(_acceptPeriodTitle)
  dailyStamp.acceptPeriod:SetText(_acceptPeriod)
  dailyStamp.eventDesc:SetText(_desc)
  dailyStamp.weekEndDesc:SetText(_weekendDesc)
  if 80 < dailyStamp.eventDesc:GetTextSizeY() then
    local addSizeY = dailyStamp.eventDesc:GetTextSizeY() - 80 + 15
    Panel_Window_DailyStamp:SetSize(Panel_Window_DailyStamp:GetSizeX(), Panel_Window_DailyStamp:GetSizeY() + addSizeY)
    dailyStamp.mainBg:SetSize(dailyStamp.mainBg:GetSizeX(), dailyStamp.mainBg:GetSizeY() + addSizeY)
    dailyStamp.eventDescBg:SetSize(dailyStamp.eventDescBg:GetSizeX(), dailyStamp.eventDescBg:GetSizeY() + addSizeY)
    dailyStamp.eventDesc:SetSpanSize(dailyStamp.eventDesc:GetSpanSize().x, dailyStamp.eventDesc:GetSpanSize().y + addSizeY)
    dailyStamp.eventPeriodTitle:SetSpanSize(dailyStamp.eventPeriodTitle:GetSpanSize().x, dailyStamp.eventPeriodTitle:GetSpanSize().y + addSizeY)
    dailyStamp.eventPeriod:SetSpanSize(dailyStamp.eventPeriod:GetSpanSize().x, dailyStamp.eventPeriod:GetSpanSize().y + addSizeY)
    dailyStamp.acceptPeriodTitle:SetSpanSize(dailyStamp.acceptPeriodTitle:GetSpanSize().x, dailyStamp.acceptPeriodTitle:GetSpanSize().y + addSizeY - 20)
    dailyStamp.acceptPeriod:SetSpanSize(dailyStamp.acceptPeriod:GetSpanSize().x, dailyStamp.acceptPeriod:GetSpanSize().y + addSizeY - 20)
  end
  local titleSizeX = math.max(dailyStamp.eventPeriodTitle:GetTextSizeX(), dailyStamp.acceptPeriodTitle:GetTextSizeX())
  local baseSizeX = dailyStamp.eventPeriodTitle:GetPosX() + titleSizeX
  if dailyStamp.eventPeriod:GetPosX() < baseSizeX + 10 then
    dailyStamp.eventPeriod:SetPosX(baseSizeX + 10)
    dailyStamp.acceptPeriod:SetPosX(baseSizeX + 10)
  end
  dailyStamp.goodItemSlotConfig.createBorder = true
end
DailyStamp_DescSet()
if isGameTypeKorea() then
  dailyStamp.eventEntryCount = {
    [0] = 10,
    20,
    30
  }
  dailyStamp.eventEntry:SetShow(false)
end
local dailyStampCount = ToClient_GetAttendanceInfoCount()
local dailyStampKeys = Array.new()
for index = 1, dailyStampCount do
  local attendancSS = ToClient_GetAttendanceInfoWrapper(index - 1)
  dailyStampKeys[index] = {
    attendancSS,
    attendancSS:getDisplayOrder(),
    false
  }
  if nil ~= dailyStampKeys[index][1] and false == dailyStampKeys[index][1]:isPossibleOverlapAttendance() and false == dailyStampKeys[index][1]:isPossibleAttendance() then
    dailyStampKeys[index][3] = true
  end
end
table.sort(dailyStampKeys, TabSort)
local yesterdayTabCount = dailyStampCount
function dailyStamp:TapInit()
  if dailyStampCount < yesterdayTabCount then
    for index = 1, yesterdayTabCount do
      if index < dailyStampCount then
        local dailyStampTapName = dailyStampKeys[index][1]:getName()
        self.tapControl[index] = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_RADIOBUTTON, Panel_Window_DailyStamp, "DailyStamp_Tap_" .. index)
        CopyBaseProperty(self.dailyStampTap, self.tapControl[index])
        self.tapControl[index]:SetShow(true)
        self.tapControl[index]:SetCheck(false)
        self.tapControl[index]:SetText(dailyStampTapName)
        local btnTapSizeX = self.tapControl[index]:GetSizeX()
        local btnTapTextPosX = btnTapSizeX - btnTapSizeX / 2 - self.tapControl[index]:GetTextSizeX() / 2
        self.tapControl[index]:SetTextSpan(btnTapTextPosX, 5)
        self.tapControl[index]:addInputEvent("Mouse_LUp", "DailyStamp_TapClicked(" .. index .. ")")
        self.prevAttendanceCount[index] = nil
        if dailyStampCount > 4 then
          self.tapControl[index]:SetSize(155, 40)
        end
        self.tapControl[index]:SetPosX(self.tapControl[index]:GetPosX() + (self.tapControl[index]:GetSizeX() + 5) * (index - 1))
        self.tapControl[index]:SetPosY(62)
      else
        self.tapControl[index]:SetShow(false)
      end
    end
    yesterdayTabCount = dailyStampCount
  else
    for index = 1, dailyStampCount do
      local dailyStampTapName = dailyStampKeys[index][1]:getName()
      self.tapControl[index] = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_RADIOBUTTON, Panel_Window_DailyStamp, "DailyStamp_Tap_" .. index)
      CopyBaseProperty(self.dailyStampTap, self.tapControl[index])
      self.tapControl[index]:SetShow(true)
      self.tapControl[index]:SetCheck(false)
      self.tapControl[index]:SetText(dailyStampTapName)
      local btnTapSizeX = self.tapControl[index]:GetSizeX()
      local btnTapTextPosX = btnTapSizeX - btnTapSizeX / 2 - self.tapControl[index]:GetTextSizeX() / 2
      self.tapControl[index]:SetTextSpan(btnTapTextPosX, 5)
      self.tapControl[index]:addInputEvent("Mouse_LUp", "DailyStamp_TapClicked(" .. index .. ")")
      self.prevAttendanceCount[index] = nil
      if dailyStampCount >= 4 then
        self.tapControl[index]:SetSize(155, 40)
      end
      self.tapControl[index]:SetPosX(self.tapControl[index]:GetPosX() + (self.tapControl[index]:GetSizeX() + 5) * (index - 1))
      self.tapControl[index]:SetPosY(62)
    end
  end
end
function dailyStamp:TabUpdate()
  for index = 1, dailyStampCount do
    local dailyStampTapName = dailyStampKeys[index][1]:getName()
    local attendanceKey = dailyStampKeys[index][1]:getKey()
    local myAttendanceCount = ToClient_getAttendanceCount(attendanceKey)
    local rewardCount = ToClient_getReceivedRewardCount(attendanceKey)
    if myAttendanceCount - rewardCount > 0 then
      dailyStampTapName = dailyStampTapName .. "(" .. myAttendanceCount - rewardCount .. ")"
    end
    self.tapControl[index]:SetText(dailyStampTapName)
  end
end
local basePosX = dailyStamp.tempDailySlot:GetPosX() + 30
local basePosY = dailyStamp.tempDailySlot:GetPosY() + 40
local gapX = 10
local gapY = 10
function dailyStamp:Init()
  for index = 0, self.rewardCount - 1 do
    local temp = {}
    temp._dayControl = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, Panel_Window_DailyStamp, "Static_DailyStamp_Day_" .. index)
    CopyBaseProperty(self.tempDailySlot, temp._dayControl)
    temp._dayControl:SetPosX(basePosX + (self.tempDailySlot:GetSizeX() + gapX) * (index % 7))
    temp._dayControl:SetPosY(basePosY + (self.tempDailySlot:GetSizeY() + gapY) * math.floor(index / 7))
    temp._dayText = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATICTEXT, temp._dayControl, "StaticText_DailyStamp_Day_" .. index)
    CopyBaseProperty(self.tempDay, temp._dayText)
    temp._dayText:SetPosX(5)
    temp._dayText:SetPosY(5)
    temp._dayText:SetText(index + 1)
    temp._rewardName = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATICTEXT, temp._dayControl, "StaticText_DailyStamp_RewardName_" .. index)
    CopyBaseProperty(self.tempName, temp._rewardName)
    temp._rewardName:SetPosX(6)
    temp._rewardName:SetPosY(70)
    temp._rewardName:SetTextMode(UI_TM.eTextMode_AutoWrap)
    temp._rewardName:SetShow(false)
    temp.slot = {}
    SlotItem.new(temp.slot, "DailyStamp_Reward_", index, temp._dayControl, self.slotConfig)
    temp.slot:createChild()
    temp.slot.icon:SetPosX(47)
    temp.slot.icon:SetPosY(47)
    temp.goodItemSlot = {}
    SlotItem.new(temp.goodItemSlot, "DailyStamp_GoodReward_", index, temp._dayControl, self.goodItemSlotConfig)
    temp.goodItemSlot:createChild()
    temp.goodItemSlot.icon:SetPosX(43)
    temp.goodItemSlot.icon:SetPosY(13)
    if isGameTypeEnglish() or isGameTypeRussia() then
      temp.goodItemSlot.icon:SetPosX(47)
      temp.goodItemSlot.icon:SetPosY(47)
    end
    temp._stamp = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, temp._dayControl, "Static_DailyStamp_StampIcon_" .. index)
    CopyBaseProperty(self.tempStamp, temp._stamp)
    temp._stamp:SetPosX(5)
    temp._stamp:SetPosY(5)
    temp._stamp:SetShow(false)
    self.dayControl[index] = temp
  end
  self.tempDailySlot:SetShow(false)
  self.tempDay:SetShow(false)
  self.btnClose:addInputEvent("Mouse_LUp", "DailStamp_Hide()")
end
function convertYYMMDDString(str)
  if not isGameTypeKorea() then
    return
  end
  if nil == str then
    return
  end
  local YY, MM, DD, hour = string.match(str, "(%d+)-(%d+)-(%d+)%s*0(%d+)")
  if 12 < tonumber(hour) then
    hour = "\236\152\164\237\155\132 " .. tonumber(hour) - 12
  else
    hour = "\236\152\164\236\160\132 " .. hour
  end
  local convertString = tostring(YY) .. "\235\133\132 " .. tostring(MM) .. "\236\155\148 " .. tostring(DD) .. "\236\157\188 \236\160\149\234\184\176\236\160\144\234\178\128\234\185\140\236\167\128"
  return convertString
end
dailyStamp:TapInit()
dailyStamp:Init()
function DailyStamp_SetData(rewardIndex)
  local self = dailyStamp
  if false == (rewardIndex >= 1 and rewardIndex <= dailyStampCount) then
    return
  end
  self.tapIndex = rewardIndex
  for index = 1, dailyStampCount do
    if rewardIndex == index then
      self.tapControl[index]:SetCheck(true)
    else
      self.tapControl[index]:SetCheck(false)
    end
  end
  local totalDayCount = dailyStampKeys[rewardIndex][1]:getRewardCount()
  self.goodDay = {totalDayCount}
  local attendanceKey = dailyStampKeys[rewardIndex][1]:getKey()
  local myAttendanceCount = ToClient_getAttendanceCount(attendanceKey)
  local recieveCount = ToClient_getReceivedRewardCount(attendanceKey)
  local yesterdayRecieveCount = dailyStampKeys[rewardIndex][1]:getAttendanceYesterdayCount()
  if nil == self.prevAttendanceCount[rewardIndex] then
    self.prevAttendanceCount[rewardIndex] = myAttendanceCount
  end
  if not dailyStampKeys[rewardIndex][1]:isPossibleAttendance() and not dailyStampKeys[rewardIndex][1]:isPossibleOverlapAttendance() then
    dailyStamp.attendanceTime:SetFontColor(UI_color.C_FFC4BEBE)
    dailyStamp.attendanceTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_TODAY_ATTENDANCE_COMPLETE"))
  end
  self.secondAttendanceCheck = false
  for index = 0, self.rewardCount - 1 do
    self.dayControl[index]._dayControl:addInputEvent("Mouse_LUp", "")
    self.dayControl[index]._dayControl:SetShow(false)
    self.dayControl[index]._dayControl:addInputEvent("Mouse_RUp", "")
    self.dayControl[index]._dayControl:addInputEvent("Mouse_On", "")
    self.dayControl[index]._dayControl:addInputEvent("Mouse_Out", "")
    self.dayControl[index].slot.icon:addInputEvent("Mouse_LUp", "")
    self.dayControl[index].slot.icon:addInputEvent("Mouse_RUP", "")
    self.dayControl[index].goodItemSlot.icon:addInputEvent("Mouse_LUp", "")
    self.dayControl[index].goodItemSlot.icon:addInputEvent("Mouse_RUP", "")
    self.dayControl[index]._stamp:SetShow(false)
    self.dayControl[index]._stamp:ResetVertexAni()
    self.dayControl[index]._stamp:SetSize(69, 69)
    self.dayControl[index]._stamp:SetPosX(5)
    self.dayControl[index]._stamp:SetPosY(5)
    self.dayControl[index].slot.icon:SetShow(false)
    self.dayControl[index].goodItemSlot.icon:SetShow(false)
    self.dayControl[index]._rewardName:SetShow(false)
    self.dayControl[index].goodItemSlot.icon:SetMonoTone(false)
    self.dayControl[index].slot.icon:SetMonoTone(false)
    self.dayControl[index]._dayControl:ResetVertexAni()
    self.dayControl[index]._dayControl:SetColor(Defines.Color.C_FFFFFFFF)
  end
  self.animationdayIndex = {}
  for index = 0, totalDayCount - 1 do
    local itemWrapper = dailyStampKeys[rewardIndex][1]:getRewardItem(index)
    self.dayControl[index].slot.icon:SetShow(true)
    self.dayControl[index]._dayControl:SetShow(true)
    self.dayControl[index].slot:setItem(itemWrapper)
    self.dayControl[index].slot.icon:addInputEvent("Mouse_On", "DailyStamp_Tooltip_Show(" .. index .. "," .. rewardIndex .. ")")
    self.dayControl[index].slot.icon:addInputEvent("Mouse_Out", "DailyStamp_Tooltip_Show()")
    self.dayControl[index]._dayText:SetFontColor(Defines.Color.C_FFEFEFEF)
    if myAttendanceCount > index then
      self.dayControl[index]._stamp:SetShow(true)
      if recieveCount > index then
        self.dayControl[index].slot.icon:SetMonoTone(true)
        self.dayControl[index].goodItemSlot.icon:SetMonoTone(true)
        if yesterdayRecieveCount <= index then
          self.dayControl[index]._stamp:SetShow(false)
          self.animationTime = 0
          self.dayControl[index]._stamp:SetScale(1, 1)
          DailyStamp_SetAnimation(rewardIndex, index)
          DailyStamp_ChangeTexture(index, 2)
          self.dayControl[index]._dayControl:addInputEvent("Mouse_On", "DailyStamp_TodayAttendance_TooltipShow(" .. index .. ")")
          self.dayControl[index]._dayControl:addInputEvent("Mouse_Out", "DailyStamp_TodayAttendance_TooltipHide()")
        else
          DailyStamp_ChangeTexture(index, 1)
        end
      else
        self.dayControl[index]._dayControl:addInputEvent("Mouse_LUp", "DailyStamp_AcceptReward(" .. rewardIndex .. ")")
        self.dayControl[index]._dayControl:addInputEvent("Mouse_RUp", "DailyStamp_AcceptReward(" .. rewardIndex .. ")")
        self.dayControl[index].slot.icon:addInputEvent("Mouse_LUp", "DailyStamp_AcceptReward(" .. rewardIndex .. ")")
        self.dayControl[index].slot.icon:addInputEvent("Mouse_RUP", "DailyStamp_AcceptReward(" .. rewardIndex .. ")")
        self.dayControl[index].goodItemSlot.icon:addInputEvent("Mouse_LUp", "DailyStamp_AcceptReward(" .. rewardIndex .. ")")
        self.dayControl[index].goodItemSlot.icon:addInputEvent("Mouse_RUP", "DailyStamp_AcceptReward(" .. rewardIndex .. ")")
        self.dayControl[index]._dayControl:addInputEvent("Mouse_On", "DailyStamp_AcceptReward_TooltipShow(" .. index .. ")")
        self.dayControl[index]._dayControl:addInputEvent("Mouse_Out", "DailyStamp_AcceptReward_TooltipShow()")
        DailyStamp_ChangeTexture(index, 0)
        local waitingTime = 0
        local possibleAttendance = false
        if dailyStampKeys[dailyStamp.tapIndex][1]:isPossibleAttendance() then
          waitingTime = ToClient_getWaitingTimeForAttendance()
          possibleAttendance = true
        end
        if dailyStampKeys[dailyStamp.tapIndex][1]:isPossibleOverlapAttendance() then
          waitingTime = ToClient_getWaitingTimeForNextAttendance(dailyStampKeys[dailyStamp.tapIndex][1]:getKey())
          possibleAttendance = true
        end
        if 0 == waitingTime and not possibleAttendance and index == myAttendanceCount - 1 then
          DailyStamp_ChangeTexture(index, 0)
          self.dayControl[index]._dayControl:SetVertexAniRun("Ani_Color_New", true)
          dailyStamp.attendanceTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_TODAY_ATTENDANCE_COMPLETE"))
        end
      end
    elseif index == myAttendanceCount then
      if dailyStampKeys[rewardIndex][1]:isPossibleAttendance() or dailyStampKeys[rewardIndex][1]:isPossibleOverlapAttendance() then
        if isPossibleAttandanceCheck() then
          DailyStamp_ChangeTexture(index, 0)
          self.dayControl[index]._dayControl:addInputEvent("Mouse_On", "DailyStamp_Attendance_TooltipShow(" .. index .. ", true )")
          self.dayControl[index]._dayControl:addInputEvent("Mouse_Out", "DailyStamp_Attendance_TooltipShow()")
        else
          DailyStamp_ChangeTexture(index, 3)
          self.dayControl[index]._dayControl:addInputEvent("Mouse_On", "DailyStamp_Attendance_TooltipShow(" .. index .. ")")
          self.dayControl[index]._dayControl:addInputEvent("Mouse_Out", "DailyStamp_Attendance_TooltipShow()")
          self.secondAttendanceCheck = true
        end
        self.dayControl[index]._dayControl:addInputEvent("Mouse_LUp", "DailyStamp_SetAttendance(" .. rewardIndex .. ")")
        self.dayControl[index]._dayControl:addInputEvent("Mouse_RUp", "DailyStamp_SetAttendance(" .. rewardIndex .. ")")
        self.dayControl[index].slot.icon:addInputEvent("Mouse_LUp", "DailyStamp_SetAttendance(" .. rewardIndex .. ")")
        self.dayControl[index].slot.icon:addInputEvent("Mouse_RUP", "DailyStamp_SetAttendance(" .. rewardIndex .. ")")
        self.dayControl[index].goodItemSlot.icon:addInputEvent("Mouse_LUp", "DailyStamp_SetAttendance(" .. rewardIndex .. ")")
        self.dayControl[index].goodItemSlot.icon:addInputEvent("Mouse_RUP", "DailyStamp_SetAttendance(" .. rewardIndex .. ")")
      else
        DailyStamp_ChangeTexture(index, 1)
      end
    else
      DailyStamp_ChangeTexture(index, 1)
    end
    for v, gIndex in pairs(self.goodDay) do
      if gIndex == index + 1 then
        local goodItemWrapper = dailyStampKeys[rewardIndex][1]:getRewardItem(index)
        self.dayControl[index].slot.icon:SetShow(false)
        self.dayControl[index].goodItemSlot.icon:SetShow(true)
        self.dayControl[index].goodItemSlot:setItem(dailyStampKeys[rewardIndex][1]:getRewardItem(index))
        self.dayControl[index].goodItemSlot.icon:addInputEvent("Mouse_On", "DailyStamp_Tooltip_Show(" .. index .. "," .. rewardIndex .. ")")
        self.dayControl[index].goodItemSlot.icon:addInputEvent("Mouse_Out", "DailyStamp_Tooltip_Show()")
        self.dayControl[index]._rewardName:SetShow(true)
        self.dayControl[index]._rewardName:SetText(goodItemWrapper:getStaticStatus():getName())
        self.dayControl[index].goodItemSlot.icon:SetPosX(43)
        self.dayControl[index].goodItemSlot.icon:SetPosY(13)
        if isGameTypeEnglish() or isGameTypeRussia() or 0 < ToClient_getGameOptionControllerWrapper():getUIFontSizeType() then
          self.dayControl[index]._rewardName:SetShow(false)
          self.dayControl[index].goodItemSlot.icon:SetPosX(47)
          self.dayControl[index].goodItemSlot.icon:SetPosY(47)
        end
        self.dayControl[index]._dayText:SetFontColor(Defines.Color.C_FFFFCE22)
      end
    end
  end
  self.eventPeriod:SetText(dailyStampKeys[rewardIndex][1]:getPeriodDate())
  self.acceptPeriod:SetText(dailyStampKeys[rewardIndex][1]:getExpireDate())
  if 25 < self.eventPeriod:GetTextSizeY() then
    self.acceptPeriodTitle:SetSpanSize(self.acceptPeriodTitle:GetSpanSize().x, self.eventPeriod:GetSpanSize().y - self.eventPeriod:GetTextSizeY())
    self.acceptPeriod:SetSpanSize(self.acceptPeriod:GetSpanSize().x, self.eventPeriod:GetSpanSize().y - self.eventPeriod:GetTextSizeY())
    local titleSizeX = math.max(self.eventPeriodTitle:GetTextSizeX(), self.acceptPeriodTitle:GetTextSizeX())
    local baseSizeX = self.eventPeriodTitle:GetPosX() + titleSizeX
    if self.acceptPeriod:GetPosX() < baseSizeX + 10 then
      self.eventPeriod:SetPosX(baseSizeX + 10)
      self.acceptPeriod:SetPosX(baseSizeX + 10)
    end
  end
  if false then
    for index = 0, #self.eventEntryCount do
      if myAttendanceCount >= self.eventEntryCount[index] then
        self.entryIcon[index]:SetShow(true)
      else
        self.entryIcon[index]:SetShow(false)
      end
    end
  end
  dailyStamp:TabUpdate()
end
function DailyStamp_ChangeTexture(index, recieveType)
  local self = dailyStamp
  if 0 == recieveType then
    self.dayControl[index]._dayControl:ChangeTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 10, 104, 105, 199)
    self.dayControl[index]._dayControl:getBaseTexture():setUV(x1, y1, x2, y2)
    self.dayControl[index]._dayControl:setRenderTexture(self.dayControl[index]._dayControl:getBaseTexture())
    self.dayControl[index]._dayControl:ChangeOnTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 108, 104, 203, 199)
    self.dayControl[index]._dayControl:getOnTexture():setUV(x1, y1, x2, y2)
    self.dayControl[index]._dayControl:ChangeClickTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 206, 104, 301, 199)
    self.dayControl[index]._dayControl:getClickTexture():setUV(x1, y1, x2, y2)
    for v, gIndex in pairs(self.goodDay) do
      if gIndex == index + 1 then
        self.dayControl[index]._dayControl:ChangeTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 407, 7, 502, 102)
        self.dayControl[index]._dayControl:getBaseTexture():setUV(x1, y1, x2, y2)
        self.dayControl[index]._dayControl:setRenderTexture(self.dayControl[index]._dayControl:getBaseTexture())
        self.dayControl[index]._dayControl:ChangeOnTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 407, 104, 502, 199)
        self.dayControl[index]._dayControl:getOnTexture():setUV(x1, y1, x2, y2)
        self.dayControl[index]._dayControl:ChangeClickTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 407, 201, 502, 296)
        self.dayControl[index]._dayControl:getClickTexture():setUV(x1, y1, x2, y2)
      end
    end
  elseif 1 == recieveType then
    self.dayControl[index]._dayControl:ChangeTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 10, 7, 105, 102)
    self.dayControl[index]._dayControl:getBaseTexture():setUV(x1, y1, x2, y2)
    self.dayControl[index]._dayControl:setRenderTexture(self.dayControl[index]._dayControl:getBaseTexture())
    self.dayControl[index]._dayControl:ChangeOnTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 10, 7, 105, 102)
    self.dayControl[index]._dayControl:getOnTexture():setUV(x1, y1, x2, y2)
    self.dayControl[index]._dayControl:ChangeClickTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 10, 7, 105, 102)
    self.dayControl[index]._dayControl:getClickTexture():setUV(x1, y1, x2, y2)
    for v, gIndex in pairs(self.goodDay) do
      if gIndex == index + 1 then
        self.dayControl[index]._dayControl:ChangeTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 307, 7, 402, 102)
        self.dayControl[index]._dayControl:getBaseTexture():setUV(x1, y1, x2, y2)
        self.dayControl[index]._dayControl:setRenderTexture(self.dayControl[index]._dayControl:getBaseTexture())
        self.dayControl[index]._dayControl:ChangeOnTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 307, 7, 402, 102)
        self.dayControl[index]._dayControl:getOnTexture():setUV(x1, y1, x2, y2)
        self.dayControl[index]._dayControl:ChangeClickTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 307, 7, 402, 102)
        self.dayControl[index]._dayControl:getClickTexture():setUV(x1, y1, x2, y2)
      end
    end
  elseif 2 == recieveType then
    self.dayControl[index]._dayControl:ChangeTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_02.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 1, 1, 96, 96)
    self.dayControl[index]._dayControl:getBaseTexture():setUV(x1, y1, x2, y2)
    self.dayControl[index]._dayControl:setRenderTexture(self.dayControl[index]._dayControl:getBaseTexture())
    self.dayControl[index]._dayControl:ChangeOnTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_02.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 99, 1, 194, 96)
    self.dayControl[index]._dayControl:getOnTexture():setUV(x1, y1, x2, y2)
    self.dayControl[index]._dayControl:ChangeClickTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_02.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 197, 1, 292, 96)
    self.dayControl[index]._dayControl:getClickTexture():setUV(x1, y1, x2, y2)
    for v, gIndex in pairs(self.goodDay) do
      if gIndex == index + 1 then
        self.dayControl[index]._dayControl:ChangeTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_02.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 1, 195, 96, 290)
        self.dayControl[index]._dayControl:getBaseTexture():setUV(x1, y1, x2, y2)
        self.dayControl[index]._dayControl:setRenderTexture(self.dayControl[index]._dayControl:getBaseTexture())
        self.dayControl[index]._dayControl:ChangeOnTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_02.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 99, 195, 194, 290)
        self.dayControl[index]._dayControl:getOnTexture():setUV(x1, y1, x2, y2)
        self.dayControl[index]._dayControl:ChangeClickTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_02.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 197, 195, 292, 290)
        self.dayControl[index]._dayControl:getClickTexture():setUV(x1, y1, x2, y2)
      end
    end
  elseif 3 == recieveType then
    self.dayControl[index]._dayControl:ChangeTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_02.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 1, 98, 96, 193)
    self.dayControl[index]._dayControl:getBaseTexture():setUV(x1, y1, x2, y2)
    self.dayControl[index]._dayControl:setRenderTexture(self.dayControl[index]._dayControl:getBaseTexture())
    self.dayControl[index]._dayControl:ChangeOnTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_02.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 99, 98, 194, 193)
    self.dayControl[index]._dayControl:getOnTexture():setUV(x1, y1, x2, y2)
    self.dayControl[index]._dayControl:ChangeClickTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_02.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 197, 98, 292, 193)
    self.dayControl[index]._dayControl:getClickTexture():setUV(x1, y1, x2, y2)
    for v, gIndex in pairs(self.goodDay) do
      if gIndex == index + 1 then
        self.dayControl[index]._dayControl:ChangeTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_02.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 1, 195, 96, 290)
        self.dayControl[index]._dayControl:getBaseTexture():setUV(x1, y1, x2, y2)
        self.dayControl[index]._dayControl:setRenderTexture(self.dayControl[index]._dayControl:getBaseTexture())
        self.dayControl[index]._dayControl:ChangeOnTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_02.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 99, 195, 194, 290)
        self.dayControl[index]._dayControl:getOnTexture():setUV(x1, y1, x2, y2)
        self.dayControl[index]._dayControl:ChangeClickTextureInfoName("New_UI_Common_ForLua/Window/DailyCheck/DailyCheck_02.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self.dayControl[index]._dayControl, 197, 195, 292, 290)
        self.dayControl[index]._dayControl:getClickTexture():setUV(x1, y1, x2, y2)
      end
    end
  end
end
function DailyStamp_RecieveReward(index, rewardIndex)
  local function recieveReward()
    ToClient_takeRewardItem(dailyStampKeys[rewardIndex][1]:getKey())
  end
  local receiveItemIndex = ToClient_getReceivedRewardCount(dailyStampKeys[rewardIndex][1]:getKey())
  if 0 == receiveItemIndex then
    receiveItemIndex = 0
  end
  TooltipSimple_Hide()
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_MSGTITLE")
  local itemWrapper = dailyStampKeys[rewardIndex][1]:getRewardItem(receiveItemIndex)
  local content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_MSGCONTENT", "name", tostring(itemWrapper:getStaticStatus():getName()))
  messageBoxData = {
    title = title,
    content = content,
    functionYes = recieveReward,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function DailyStamp_TodayAttendance_TooltipShow(index)
  local uiControl = dailyStamp.dayControl[index]._dayControl
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_TODAYATTENDANCE_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_TODAYATTENDANCE_DESC")
  TooltipSimple_Show(uiControl, name, desc)
end
function DailyStamp_TodayAttendance_TooltipHide()
  TooltipSimple_Hide()
end
function DailyStamp_AcceptReward_TooltipShow(index)
  if nil == index then
    TooltipSimple_Hide()
    return
  end
  local uiControl = dailyStamp.dayControl[index]._dayControl
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_RECEIVEPOSSIBLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_MOUSE_CLICKRECEIVE")
  TooltipSimple_Show(uiControl, name, desc)
end
function DailyStamp_Attendance_TooltipShow(index, isPossible)
  if nil == index then
    TooltipSimple_Hide()
    return
  end
  local uiControl = dailyStamp.dayControl[index]._dayControl
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_DAILYCHECK_POSSIBLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_MOUSE_CLICKSTAMP")
  if nil == isPossible then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_DAILYCHECK_IMPOSSIBLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_CHECK_THIRTYMINUTE_POSSIBLE")
  end
  TooltipSimple_Show(uiControl, name, desc)
end
function DailyStamp_TapClicked(rewardIndex)
  local self = dailyStamp
  dailyStamp.animationdayIndex = {}
  DailyStamp_SetData(rewardIndex)
end
function DailyStamp_SetAttendance(rewardIndex)
  if not isPossibleAttandanceCheck() then
    local waitingTime = -1
    if dailyStampKeys[rewardIndex][1]:isPossibleAttendance() then
      waitingTime = ToClient_getWaitingTimeForAttendance()
    end
    if dailyStampKeys[rewardIndex][1]:isPossibleOverlapAttendance() then
      waitingTime = ToClient_getWaitingTimeForNextAttendance(dailyStampKeys[rewardIndex][1]:getKey())
    end
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_STILL_CHECK_IMPOSSIBLE_REMAINTIME", "remainTime", Util.Time.timeFormatting_Minute(waitingTime)))
    return false
  end
  local attendanceKey = dailyStampKeys[rewardIndex][1]:getKey()
  ToClient_onAttendance(attendanceKey)
  return true
end
function FGlobal_DailyStamp_SetAttendanceAll()
  local openDailyStamp = false
  for index = 1, dailyStampCount do
    if nil ~= dailyStampKeys[index][1] and (dailyStampKeys[index][1]:isPossibleAttendance() or dailyStampKeys[index][1]:isPossibleOverlapAttendance()) and dailyStampKeys[index][3] == false then
      dailyStampKeys[index][3] = true
      if true == DailyStamp_SetAttendance(index) then
        openDailyStamp = true
      end
    end
  end
  if not Panel_Window_DailyStamp:GetShow() and true == openDailyStamp then
    DailyStamp_ShowToggle()
  end
end
function DailyStamp_AcceptReward(rewardIndex)
  local attendanceKey = dailyStampKeys[rewardIndex][1]:getKey()
  local function recieveReward()
    ToClient_takeRewardItem(attendanceKey)
  end
  local myAttendanceCount = ToClient_getAttendanceCount(attendanceKey)
  local receiveItemIndex = ToClient_getReceivedRewardCount(attendanceKey)
  if myAttendanceCount <= receiveItemIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_NOTHING_REWARD"))
    return
  end
  if 0 == receiveItemIndex then
    receiveItemIndex = 0
  end
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_MSGTITLE")
  local itemWrapper = dailyStampKeys[rewardIndex][1]:getRewardItem(receiveItemIndex)
  local content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_MSGCONTENT", "name", tostring(itemWrapper:getStaticStatus():getName()))
  messageBoxData = {
    title = title,
    content = content,
    functionYes = recieveReward,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function DailyStamp_Tooltip_Show(index, rewardIndex)
  if nil == index then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper = dailyStampKeys[rewardIndex][1]:getRewardItem(index)
  local itemSSW = itemWrapper:getStaticStatus()
  local uiBase = dailyStamp.dayControl[index].slot.icon
  Panel_Tooltip_Item_Show(itemSSW, uiBase, true, false)
end
function DailyStamp_ShowToggle(showType)
  local currentCount = ToClient_GetAttendanceInfoCount()
  if dailyStampCount ~= currentCount then
    dailyStampCount = currentCount
    dailyStampKeys = Array.new()
    for index = 1, dailyStampCount do
      local attendaceSS = ToClient_GetAttendanceInfoWrapper(index - 1)
      dailyStampKeys[index] = {
        attendaceSS,
        attendaceSS:getDisplayOrder(),
        false
      }
      if nil ~= dailyStampKeys[index][1] and false == dailyStampKeys[index][1]:isPossibleOverlapAttendance() and false == dailyStampKeys[index][1]:isPossibleAttendance() then
        dailyStampKeys[index][3] = true
      end
    end
    table.sort(orderStamp, TabSort)
    dailyStamp:TapInit()
  end
  if dailyStampCount <= 0 then
    return
  end
  local self = dailyStamp
  if Panel_LevelupGuide:IsShow() then
    FGlobal_LevelupGuide_PowerClose()
  end
  if not Panel_Window_DailyStamp:GetShow() then
    for index = 1, dailyStampCount do
      self.tapControl[index]:SetCheck(false)
    end
    Panel_Window_DailyStamp:SetShow(true, true)
    self.tapControl[1]:SetCheck(true)
    DailyStamp_SetData(1)
    Panel_Window_DailyStamp_RePos()
  end
  TooltipSimple_Hide()
end
function DailStamp_Hide()
  Panel_Window_DailyStamp:SetShow(false, true)
  local temporaryPCRoomWrapper = getTemporaryInformationWrapper()
  local isPremiumPcRoom = temporaryPCRoomWrapper:isPremiumPcRoom()
  local isEventBeforShow = temporaryPCRoomWrapper:isEventBeforeShow()
  if isPremiumPcRoom then
    if isGameTypeEnglish() then
      FGlobal_LevelupGuide_Open(false)
    elseif temporaryPCRoomWrapper:isPcRoomBeforeShow() then
      if not isEventBeforShow then
        EventNotify_Open()
      end
    else
      PcRoomNotify_FirstUsePearl_Open()
    end
  else
    EventNotify_Open()
  end
end
function Panel_Window_DailyStamp_RePos()
  Panel_Window_DailyStamp:SetPosX(getScreenSizeX() / 2 - Panel_Window_DailyStamp:GetSizeX() / 2)
  Panel_Window_DailyStamp:SetPosY(getScreenSizeY() / 2 - Panel_Window_DailyStamp:GetSizeY() / 2)
end
function FromClient_receiveAttendanceReward(attendanceKey)
  for index = 1, dailyStampCount do
    local dailyKey = dailyStampKeys[index][1]:getKey()
    if dailyKey:get() == attendanceKey:get() then
      DailyStamp_SetData(index)
      return
    end
  end
end
local secondAttendanceCheck = false
function FromClient_AttendanceUpdate(attendanceKey)
  secondAttendanceCheck = dailyStamp.secondAttendanceCheck
  for index = 1, dailyStampCount do
    local dailyKey = dailyStampKeys[index][1]:getKey()
    if dailyKey:get() == attendanceKey:get() then
      DailyStamp_AcceptRewardAll(index)
      DailyStamp_SetData(index)
      dailyStampKeys[index][3] = false
      if nil ~= dailyStampKeys[index][1] and false == dailyStampKeys[index][1]:isPossibleOverlapAttendance() and false == dailyStampKeys[index][1]:isPossibleAttendance() then
        dailyStampKeys[index][3] = true
      end
      break
    end
  end
  if dailyStamp.nextDayShow or secondAttendanceCheck then
    local seflPlayer = getSelfPlayer()
    if nil == seflPlayer then
      return
    end
    local regionInfo = getRegionInfoByPosition(seflPlayer:get():getPosition())
    local isSafeZone = regionInfo:get():isSafeZone()
    if false == isSafeZone then
      return
    end
    dailyStamp.nextDayShow = false
  end
  if not Panel_Window_DailyStamp:GetShow() then
    Panel_Window_DailyStamp:SetShow(true, true)
  end
end
function FromClient_AttendanceUpdateAll(isNextDay)
  if isNextDay then
    dailyStamp.nextDayShow = isNextDay
  end
  dailyStampCount = ToClient_GetAttendanceInfoCount()
  dailyStampKeys = Array.new()
  for index = 1, dailyStampCount do
    local attendaceSS = ToClient_GetAttendanceInfoWrapper(index - 1)
    dailyStampKeys[index] = {
      attendaceSS,
      attendaceSS:getDisplayOrder(),
      false
    }
  end
  table.sort(dailyStampKeys, TabSort)
  dailyStamp:TapInit()
end
function FromClient_DailyStampRegionCheck(regionData)
  if dailyStamp.nextDayShow then
    local isSafeZone = regionData:get():isSafeZone()
    if isSafeZone and not Panel_Window_DailyStamp:GetShow() then
      dailyStamp.nextDayShow = false
      DailyStamp_ShowToggle()
      return
    end
  end
  if secondAttendanceCheck then
    local isSafeZone = regionData:get():isSafeZone()
    if isSafeZone and not Panel_Window_DailyStamp:GetShow() then
      secondAttendanceCheck = false
      DailyStamp_ShowToggle()
      return
    end
  end
end
function DailyStamp_AcceptRewardAll(tabIndex)
  local attendanceKey = dailyStampKeys[tabIndex][1]:getKey()
  local myAttendanceCount = ToClient_getAttendanceCount(attendanceKey)
  local receiveItemIndex = ToClient_getReceivedRewardCount(attendanceKey)
  if myAttendanceCount > receiveItemIndex then
    for index = receiveItemIndex, myAttendanceCount - 1 do
      ToClient_takeRewardItem(attendanceKey)
    end
  end
end
local attendanceTimeCheck = false
local timercount = 0
function isPossibleAttandanceCheck()
  if nil == dailyStampKeys[dailyStamp.tapIndex][1] then
    return false
  end
  local waitingTime = -1
  local possibleAttendance = false
  if dailyStampKeys[dailyStamp.tapIndex][1]:isPossibleAttendance() then
    waitingTime = ToClient_getWaitingTimeForAttendance()
    possibleAttendance = true
  end
  if dailyStampKeys[dailyStamp.tapIndex][1]:isPossibleOverlapAttendance() then
    waitingTime = ToClient_getWaitingTimeForNextAttendance(dailyStampKeys[dailyStamp.tapIndex][1]:getKey())
    possibleAttendance = true
  end
  if waitingTime < 0 then
    return false
  end
  if 0 == waitingTime then
    if possibleAttendance then
      dailyStamp.attendanceTime:SetFontColor(UI_color.C_FF96D4FC)
      dailyStamp.attendanceTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_NEWDAY_ATTENDANCE_CLICK"))
    else
      dailyStamp.attendanceTime:SetFontColor(UI_color.C_FFC4BEBE)
      dailyStamp.attendanceTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_TODAY_ATTENDANCE_COMPLETE"))
    end
    if not attendanceTimeCheck then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_TODAY_ATTENDANCE_POSSIBLE"))
      attendanceTimeCheck = true
      DailyStamp_SetData(dailyStamp.tapIndex)
    end
  else
    local remainTimeText = ""
    if waitingTime < 60 then
      remainTimeText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_REMAIN_SECOND", "remainTime", waitingTime)
    else
      remainTimeText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_REMAIN_MINUTE", "remainTime", math.floor(waitingTime / 60))
    end
    dailyStamp.attendanceTime:SetFontColor(UI_color.C_FFEFEFEF)
    dailyStamp.attendanceTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_DONOT_ATTENDANCE_AFTERPOSSIBLE", "remainTimeText", remainTimeText))
    if attendanceTimeCheck then
      attendanceTimeCheck = false
      DailyStamp_SetData(dailyStamp.tapIndex)
    end
  end
  FGlobal_DailyStamp_CheckAttendance(isPossibleAttendance_AnyType(waitingTime))
  return attendanceTimeCheck
end
function isPossibleAttendance_AnyType(waitingTime)
  local isPossible = false
  for index = 1, dailyStampCount do
    if nil ~= dailyStampKeys[index][1] and 0 == waitingTime and (dailyStampKeys[index][1]:isPossibleAttendance() or dailyStampKeys[index][1]:isPossibleOverlapAttendance()) then
      isPossible = true
    end
  end
  return isPossible
end
function FromClient_AttendanceTimer()
  if getSelfPlayer():get():getLevel() < 6 then
    return
  end
  local waitingTime = -1
  local attendance = false
  local remainTimeText = ""
  for index = 1, dailyStampCount do
    if nil ~= dailyStampKeys[index][1] and dailyStampKeys[index][1]:isPossibleAttendance() then
      waitingTime = ToClient_getWaitingTimeForAttendance()
      if 0 == waitingTime then
        local attendanceKey = dailyStampKeys[index][1]:getKey()
        ToClient_onAttendance(attendanceKey)
        attendance = true
      elseif waitingTime > 0 then
        if waitingTime < 60 then
          remainTimeText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_REMAIN_SECOND", "remainTime", waitingTime)
        else
          remainTimeText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_REMAIN_MINUTE", "remainTime", math.floor(waitingTime / 60))
        end
        dailyStamp.attendanceTime:SetFontColor(UI_color.C_FFEFEFEF)
        dailyStamp.attendanceTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_DONOT_ATTENDANCE_AFTERPOSSIBLE", "remainTimeText", remainTimeText))
      end
    end
  end
  waitingTime = -1
  for index = 1, dailyStampCount do
    if nil ~= dailyStampKeys[index][1] and dailyStampKeys[index][1]:isPossibleOverlapAttendance() then
      waitingTime = ToClient_getWaitingTimeForNextAttendance(dailyStampKeys[index][1]:getKey())
      if 0 == waitingTime then
        local attendanceKey = dailyStampKeys[index][1]:getKey()
        ToClient_onAttendance(attendanceKey)
        attendance = true
      elseif waitingTime > 0 then
        if waitingTime < 60 then
          remainTimeText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_REMAIN_SECOND", "remainTime", waitingTime)
        else
          remainTimeText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_REMAIN_MINUTE", "remainTime", math.floor(waitingTime / 60))
        end
        if dailyStamp.tapIndex == index then
          dailyStamp.attendanceTime:SetFontColor(UI_color.C_FFEFEFEF)
          dailyStamp.attendanceTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_DONOT_ATTENDANCE_AFTERPOSSIBLE", "remainTimeText", remainTimeText))
        end
      end
    end
  end
end
function FGlobal_DailyStamp_ShowCheck()
  if ToClient_IsContentsGroupOpen("1025") then
    DailyStamp_ShowToggle()
  end
end
function DailyStamp_SetAnimation(tabIndex, dayIndex)
  dailyStamp.animationTabIndex = tabIndex
  if nil == dailyStamp.animationdayIndex[0] then
    dailyStamp.animationdayIndex[0] = dayIndex
  else
    dailyStamp.animationdayIndex[1] = dayIndex
  end
end
function DailStamp_StampAnimation(deltaTime)
  local self = dailyStamp
  self.animationTime = self.animationTime + deltaTime
  if self.tapIndex == self.animationTabIndex and self.animationTime > 0.3 and self.animationTime < 1 then
    for index = 0, #dailyStamp.animationdayIndex do
      if self.animationdayIndex[index] <= self.rewardCount - 1 then
        self.dayControl[self.animationdayIndex[index]]._stamp:SetShow(true)
        self.dayControl[self.animationdayIndex[index]]._stamp:ResetVertexAni()
        self.dayControl[self.animationdayIndex[index]]._stamp:SetScale(1, 1)
        self.dayControl[self.animationdayIndex[index]]._stamp:SetSize(69, 69)
        self.dayControl[self.animationdayIndex[index]]._stamp:SetPosX(5)
        self.dayControl[self.animationdayIndex[index]]._stamp:SetPosY(5)
        self.dayControl[self.animationdayIndex[index]]._stamp:SetVertexAniRun("Ani_Move_Pos_New", true)
        self.dayControl[self.animationdayIndex[index]]._stamp:SetVertexAniRun("Ani_Scale_New", true)
      end
    end
    audioPostEvent_SystemUi(0, 21)
    self.animationTime = 5
  end
end
Panel_Window_DailyStamp:RegisterUpdateFunc("DailStamp_StampAnimation")
registerEvent("FromClient_AttendanceUpdate", "FromClient_AttendanceUpdate")
registerEvent("FromClient_AttendanceUpdateAll", "FromClient_AttendanceUpdateAll")
registerEvent("FromClient_receiveAttendanceReward", "FromClient_receiveAttendanceReward")
registerEvent("onScreenResize", "Panel_Window_DailyStamp_RePos")
registerEvent("selfPlayer_regionChanged", "FromClient_DailyStampRegionCheck")
registerEvent("FromClient_AttendanceTimer", "FromClient_AttendanceTimer")
