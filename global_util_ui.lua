if nil == UI then
  UI = {}
end
local defaultRenderMode = PAUIRenderModeBitSet({
  Defines.RenderMode.eRenderMode_Default
})
function UI.createPanel(strID, groupID)
  tempUIBaseForLua = nil
  createPanel(strID, groupID, defaultRenderMode)
  return tempUIBaseForLua
end
function UI.createPanelAndSetPanelRenderMode(strID, groupID, renderModeBitSet)
  tempUIBaseForLua = nil
  createPanel(strID, groupID, renderModeBitSet)
  return tempUIBaseForLua
end
function UI.createControl(uiType, parent, strID)
  tempUIBaseForLua = nil
  createControl(uiType, parent, strID)
  return tempUIBaseForLua
end
function UI.createAndCopyBasePropertyControl(fromParent, fromStrID, parent, strID)
  local fromControl = UI.getChildControl(fromParent, fromStrID)
  if nil == fromControl then
    UI.ASSERT(nil ~= fromControl and "number" ~= type(fromControl), fromStrID)
    return nil
  end
  fromControl:SetShow(false)
  tempUIBaseForLua = nil
  createControl(fromControl:GetType(), parent, strID)
  if nil == tempUIBaseForLua then
    UI.ASSERT(nil ~= tempUIBaseForLua and "number" ~= type(tempUIBaseForLua), strID)
    return nil
  end
  CopyBaseProperty(fromControl, tempUIBaseForLua)
  tempUIBaseForLua:SetShow(true)
  return tempUIBaseForLua
end
function UI.cloneControl(controlToClone, parent, strID)
  if nil == controlToClone then
    UI.ASSERT(false, "clone\237\149\152\235\160\164\235\138\148 rootUI\234\176\128 nil\236\158\133\235\139\136\235\139\164")
    return nil
  end
  tempUIBaseForLua = nil
  cloneControl(controlToClone, parent, strID)
  if nil == tempUIBaseForLua then
    UI.ASSERT(false, "Control\236\157\132 \235\179\181\236\160\156\234\176\128 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.")
  end
  return tempUIBaseForLua
end
function UI.createCustomControl(typeStr, parent, strID)
  tempUIBaseForLua = nil
  createCustomControl(typeStr, parent, strID)
  return tempUIBaseForLua
end
function UI.deleteControl(conrol)
  deleteControl(conrol)
end
function UI.getChildControl(parent, strID)
  tempUIBaseForLua = nil
  parent:getChildControl(strID)
  if nil == tempUIBaseForLua then
    UI.ASSERT(nil ~= tempUIBaseForLua and "number" ~= type(tempUIBaseForLua), strID)
    return nil
  end
  return tempUIBaseForLua
end
function UI.getChildControlByIndex(parent, index)
  tempUIBaseForLua = nil
  parent:getChildControlByIndex(index)
  return tempUIBaseForLua
end
function UI.deletePanel(strID)
  deletePanel(strID, groupID)
end
function UI.createOtherPanel(strID, groupID)
  tempUIBaseForLua = nil
  createOtherPanel(strID, groupID)
  return tempUIBaseForLua
end
function UI.deleteOtherPanel(strID)
  deleteOtherPanel(strID)
end
function UI.deleteOtherControl(panel, control)
  deleteOtherControl(panel, control)
end
function UI.isFlushedUI()
  return isFlushedUI()
end
function UI.ASSERT(test, message)
  message = message or tostring(test)
  if "string" ~= type(message) then
    message = tostring(message)
  end
  test = nil ~= test and false ~= test and 0 ~= test
  _PA_ASSERT(test, message)
end
function UI.Set_ProcessorInputMode(UIModeType)
end
function UI.ClearFocusEdit()
  ClearFocusEdit()
  CheckChattingInput()
end
function UI.isGameOptionMouseMode()
  return true == getOptionMouseMode()
end
function UI.Get_ProcessorInputMode()
  return getInputMode()
end
function setTextureUV_Func(control, pixX, pixY, pixEndX, pixEndY)
  local sizeX = control:getTextureWidth()
  local sizeY = control:getTextureHeight()
  if sizeX == 0 and sizeY == 0 then
    return 0, 0, 0, 0
  end
  return pixX / sizeX, pixY / sizeY, pixEndX / sizeX, pixEndY / sizeY
end
function UI.getFocusEdit()
  return GetFocusEdit()
end
function UI.isInPositionForLua(control, posX, posY)
  return isInPostion(control, posX, posY)
end
function UI.checkShowWindow()
  return check_ShowWindow()
end
function UI.checkIsInMouse(panel)
  local IsMouseOver = panel:GetPosX() < getMousePosX() and getMousePosX() < panel:GetPosX() + panel:GetSizeX() and panel:GetPosY() < getMousePosY() and getMousePosY() < panel:GetPosY() + panel:GetSizeY() and CppEnums.EProcessorInputMode.eProcessorInputMode_UiMode == UI.Get_ProcessorInputMode()
  return IsMouseOver and false == isCharacterCameraRotateMode()
end
function UI.checkIsInMouseAndEventPanel(panel)
  local isOverEvent = UI.checkIsInMouse(panel)
  local eventControl = getEventControl()
  if nil ~= eventControl then
    local parentPanel = eventControl:GetParentPanel()
    return parentPanel:GetKey() == panel:GetKey() and isOverEvent
  end
  return isOverEvent
end
