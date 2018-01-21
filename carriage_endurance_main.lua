PaGlobalCarriageEnduranceList = {
  panel = Panel_CarriageEndurance,
  enduranceTypeCount = 5,
  enduranceInfo = {},
  effectBG = UI.getChildControl(Panel_CarriageEndurance, "Static_CarriageEffect"),
  noticeEndurance = UI.getChildControl(Panel_CarriageEndurance, "StaticText_NoticeEndurance"),
  repair_AutoNavi = UI.getChildControl(Panel_CarriageEndurance, "CheckButton_Repair_AutoNavi"),
  repair_Navi = UI.getChildControl(Panel_CarriageEndurance, "Checkbox_Repair_Navi"),
  radarSizeX = 0
}
function PaGlobalCarriageEnduranceList:initialize()
  for index = 0, self.enduranceTypeCount - 1 do
    self.enduranceInfo[index] = {}
    if index == 0 then
      self.enduranceInfo[index].control = UI.getChildControl(self.panel, "Static_Carriage_Flag")
    elseif index == 1 then
      self.enduranceInfo[index].control = UI.getChildControl(self.panel, "Static_Carriage_Cover")
    elseif index == 2 then
      self.enduranceInfo[index].control = UI.getChildControl(self.panel, "Static_Carriage_Wheel")
    elseif index == 3 then
      self.enduranceInfo[index].control = UI.getChildControl(self.panel, "Static_Carriage_Curtain")
    elseif index == 4 then
      self.enduranceInfo[index].control = UI.getChildControl(self.panel, "Static_Carriage_Lamp")
    end
    self.enduranceInfo[index].control:SetShow(false)
    self.enduranceInfo[index].color = Defines.Color.C_FF000000
    self.enduranceInfo[index].itemEquiped = false
    self.enduranceInfo[index].isBroken = false
  end
  self.noticeEndurance:SetShow(false)
  self.repair_AutoNavi:SetShow(false)
  self.repair_Navi:SetShow(false)
  self.panel:SetShow(true)
  if not self.repair_Navi:GetShow() then
    self.effectBG:EraseAllEffect()
  end
  self.effectBG:addInputEvent("Mouse_On", "HandleMEnduranceNotice(CppEnums.EnduranceType.eEnduranceType_Carriage, true)")
  self.effectBG:addInputEvent("Mouse_Out", "HandleMEnduranceNotice(CppEnums.EnduranceType.eEnduranceType_Carriage, false)")
  self.repair_AutoNavi:addInputEvent("Mouse_LUp", "HandleMLUpRepairNavi(CppEnums.EnduranceType.eEnduranceType_Carriage, true)")
  self.repair_Navi:addInputEvent("Mouse_LUp", "HandleMLUpRepairNavi(CppEnums.EnduranceType.eEnduranceType_Carriage, false)")
  self.radarSizeX = FGlobal_Panel_Radar_GetSizeX()
  Panel_CarriageEndurance_Position()
end
function Panel_CarriageEndurance_Position()
  local self = PaGlobalCarriageEnduranceList
  if FGlobal_Panel_Radar_GetShow() then
    self.panel:SetPosX(getScreenSizeX() - self.radarSizeX - self.panel:GetSizeX() * 1.7)
    self.panel:SetPosY(FGlobal_Panel_Radar_GetPosY() - FGlobal_Panel_Radar_GetSizeY() / 1.5)
  else
    self.panel:SetPosX(getScreenSizeX() - self.panel:GetSizeX())
    self.panel:SetPosY(30)
  end
  if Panel_Widget_TownNpcNavi:GetShow() then
    self.panel:SetPosY(Panel_Widget_TownNpcNavi:GetSizeY() + Panel_Widget_TownNpcNavi:GetPosY() + 10)
  end
end
function renderModeChange_CarriageEndurance_Position(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  Panel_CarriageEndurance_Position()
end
PaGlobalCarriageEnduranceList:initialize()
registerEvent("FromClient_RenderModeChangeState", "renderModeChange_CarriageEndurance_Position")
registerEvent("onScreenResize", "Panel_CarriageEndurance_Position")
