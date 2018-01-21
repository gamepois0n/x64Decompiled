Panel_Adrenallin:SetShow(false)
local ui = {
  _adCircleProgress = UI.getChildControl(Panel_Adrenallin, "CircularProgress_Adrenallin"),
  _txt_Adrenallin = UI.getChildControl(Panel_Adrenallin, "StaticText_AdPercent")
}
local _close_Adrenallin = UI.getChildControl(Panel_Adrenallin, "Button_Win_Close")
_close_Adrenallin:SetShow(false)
local prevAdrenallin = 0
_transLockButton = UI.getChildControl(Panel_Adrenallin, "Button_TransLock")
_transLockButton:addInputEvent("Mouse_LUp", "requestBlackSpritSkill()")
_staticLockButton = UI.getChildControl(Panel_Adrenallin, "Static_Lock")
_staticLockButton:SetShow(false)
function UseableBlackSpritSkill()
  local selfPlayer = getSelfPlayer()
  if true == selfPlayer:isUseableBlackSpritSkill() then
    _staticLockButton:SetShow(false)
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_USEABLE_BLACKSPRITSKILL"), 5)
  else
    _staticLockButton:SetShow(true)
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOTUSEABLE_BLACKSPRITSKILL"), 5)
  end
end
function adrenallin_Update()
  local selfPlayer = getSelfPlayer()
  local adrenallin = selfPlayer:getAdrenalin()
  ui._adCircleProgress:SetProgressRate(adrenallin)
  ui._txt_Adrenallin:SetText(tostring(adrenallin) .. "%")
  if prevAdrenallin ~= adrenallin then
    FGlobal_MainStatus_FadeIn(5)
  end
  prevAdrenallin = adrenallin
end
function Panel_adrenallin_EnableSimpleUI()
  Panel_adrenallin_SetAlphaAllChild(Panel_MainStatus_User_Bar:GetAlpha())
end
function Panel_adrenallin_DisableSimpleUI()
  Panel_adrenallin_SetAlphaAllChild(1)
end
function Panel_adrenallin_UpdateSimpleUI(fDeltaTime)
  Panel_adrenallin_SetAlphaAllChild(Panel_MainStatus_User_Bar:GetAlpha())
end
function Panel_adrenallin_SetAlphaAllChild(alphaValue)
  Panel_Adrenallin:SetAlpha(alphaValue)
  ui._adCircleProgress:SetAlpha(alphaValue)
  ui._txt_Adrenallin:SetFontAlpha(alphaValue)
end
registerEvent("SimpleUI_UpdatePerFrame", "Panel_adrenallin_UpdateSimpleUI")
registerEvent("EventSimpleUIEnable", "Panel_adrenallin_EnableSimpleUI")
registerEvent("EventSimpleUIDisable", "Panel_adrenallin_DisableSimpleUI")
function FromClient_UpdateAdrenalin()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  changePositionBySever(Panel_Adrenallin, CppEnums.PAGameUIType.PAGameUIPanel_Adrenallin, false, true, false)
  Panel_Adrenallin:SetShow(getSelfPlayer():isEnableAdrenalin() and not isRecordMode)
  adrenallin_Update()
end
function FromClient_ChangeAdrenalinMode()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  adrenallin_Update()
  if not isLuaLoadingComplete then
    return
  elseif Defines.UIMode.eUIMode_Default ~= GetUIMode() then
    return
  end
  if CppDefine.ChangeUIAndResolution == true then
    if Panel_Adrenallin:GetRelativePosX() == -1 and Panel_Adrenallin:GetRelativePosY() == -1 then
      local initPosX = getScreenSizeX() / 2 - Panel_Adrenallin:GetSizeX() / 2 + 225
      local initPosY = getScreenSizeY() - Panel_QuickSlot:GetSizeY() - 76
      Panel_Adrenallin:SetPosX(initPosX)
      Panel_Adrenallin:SetPosY(initPosY)
      changePositionBySever(Panel_Adrenallin, CppEnums.PAGameUIType.PAGameUIPanel_Adrenallin, false, true, false)
      FGlobal_InitPanelRelativePos(Panel_Adrenallin, initPosX, initPosY)
    elseif Panel_Adrenallin:GetRelativePosX() == 0 and Panel_Adrenallin:GetRelativePosY() == 0 then
      Panel_Adrenallin:SetPosX(getScreenSizeX() / 2 - Panel_Adrenallin:GetSizeX() / 2 + 225)
      Panel_Adrenallin:SetPosY(getScreenSizeY() - Panel_QuickSlot:GetSizeY() - 76)
    else
      Panel_Adrenallin:SetPosX(getScreenSizeX() * Panel_Adrenallin:GetRelativePosX() - Panel_Adrenallin:GetSizeX() / 2)
      Panel_Adrenallin:SetPosY(getScreenSizeY() * Panel_Adrenallin:GetRelativePosY() - Panel_Adrenallin:GetSizeY() / 2)
    end
  else
    changePositionBySever(Panel_Adrenallin, CppEnums.PAGameUIType.PAGameUIPanel_Adrenallin, false, true, false)
  end
  Panel_Adrenallin:SetShow(getSelfPlayer():isEnableAdrenalin() and not isRecordMode)
end
function Adrenallin_ShowSimpleToolTip(isShow)
  name = PAGetString(Defines.StringSheet_GAME, "LUA_ADRENALLIN_TOOLTIP_TITLE")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_ADRENALLIN_TOOLTIP_DESC")
  uiControl = Panel_Adrenallin
  registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
  if isShow == true then
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function Panel_Adrenallin_ChangeTexture_On()
  Panel_Adrenallin:ChangeTextureInfoName("new_ui_common_forlua/default/window_sample_drag.dds")
  _close_Adrenallin:SetShow(true)
end
function Panel_Adrenallin_ChangeTexture_Off()
  _close_Adrenallin:SetShow(false)
  if Panel_UIControl:IsShow() then
    Panel_Adrenallin:ChangeTextureInfoName("new_ui_common_forlua/default/window_sample_isWidget.dds")
  else
    Panel_Adrenallin:ChangeTextureInfoName("new_ui_common_forlua/default/window_sample_empty.dds")
  end
end
function check_Adrenallin_PostEvent(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  FromClient_ChangeAdrenalinMode()
end
registerEvent("FromClient_RenderModeChangeState", "check_Adrenallin_PostEvent")
function Panel_Adrenallin_OnSreenResize()
  if CppDefine.ChangeUIAndResolution == true then
    if Panel_Adrenallin:GetRelativePosX() == -1 and Panel_Adrenallin:GetRelativePosY() == -1 then
      local initPosX = getScreenSizeX() / 2 - Panel_Adrenallin:GetSizeX() / 2 + 225
      local initPosY = getScreenSizeY() - Panel_QuickSlot:GetSizeY() - 76
      Panel_Adrenallin:SetPosX(initPosX)
      Panel_Adrenallin:SetPosY(initPosY)
      changePositionBySever(Panel_Adrenallin, CppEnums.PAGameUIType.PAGameUIPanel_Adrenallin, false, true, false)
      FGlobal_InitPanelRelativePos(Panel_Adrenallin, initPosX, initPosY)
    elseif Panel_Adrenallin:GetRelativePosX() == 0 and Panel_Adrenallin:GetRelativePosY() == 0 then
      Panel_Adrenallin:SetPosX(getScreenSizeX() / 2 - Panel_Adrenallin:GetSizeX() / 2 + 225)
      Panel_Adrenallin:SetPosY(getScreenSizeY() - Panel_QuickSlot:GetSizeY() - 76)
    else
      Panel_Adrenallin:SetPosX(getScreenSizeX() * Panel_Adrenallin:GetRelativePosX() - Panel_Adrenallin:GetSizeX() / 2)
      Panel_Adrenallin:SetPosY(getScreenSizeY() * Panel_Adrenallin:GetRelativePosY() - Panel_Adrenallin:GetSizeY() / 2)
    end
  else
    Panel_Adrenallin:SetPosX(getScreenSizeX() / 2 - Panel_Adrenallin:GetSizeX() / 2 + 225)
    Panel_Adrenallin:SetPosY(getScreenSizeY() - Panel_QuickSlot:GetSizeY() - 76)
    changePositionBySever(Panel_Adrenallin, CppEnums.PAGameUIType.PAGameUIPanel_Adrenallin, false, true, false)
  end
  Panel_Adrenallin:SetShow(getSelfPlayer():isEnableAdrenalin() and not isRecordMode)
  FGlobal_PanelRepostionbyScreenOut(Panel_Adrenallin)
end
FromClient_UpdateAdrenalin()
FromClient_ChangeAdrenalinMode()
Panel_Adrenallin:addInputEvent("Mouse_On", "Panel_Adrenallin_ChangeTexture_On()")
Panel_Adrenallin:addInputEvent("Mouse_Out", "Panel_Adrenallin_ChangeTexture_Off()")
_transLockButton:addInputEvent("Mouse_On", "Adrenallin_ShowSimpleToolTip( true )")
_transLockButton:addInputEvent("Mouse_Out", "Adrenallin_ShowSimpleToolTip( false ) ")
Panel_Adrenallin:setTooltipEventRegistFunc("Adrenallin_ShowSimpleToolTip( true )")
registerEvent("FromClient_UpdateAdrenalin", "FromClient_UpdateAdrenalin")
registerEvent("FromClient_ChangeAdrenalinMode", "FromClient_ChangeAdrenalinMode")
registerEvent("onScreenResize", "Panel_Adrenallin_OnSreenResize")
registerEvent("FromClient_RenderModeChangeState", "Panel_Adrenallin_OnSreenResize")
registerEvent("FromClient_UseableBlackSpritSkill", "UseableBlackSpritSkill")
function Panel_Adrenallin_InitShow()
  changePositionBySever(Panel_Adrenallin, CppEnums.PAGameUIType.PAGameUIPanel_Adrenallin, false, true, false)
  Panel_Adrenallin:SetShow(getSelfPlayer():isEnableAdrenalin() and not isRecordMode)
end
Panel_Adrenallin_InitShow()
