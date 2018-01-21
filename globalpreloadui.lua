local _voidCursor = UI.getChildControl(Panel_Cursor, "Static_Cursor")
Panel_Cursor:SetShow(true)
local mouseVisibleState = {
  [CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode] = false,
  [CppEnums.EProcessorInputMode.eProcessorInputMode_UiMode] = true,
  [CppEnums.EProcessorInputMode.eProcessorInputMode_ChattingInputMode] = true,
  [CppEnums.EProcessorInputMode.eProcessorInputMode_KeyCustomizing] = true,
  [CppEnums.EProcessorInputMode.eProcessorInputMode_UiModeNotInput] = true,
  [CppEnums.EProcessorInputMode.eProcessorInputMode_UiControlMode] = true,
  [CppEnums.EProcessorInputMode.eProcessorInputMode_Undefined] = false
}
local currentModeCache
local posX = -10000
local posY = -10000
function ProcessorInputModeChange(prevMode, currentMode)
  _voidCursor:SetPosX(getMousePosX())
  _voidCursor:SetPosY(getMousePosY())
  if nil == currentModeCache then
    currentModeCache = currentMode
    posX = getMousePosX()
    posY = getMousePosY()
  end
  local prevVisibleState = mouseVisibleState[prevMode]
  local currentVisibleState = mouseVisibleState[currentMode]
  if nil == currentVisibleState or prevVisibleState == currentVisibleState then
    return
  end
  if currentVisibleState then
    _voidCursor:AddEffect("UI_Mouse_Appear", false, 0, 0)
    _voidCursor:AddEffect("fUI_SkillButton03", false, 0, 0)
  else
    _voidCursor:AddEffect("UI_Mouse_Hide", false, 0, 0)
    _voidCursor:AddEffect("fUI_SkillButton01", false, 0, 0)
  end
  currentModeCache = currentVisibleState
  posX = getMousePosX()
  posY = getMousePosY()
end
function CursorUIEffect_UpdateCursorPos()
  if currentModeCache then
    _voidCursor:SetPosX(getMousePosX())
    _voidCursor:SetPosY(getMousePosY())
  else
    _voidCursor:SetPosX(posX)
    _voidCursor:SetPosY(posY)
  end
end
Panel_Cursor:RegisterUpdateFunc("CursorUIEffect_UpdateCursorPos")
registerEvent("EventProcessorInputModeChange", "ProcessorInputModeChange")
