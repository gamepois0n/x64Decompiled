local CT = CppEnums.ClassType
local awakenWeapon = {
  [CT.ClassType_Warrior] = ToClient_IsContentsGroupOpen("901"),
  [CT.ClassType_Ranger] = ToClient_IsContentsGroupOpen("902"),
  [CT.ClassType_Sorcerer] = ToClient_IsContentsGroupOpen("903"),
  [CT.ClassType_Giant] = ToClient_IsContentsGroupOpen("904"),
  [CT.ClassType_Tamer] = ToClient_IsContentsGroupOpen("905"),
  [CT.ClassType_BladeMaster] = ToClient_IsContentsGroupOpen("906"),
  [CT.ClassType_BladeMasterWomen] = ToClient_IsContentsGroupOpen("907"),
  [CT.ClassType_Valkyrie] = ToClient_IsContentsGroupOpen("908"),
  [CT.ClassType_Wizard] = ToClient_IsContentsGroupOpen("909"),
  [CT.ClassType_WizardWomen] = ToClient_IsContentsGroupOpen("910"),
  [CT.ClassType_NinjaMan] = ToClient_IsContentsGroupOpen("911"),
  [CT.ClassType_NinjaWomen] = ToClient_IsContentsGroupOpen("912"),
  [CT.ClassType_DarkElf] = ToClient_IsContentsGroupOpen("913"),
  [CT.ClassType_Combattant] = ToClient_IsContentsGroupOpen("914"),
  [CT.ClassType_CombattantWomen] = ToClient_IsContentsGroupOpen("918"),
  [CT.ClassType_Lahn] = ToClient_IsContentsGroupOpen("916")
}
local classType = getSelfPlayer():getClassType()
function FromClient_EnduranceUpdate(enduranceType)
  if (Panel_Window_StableList:GetShow() or Panel_Window_WharfList:GetShow() or Panel_Window_Repair:GetShow()) and false == PaGlobal_Camp:getIsCamping() then
    return
  end
  local self = PaGlobalPlayerEnduranceList
  if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
    self = PaGlobalPlayerEnduranceList
  elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Horse then
    self = PaGlobalHorseEnduranceList
  elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Carriage then
    self = PaGlobalCarriageEnduranceList
  elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Ship then
    self = PaGlobalShipEnduranceList
  end
  local isShow = false
  local isCantRepair = false
  local enduranceCheck = 0
  for index = 0, self.enduranceTypeCount - 1 do
    local enduranceLevel = -1
    if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
      enduranceLevel = ToClient_GetPlayerEquipmentEnduranceLevel(index)
      if false == isCantRepair then
        isCantRepair = ToClient_IsCantRepairPlayerEquipment(index)
      end
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Horse then
      enduranceLevel = ToClient_GetHorseEquipmentEnduranceLevel(index)
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Carriage then
      enduranceLevel = ToClient_GetCarriageEquipmentEnduranceLevel(index)
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Ship then
      enduranceLevel = ToClient_GetShipEquipmentEnduranceLevel(index)
    end
    self.enduranceInfo[index].control:ResetVertexAni()
    if enduranceLevel < 0 then
      self.enduranceInfo[index].itemEquiped = false
      self.enduranceInfo[index].color = Defines.Color.C_FF000000
      self.enduranceInfo[index].isBroken = false
    else
      self.enduranceInfo[index].itemEquiped = true
      if enduranceLevel > 1 then
        self.enduranceInfo[index].color = Defines.Color.C_FF444444
        self.enduranceInfo[index].isBroken = false
      else
        if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
          if enduranceLevel == 0 then
            if 0 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Armor_Red", true)
            elseif 1 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Helm_Red", true)
            elseif 2 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Glove_Red", true)
            elseif 3 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Boots_Red", true)
            elseif 4 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_WeaponR_Red", true)
            elseif 5 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_WeaponL_Red", true)
            elseif 6 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Earing1_Red", true)
            elseif 7 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Earing2_Red", true)
            elseif 8 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Belt_Red", true)
            elseif 9 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Necklace_Red", true)
            elseif 10 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ring1_Red", true)
            elseif 11 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ring2_Red", true)
            elseif 12 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_AwakenWeapon_Red", true)
            end
          elseif enduranceLevel == 1 then
            if 0 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Armor_Orange", true)
            elseif 1 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Helm_Orange", true)
            elseif 2 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Glove_Orange", true)
            elseif 3 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Boots_Orange", true)
            elseif 4 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_WeaponR_Orange", true)
            elseif 5 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_WeaponL_Orange", true)
            elseif 6 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Earing1_Orange", true)
            elseif 7 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Earing2_Orange", true)
            elseif 8 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Belt_Orange", true)
            elseif 9 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Necklace_Orange", true)
            elseif 10 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ring1_Orange", true)
            elseif 11 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ring2_Orange", true)
            elseif 12 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_AwakenWeapon_Orange", true)
            end
          end
        elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Horse then
          if 0 == enduranceLevel then
            if 0 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Head_Red", true)
            elseif 1 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Body_Red", true)
            elseif 2 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_RiderFoot_Red", true)
            elseif 3 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Saddle_Red", true)
            elseif 4 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_HorseFoot_Red", true)
            end
          elseif 1 == enduranceLevel then
            if 0 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Head_Orange", true)
            elseif 1 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Body_Orange", true)
            elseif 2 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_RiderFoot_Orange", true)
            elseif 3 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Saddle_Orange", true)
            elseif 4 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_HorseFoot_Orange", true)
            end
          end
        elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Carriage then
          if 0 == enduranceLevel then
            if 0 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Flag_Red", true)
            elseif 1 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Cover_Red", true)
            elseif 2 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Wheel_Red", true)
            elseif 3 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Curtain_Red", true)
            elseif 4 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Lamp_Red", true)
            end
          elseif 1 == enduranceLevel then
            if 0 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Flag_Orange", true)
            elseif 1 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Cover_Orange", true)
            elseif 2 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Wheel_Orange", true)
            elseif 3 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Curtain_Orange", true)
            elseif 4 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Lamp_Orange", true)
            end
          end
        elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Ship then
          if 0 == enduranceLevel then
            if 0 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Main_Red", true)
            elseif 1 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Head_Red", true)
            elseif 2 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Deco_Red", true)
            elseif 3 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Goods_Red", true)
            end
          elseif 1 == enduranceLevel then
            if 0 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Main_Orange", true)
            elseif 1 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Head_Orange", true)
            elseif 2 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Deco_Orange", true)
            elseif 3 == index then
              self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Goods_Orange", true)
            end
          end
        end
        self.enduranceInfo[index].isBroken = true
        isShow = true
        enduranceCheck = enduranceCheck + 1
      end
    end
    self.enduranceInfo[index].control:SetColor(self.enduranceInfo[index].color)
  end
  if isShow then
    for index = 0, self.enduranceTypeCount - 1 do
      self.enduranceInfo[index].control:SetShow(true)
    end
    if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
      self.enduranceInfo[12].control:SetShow(awakenWeapon[classType])
    end
    self.effectBG:EraseAllEffect()
    if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Horse then
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Carriage then
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Ship then
    end
    if false == self.isEffectSound then
      self.isEffectSound = true
      audioPostEvent_SystemUi(8, 6)
    end
    if (4 == enduranceCheck or 1 == enduranceCheck) and true == isCantRepair then
      self.noticeEndurance:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENDURANCE_NOTICEENDURACNE1"))
    elseif true == isCantRepair then
      self.noticeEndurance:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENDURANCE_NOTICEENDURACNE2"))
    else
      self.noticeEndurance:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENDURANCE_NOTICEENDURACNE3"))
    end
    self.panel:SetShow(true)
    self.effectBG:SetEnable(true)
  else
    for index = 0, self.enduranceTypeCount - 1 do
      self.enduranceInfo[index].control:SetShow(false)
      self.enduranceInfo[index].control:ResetVertexAni()
    end
    self.isEffectSound = false
    self.effectBG:EraseAllEffect()
    self.noticeEndurance:SetShow(false)
    self.effectBG:SetEnable(false)
    if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
    else
      self.panel:SetShow(false)
    end
  end
  local enduranceList = {
    PaGlobalPlayerEnduranceList,
    PaGlobalHorseEnduranceList,
    PaGlobalCarriageEnduranceList,
    PaGlobalShipEnduranceList
  }
  local isRepairShow = false
  for key, value in pairs(enduranceList) do
    if value.effectBG:IsEnable() and false == isRepairShow then
      value.repair_AutoNavi:SetShow(true)
      value.repair_Navi:SetShow(true)
      isRepairShow = true
    else
      value.repair_AutoNavi:SetShow(false)
      value.repair_Navi:SetShow(false)
    end
  end
  FGlobal_Inventory_WeightCheck()
end
function FromClient_PlayerEnduranceUpdate()
  FromClient_EnduranceUpdate(CppEnums.EnduranceType.eEnduranceType_Player)
end
function FromClient_ServantEnduranceUpdate()
  FromClient_EnduranceUpdate(CppEnums.EnduranceType.eEnduranceType_Horse)
  FromClient_EnduranceUpdate(CppEnums.EnduranceType.eEnduranceType_Carriage)
  FromClient_EnduranceUpdate(CppEnums.EnduranceType.eEnduranceType_Ship)
end
function Panel_Endurance_Update()
  FromClient_PlayerEnduranceUpdate()
  FromClient_ServantEnduranceUpdate()
end
function renderModeChange_Panel_Endurance_Update(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  Panel_Endurance_Update()
end
Panel_Endurance_Update()
registerEvent("FromClient_RenderModeChangeState", "renderModeChange_Panel_Endurance_Update")
registerEvent("FromClient_EquipEnduranceChanged", "Panel_Endurance_Update")
registerEvent("EventEquipmentUpdate", "FromClient_PlayerEnduranceUpdate")
registerEvent("EventServantEquipItem", "FromClient_ServantEnduranceUpdate")
registerEvent("EventServantEquipmentUpdate", "FromClient_ServantEnduranceUpdate")
