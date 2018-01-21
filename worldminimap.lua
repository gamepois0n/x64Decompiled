PaGlobal_WorldMiniMap = {
  _ui = {},
  _panelSizeScale = false,
  _isRotate = false,
  _nodeWarRegionName = nil,
  _initialize = false
}
function PaGlobal_WorldMiniMap:InitWorldMiniMap()
  if ToClient_IsDevelopment() then
    ToClient_initializeWorldMiniMap()
  else
    return
  end
  if Panel_WorldMiniMap ~= nil then
    Panel_WorldMiniMap:SetPosX(getScreenSizeX() - Panel_WorldMiniMap:GetSizeX() - 15)
    Panel_WorldMiniMap:SetPosY(30)
    Panel_WorldMiniMap:SetShow(false)
  end
  self._ui.regionName = UI.getChildControl(Panel_WorldMiniMap, "StaticText_RegionName")
  self._ui.regionName:SetShow(true)
  self._ui.regionNodeName = UI.getChildControl(Panel_WorldMiniMap, "StaticText_RegionNodeName")
  self._ui.regionNodeName:SetShow(true)
  self._ui.regionWarName = UI.getChildControl(Panel_WorldMiniMap, "StaticText_RegionWarName")
  self._ui.regionWarName:SetShow(true)
  PaGlobal_WorldMiniMap:setPositionRegionNameList()
  self._ui.btn_changeScale = UI.getChildControl(Panel_WorldMiniMap, "Button_changeScale")
  self._ui.btn_changeScale:SetShow(true)
  self._ui.btn_changeRadar = UI.getChildControl(Panel_WorldMiniMap, "Button_changeRadar")
  self._ui.btn_changeRadar:SetShow(true)
  self._ui.btn_changeScale:addInputEvent("Mouse_LUp", "PaGlobal_WorldMiniMap:changePanelSize()")
  self._ui.btn_changeRadar:addInputEvent("Mouse_LUp", "PaGlobal_changeRadarUI()")
  self._ui.static_selfPlayerArrow = UI.getChildControl(Panel_WorldMiniMap, "Static_SelfPlayerArrow")
  self._ui.static_selfPlayerArrow:SetShow(true)
  self._ui.static_selfPlayerArrow:SetSize(30, 26)
  self._ui.static_selfPlayerArrow:SetPosX()
  self._ui.static_selfPlayerArrow:ComputePos()
  GLOBAL_CHECK_WORLDMINIMAP = false
  if ToClient_isWorldMiniMapUse() then
    PaGlobal_changeRadarUI()
  else
    GLOBAL_CHECK_WORLDMINIMAP = false
  end
  Panel_WorldMiniMap:RegisterUpdateFunc("Panel_WorldMiniMap_UpdatePerFrame")
  registerEvent("selfPlayer_regionChanged", "worldMiniMap_updateRegion")
  registerEvent("FromClint_EventChangedExplorationNode", "worldMiniMap_NodeLevelRegionNameShow")
  registerEvent("FromClient_RClickedWorldMiniMap", "FromClient_RClickedWorldMiniMap")
  registerEvent("FromClient_ChangeRadarRotateMode", "FromClient_SetRotateMode")
  PaGlobal_WorldMiniMap._initialize = true
end
function PaGlobal_changeRadarUI()
  if true == PaGlobal_WorldMiniMap._initialize then
    ToClient_changeRadar()
  end
  if ToClient_getRadarType() == true then
    GLOBAL_CHECK_WORLDMINIMAP = true
    FGlobal_Panel_Radar_Show(false)
    Panel_WorldMiniMap:SetShow(true)
    ToClient_setRadorUIPanel(Panel_WorldMiniMap)
    ToClient_setRadorUIViewDistanceRate(7225)
    ToCleint_InitializeRadarActorPool(1000)
    ToClient_updateCameraWorldMiniMap()
    setChangeUiSettingRadarUI(Panel_WorldMiniMap)
  else
    GLOBAL_CHECK_WORLDMINIMAP = false
    Panel_WorldMiniMap:SetShow(false)
    FGlobal_Panel_Radar_Show(true)
    ToClient_setRadorUIPanel(Panel_Radar)
    ToClient_setRadorUIViewDistanceRate(7225)
    ToCleint_InitializeRadarActorPool(1000)
    setChangeUiSettingRadarUI(Panel_Radar)
  end
  local self = PaGlobal_WorldMiniMap
  self._panelSizeScale = true
  self:changePanelSize()
end
function PaGlobal_WorldMiniMap:changePanelSize()
  local miniMap = ToClient_getWorldMiniMapPanel()
  if true == self._panelSizeScale then
    miniMap:SetSize(300, 260)
    Panel_WorldMiniMap:SetSize(300, 260)
    Panel_WorldMiniMap:SetPosX(getScreenSizeX() - Panel_WorldMiniMap:GetSizeX() - 15)
  else
    miniMap:SetSize(500, 460)
    Panel_WorldMiniMap:SetSize(500, 460)
    Panel_WorldMiniMap:SetPosX(getScreenSizeX() - Panel_WorldMiniMap:GetSizeX() - 15)
  end
  self._ui.btn_changeScale:ComputePos()
  self._ui.static_selfPlayerArrow:ComputePos()
  PaGlobal_WorldMiniMap:setPositionRegionNameList()
  self._panelSizeScale = not self._panelSizeScale
end
function PaGlobal_WorldMiniMap_luaLoadComplete()
  local self = PaGlobal_WorldMiniMap
  if ToClient_IsDevelopment() then
    PaGlobal_WorldMiniMap:InitWorldMiniMap()
  else
    self._initialize = false
  end
  if Panel_WorldMiniMap ~= nil then
    Panel_WorldMiniMap:SetShow(true)
  end
end
function worldMiniMap_updateRegion(regionData)
  local self = PaGlobal_WorldMiniMap
  self._ui.regionName:SetAutoResize(true)
  self._ui.regionName:SetNotAbleMasking(true)
  local isArenaZone = regionData:get():isArenaZone()
  local isSafetyZone = regionData:get():isSafeZone()
  self._ui.regionName:SetFontColor(Defines.Color.C_FFEFEFEF)
  self._ui.regionName:useGlowFont(false)
  self._ui.regionNodeName:SetFontColor(Defines.Color.C_FFEFEFEF)
  self._ui.regionNodeName:useGlowFont(false)
  self._ui.regionWarName:SetFontColor(Defines.Color.C_FFEFEFEF)
  self._ui.regionWarName:useGlowFont(false)
  if isSafetyZone then
    self._ui.regionName:SetFontColor(4292276981)
    self._ui.regionName:useGlowFont(true, "BaseFont_12_Glow", 4281961144)
    self._ui.regionNodeName:SetFontColor(4292276981)
    self._ui.regionNodeName:useGlowFont(true, "BaseFont_8_Glow", 4281961144)
    self._ui.regionWarName:SetFontColor(4292276981)
    self._ui.regionWarName:useGlowFont(true, "BaseFont_8_Glow", 4281961144)
  elseif isArenaZone then
    self._ui.regionName:SetFontColor(4294495693)
    self._ui.regionName:useGlowFont(true, "BaseFont_12_Glow", 4286580487)
    self._ui.regionNodeName:SetFontColor(4294495693)
    self._ui.regionNodeName:useGlowFont(true, "BaseFont_8_Glow", 4286580487)
    self._ui.regionWarName:SetFontColor(4294495693)
    self._ui.regionWarName:useGlowFont(true, "BaseFont_8_Glow", 4286580487)
  else
    self._ui.regionName:SetFontColor(4294495693)
    self._ui.regionName:useGlowFont(true, "BaseFont_12_Glow", 4286580487)
    self._ui.regionNodeName:SetFontColor(4294495693)
    self._ui.regionNodeName:useGlowFont(true, "BaseFont_8_Glow", 4286580487)
    self._ui.regionWarName:SetFontColor(4294495693)
    self._ui.regionWarName:useGlowFont(true, "BaseFont_8_Glow", 4286580487)
  end
  self._ui.regionName:SetText(regionData:getAreaName())
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayerPos = selfPlayerWrapper:get3DPos()
  local linkSiegeWrapper = ToClient_getInstallableVillageSiegeRegionInfoWrapper(selfPlayerPos)
  self._nodeWarRegionName = ""
  if nil ~= linkSiegeWrapper then
    local villageWarZone = linkSiegeWrapper:get():isVillageWarZone()
    if true == villageWarZone then
      self._nodeWarRegionName = linkSiegeWrapper:getvillageSiegeName()
    end
    self._ui.regionName:SetText(regionData:getAreaName())
  end
end
function worldMiniMap_NodeLevelRegionNameShow(wayPointKey)
  local self = PaGlobal_WorldMiniMap
  local nodeName = ToClient_GetNodeNameByWaypointKey(wayPointKey)
  if "" == nodeName or nil == nodeName then
    self._ui.regionNodeName:SetShow(false)
  else
    self._ui.regionNodeName:SetShow(true)
    self._ui.regionNodeName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RADER_REGIONNODENAME", "getName", nodeName))
    self._ui.regionNodeName:SetSize(self._ui.regionNodeName:GetTextSizeX(), self._ui.regionNodeName:GetSizeY())
    self._ui.regionNodeName:SetPosX(Panel_WorldMiniMap:GetSizeX() - self._ui.regionNodeName:GetSizeX())
    self._ui.regionNodeName:SetPosY(Panel_WorldMiniMap:GetSizeY() - self._ui.regionNodeName:GetSizeY())
    self._ui.regionNodeName:ComputePos()
  end
  if "" == self._nodeWarRegionName or nil == self._nodeWarRegionName then
    self._ui.regionWarName:SetShow(false)
  else
    self._ui.regionWarName:SetShow(true)
    self._ui.regionWarName:SetText(self._nodeWarRegionName .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_VILLAGEWARABLE_NAME"))
    self._ui.regionWarName:SetSize(self._ui.regionWarName:GetTextSizeX(), self._ui.regionWarName:GetSizeY())
    self._ui.regionWarName:SetPosX(Panel_WorldMiniMap:GetSizeX() - self._ui.regionWarName:GetSizeX())
    self._ui.regionWarName:SetPosY(Panel_WorldMiniMap:GetSizeY() - self._ui.regionWarName:GetSizeY())
    self._ui.regionWarName:ComputePos()
  end
end
function PaGlobal_WorldMiniMap:setPositionRegionNameList()
  self._ui.regionName:SetPosX(5)
  self._ui.regionName:SetPosY(5)
  self._ui.regionName:SetSize(self._ui.regionName:GetTextSizeX() + 40, self._ui.regionName:GetSizeY())
  self._ui.regionName:ComputePos()
  self._ui.regionNodeName:SetPosX(Panel_WorldMiniMap:GetSizeX() - self._ui.regionNodeName:GetSizeX())
  self._ui.regionNodeName:SetPosY(Panel_WorldMiniMap:GetSizeY() - self._ui.regionNodeName:GetSizeY())
  self._ui.regionNodeName:ComputePos()
  self._ui.regionWarName:SetPosX(Panel_WorldMiniMap:GetSizeX() - self._ui.regionWarName:GetSizeX())
  self._ui.regionWarName:SetPosY(Panel_WorldMiniMap:GetSizeY() - self._ui.regionWarName:GetSizeY())
  self._ui.regionWarName:ComputePos()
end
function FromClient_SetRotateMode(isRotate)
  local self = PaGlobal_WorldMiniMap
  local camRot = getCameraRotation()
  local rot = 0
  if false == isRotate then
    rot = 0
  else
    rot = math.pi
  end
  self._isRotate = isRotate
  Panel_WorldMiniMap:SetParentRotCalc(isRotate)
  self._ui.static_selfPlayerArrow:SetRotate(rot)
end
function Panel_WorldMiniMap_UpdatePerFrame(deltaTime)
  local self = PaGlobal_WorldMiniMap
  if false == self._isRotate then
    self._ui.static_selfPlayerArrow:SetRotate(getCameraRotation() + math.pi)
  else
  end
end
function FromClient_RClickedWorldMiniMap(position, clickActor)
  local self = PaGlobal_WorldMiniMap
  if ToClient_IsShowNaviGuideGroup(0) then
    ToClient_DeleteNaviGuideByGroup(0)
  elseif true == clickActor then
    FromClient_RClickWorldmapPanel(position, true, false)
  else
    if 0 ~= ToClient_GetMyTeamNoLocalWar() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_LOCALWAR_CANTNAVI_ACK"))
      return
    end
    if getSelfPlayer():get():getLevel() < 11 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TUTORIAL_PROGRSS_ACK"))
      FGlobal_QuestWidget_UpdateList()
      if not isQuest160524_chk() then
        updateQuestWindowList(FGlobal_QuestWindowGetStartPosition())
      end
      return
    end
    ToClient_WorldMapNaviStart(position, NavigationGuideParam(), false, true)
  end
end
registerEvent("FromClient_luaLoadComplete", "PaGlobal_WorldMiniMap_luaLoadComplete")
