local CONTROL = CppEnums.PA_UI_CONTROL_TYPE
function PaGlobal_Option:SpectialControlComboBoxInitValue()
  local option
  option = self._elements.ScreenResolution
  option._comboBoxList = {}
  option._comboBoxListCount = self._availableResolutionList:getDisplayModeListSize()
  for ii = 0, option._comboBoxListCount - 1 do
    option._comboBoxList[ii] = tostring(self._availableResolutionList:getDisplayModeWidth(ii)) .. "x" .. tostring(self._availableResolutionList:getDisplayModeHeight(ii))
  end
end
function PaGlobal_Option:radioButtonMapping_TextureQuality(value, fromRadioButtonToCppEnum)
  local radioMap = {
    [0] = 2,
    [1] = 1,
    [2] = 0
  }
  return PaGlobal_Option:RadioButtonMapping(radioMap, value, fromRadioButtonToCppEnum)
end
function PaGlobal_Option:radioButtonMapping_GraphicOption(value, fromRadioButtonToCppEnum)
  local radioMap = {
    [0] = 5,
    [1] = 4,
    [2] = 3,
    [3] = 2,
    [4] = 1,
    [5] = 0,
    [6] = 6
  }
  return PaGlobal_Option:RadioButtonMapping(radioMap, value, fromRadioButtonToCppEnum)
end
function PaGlobal_Option:radioButtonMapping_AudioResourceType(value, fromRadioButtonToCppEnum)
  local radioMap = {}
  if isGameTypeKorea() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_KR,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_JP,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif isGameTypeJapan() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_JP,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_KR,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif isGameTypeRussia() then
  elseif isGameTypeEnglish() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_JP,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_KR
    }
  elseif isGameTypeTaiwan() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_TW,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_JP,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_KR
    }
  elseif isGameTypeTR() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_TR
    }
  elseif isGameTypeID() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif isGameTypeTH() then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  end
  local val = PaGlobal_Option:RadioButtonMapping(radioMap, value, fromRadioButtonToCppEnum)
  if -1 == val then
    return 0
  end
  return val
end
function PaGlobal_Option:radioButtonMapping_ServiceResourceType(value, fromRadioButtonToCppEnum)
  local radioMap = {
    [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN,
    [1] = CppEnums.ServiceResourceType.eServiceResourceType_FR,
    [2] = CppEnums.ServiceResourceType.eServiceResourceType_ID
  }
  local resourceType = getGameServiceType()
  if CppEnums.GameServiceType.eGameServiceType_DEV == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_FR,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_ID
    }
  elseif CppEnums.GameServiceType.eGameServiceType_NA_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_FR,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_DE
    }
  elseif CppEnums.GameServiceType.eGameServiceType_NA_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_EN,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_FR,
      [2] = CppEnums.ServiceResourceType.eServiceResourceType_DE
    }
  elseif CppEnums.GameServiceType.eGameServiceType_SA_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_PT,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_ES
    }
  elseif CppEnums.GameServiceType.eGameServiceType_SA_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_PT,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_ES
    }
  elseif CppEnums.GameServiceType.eGameServiceType_ID_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_ID,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif CppEnums.GameServiceType.eGameServiceType_ID_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_ID,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif CppEnums.GameServiceType.eGameServiceType_TR_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_TR,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  elseif CppEnums.GameServiceType.eGameServiceType_TR_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.ServiceResourceType.eServiceResourceType_TR,
      [1] = CppEnums.ServiceResourceType.eServiceResourceType_EN
    }
  end
  return PaGlobal_Option:RadioButtonMapping(radioMap, value, fromRadioButtonToCppEnum)
end
function PaGlobal_Option:radioButtonMapping_ChatChannelType(value, fromRadioButtonToCppEnum)
  local radioMap = {
    [0] = CppEnums.LangType.LangType_International,
    [1] = CppEnums.LangType.LangType_English,
    [2] = CppEnums.LangType.LangType_French,
    [3] = CppEnums.LangType.LangType_ID
  }
  local resourceType = getGameServiceType()
  if CppEnums.GameServiceType.eGameServiceType_DEV == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_English,
      [2] = CppEnums.LangType.LangType_French,
      [3] = CppEnums.LangType.LangType_ID
    }
  elseif CppEnums.GameServiceType.eGameServiceType_NA_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_English,
      [2] = CppEnums.LangType.LangType_French,
      [3] = CppEnums.LangType.LangType_German
    }
  elseif CppEnums.GameServiceType.eGameServiceType_NA_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_English,
      [2] = CppEnums.LangType.LangType_French,
      [3] = CppEnums.LangType.LangType_German
    }
  elseif CppEnums.GameServiceType.eGameServiceType_SA_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_Pt,
      [2] = CppEnums.LangType.LangType_Es
    }
  elseif CppEnums.GameServiceType.eGameServiceType_SA_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_Pt,
      [2] = CppEnums.LangType.LangType_Es
    }
  elseif CppEnums.GameServiceType.eGameServiceType_ID_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_English,
      [2] = CppEnums.LangType.LangType_ID
    }
  elseif CppEnums.GameServiceType.eGameServiceType_ID_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_English,
      [2] = CppEnums.LangType.LangType_ID
    }
  elseif CppEnums.GameServiceType.eGameServiceType_TR_ALPHA == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_TR,
      [2] = CppEnums.LangType.LangType_English
    }
  elseif CppEnums.GameServiceType.eGameServiceType_TR_REAL == resourceType then
    radioMap = {
      [0] = CppEnums.LangType.LangType_International,
      [1] = CppEnums.LangType.LangType_TR,
      [2] = CppEnums.LangType.LangType_English
    }
  end
  return PaGlobal_Option:RadioButtonMapping(radioMap, value, fromRadioButtonToCppEnum)
end
local isOnServiceResourceTypeTag = {
  [CppEnums.ServiceResourceType.eServiceResourceType_Dev] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_DEV"),
  [CppEnums.ServiceResourceType.eServiceResourceType_KR] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_KR"),
  [CppEnums.ServiceResourceType.eServiceResourceType_EN] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_EN"),
  [CppEnums.ServiceResourceType.eServiceResourceType_JP] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_JP"),
  [CppEnums.ServiceResourceType.eServiceResourceType_CN] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_CN"),
  [CppEnums.ServiceResourceType.eServiceResourceType_RU] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_RU"),
  [CppEnums.ServiceResourceType.eServiceResourceType_FR] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_FR"),
  [CppEnums.ServiceResourceType.eServiceResourceType_DE] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_DE"),
  [CppEnums.ServiceResourceType.eServiceResourceType_ES] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_ES"),
  [CppEnums.ServiceResourceType.eServiceResourceType_TW] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_TW"),
  [CppEnums.ServiceResourceType.eServiceResourceType_PT] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_PT"),
  [CppEnums.ServiceResourceType.eServiceResourceType_TH] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_OPTION_TEXT_TH"),
  [CppEnums.ServiceResourceType.eServiceResourceType_ID] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_OPTION_TEXT_ID"),
  [CppEnums.ServiceResourceType.eServiceResourceType_TR] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_OPTION_TEXT_TR")
}
local isOnServiceChatTypeTag = {
  [CppEnums.LangType.LangType_Dev] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_DEV"),
  [CppEnums.LangType.LangType_International] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_OPTION_TEXT_INTERNATIONAL"),
  [CppEnums.LangType.LangType_English] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_EN"),
  [CppEnums.LangType.LangType_Jp] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_JP"),
  [CppEnums.LangType.LangType_Cn] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_CN"),
  [CppEnums.LangType.LangType_Ru] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_RU"),
  [CppEnums.LangType.LangType_French] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_FR"),
  [CppEnums.LangType.LangType_German] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_DE"),
  [CppEnums.LangType.LangType_Es] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_ES"),
  [CppEnums.LangType.LangType_Tw] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_TW"),
  [CppEnums.LangType.LangType_Pt] = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TEXT_PT"),
  [CppEnums.LangType.LangType_TH] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_OPTION_TEXT_TH"),
  [CppEnums.LangType.LangType_ID] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_OPTION_TEXT_ID"),
  [CppEnums.LangType.LangType_TR] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_OPTION_TEXT_TR")
}
function PaGlobal_Option:RadioButtonMapping(table, value, fromRadioButtonToCppEnum)
  if nil == fromRadioButtonToCppEnum or false == fromRadioButtonToCppEnum then
    return table[value]
  end
  for i, v in pairs(table) do
    if v == value then
      return i
    end
  end
  return -1
end
function PaGlobal_Option:GetEventTypeText(controlTypeEnum)
  local eventType
  if CONTROL.PA_UI_CONTROL_SLIDER == controlTypeEnum then
    eventType = "Mouse_LPress"
  elseif CONTROL.PA_UI_CONTROL_COMBOBOX == controlTypeEnum then
    eventType = "Mouse_LUp"
  elseif CONTROL.PA_UI_CONTROL_CHECKBUTTON == controlTypeEnum then
    eventType = "Mouse_LUp"
  elseif CONTROL.PA_UI_CONTROL_RADIOBUTTON == controlTypeEnum then
    eventType = "Mouse_LUp"
  else
    if CONTROL.PA_UI_CONTROL_BUTTON == controlTypeEnum then
      eventType = "Mouse_LUp"
    else
    end
  end
  return eventType
end
function PaGlobal_Option:GetControlTypeByControlName(controlName)
  local controlTypeEnum
  if "CheckButton" == controlName then
    controlTypeEnum = CONTROL.PA_UI_CONTROL_CHECKBUTTON
  elseif "RadioButton" == controlName then
    controlTypeEnum = CONTROL.PA_UI_CONTROL_RADIOBUTTON
  elseif "Slider" == controlName then
    controlTypeEnum = CONTROL.PA_UI_CONTROL_SLIDER
  elseif "ComboBox" == controlName then
    controlTypeEnum = CONTROL.PA_UI_CONTROL_COMBOBOX
  elseif "Button" == controlName then
    controlTypeEnum = CONTROL.PA_UI_CONTROL_BUTTON
  else
    controlTypeEnum = nil
  end
  return controlTypeEnum
end
function PaGlobal_Option:FromSliderValueToRealValue(value, min, max)
  function clamp(value, lower, upper)
    if upper < lower then
      lower, upper = upper, lower
    end
    return math.max(lower, math.min(upper, value))
  end
  value = clamp(value, 0, 1)
  local offset = max - min
  value = value * offset
  value = value + min
  return value
end
function PaGlobal_Option:FromRealValueToSliderValue(value, lower, upper)
  local offset = upper - lower
  value = value - lower
  value = value / offset
  return value
end
function PaGlobal_Option:SpecialCreateRadioButton(elementName)
  if "ServiceResourceType" == elementName then
    local count
    local tempCount = 10
    local controlCount = 6
    for ii = 0, tempCount do
      if nil == self:radioButtonMapping_ServiceResourceType(ii) then
        count = ii
        break
      end
    end
    for i, eventControl in pairs(self._elements[elementName]._eventControl) do
      eventControl:SetText(isOnServiceResourceTypeTag[self:radioButtonMapping_ServiceResourceType(0)])
    end
    for ii = 1, controlCount do
      if nil == self._elements[elementName]["_eventControl" .. ii] then
        break
      end
      for i, eventControl in pairs(self._elements[elementName]["_eventControl" .. ii]) do
        if ii < count then
          eventControl:SetShow(true)
          eventControl:SetText(isOnServiceResourceTypeTag[self:radioButtonMapping_ServiceResourceType(ii)])
        else
          eventControl:SetShow(false)
        end
      end
    end
  end
  if "ChatChannelType" == elementName then
    local count
    local tempCount = 10
    local controlCount = 6
    for ii = 0, tempCount do
      if nil == self:radioButtonMapping_ChatChannelType(ii) then
        count = ii
        break
      end
    end
    for i, eventControl in pairs(self._elements[elementName]._eventControl) do
      eventControl:SetText(isOnServiceChatTypeTag[self:radioButtonMapping_ChatChannelType(0)])
    end
    for ii = 1, controlCount do
      if nil == self._elements[elementName]["_eventControl" .. ii] then
        break
      end
      for i, eventControl in pairs(self._elements[elementName]["_eventControl" .. ii]) do
        if ii < count then
          eventControl:SetShow(true)
          eventControl:SetText(isOnServiceChatTypeTag[self:radioButtonMapping_ChatChannelType(ii)])
        else
          eventControl:SetShow(false)
        end
      end
    end
  end
  if "AudioResourceType" == elementName then
    local controlCount = 3
    for index, eventControl in pairs(self._elements[elementName]._eventControl) do
      if nil == self._elements[elementName]._eventControl and nil == self._elements[elementName]._eventControl[index] then
        return
      elseif nil == self._elements[elementName]._eventControl1 and nil == self._elements[elementName]._eventControl1[index] then
        return
      elseif nil == self._elements[elementName]._eventControl2 and nil == self._elements[elementName]._eventControl2[index] then
        return
      end
    end
    if isGameTypeKorea() then
      for index, eventControl in pairs(self._elements[elementName]._eventControl) do
        self._elements[elementName]._eventControl[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_KOREAN"))
        self._elements[elementName]._eventControl1[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_JAPANESE"))
        self._elements[elementName]._eventControl2[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_ENGLISH"))
      end
    elseif isGameTypeJapan() then
      for index, eventControl in pairs(self._elements[elementName]._eventControl) do
        self._elements[elementName]._eventControl[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_JAPANESE"))
        self._elements[elementName]._eventControl1[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_KOREAN"))
        self._elements[elementName]._eventControl2[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_ENGLISH"))
      end
    elseif isGameTypeRussia() then
    elseif isGameTypeEnglish() then
      for index, eventControl in pairs(self._elements[elementName]._eventControl) do
        self._elements[elementName]._eventControl[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_ENGLISH"))
        self._elements[elementName]._eventControl1[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_JAPANESE"))
        self._elements[elementName]._eventControl2[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_KOREAN"))
      end
    elseif isGameTypeTaiwan() then
      for index, eventControl in pairs(self._elements[elementName]._eventControl) do
        self._elements[elementName]._eventControl[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_ENGLISH"))
        self._elements[elementName]._eventControl1[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_JAPANESE"))
        self._elements[elementName]._eventControl2[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_KOREAN"))
      end
    elseif isGameTypeTR() then
      for index, eventControl in pairs(self._elements[elementName]._eventControl) do
        self._elements[elementName]._eventControl[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_ENGLISH"))
        self._elements[elementName]._eventControl1[index]:SetShow(false)
        self._elements[elementName]._eventControl2[index]:SetShow(false)
      end
    elseif isGameTypeID() then
      for index, eventControl in pairs(self._elements[elementName]._eventControl) do
        self._elements[elementName]._eventControl[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_ENGLISH"))
        self._elements[elementName]._eventControl1[index]:SetShow(false)
        self._elements[elementName]._eventControl2[index]:SetShow(false)
      end
    elseif isGameTypeTH() then
      for index, eventControl in pairs(self._elements[elementName]._eventControl) do
        self._elements[elementName]._eventControl[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_ENGLISH"))
        self._elements[elementName]._eventControl1[index]:SetShow(false)
        self._elements[elementName]._eventControl2[index]:SetShow(false)
      end
    else
      _PA_LOG("LUA", "\234\188\173 \234\181\173\234\176\128 \235\166\172\236\134\140\236\138\164\234\176\128 \236\182\148\234\176\128\235\144\152\235\169\180 \236\157\180 \234\179\179\235\143\132 \236\136\152\236\160\149 \237\140\144\235\139\168 \237\149\180\236\163\188\236\150\180\236\149\188\237\149\169\235\139\136\235\139\164.")
    end
  end
end
function PaGlobal_Option:SetUltra(value)
  local graphicOption = self._elements.GraphicOption
  if true == value then
    self:SetGraphicOption(self.GRAPHIC.VeryVeryHigh, true)
    graphicOption._beforeValue = graphicOption._initValue
    if nil ~= graphicOption._applyValue then
      graphicOption._beforeValue = graphicOption._applyValue
    end
    if nil ~= graphicOption._curValue then
      graphicOption._beforeValue = graphicOption._curValue
    end
    graphicOption._curValue = self.GRAPHIC.VeryVeryHigh
  else
    if nil == graphicOption._beforeValue then
      return
    end
    graphicOption._curValue = graphicOption._beforeValue
    self:SetGraphicOption(graphicOption._curValue, false)
  end
  self:ResetControlSettingTable(graphicOption)
  self:SetControlSettingTable(graphicOption, graphicOption._curValue)
end
function PaGlobal_Option:SetGraphicOption(value, isIncrease)
  local _SSAO = self._elements.SSAO
  local _AntiAliasing = self._elements.AntiAliasing
  local _Dof = self._elements.Dof
  local _Tessellation = self._elements.Tessellation
  if self.GRAPHIC.VeryVeryLow == value then
    _SSAO._curValue = false
    _AntiAliasing._curValue = false
    _Dof._curValue = false
    _Tessellation._curValue = false
    for index, eventControl in pairs(_Tessellation._eventControl) do
      eventControl:SetMonoTone(true)
      eventControl:SetEnable(false)
    end
  elseif self.GRAPHIC.VeryLow == value then
    if true == isIncrease then
      _SSAO._curValue = true
      _AntiAliasing._curValue = true
    elseif false == isIncrease then
      _Dof._curValue = false
      _Tessellation._curValue = false
    end
    for index, eventControl in pairs(_Tessellation._eventControl) do
      eventControl:SetMonoTone(true)
      eventControl:SetEnable(false)
    end
  elseif self.GRAPHIC.Low == value then
    if true == isIncrease then
      _SSAO._curValue = true
      _AntiAliasing._curValue = true
    elseif false == isIncrease then
      _Dof._curValue = false
      _Tessellation._curValue = false
    end
    for index, eventControl in pairs(_Tessellation._eventControl) do
      eventControl:SetMonoTone(true)
      eventControl:SetEnable(false)
    end
  elseif self.GRAPHIC.Medium == value then
    if true == isIncrease then
      _SSAO._curValue = true
      _AntiAliasing._curValue = true
    elseif false == isIncrease then
      _Dof._curValue = false
      _Tessellation._curValue = false
    end
    for index, eventControl in pairs(_Tessellation._eventControl) do
      eventControl:SetMonoTone(true)
      eventControl:SetEnable(false)
    end
  elseif self.GRAPHIC.High == value then
    if true == isIncrease then
      _SSAO._curValue = true
      _AntiAliasing._curValue = true
      _Dof._curValue = true
      _Tessellation._curValue = false
    elseif false == isIncrease then
      _Tessellation._curValue = false
    end
    for index, eventControl in pairs(_Tessellation._eventControl) do
      eventControl:SetMonoTone(true)
      eventControl:SetEnable(false)
    end
  elseif self.GRAPHIC.VeryHigh == value then
    if true == isIncrease then
      _SSAO._curValue = true
      _AntiAliasing._curValue = true
      _Dof._curValue = true
    end
    for index, eventControl in pairs(_Tessellation._eventControl) do
      eventControl:SetMonoTone(false)
      eventControl:SetEnable(true)
    end
  elseif self.GRAPHIC.VeryVeryHigh == value then
    if true == isIncrease then
      _SSAO._curValue = true
      _AntiAliasing._curValue = true
      _Dof._curValue = true
    end
    for index, eventControl in pairs(_Tessellation._eventControl) do
      eventControl:SetMonoTone(false)
      eventControl:SetEnable(true)
    end
  end
  self:SetControlSettingTable(_SSAO, _SSAO._curValue)
  self:SetControlSettingTable(_AntiAliasing, _AntiAliasing._curValue)
  self:SetControlSettingTable(_Dof, _Dof._curValue)
  self:SetControlSettingTable(_Tessellation, _Tessellation._curValue)
end
function PaGlobal_Option:SetSpecSetting(value)
  local PETRENDER = {
    ALL = 0,
    ONLYME = 1,
    NONE = 2
  }
  local options = self._elements
  if self.SPEC.LowNormal == value then
    options.GraphicOption._curValue = self.GRAPHIC.VeryLow
    self:SetGraphicOption(options.GraphicOption._curValue, false)
    options.UseEffectFrameOptimization._curValue = true
    options.EffectFrameOptimization._curValue = 0.9
    options.UsePlayerEffectDistOptimization._curValue = true
    options.PlayerEffectDistOptimization._curValue = 0.9
    options.UseCharacterUpdateFrameOptimize._curValue = true
    options.UseOtherPlayerUpdate._curValue = true
    options.WorkerVisible._curValue = false
    options.PetRender._curValue = PETRENDER.NONE
  elseif self.SPEC.MidNormal == value then
    options.GraphicOption._curValue = self.GRAPHIC.Medium
    self:SetGraphicOption(options.GraphicOption._curValue, false)
    options.UseEffectFrameOptimization._curValue = true
    options.EffectFrameOptimization._curValue = 0.6
    options.UsePlayerEffectDistOptimization._curValue = true
    options.PlayerEffectDistOptimization._curValue = 0.6
    options.UseCharacterUpdateFrameOptimize._curValue = true
    options.UseOtherPlayerUpdate._curValue = true
    options.WorkerVisible._curValue = false
    options.PetRender._curValue = PETRENDER.NONE
  elseif self.SPEC.HighNormal == value then
    options.GraphicOption._curValue = self.GRAPHIC.VeryHigh
    self:SetGraphicOption(options.GraphicOption._curValue, true)
    options.UseEffectFrameOptimization._curValue = true
    options.EffectFrameOptimization._curValue = 0.3
    options.UsePlayerEffectDistOptimization._curValue = true
    options.PlayerEffectDistOptimization._curValue = 0.3
    options.UseCharacterUpdateFrameOptimize._curValue = true
    options.UseOtherPlayerUpdate._curValue = false
    options.WorkerVisible._curValue = false
    options.PetRender._curValue = PETRENDER.ONLYME
  elseif self.SPEC.HighestNormal == value then
    options.GraphicOption._curValue = self.GRAPHIC.VeryVeryHigh
    self:SetGraphicOption(options.GraphicOption._curValue, true)
    options.UseEffectFrameOptimization._curValue = false
    options.UsePlayerEffectDistOptimization._curValue = false
    options.UseCharacterUpdateFrameOptimize._curValue = false
    options.UseOtherPlayerUpdate._curValue = false
    options.WorkerVisible._curValue = true
    options.PetRender._curValue = PETRENDER.ALL
  elseif self.SPEC.LowSiege == value then
    options.GraphicOption._curValue = self.GRAPHIC.VeryLow
    self:SetGraphicOption(options.GraphicOption._curValue, false)
    options.UseEffectFrameOptimization._curValue = true
    options.EffectFrameOptimization._curValue = 1
    options.UsePlayerEffectDistOptimization._curValue = true
    options.PlayerEffectDistOptimization._curValue = 1
    options.UseCharacterUpdateFrameOptimize._curValue = true
    options.UseOtherPlayerUpdate._curValue = true
    options.WorkerVisible._curValue = false
    options.PetRender._curValue = PETRENDER.NONE
  elseif self.SPEC.MidSiege == value then
    options.GraphicOption._curValue = self.GRAPHIC.Medium
    self:SetGraphicOption(options.GraphicOption._curValue, false)
    options.UseEffectFrameOptimization._curValue = true
    options.EffectFrameOptimization._curValue = 0.75
    options.UsePlayerEffectDistOptimization._curValue = true
    options.PlayerEffectDistOptimization._curValue = 0.75
    options.UseCharacterUpdateFrameOptimize._curValue = true
    options.UseOtherPlayerUpdate._curValue = true
    options.WorkerVisible._curValue = false
    options.PetRender._curValue = PETRENDER.NONE
  elseif self.SPEC.HighSiege == value then
    options.GraphicOption._curValue = self.GRAPHIC.VeryHigh
    self:SetGraphicOption(options.GraphicOption._curValue, true)
    options.UseEffectFrameOptimization._curValue = true
    options.EffectFrameOptimization._curValue = 0.5
    options.UsePlayerEffectDistOptimization._curValue = true
    options.PlayerEffectDistOptimization._curValue = 0.5
    options.UseCharacterUpdateFrameOptimize._curValue = true
    options.UseOtherPlayerUpdate._curValue = true
    options.WorkerVisible._curValue = false
    options.PetRender._curValue = PETRENDER.ONLYME
  elseif self.SPEC.HighestSiege == value then
    options.GraphicOption._curValue = self.GRAPHIC.VeryVeryHigh
    self:SetGraphicOption(options.GraphicOption._curValue, true)
    options.UseEffectFrameOptimization._curValue = true
    options.EffectFrameOptimization._curValue = 0.3
    options.UsePlayerEffectDistOptimization._curValue = true
    options.PlayerEffectDistOptimization._curValue = 0.3
    options.UseCharacterUpdateFrameOptimize._curValue = true
    options.UseOtherPlayerUpdate._curValue = false
    options.WorkerVisible._curValue = false
    options.PetRender._curValue = PETRENDER.ONLYME
  end
  options.GraphicUltra._curValue = false
  self:ClickedConfirmOption()
  self:MoveUi(self.UIMODE.Main)
end
local InitSpectionOption_LUT = function()
  local parent = UI.getChildControl(PaGlobal_Option._frames.Graphic.Effect._uiFrameContent, "StaticText_BgOrder0_Import")
  UI.getChildControl(parent, "Button_LUTReset"):addInputEvent("Mouse_LUp", "PaGlobal_Option:SetRecommandationLUT()")
  UI.getChildControl(parent, "Button_LUTReset2"):addInputEvent("Mouse_LUp", "PaGlobal_Option:SetRecommandationLUT2()")
end
local LUTRecommandation = -1
local LUTRecommandation2 = -1
local LUTRecommandationName = "Vibrance"
local LUTRecommandationName2 = "NonContrast"
function PaGlobal_Option:SetRecommandationLUT()
  if LUTRecommandation == -1 then
    for idx = 0, 30 do
      if getCameraLUTFilterName(idx) == LUTRecommandationName then
        LUTRecommandation = idx
        LUTRecommandationName = nil
        break
      end
    end
  end
  local _contrastValue = 0.7
  if LUTRecommandation ~= -1 then
    self:SetXXX("LUT", LUTRecommandation)
    self:SetXXX("ContrastValue", _contrastValue)
  end
end
function PaGlobal_Option:SetRecommandationLUT2()
  if LUTRecommandation2 == -1 then
    for idx = 0, 30 do
      if getCameraLUTFilterName(idx) == LUTRecommandationName2 then
        LUTRecommandation2 = idx
        LUTRecommandationName2 = nil
        break
      end
    end
  end
  local _contrastValue = 0.5
  if LUTRecommandation2 ~= -1 then
    self:SetXXX("LUT", LUTRecommandation2)
    self:SetXXX("ContrastValue", _contrastValue)
  end
end
function PaGlobal_Option:SpectialOptionInit()
  InitSpectionOption_LUT()
  InitSpectionOption_LUT = nil
end
