PaGlobal_CharacterInfo = {
  _tabButton = {
    _basic = 0,
    _title = 1,
    _history = 2,
    _challenge = 3,
    _profile = 4
  },
  _panel = {
    [0] = Panel_Window_CharInfo_BasicStatus,
    [1] = Panel_Window_CharInfo_TitleInfo,
    [2] = Panel_Window_CharInfo_HistoryInfo,
    [3] = Panel_Window_Challenge,
    [4] = Panel_Window_Profile
  },
  _ui = {
    _staticDefaultBG = {},
    _radioButton = {},
    _checkButtonPopUp = UI.getChildControl(Panel_Window_CharInfo_Status, "CheckButton_PopUp"),
    _buttonQuestion = UI.getChildControl(Panel_Window_CharInfo_Status, "Button_Question"),
    _buttonClose = UI.getChildControl(Panel_Window_CharInfo_Status, "Button_Close")
  },
  _isProfileOpen = ToClient_IsContentsGroupOpen("271")
}
function PaGlobal_CharacterInfo:showAni()
  local aniInfo1 = Panel_Window_CharInfo_Status:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.12)
  aniInfo1.AxisX = Panel_Window_CharInfo_Status:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_CharInfo_Status:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_CharInfo_Status:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.12)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_CharInfo_Status:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_CharInfo_Status:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_CharacterInfo:hideAni()
  UIAni.closeAni(Panel_Window_CharInfo_Status)
end
function PaGlobal_CharacterInfo:initialize()
  Panel_Window_CharInfo_Status:SetShow(false)
  Panel_Window_CharInfo_Status:setMaskingChild(true)
  Panel_Window_CharInfo_Status:setGlassBackground(true)
  Panel_Window_CharInfo_Status:SetDragEnable(true)
  Panel_Window_CharInfo_Status:ActiveMouseEventEffect(true)
  for key, index in pairs(self._tabButton) do
    self._ui._staticDefaultBG[index] = UI.getChildControl(Panel_Window_CharInfo_Status, "Static_DefaultBG" .. index)
    self._ui._radioButton[index] = UI.getChildControl(Panel_Window_CharInfo_Status, "RadioButton_Tab" .. index)
    self._panel[index]:SetShow(false)
    self._ui._staticDefaultBG[index]:MoveChilds(self._ui._staticDefaultBG[index]:GetID(), self._panel[index])
    UI.deletePanel(self._panel[index]:GetID())
  end
  self._ui._radioButton[self._tabButton._profile]:SetShow(self._isProfileOpen)
end
function PaGlobal_CharacterInfo:registEventHandler()
  Panel_Window_CharInfo_Status:RegisterShowEventFunc(true, "PaGlobal_CharacterInfo:showAni()")
  Panel_Window_CharInfo_Status:RegisterShowEventFunc(false, "PaGlobal_CharacterInfo:hideAni()")
  for key, index in pairs(self._tabButton) do
    self._ui._radioButton[index]:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfo:showWindow(" .. index .. ")")
  end
  self._ui._checkButtonPopUp:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfo:handleClicked_PopUp()")
  self._ui._checkButtonPopUp:addInputEvent("Mouse_On", "PaGlobal_CharacterInfo:popUpToolTip( true )")
  self._ui._checkButtonPopUp:addInputEvent("Mouse_Out", "PaGlobal_CharacterInfo:popUpToolTip( false )")
  self._ui._buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"SelfCharacterInfo\" )")
  self._ui._buttonQuestion:addInputEvent("Mouse_On", "HelpMessageQuestion_Show( \"SelfCharacterInfo\", \"true\")")
  self._ui._buttonQuestion:addInputEvent("Mouse_Out", "HelpMessageQuestion_Show( \"SelfCharacterInfo\", \"false\")")
  self._ui._buttonClose:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfo:hideWindow()")
end
function PaGlobal_CharacterInfo:showWindow(index)
  if nil == index then
    index = 0
  end
  Panel_Window_CharInfo_Status:SetShow(true, true)
  for key, tab in pairs(self._tabButton) do
    self._ui._staticDefaultBG[tab]:SetShow(false)
    self._ui._radioButton[tab]:SetCheck(false)
  end
  self._ui._staticDefaultBG[index]:SetShow(true)
  self._ui._radioButton[index]:SetCheck(true)
  if self._tabButton._basic == index then
    PaGlobal_CharacterInfoBasic:showWindow()
  elseif self._tabButton._title == index then
    PaGlobal_CharacterInfoTitle:showWindow()
  elseif self._tabButton._history == index then
    MyHistory_DataUpdate()
  elseif self._tabButton._challenge == index then
    Fglobal_Challenge_UpdateData()
  elseif self._tabButton._profile == index then
    FGlobal_Profile_Update()
  end
end
function PaGlobal_CharacterInfo:hideWindow()
  Panel_Window_CharInfo_Status:SetShow(false, false)
  PaGlobal_CharacterInfoBasic:hideWindow()
  UI.ClearFocusEdit()
  Panel_Window_CharInfo_Status:CloseUISubApp()
  self._ui._checkButtonPopUp:SetCheck(false)
  HelpMessageQuestion_Out()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_CharacterInfo:handleClicked_PopUp()
  if self._ui._checkButtonPopUp:IsCheck() then
    Panel_Window_CharInfo_Status:OpenUISubApp()
  else
    Panel_Window_CharInfo_Status:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function PaGlobal_CharacterInfo:popUpToolTip(isShow)
  if isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if self._ui._checkButtonPopUp:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(self._ui._checkButtonPopUp, name, desc)
  else
    TooltipSimple_Hide()
  end
end
PaGlobal_CharacterInfo:initialize()
PaGlobal_CharacterInfo:registEventHandler()
