Panel_Window_WharfInfo:SetShow(false, false)
Panel_Window_WharfInfo:setMaskingChild(true)
Panel_Window_WharfInfo:ActiveMouseEventEffect(true)
Panel_Window_WharfInfo:SetDragEnable(true)
Panel_Window_WharfInfo:RegisterShowEventFunc(true, "WharfInfoShowAni()")
Panel_Window_WharfInfo:RegisterShowEventFunc(false, "WharfInfoHideAni()")
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
function WharfInfoShowAni()
  Panel_Window_WharfInfo:SetShow(true, false)
  UIAni.fadeInSCR_Right(Panel_Window_WharfInfo)
  local aniInfo3 = Panel_Window_WharfInfo:addColorAnimation(0, 0.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo3:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = false
end
function WharfInfoHideAni()
  Panel_Window_WharfInfo:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_WharfInfo:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
local wharfInfo = {
  _staticName = UI.getChildControl(Panel_Window_WharfInfo, "StaticText_Name"),
  _mp = UI.getChildControl(Panel_Window_WharfInfo, "MP"),
  _staticText_GaugeBar_Hp = UI.getChildControl(Panel_Window_WharfInfo, "HP_GaugeBar"),
  _staticText_GaugeBar_Mp = UI.getChildControl(Panel_Window_WharfInfo, "MP_GaugeBar"),
  _staticText_GaugeBar_Weight = UI.getChildControl(Panel_Window_WharfInfo, "Weight_GaugeBar"),
  _staticText_Hp = UI.getChildControl(Panel_Window_WharfInfo, "HP_Value"),
  _staticText_Mp = UI.getChildControl(Panel_Window_WharfInfo, "MP_Value"),
  _staticText_Weight = UI.getChildControl(Panel_Window_WharfInfo, "Weight_Value"),
  _staticText_MoveSpeed = UI.getChildControl(Panel_Window_WharfInfo, "MaxMoveSpeedValue"),
  _staticText_Acceleration = UI.getChildControl(Panel_Window_WharfInfo, "AccelerationValue"),
  _staticText_Cornering = UI.getChildControl(Panel_Window_WharfInfo, "CorneringSpeedValue"),
  _staticText_BrakeSpeed = UI.getChildControl(Panel_Window_WharfInfo, "BrakeSpeedValue"),
  _deadCount = UI.getChildControl(Panel_Window_WharfInfo, "StaticText_DeadCount"),
  _deadCountValue = UI.getChildControl(Panel_Window_WharfInfo, "StaticText_DeadCountValue")
}
function wharfInfo:init()
end
function wharfInfo:update()
  local servantInfo = stable_getServant(WharfList_SelectSlotNo())
  if nil == servantInfo then
    return
  end
  local vehicleType = servantInfo:getVehicleType()
  local Weight = servantInfo:getInventoryWeight_s64()
  local MaxWeight = servantInfo:getMaxWeight_s64() / Defines.s64_const.s64_10000
  local GuageWeight = Int64toInt32(Weight)
  local GuageMaxWeight = Int64toInt32(MaxWeight)
  self._staticName:SetText(servantInfo:getName())
  self._staticText_GaugeBar_Hp:SetSize(2.5 * (servantInfo:getHp() / servantInfo:getMaxHp() * 100), 6)
  self._staticText_GaugeBar_Mp:SetSize(2.5 * (servantInfo:getMp() / servantInfo:getMaxMp() * 100), 6)
  self._staticText_GaugeBar_Weight:SetSize(2.5 * (GuageWeight / GuageMaxWeight * 100), 6)
  self._staticText_Hp:SetText(makeDotMoney(servantInfo:getHp()) .. " / " .. makeDotMoney(servantInfo:getMaxHp()))
  self._staticText_Mp:SetText(makeDotMoney(servantInfo:getMp()) .. " / " .. makeDotMoney(servantInfo:getMaxMp()))
  self._staticText_Weight:SetText(makeDotMoney(Weight) .. " / " .. makeDotMoney(MaxWeight))
  self._staticText_MoveSpeed:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed) / 10000) .. "%")
  self._staticText_Acceleration:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_Acceleration) / 10000) .. "%")
  self._staticText_Cornering:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_CorneringSpeed) / 10000) .. "%")
  self._staticText_BrakeSpeed:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_BrakeSpeed) / 10000) .. "%")
  if CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_PersonTradeShip == vehicleType then
    self._mp:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANT_SHIPINFO_MP"))
  else
    self._mp:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_HEART"))
  end
  local deadCount = servantInfo:getDeadCount()
  if servantInfo:doClearCountByDead() then
    deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETOK", "deadCount", deadCount)
  else
    deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETNO", "deadCount", deadCount)
  end
  if servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Horse or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Camel or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Donkey or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Elephant then
    self._deadCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_KILLCOUNT"))
  elseif servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Carriage or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_CowCarriage or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_RepairableCarriage then
    self._deadCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_DESTROYCOUNT"))
  elseif servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Boat or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Raft or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_FishingBoat or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_SailingBoat then
    self._deadCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_DESTROYCOUNT"))
  end
  self._deadCountValue:SetText(deadCount)
end
function wharfInfo:registEventHandler()
end
function wharfInfo:registMessageHandler()
  registerEvent("onScreenResize", "WharfInfo_Resize")
end
function WharfInfo_Resize()
  Panel_Window_WharfInfo:SetSpanSize(20, 30)
  Panel_Window_WharfInfo:ComputePos()
end
function WharfInfo_Open()
  local self = wharfInfo
  self:update()
  if Panel_Window_WharfInfo:GetShow() then
    return
  end
  Panel_Window_WharfInfo:SetShow(true)
end
function WharfInfo_Close()
  if not Panel_Window_WharfInfo:GetShow() then
    return
  end
  Panel_Window_WharfInfo:SetShow(false)
end
wharfInfo:init()
wharfInfo:registEventHandler()
wharfInfo:registMessageHandler()
WharfInfo_Resize()
