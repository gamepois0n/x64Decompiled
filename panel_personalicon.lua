Panel_PersonalIcon:SetShow(false)
local personalIcon = {
  _btn_NpcNavi = UI.getChildControl(Panel_PersonalIcon, "Button_FindNavi"),
  _btn_NpcNaviTW = UI.getChildControl(Panel_PersonalIcon, "Button_FindNaviTW"),
  _btn_MovieGuide = UI.getChildControl(Panel_PersonalIcon, "Button_MovieTooltip"),
  _btn_VoiceChat = UI.getChildControl(Panel_PersonalIcon, "Button_SetState"),
  _btn_Hunting = UI.getChildControl(Panel_PersonalIcon, "Button_HuntingAlert"),
  _btn_SiegeArea = UI.getChildControl(Panel_PersonalIcon, "Button_VillageSiegeArea"),
  _btn_SummonElephant = UI.getChildControl(Panel_PersonalIcon, "Button_SummonElephant"),
  _btn_BusterCall = UI.getChildControl(Panel_PersonalIcon, "Button_BusterCall"),
  _btn_WarCall = UI.getChildControl(Panel_PersonalIcon, "Button_WarCall"),
  _btn_ReturnStone = UI.getChildControl(Panel_PersonalIcon, "Button_ReturnStone"),
  _btn_SummonParty = UI.getChildControl(Panel_PersonalIcon, "Button_SummonParty"),
  _btn_Militia = UI.getChildControl(Panel_PersonalIcon, "Button_Militia"),
  _btn_DropItem = UI.getChildControl(Panel_PersonalIcon, "Button_DropItem"),
  _plus_MovieGuide = UI.getChildControl(Panel_PersonalIcon, "StaticText_MoviePlus"),
  _plus_Hunting = UI.getChildControl(Panel_PersonalIcon, "StaticText_HuntingPlus"),
  _currentRegion = nil
}
local radarPosX = 0
local radarPosY = 0
function PersonalIcon_Initalize()
  local self = personalIcon
  for _, v in pairs(self) do
    v:SetShow(false)
  end
  radarPosX = FGlobal_Panel_Radar_GetPosX()
  radarPosY = FGlobal_Panel_Radar_GetPosY()
  PersonalIcon_Tooltip()
end
function FGlobal_PersonalIcon_ButtonPosUpdate()
  local self = personalIcon
  local showIconCount = 0
  local controlGapX = 5
  local sizeX = self._btn_NpcNavi:GetSizeX()
  local panelPosX = Panel_PersonalIcon:GetPosX()
  local RadarSpanSizeY = FGlobal_Panel_Radar_GetSpanSizeY()
  local playerLV = getSelfPlayer():get():getLevel()
  if getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_CBT then
    if isGameTypeEnglish() then
      self._btn_MovieGuide:SetShow(true)
    else
      self._btn_MovieGuide:SetShow(false)
    end
  elseif isGameTypeKR2() then
    self._btn_MovieGuide:SetShow(false)
  elseif isGameTypeTH() then
    self._btn_MovieGuide:SetShow(false)
  else
    self._btn_MovieGuide:SetShow(true)
  end
  if playerLV > 51 then
    self._btn_NpcNavi:SetShow(true)
    self._btn_NpcNaviTW:SetShow(false)
  else
    self._btn_NpcNavi:SetShow(false)
    self._btn_NpcNaviTW:SetShow(true)
  end
  if ToClient_IsContentsGroupOpen("245") then
    local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
    if nil ~= myGuildInfo then
      if playerLV >= 58 then
        self._btn_Militia:SetShow(true)
      else
        self._btn_Militia:SetShow(false)
      end
    else
      self._btn_Militia:SetShow(false)
    end
  end
  if self._btn_Militia:GetShow() then
    self._btn_Militia:SetPosX((sizeX + controlGapX) * showIconCount)
    self._btn_Militia:SetPosY(10)
    showIconCount = showIconCount + 1
  end
  if self._btn_DropItem:GetShow() then
    self._btn_DropItem:SetPosX((sizeX + controlGapX) * showIconCount)
    self._btn_DropItem:SetPosY(10)
    showIconCount = showIconCount + 1
  end
  if self._btn_WarCall:GetShow() then
    self._btn_WarCall:SetPosX((sizeX + controlGapX) * showIconCount)
    self._btn_WarCall:SetPosY(10)
    showIconCount = showIconCount + 1
  end
  if self._btn_SummonParty:GetShow() then
    self._btn_SummonParty:SetPosX((sizeX + controlGapX) * showIconCount)
    self._btn_SummonParty:SetPosY(10)
    showIconCount = showIconCount + 1
  end
  if self._btn_ReturnStone:GetShow() then
    self._btn_ReturnStone:SetPosX((sizeX + controlGapX) * showIconCount)
    self._btn_ReturnStone:SetPosY(10)
    showIconCount = showIconCount + 1
  end
  if self._btn_BusterCall:GetShow() then
    self._btn_BusterCall:SetPosX((sizeX + controlGapX) * showIconCount)
    self._btn_BusterCall:SetPosY(10)
    showIconCount = showIconCount + 1
  end
  if self._btn_SummonElephant:GetShow() then
    self._btn_SummonElephant:SetPosX((sizeX + controlGapX) * showIconCount)
    self._btn_SummonElephant:SetPosY(10)
    showIconCount = showIconCount + 1
  end
  self._btn_SiegeArea:SetShow(ToClient_IsContentsGroupOpen("21"))
  self._btn_SiegeArea:SetPosX((sizeX + controlGapX) * showIconCount)
  self._btn_SiegeArea:SetPosY(10)
  showIconCount = showIconCount + 1
  if ToClient_IsContentsGroupOpen("28") then
    self._btn_Hunting:SetShow(true)
    self._btn_Hunting:SetPosX((sizeX + controlGapX) * showIconCount)
    self._btn_Hunting:SetPosY(10)
    showIconCount = showIconCount + 1
  else
    self._btn_Hunting:SetShow(false)
  end
  if ToClient_IsContentsGroupOpen("75") then
    self._btn_VoiceChat:SetShow(true)
    self._btn_VoiceChat:SetPosX((sizeX + controlGapX) * showIconCount)
    self._btn_VoiceChat:SetPosY(10)
    showIconCount = showIconCount + 1
  else
    self._btn_VoiceChat:SetShow(false)
  end
  if self._btn_MovieGuide:GetShow() then
    self._btn_MovieGuide:SetPosX((sizeX + controlGapX) * showIconCount)
    self._btn_MovieGuide:SetPosY(10)
    showIconCount = showIconCount + 1
  end
  if self._btn_NpcNavi:GetShow() or self._btn_NpcNaviTW:GetShow() then
    self._btn_NpcNavi:SetPosX((sizeX + controlGapX) * showIconCount)
    self._btn_NpcNavi:SetPosY(10)
    self._btn_NpcNaviTW:SetPosX((sizeX + controlGapX) * showIconCount)
    self._btn_NpcNaviTW:SetPosY(10)
    showIconCount = showIconCount + 1
  end
  self._plus_MovieGuide:SetPosX(self._btn_MovieGuide:GetPosX() + 25)
  self._plus_MovieGuide:SetPosY(self._btn_MovieGuide:GetPosY() + 25)
  self._plus_Hunting:SetPosX(self._btn_Hunting:GetPosX() + 25)
  self._plus_Hunting:SetPosY(self._btn_Hunting:GetPosY() + 25)
  Panel_PersonalIcon:SetShow(true)
  if CppDefine.ChangeUIAndResolution == true then
    radarPosX = FGlobal_Panel_Radar_GetPosX()
    radarPosY = FGlobal_Panel_Radar_GetPosY()
  end
  Panel_PersonalIcon:SetSize((sizeX + controlGapX) * showIconCount - 5, Panel_PersonalIcon:GetSizeY())
  Panel_PersonalIcon:SetPosX(radarPosX - (sizeX + controlGapX) * showIconCount)
end
function FGlobal_GetPersonalIconControl(index)
  local self = personalIcon
  if 0 == index then
    local playerLV = getSelfPlayer():get():getLevel()
    if playerLV > 51 then
      return self._btn_NpcNavi
    else
      return self._btn_NpcNaviTW
    end
  elseif 1 == index then
    return self._btn_MovieGuide
  elseif 2 == index then
    return self._btn_VoiceChat
  elseif 3 == index then
    return self._btn_Hunting
  elseif 4 == index then
    return self._btn_SiegeArea
  elseif 6 == index then
    return self._btn_BusterCall
  elseif 7 == index then
    return self._btn_ReturnStone
  elseif 8 == index then
    return self._btn_SummonElephant
  elseif 9 == index then
    return self._btn_SummonParty
  elseif 10 == index then
    return self._btn_WarCall
  elseif 11 == index then
    return self._btn_Militia
  elseif 12 == index then
    return self._btn_DropItem
  else
    return nil
  end
end
function FGlobal_GetPersonalText(index)
  local self = personalIcon
  if 1 == index then
    return self._plus_MovieGuide
  elseif 3 == index then
    return self._plus_Hunting
  else
    return nil
  end
end
function FGlobal_GetPersonalIconPosX(index)
  local self = personalIcon
  local posX = Panel_PersonalIcon:GetPosX()
  if 0 == index then
    return self._btn_NpcNavi:GetPosX() + posX
  elseif 1 == index then
    return self._btn_MovieGuide:GetPosX() + posX
  elseif 2 == index then
    return self._btn_VoiceChat:GetPosX() + posX
  elseif 3 == index then
    return self._btn_Hunting:GetPosX() + posX
  elseif 4 == index then
    return self._btn_SiegeArea:GetPosX() + posX
  elseif 6 == index then
    return self._btn_BusterCall:GetPosX() + posX
  elseif 7 == index then
    return self._btn_ReturnStone:GetPosX() + posX
  elseif 8 == index then
    return self._btn_SummonElephant:GetPosX() + posX
  elseif 9 == index then
    return self._btn_SummonParty:GetPosX() + posX
  elseif 10 == index then
    return self._btn_WarCall:GetPosX() + posX
  elseif 11 == index then
    return self._btn_Militia:GetPosX() + posX
  elseif 12 == index then
    return self._btn_DropItem:GetPosX() + posX
  else
    return nil
  end
end
function FGlobal_GetPersonalIconPosY(index)
  local self = personalIcon
  local posY = Panel_PersonalIcon:GetPosY()
  if 0 == index then
    return self._btn_NpcNavi:GetPosY() + posY
  elseif 1 == index then
    return self._btn_MovieGuide:GetPosY() + posY
  elseif 2 == index then
    return self._btn_VoiceChat:GetPosY() + posY
  elseif 3 == index then
    return self._btn_Hunting:GetPosY() + posY
  elseif 4 == index then
    return self._btn_SiegeArea:GetPosY() + posY
  elseif 6 == index then
    return self._btn_BusterCall:GetPosY() + posY
  elseif 7 == index then
    return self._btn_ReturnStone:GetPosY() + posY
  elseif 8 == index then
    return self._btn_SummonElephant:GetPosY() + posY
  elseif 9 == index then
    return self._btn_SummonParty:GetPosY() + posY
  elseif 10 == index then
    return self._btn_WarCall:GetPosY() + posY
  elseif 11 == index then
    return self._btn_Militia:GetPosY() + posY
  elseif 12 == index then
    return self._btn_DropItem:GetPosY() + posY
  else
    return nil
  end
end
function FGlobal_GetPersonalIconSizeX()
  local self = personalIcon
  local sizeX = self._btn_NpcNavi:GetSizeX()
  return sizeX
end
function FGlobal_GetPersonalIconSizeY()
  local self = personalIcon
  local sizeY = self._btn_NpcNavi:GetSizeY()
  return sizeY
end
function PersonalIcon_Tooltip()
  local self = personalIcon
  self._btn_NpcNavi:addInputEvent("Mouse_LUp", "NpcNavi_ShowToggle()")
  self._btn_NpcNaviTW:addInputEvent("Mouse_LUp", "NpcNavi_ShowToggle()")
  self._btn_MovieGuide:addInputEvent("Mouse_LUp", "PaGlobal_MovieGuide_Web:Open()")
  self._btn_VoiceChat:addInputEvent("Mouse_On", "HandleOnOut_SetVoiceChat_Tooltip(true)")
  self._btn_VoiceChat:addInputEvent("Mouse_Out", "HandleOnOut_SetVoiceChat_Tooltip(false)")
  self._btn_VoiceChat:addInputEvent("Mouse_LUp", "FGlobal_SetVoiceChat_Toggle()")
  self._btn_VoiceChat:setTooltipEventRegistFunc("HandleOnOut_SetVoiceChat_Tooltip( true )")
  self._btn_Hunting:addInputEvent("Mouse_On", "Hunting_ToolTip_ShowToggle(true)")
  self._btn_Hunting:addInputEvent("Mouse_Out", "Hunting_ToolTip_ShowToggle(false)")
  self._btn_SiegeArea:addInputEvent("Mouse_On", "VillageSiegeArea_Tooltip_ShowToggle(true)")
  self._btn_SiegeArea:addInputEvent("Mouse_Out", "VillageSiegeArea_Tooltip_ShowToggle(false)")
  self._btn_SiegeArea:addInputEvent("Mouse_LUp", "ToggleVillageSiegeArea(false)")
  self._btn_SummonElephant:addInputEvent("Mouse_On", "SummonElephant_Tooltip_ShowToggle(true)")
  self._btn_SummonElephant:addInputEvent("Mouse_Out", "SummonElephant_Tooltip_ShowToggle(false)")
  self._btn_SummonElephant:addInputEvent("Mouse_LUp", "SummonElephant()")
  self._btn_BusterCall:addInputEvent("Mouse_On", "BusterCall_ToolTip(true)")
  self._btn_BusterCall:addInputEvent("Mouse_Out", "BusterCall_ToolTip(false)")
  self._btn_BusterCall:addInputEvent("Mouse_LUp", "Click_BusterCall()")
  self._btn_WarCall:addInputEvent("Mouse_On", "WarCall_ToolTip(true)")
  self._btn_WarCall:addInputEvent("Mouse_Out", "WarCall_ToolTip(false)")
  self._btn_WarCall:addInputEvent("Mouse_LUp", "Click_WarCall()")
  self._btn_ReturnStone:addInputEvent("Mouse_On", "ReturnStone_ToolTip(true)")
  self._btn_ReturnStone:addInputEvent("Mouse_Out", "ReturnStone_ToolTip(false)")
  self._btn_ReturnStone:addInputEvent("Mouse_LUp", "Click_ReturnStone()")
  self._btn_SummonParty:addInputEvent("Mouse_On", "SummonParty_ToolTip(true)")
  self._btn_SummonParty:addInputEvent("Mouse_Out", "SummonParty_ToolTip(false)")
  self._btn_SummonParty:addInputEvent("Mouse_LUp", "Click_SummonParty()")
  self._btn_Militia:addInputEvent("Mouse_On", "MilitiaButton_Tooltip(true)")
  self._btn_Militia:addInputEvent("Mouse_Out", "MilitiaButton_Tooltip(false)")
  self._btn_Militia:addInputEvent("Mouse_LUp", "FGlobal_MercenaryOpen()")
  self._btn_DropItem:addInputEvent("Mouse_On", "DropItemButton_Tooltip(true)")
  self._btn_DropItem:addInputEvent("Mouse_Out", "DropItemButton_Tooltip(false)")
  self._btn_DropItem:addInputEvent("Mouse_LUp", "FGlobal_DropItemOpen()")
end
function MilitiaButton_Tooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = personalIcon._btn_Militia
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MERCENARY_TITLE")
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MERCENARY_TOPDESC")
  registTooltipControl(control, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(control, name, desc)
end
function DropItemButton_Tooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = personalIcon._btn_DropItem
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALICON_DROPITEM_TOOLTIPNAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALICON_DROPITEM_TOOLTIPDESC")
  registTooltipControl(control, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(control, name, desc)
end
function DropItemButton_RegionCheck()
  if not ToClient_IsContentsGroupOpen("337") then
    return
  end
  local self = personalIcon
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    self._btn_DropItem:SetShow(false)
    PaGlobal_DropItem:Close()
  end
  local currentRegionKeyRaw = selfPlayer:getRegionKeyRaw()
  local regionDropItemIndex = ToClient_RegionDropItem_GetIndexByRegionKey(currentRegionKeyRaw)
  if regionDropItemIndex > 0 then
    currentRegionKeyRaw = ToClient_RegionDropItem_GetRegionKeyByIndex(regionDropItemIndex)
  end
  local itemCount = ToClient_GetRegionDropItemSize(currentRegionKeyRaw)
  self._currentRegion = currentRegionKeyRaw
  if itemCount > 0 then
    self._btn_DropItem:SetShow(true)
    PaGlobal_DropItem:Update()
  else
    self._btn_DropItem:SetShow(false)
  end
  FGlobal_PersonalIcon_ButtonPosUpdate()
end
function FGlobal_GetRegionKey_ByDropItem()
  return personalIcon._currentRegion
end
PersonalIcon_Initalize()
FGlobal_PersonalIcon_ButtonPosUpdate()
if CppDefine.ChangeUIAndResolution == true then
  registerEvent("onScreenResize", "FGlobal_PersonalIcon_ButtonPosUpdate")
  registerEvent("selfPlayer_regionChanged", "DropItemButton_RegionCheck")
end
