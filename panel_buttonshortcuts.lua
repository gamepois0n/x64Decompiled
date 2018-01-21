Panel_ButtonShortcuts:SetShow(false)
PaGlobal_ButtonShortcuts = {
  _ui = {
    _curButtonString,
    _curChangeeShortcutsKey,
    _curButtonBg = UI.getChildControl(Panel_ButtonShortcuts, "Static_Current_Key_BG"),
    _list2 = UI.getChildControl(Panel_ButtonShortcuts, "List2_KeySetting_BG"),
    _checkButtonAllVeiw = UI.getChildControl(Panel_ButtonShortcuts, "CheckButton_AllView"),
    _editSearchText = UI.getChildControl(Panel_ButtonShortcuts, "Edit_SearchOption")
  },
  _curId = -1,
  _curButtonsShortcuts = nil,
  _altString = "Alt + ",
  _searchText = ""
}
function addButtonShortcutsEvent(func, keyCode)
  local buttonShortcuts = ButtonShortcuts(keyCode)
  ToClent_addButtonShortcutsEvent(buttonShortcuts)
end
function PaGlobal_ButtonShortcuts:Open(index)
  Panel_ButtonShortcuts:SetShow(true)
  self:ListRefresh()
end
function PaGlobal_ButtonShortcuts:ListRefresh()
  self._ui._list2:getElementManager():clearKey()
  local count = ToClent_getButtonShortcutsEventCount()
  for index = 0, count - 1 do
    local isShow = true
    local data = ToClent_getButtonShortcutsEventAt(index)
    if "" ~= self._searchText and nil == string.find(data:getButtonString(), self._searchText) then
      isShow = false
    end
    if false == self._ui._checkButtonAllVeiw:IsCheck() and 0 == data:getKeyCode() then
      isShow = false
    end
    if true == isShow then
      self._ui._list2:getElementManager():pushKey(toInt64(0, index))
    end
  end
end
function PaGlobal_ButtonShortcuts:ClickedChangeShortcuts()
  SetUIMode(Defines.UIMode.eUIMode_KeyCustom_ButtonShortcuts)
  self._ui._curChangeeShortcutsKey:SetCheck(true)
  self._ui._curChangeeShortcutsKey:SetText("")
end
function PaGlobal_ButtonShortcuts:ClickedListElementChangeShortcuts(id)
  self._curId = id
  self._curButtonsShortcuts = ToClent_getButtonShortcutsEventAt(id)
  SetUIMode(Defines.UIMode.eUIMode_KeyCustom_ButtonShortcuts)
  self._ui._list2:requestUpdateByKey(toInt64(0, self._curId))
end
function PaGlobal_ButtonShortcuts:Remove()
  self._curId = -1
  ToClent_removeAtButtonShortcutsEvent(self._curButtonsShortcuts)
  self:ListRefresh()
end
function PaGlobal_ButtonShortcuts:Register(VirtualKeyCode)
  if true == self:IsExhibitKey(VirtualKeyCode) then
    return
  end
  local id = self._curId
  self._curId = -1
  ToClent_addButtonShortcutsEvent(self._curButtonsShortcuts, VirtualKeyCode)
  self:ListRefresh()
end
function PaGlobal_ButtonShortcuts:Close()
  Panel_ButtonShortcuts:SetShow(false)
end
function FGlobal_ButtonShortcurs_List2EventControlCreate(list_content, key)
  local id = Int64toInt32(key)
  local buttonShortcuts = ToClent_getButtonShortcutsEventAt(id)
  local buttonName = UI.getChildControl(list_content, "StaticText_ListKeySetting_Name")
  local shortcuts = UI.getChildControl(list_content, "Button_ListKeySetting")
  local isShow = true
  buttonName:SetShow(true)
  shortcuts:SetShow(true)
  buttonName:SetText(buttonShortcuts:getButtonString())
  shortcuts:SetText(PaGlobal_ButtonShortcuts:GetText(buttonShortcuts:getKeyCode()))
  _PA_LOG("\237\155\132\236\167\132", "buttonShortcuts:getKeyCode() : " .. buttonShortcuts:getKeyCode())
  if nil ~= PaGlobal_ButtonShortcuts._curId and id == PaGlobal_ButtonShortcuts._curId then
    shortcuts:SetText("")
  end
  shortcuts:SetCheck(id == PaGlobal_ButtonShortcuts._curId)
  shortcuts:addInputEvent("Mouse_LUp", "PaGlobal_ButtonShortcuts:ClickedListElementChangeShortcuts(" .. id .. ")")
end
function PaGlobal_ButtonShortcuts:ToggleAllVeiw()
  self._searchText = ""
  self:ListRefresh()
  ClearFocusEdit()
end
function PaGlobal_ButtonShortcuts:ClickedSearch()
  self._searchText = self._ui._editSearchText:GetEditText()
  self:ListRefresh()
  self._ui._editSearchText:SetEditText("")
  self._searchText = ""
  ClearFocusEdit()
end
function FromClient_InitButtonShortcuts()
  PaGlobal_ButtonShortcuts._altString = "Alt + "
  PaGlobal_ButtonShortcuts._ui._checkButtonAllVeiw:addInputEvent("Mouse_LUp", "PaGlobal_ButtonShortcuts:ToggleAllVeiw()")
  PaGlobal_ButtonShortcuts._ui._checkButtonAllVeiw:SetCheck(true)
  PaGlobal_ButtonShortcuts._ui._list2:registEvent(CppEnums.PAUIList2EventType.luaChangeContent, "FGlobal_ButtonShortcurs_List2EventControlCreate")
  PaGlobal_ButtonShortcuts._ui._list2:createChildContent(CppEnums.PAUIList2ElementManagerType.list)
  UI.getChildControl(Panel_ButtonShortcuts, "Button_Close"):addInputEvent("Mouse_LUp", "PaGlobal_ButtonShortcuts:Close()")
  UI.getChildControl(PaGlobal_ButtonShortcuts._ui._editSearchText, "Button_SearchIcon"):addInputEvent("Mouse_LUp", "PaGlobal_ButtonShortcuts:ClickedSearch()")
end
function FromClient_ButtonShortcuts_luaLoadCompleteLateUdpate()
  if false then
    ToClent_updateButtonShortcutsGameVariable()
  end
end
function FromClient_OpenButtonShortcuts(index)
  if false then
    PaGlobal_ButtonShortcuts:Open(index)
  end
end
registerEvent("FromClient_luaLoadComplete", "FromClient_InitButtonShortcuts")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_ButtonShortcuts_luaLoadCompleteLateUdpate")
registerEvent("FromClient_OpenButtonShortcuts", "FromClient_OpenButtonShortcuts")
registerEvent("FromClient_OpenButtonShortcuts_WithElement", "FromClient_OpenButtonShortcuts_WithElement")
function PaGlobal_ButtonShortcuts:GetText(keyCode)
  if 0 == keyCode then
    return ""
  else
    return self._altString .. self.keyString[keyCode]
  end
end
function PaGlobal_ButtonShortcuts:IsExhibitKey(keyCode)
  if CppEnums.VirtualKeyCode.KeyCode_SHIFT == keyCode or CppEnums.VirtualKeyCode.KeyCode_TAB == keyCode or CppEnums.VirtualKeyCode.KeyCode_BACK == keyCode or CppEnums.VirtualKeyCode.KeyCode_CAPITAL == keyCode or CppEnums.VirtualKeyCode.KeyCode_CONTROL == keyCode or CppEnums.VirtualKeyCode.KeyCode_SPACE == keyCode or CppEnums.VirtualKeyCode.KeyCode_OEM_7 == keyCode or CppEnums.VirtualKeyCode.KeyCode_OEM_2 == keyCode or CppEnums.VirtualKeyCode.KeyCode_OEM_3 == keyCode then
    return true
  end
  return false
end
PaGlobal_ButtonShortcuts.keyString = {
  [CppEnums.VirtualKeyCode.KeyCode_ESCAPE] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Esc"),
  [CppEnums.VirtualKeyCode.KeyCode_F1] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F1"),
  [CppEnums.VirtualKeyCode.KeyCode_F2] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F2"),
  [CppEnums.VirtualKeyCode.KeyCode_F3] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F3"),
  [CppEnums.VirtualKeyCode.KeyCode_F4] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F4"),
  [CppEnums.VirtualKeyCode.KeyCode_F5] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F5"),
  [CppEnums.VirtualKeyCode.KeyCode_F6] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F6"),
  [CppEnums.VirtualKeyCode.KeyCode_F7] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F7"),
  [CppEnums.VirtualKeyCode.KeyCode_F8] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F8"),
  [CppEnums.VirtualKeyCode.KeyCode_F9] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F9"),
  [CppEnums.VirtualKeyCode.KeyCode_F10] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F10"),
  [CppEnums.VirtualKeyCode.KeyCode_F11] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F11"),
  [CppEnums.VirtualKeyCode.KeyCode_F12] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F12"),
  [CppEnums.VirtualKeyCode.KeyCode_OEM_3] = "OEM_3",
  [CppEnums.VirtualKeyCode.KeyCode_1] = "1",
  [CppEnums.VirtualKeyCode.KeyCode_2] = "2",
  [CppEnums.VirtualKeyCode.KeyCode_3] = "3",
  [CppEnums.VirtualKeyCode.KeyCode_4] = "4",
  [CppEnums.VirtualKeyCode.KeyCode_5] = "5",
  [CppEnums.VirtualKeyCode.KeyCode_6] = "6",
  [CppEnums.VirtualKeyCode.KeyCode_7] = "7",
  [CppEnums.VirtualKeyCode.KeyCode_8] = "8",
  [CppEnums.VirtualKeyCode.KeyCode_9] = "9",
  [CppEnums.VirtualKeyCode.KeyCode_0] = "0",
  [CppEnums.VirtualKeyCode.KeyCode_SUBTRACT] = "SUBTRACT",
  [CppEnums.VirtualKeyCode.KeyCode_ADD] = "ADD",
  [CppEnums.VirtualKeyCode.KeyCode_BACK] = "BACK",
  [CppEnums.VirtualKeyCode.KeyCode_TAB] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Tab"),
  [CppEnums.VirtualKeyCode.KeyCode_Q] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Q"),
  [CppEnums.VirtualKeyCode.KeyCode_W] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_W"),
  [CppEnums.VirtualKeyCode.KeyCode_E] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_E"),
  [CppEnums.VirtualKeyCode.KeyCode_R] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_R"),
  [CppEnums.VirtualKeyCode.KeyCode_T] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_T"),
  [CppEnums.VirtualKeyCode.KeyCode_Y] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Y"),
  [CppEnums.VirtualKeyCode.KeyCode_U] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_U"),
  [CppEnums.VirtualKeyCode.KeyCode_I] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_I"),
  [CppEnums.VirtualKeyCode.KeyCode_O] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_O"),
  [CppEnums.VirtualKeyCode.KeyCode_P] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_P"),
  [CppEnums.VirtualKeyCode.KeyCode_CAPITAL] = "CAPITAL",
  [CppEnums.VirtualKeyCode.KeyCode_A] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_A"),
  [CppEnums.VirtualKeyCode.KeyCode_S] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_S"),
  [CppEnums.VirtualKeyCode.KeyCode_D] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_D"),
  [CppEnums.VirtualKeyCode.KeyCode_F] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_F"),
  [CppEnums.VirtualKeyCode.KeyCode_G] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_G"),
  [CppEnums.VirtualKeyCode.KeyCode_H] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_H"),
  [CppEnums.VirtualKeyCode.KeyCode_J] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_J"),
  [CppEnums.VirtualKeyCode.KeyCode_K] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_K"),
  [CppEnums.VirtualKeyCode.KeyCode_L] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_L"),
  [CppEnums.VirtualKeyCode.KeyCode_OEM_7] = "'",
  [CppEnums.VirtualKeyCode.KeyCode_RETURN] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Enter"),
  [CppEnums.VirtualKeyCode.KeyCode_SHIFT] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Shift"),
  [CppEnums.VirtualKeyCode.KeyCode_Z] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Z"),
  [CppEnums.VirtualKeyCode.KeyCode_X] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_X"),
  [CppEnums.VirtualKeyCode.KeyCode_C] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_C"),
  [CppEnums.VirtualKeyCode.KeyCode_V] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_V"),
  [CppEnums.VirtualKeyCode.KeyCode_B] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_B"),
  [CppEnums.VirtualKeyCode.KeyCode_N] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_N"),
  [CppEnums.VirtualKeyCode.KeyCode_M] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_M"),
  [CppEnums.VirtualKeyCode.KeyCode_OEM_2] = "/",
  [CppEnums.VirtualKeyCode.KeyCode_SHIFT] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Shift"),
  [CppEnums.VirtualKeyCode.KeyCode_CONTROL] = "CONTROL",
  [CppEnums.VirtualKeyCode.KeyCode_MENU] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Alt"),
  [CppEnums.VirtualKeyCode.KeyCode_SPACE] = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Space")
}
