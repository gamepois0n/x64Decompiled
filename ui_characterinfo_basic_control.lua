local UI_Class = CppEnums.ClassType
local CombatType = CppEnums.CombatResourceType
local BattleSpeed = CppEnums.BattleSpeedType
local Class_BattleSpeed = CppEnums.ClassType_BattleSpeed
local UI_DefaultFaceTexture = CppEnums.ClassType_DefaultFaceTexture
local IM = CppEnums.EProcessorInputMode
local UI_LifeType = CppEnums.LifeExperienceType
local UI_LifeToolTip = CppEnums.LifeExperienceTooltip
local UI_LifeString = CppEnums.LifeExperienceString
local self = PaGlobal_CharacterInfoBasic
function FromClient_UI_CharacterInfo_Basic_TendencyChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local tendency = self._playerGet:getTendency()
  self._ui._staticTextTendency_Value:SetText(tostring(tendency))
end
function FromClient_UI_CharacterInfo_Basic_MentalChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local mental = self._player:getWp()
  local maxMental = self._player:getMaxWp()
  self._ui._staticTextMental_Value:SetText(tostring(mental) .. " / " .. tostring(maxMental))
end
function FromClient_UI_CharacterInfo_Basic_ContributionChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local territoryKeyRaw = ToClient_getDefaultTerritoryKey()
  local contribution = ToClient_getExplorePointByTerritoryRaw(territoryKeyRaw)
  local remainContribution = contribution:getRemainedPoint()
  local aquiredContribution = contribution:getAquiredPoint()
  self._ui._staticTextContribution_Value:SetText(tostring(remainContribution) .. " / " .. tostring(aquiredContribution))
end
function FromClient_UI_CharacterInfo_Basic_LevelChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local ChaLevel = self._playerGet:getLevel()
  self._ui._staticClassSymbol:SetText("Lv " .. tostring(ChaLevel))
end
function FromClient_UI_CharacterInfo_Basic_HpChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local hp = self._playerGet:getHp()
  local maxHp = self._playerGet:getMaxHp()
  local hpRate = hp / maxHp * 100
  self._ui._staticStatus_Value[self._status._health]:SetText(tostring(hp) .. " / " .. tostring(maxHp))
  self._ui._progress2Status[self._status._health]:SetProgressRate(hpRate)
end
function FromClient_UI_CharacterInfo_Basic_MpChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local mp = self._playerGet:getMp()
  local maxMp = self._playerGet:getMaxMp()
  local MpRate = mp / maxMp * 100
  self._ui._staticStatus_Value[self._status._mental]:SetText(tostring(mp) .. " / " .. tostring(maxMp))
  self._ui._progress2Status[self._status._mental]:SetProgressRate(MpRate)
end
function FromClient_UI_CharacterInfo_Basic_WeightChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local _const = Defines.s64_const
  local s64_moneyWeight = self._playerGet:getInventory():getMoneyWeight_s64()
  local s64_equipmentWeight = self._playerGet:getEquipment():getWeight_s64()
  local s64_allWeight = self._playerGet:getCurrentWeight_s64()
  local s64_maxWeight = self._playerGet:getPossessableWeight_s64()
  local s64_allWeight_div = s64_allWeight / _const.s64_100
  local s64_maxWeight_div = s64_maxWeight / _const.s64_100
  local str_AllWeight = string.format("%.1f", Int64toInt32(s64_allWeight_div) / 100)
  local str_MaxWeight = string.format("%.0f", Int64toInt32(s64_maxWeight_div) / 100)
  if s64_allWeight_div <= s64_maxWeight_div then
    self._ui._progress2WeightMoney:SetProgressRate(Int64toInt32(s64_moneyWeight / s64_maxWeight_div))
    self._ui._progress2WeightEquip:SetProgressRate(Int64toInt32((s64_moneyWeight + s64_equipmentWeight) / s64_maxWeight_div))
    self._ui._progress2Status[self._status._weight]:SetProgressRate(Int64toInt32(s64_allWeight / s64_maxWeight_div))
  else
    self._ui._progress2WeightMoney:SetProgressRate(Int64toInt32(s64_moneyWeight / s64_allWeight_div))
    self._ui._progress2WeightEquip:SetProgressRate(Int64toInt32((s64_moneyWeight + s64_equipmentWeight) / s64_allWeight_div))
    self._ui._progress2Status[self._status._weight]:SetProgressRate(Int64toInt32(s64_allWeight / s64_allWeight_div))
  end
  self._ui._staticStatus_Value[self._status._weight]:SetText(tostring(str_AllWeight) .. " / " .. tostring(str_MaxWeight) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
end
function FromClient_UI_CharacterInfo_Basic_AttackChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  ToClient_updateAttackStat()
  local chaAttack = ToClient_getOffence()
  self._ui._staticTextAttack_Value:SetText(tostring(chaAttack))
  local isSetAwakenWeapon = ToClient_getEquipmentItem(CppEnums.EquipSlotNo.awakenWeapon)
  if nil ~= isSetAwakenWeapon then
    local chaAwakenAttack = ToClient_getAwakenOffence()
    self._ui._staticTextAwakenAttack_Title:SetShow(true)
    self._ui._staticTextAwakenAttack_Value:SetText(tostring(chaAwakenAttack))
    self._ui._staticTextDefence_Title:SetSpanSize(385, 395)
    self._ui._staticTextStamina_Title:SetSpanSize(385, 419)
    self._ui._staticTextZodiac_Title:SetSpanSize(385, 515)
    self._ui._staticTextZodiac_Value:SetSpanSize(611, 515)
    self._ui._staticTextTendency_Title:SetSpanSize(385, 540)
    self._ui._staticTextTendency_Value:SetSpanSize(611, 540)
    self._ui._staticTextMental_Title:SetSpanSize(385, 443)
    self._ui._staticTextMental_Value:SetSpanSize(611, 443)
    self._ui._staticTextSkillPoint_Title:SetSpanSize(385, 491)
    self._ui._staticTextSkillPoint_Value:SetSpanSize(611, 491)
    self._ui._staticTextContribution_Title:SetSpanSize(385, 467)
    self._ui._staticTextContribution_Value:SetSpanSize(611, 467)
  else
    self._ui._staticTextAwakenAttack_Title:SetShow(false)
    self._ui._staticTextDefence_Title:SetSpanSize(385, 371)
    self._ui._staticTextStamina_Title:SetSpanSize(385, 395)
    self._ui._staticTextZodiac_Title:SetSpanSize(385, 491)
    self._ui._staticTextZodiac_Value:SetSpanSize(611, 491)
    self._ui._staticTextTendency_Title:SetSpanSize(385, 515)
    self._ui._staticTextTendency_Value:SetSpanSize(611, 515)
    self._ui._staticTextMental_Title:SetSpanSize(385, 419)
    self._ui._staticTextMental_Value:SetSpanSize(611, 419)
    self._ui._staticTextSkillPoint_Title:SetSpanSize(385, 467)
    self._ui._staticTextSkillPoint_Value:SetSpanSize(611, 467)
    self._ui._staticTextContribution_Title:SetSpanSize(385, 443)
    self._ui._staticTextContribution_Value:SetSpanSize(611, 443)
  end
  local chaDefence = ToClient_getDefence()
  self._ui._staticTextDefence_Value:SetText(tostring(chaDefence))
end
function FromClient_UI_CharacterInfo_Basic_StaminaChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local maxStamina = self._playerGet:getStamina():getMaxSp()
  self._ui._staticTextStamina_Value:SetText(tostring(maxStamina))
end
function FromClient_UI_CharacterInfo_Basic_SkillPointChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local skillPointInfo = ToClient_getSkillPointInfo(0)
  if nil ~= skillPointInfo then
    self._ui._staticTextSkillPoint_Value:SetText(tostring(skillPointInfo._remainPoint .. " / " .. skillPointInfo._acquirePoint))
  end
end
function FromClient_UI_CharacterInfo_Basic_FamilyPointsChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local battleFP = self._playerGet:getBattleFamilyPoint()
  local lifeFP = self._playerGet:getLifeFamilyPoint()
  local etcFP = self._playerGet:getEtcFamilyPoint()
  local sumFP = battleFP + lifeFP + etcFP
  self._ui._staticTextFamilyPoints[self._familyPoint._family]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FAMILYPOINT_TITLE", "familyPoint", tostring(sumFP)))
  self._ui._staticTextFamilyPoints[self._familyPoint._combat]:SetText(tostring(battleFP))
  self._ui._staticTextFamilyPoints[self._familyPoint._life]:SetText(tostring(lifeFP))
  self._ui._staticTextFamilyPoints[self._familyPoint._etc]:SetText(tostring(etcFP))
end
function FromClient_UI_CharacterInfo_Basic_ResistChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local data = {
    [self._regist._sturn] = self._player:getStunResistance(),
    [self._regist._down] = self._player:getKnockdownResistance(),
    [self._regist._capture] = self._player:getCatchResistance(),
    [self._regist._knockBack] = self._player:getKnockbackResistance()
  }
  for key, index in pairs(self._regist) do
    self._ui._progress2Resist[index]:SetProgressRate(math.floor(data[index] / 10000))
    self._ui._staticTextResist_Percent[index]:SetText(math.floor(data[index] / 10000) .. "%")
  end
end
function FromClient_UI_CharacterInfo_Basic_CraftLevelChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local LifeIcon = {
    [UI_LifeType.gather] = {
      "new_ui_common_forlua/default/default_etc_02.dds",
      159,
      1,
      169,
      11
    },
    [UI_LifeType.fishing] = {
      "new_ui_common_forlua/default/default_etc_02.dds",
      214,
      1,
      224,
      11
    },
    [UI_LifeType.hunting] = {
      "new_ui_common_forlua/default/default_etc_02.dds",
      225,
      1,
      235,
      11
    },
    [UI_LifeType.cooking] = {
      "new_ui_common_forlua/default/default_etc_02.dds",
      181,
      1,
      191,
      11
    },
    [UI_LifeType.alchemy] = {
      "new_ui_common_forlua/default/default_etc_02.dds",
      203,
      1,
      213,
      11
    },
    [UI_LifeType.manufacture] = {
      "new_ui_common_forlua/default/default_etc_02.dds",
      170,
      1,
      180,
      11
    },
    [UI_LifeType.training] = {
      "new_ui_common_forlua/default/default_etc_02.dds",
      192,
      1,
      202,
      11
    },
    [UI_LifeType.trade] = {
      "new_ui_common_forlua/default/default_etc_02.dds",
      236,
      1,
      246,
      11
    },
    [UI_LifeType.growth] = {
      "new_ui_common_forlua/default/default_etc_02.dds",
      159,
      12,
      169,
      22
    }
  }
  local isSailOpen = ToClient_IsContentsGroupOpen("83")
  if isSailOpen then
    LifeIcon[UI_LifeType.sail] = {
      "new_ui_common_forlua/default/default_etc_02.dds",
      170,
      12,
      180,
      22
    }
  end
  for index = 0, #LifeIcon + 1 do
    local tableIdx = index + 1
    self._craftTable[tableIdx]._type = index
    self._craftTable[tableIdx]._level = self._playerGet:getLifeExperienceLevel(self._craftTable[tableIdx]._type)
    self._craftTable[tableIdx]._exp = self._playerGet:getCurrLifeExperiencePoint(self._craftTable[tableIdx]._type)
    self._craftTable[tableIdx]._maxExp = self._playerGet:getDemandLifeExperiencePoint(self._craftTable[tableIdx]._type)
    self._sortCraftTable[tableIdx] = self._craftTable[tableIdx]
    self._ui._staticCraftIcon[index]:SetShow(true)
  end
  table.sort(self._sortCraftTable, function(a, b)
    return a._level > b._level or a._level == b._level and a._exp > b._exp
  end)
  for index = 0, #LifeIcon do
    local tableIdx = index + 1
    local crafType = self._craftTable[tableIdx]._type
    self._ui._staticCraftIcon[tableIdx]:ChangeTextureInfoName(LifeIcon[crafType][1])
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._staticCraftIcon[tableIdx], LifeIcon[crafType][2], LifeIcon[crafType][3], LifeIcon[crafType][4], LifeIcon[crafType][5])
    self._ui._staticCraftIcon[tableIdx]:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._staticCraftIcon[tableIdx]:setRenderTexture(self._ui._staticCraftIcon[tableIdx]:getBaseTexture())
    self._ui._staticTextCraft_Title[tableIdx]:SetText(UI_LifeString[crafType])
    self._ui._staticTextCraft_Level[tableIdx]:SetText(FGlobal_UI_CharacterInfo_Basic_Global_CraftLevelReplace(self._craftTable[tableIdx]._level))
    self._ui._staticTextCraft_Level[tableIdx]:SetFontColor(FGlobal_UI_CharacterInfo_Basic_Global_CraftColorReplace(self._craftTable[tableIdx]._level))
    local ExpRate = Int64toInt32(self._craftTable[tableIdx]._exp * toInt64(0, 100) / self._craftTable[tableIdx]._maxExp)
    self._ui._progress2Craft[tableIdx]:SetProgressRate(ExpRate)
    self._ui._staticTextCraft_Percent[tableIdx]:SetText(ExpRate .. "%")
    self._ui._staticTextCraft_Percent[tableIdx]:SetFontColor(FGlobal_UI_CharacterInfo_Basic_Global_CraftColorReplace(self._craftTable[tableIdx]._level))
    if isGameTypeTH() or isGameTypeID() then
      self._ui._staticTextCraft_Level[tableIdx]:SetSpanSize(80, -3)
      self._ui._staticTextCraft_Percent[tableIdx]:SetShow(false)
    end
  end
  local crafType = self._sortCraftTable[1]._type
  self._ui._staticCraftIcon[0]:ChangeTextureInfoName(LifeIcon[crafType][1])
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._staticCraftIcon[0], LifeIcon[crafType][2], LifeIcon[crafType][3], LifeIcon[crafType][4], LifeIcon[crafType][5])
  self._ui._staticCraftIcon[0]:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._staticCraftIcon[0]:setRenderTexture(self._ui._staticCraftIcon[0]:getBaseTexture())
  self._ui._staticTextCraft_Title[0]:SetText(UI_LifeString[crafType])
  self._ui._staticTextCraft_Level[0]:SetText(FGlobal_UI_CharacterInfo_Basic_Global_CraftLevelReplace(self._sortCraftTable[1]._level))
  self._ui._staticTextCraft_Level[0]:SetFontColor(FGlobal_UI_CharacterInfo_Basic_Global_CraftColorReplace(self._sortCraftTable[1]._level))
  local ExpRate = Int64toInt32(self._sortCraftTable[1]._exp * toInt64(0, 100) / self._sortCraftTable[1]._maxExp)
  self._ui._progress2Craft[0]:SetProgressRate(ExpRate)
  self._ui._staticTextCraft_Percent[0]:SetText(ExpRate .. "%")
  self._ui._staticTextCraft_Percent[0]:SetFontColor(FGlobal_UI_CharacterInfo_Basic_Global_CraftColorReplace(self._sortCraftTable[1]._level))
  self._requestRank = true
end
function FromClient_UI_CharacterInfo_Basic_RankChanged()
  if self._requestRank == false then
    return
  end
  self._requestRank = false
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local bestRank = ToClient_GetLifeMyRank()
  if bestRank > 0 and bestRank < 31 then
    local bestTitle = UI_LifeString[self._sortCraftTable[1]._type] .. "( " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LIFERANKING_RANK", "listIdx", bestRank) .. " )"
    self._ui._staticTextCraft_Title[0]:SetText(bestTitle)
  end
end
function FromClient_UI_CharacterInfo_Basic_PotentialChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local levelText = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_POTENLEVEL")
  local classType = self._player:getClassType()
  local currentData = {
    [self._potential._moveSpeed] = self._player:characterStatPointSpeed(self._potential._moveSpeed),
    [self._potential._attackSpeed] = self._player:characterStatPointSpeed(self._potential._attackSpeed + Class_BattleSpeed[classType]),
    [self._potential._critical] = self._player:characterStatPointCritical(),
    [self._potential._fishTime] = self._player:getCharacterStatPointFishing(),
    [self._potential._product] = self._player:getCharacterStatPointCollection(),
    [self._potential._dropChance] = self._player:getCharacterStatPointDropItem()
  }
  local limitData = {
    [self._potential._moveSpeed] = self._player:characterStatPointLimitedSpeed(self._potential._moveSpeed),
    [self._potential._attackSpeed] = self._player:characterStatPointLimitedSpeed(self._potential._attackSpeed + Class_BattleSpeed[classType]),
    [self._potential._critical] = self._player:characterStatPointLimitedCritical(),
    [self._potential._fishTime] = self._player:getCharacterStatPointLimitedFishing(),
    [self._potential._product] = self._player:getCharacterStatPointLimitedCollection(),
    [self._potential._dropChance] = self._player:getCharacterStatPointLimitedDropItem()
  }
  for key, index in pairs(self._potential) do
    if limitData[index] < currentData[index] then
      currentData[index] = limitData[index]
    end
    if index < 2 then
      self._ui._staticTextPotential_Value[index]:SetText(tostring(currentData[index] - 5) .. " " .. levelText)
      for slotIndex = 0, 4 do
        self._ui._staticPotencialPlusGrade[index][slotIndex]:SetShow(slotIndex < currentData[index] - 5)
      end
    else
      self._ui._staticTextPotential_Value[index]:SetText(tostring(currentData[index]) .. " " .. levelText)
      for slotIndex = 0, 4 do
        self._ui._staticPotencialPlusGrade[index][slotIndex]:SetShow(slotIndex < currentData[index])
      end
    end
    if isGameTypeTH() or isGameTypeID() then
      self._ui._staticTextPotential_Value[index]:SetShow(false)
    end
  end
end
function FromClient_UI_CharacterInfo_Basic_FitnessChanged(addSp, addWeight, addHp, addMp)
  if addSp > 0 then
    FGlobal_FitnessLevelUp(addSp, addWeight, addHp, addMp, self._fitness._stamina)
  elseif addWeight > 0 then
    FGlobal_FitnessLevelUp(addSp, addWeight, addHp, addMp, self._fitness._strength)
  elseif addHp > 0 or addMp > 0 then
    FGlobal_FitnessLevelUp(addSp, addWeight, addHp, addMp, self._fitness._health)
  end
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local titleString = {
    [self._fitness._stamina] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STAMINA_TITLE"),
    [self._fitness._strength] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STRENGTH_TITLE"),
    [self._fitness._health] = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_HEALTH_TITLE")
  }
  for key, index in pairs(self._fitness) do
    local current = Int64toInt32(self._playerGet:getCurrFitnessExperiencePoint(index))
    local max = Int64toInt32(self._playerGet:getDemandFItnessExperiencePoint(index))
    local rate = current / max * 100
    local level = self._playerGet:getFitnessLevel(index)
    self._ui._progress2Fitness[index]:SetProgressRate(rate)
    self._ui._staticTextFitness_Level[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_CRAFTLEVEL") .. tostring(level))
    if index ~= self._fitness._strength then
      self._ui._staticTextFitness_Title[index]:SetText(titleString[index] .. tostring(ToClient_GetFitnessLevelStatus(index)))
    else
      self._ui._staticTextFitness_Title[index]:SetText(titleString[index] .. tostring(ToClient_GetFitnessLevelStatus(index) / 10000))
    end
  end
end
function FromClient_UI_CharacterInfo_Basic_NormalStackChanged()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  local defaultCount = self._playerGet:getEnchantFailCount()
  local valksCount = self._playerGet:getEnchantValuePackCount()
  if ToClient_IsReceivedEnchantFailCount() then
    self._ui._staticTextNormalStack:SetText(defaultCount + valksCount)
  else
    self._ui._staticTextNormalStack:SetText("-")
  end
  self._ui._staticTextNormalStack:addInputEvent("Mouse_On", "PaGlobal_CharacterInfoBasic:handleMouseOver_NormalStack( " .. defaultCount .. "," .. valksCount .. ", true )")
  self._ui._staticTextNormalStack:addInputEvent("Mouse_Out", "PaGlobal_CharacterInfoBasic:handleMouseOver_NormalStack( " .. defaultCount .. "," .. valksCount .. ", false )")
end
function FromClient_UI_CharacterInfo_Basic_ScreenResize()
  Panel_Window_CharInfo_Status:SetPosX(5)
  Panel_Window_CharInfo_Status:SetPosY(getScreenSizeY() / 2 - Panel_Window_CharInfo_Status:GetSizeY() / 2)
end
function PaGlobal_CharacterInfoBasic:handleClicked_FacePhotoButton()
  self:handleMouseOver_FacePhotoButton(false)
  FGlobal_InGameCustomize_SetCharacterInfo(true)
  IngameCustomize_Show()
end
function PaGlobal_CharacterInfoBasic:handleClicked_Introduce()
  SetFocusEdit(self._ui._multilineEdit)
  self._ui._multilineEdit:SetEditText(self._ui._multilineEdit:GetEditText(), true)
end
function PaGlobal_CharacterInfoBasic:handleClicked_SetIntroduce()
  local msg = self._ui._multilineEdit:GetEditText()
  ToClient_RequestSetUserIntroduction(msg)
  local oneLineMsg = string.gsub(msg, "\n", " ")
  self._ui._multilineEditIntroduce:SetEditText(oneLineMsg)
  ClearFocusEdit()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_MYINTRODUCE_REGIST"))
  self:showIntroduce(false)
end
function PaGlobal_CharacterInfoBasic:handleClicked_ResetIntroduce()
  local msg = ""
  self._ui._multilineEdit:SetEditText(msg)
  ToClient_RequestSetUserIntroduction(msg)
  local oneLineMsg = string.gsub(msg, "\n", " ")
  self._ui._multilineEditIntroduce:SetEditText(oneLineMsg)
  ClearFocusEdit()
end
function PaGlobal_CharacterInfoBasic:handleMouseOver_FacePhotoButton(isShow)
  if self:checkToolTip(isShow) == false then
    return
  end
  local uiControl, name, desc
  uiControl = self._ui._buttonFacePhoto
  name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_FACEPHOTO_TOOLTIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_FACEPHOTO_TOOLTIP_DESC")
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobal_CharacterInfoBasic:handleMouseOver_FamilyPoints(isShow, tipType)
  if self:checkToolTip(isShow) == false then
    return
  end
  local string = {
    [self._familyPoint._family] = {
      "LUA_FAMILYPOINTS_SUM_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_SUM_TOOLTIP_DESC"
    },
    [self._familyPoint._combat] = {
      "LUA_FAMILYPOINTS_COMBAT_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_COMBAT_TOOLTIP_DESC"
    },
    [self._familyPoint._life] = {
      "LUA_FAMILYPOINTS_LIFE_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_LIFE_TOOLTIP_DESC"
    },
    [self._familyPoint._etc] = {
      "LUA_FAMILYPOINTS_ETC_TOOLTIP_TITLE",
      "LUA_FAMILYPOINTS_ETC_TOOLTIP_DESC"
    }
  }
  local uiControl = self._ui._staticTextFamilyPoints[tipType]
  local name = PAGetString(Defines.StringSheet_GAME, string[tipType][1])
  local desc = PAGetString(Defines.StringSheet_GAME, string[tipType][2])
  registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobal_CharacterInfoBasic:handleMouseOver_NormalStack(defaultCount, valksCount, isShow)
  if self:checkToolTip(isShow) == false then
    return
  end
  local uiControl, name, desc, isValksItemCheck
  local isValksItem = ToClient_IsContentsGroupOpen("47")
  if isValksItem == false then
    isValksItemCheck = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENCHANTCOUNT_TOOLTIP_ADDCOUNT_NONE", "defaultCount", tostring(defaultCount))
  else
    isValksItemCheck = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENCHANTCOUNT_TOOLTIP", "defaultCount", tostring(defaultCount), "valksCount", tostring(valksCount))
  end
  uiControl = self._ui._staticTextNormalStack
  name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_DESC") .. isValksItemCheck
  registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobal_CharacterInfoBasic:handleMouseOver_Regist(isShow, tipType)
  if self:checkToolTip(isShow) == false then
    return
  end
  local string = {
    [self._regist._sturn] = {
      "LUA_CHARACTERINFO_TXT_REGIST_STUN_TOOLTIP_NAME",
      "LUA_CHARACTERINFO_TXT_REGIST_STUN_TOOLTIP_DESC"
    },
    [self._regist._down] = {
      "LUA_CHARACTERINFO_TXT_REGIST_DOWN_TOOLTIP_NAME",
      "LUA_CHARACTERINFO_TXT_REGIST_DOWN_TOOLTIP_DESC"
    },
    [self._regist._capture] = {
      "LUA_CHARACTERINFO_TXT_REGIST_CAPTURE_TOOLTIP_NAME",
      "LUA_CHARACTERINFO_TXT_REGIST_CAPTURE_TOOLTIP_DESC"
    },
    [self._regist._knockBack] = {
      "LUA_CHARACTERINFO_TXT_REGIST_KNOCKBACK_TOOLTIP_NAME",
      "LUA_CHARACTERINFO_TXT_REGIST_KNOCKBACK_TOOLTIP_DESC"
    }
  }
  local uiControl, name, desc
  uiControl = self._ui._staticTextResist_Title[tipType]
  name = PAGetString(Defines.StringSheet_GAME, string[tipType][1])
  desc = PAGetString(Defines.StringSheet_GAME, string[tipType][2])
  registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobal_CharacterInfoBasic:handleMouseOver_Fitness(isShow, _tipType)
  if self:checkToolTip(isShow) == false then
    return
  end
  local uiControl, name, desc
  if self._fitness._stamina == _tipType then
    uiControl = self._ui._staticTextFitness_Title[self._fitness._stamina]
    name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_FITNESS_STAMINA_MSG", "type", tostring(ToClient_GetFitnessLevelStatus(_tipType)))
  elseif self._fitness._strength == _tipType then
    uiControl = self._ui._staticTextFitness_Title[self._fitness._strength]
    name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_FITNESS_STRENGTH_MSG", "type", tostring(ToClient_GetFitnessLevelStatus(_tipType) / 10000))
  elseif self._fitness._health == _tipType then
    uiControl = self._ui._staticTextFitness_Title[self._fitness._health]
    name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFCHARACTERINFO_FITNESS_HEALTH_MSG", "type", tostring(ToClient_GetFitnessLevelStatus(_tipType)))
  else
    return
  end
  registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobal_CharacterInfoBasic:handleMouseOver_Potential(isShow, _tipType)
  if self:checkToolTip(isShow) == false then
    return
  end
  local classType = self._player:getClassType()
  local string = {
    [self._potential._attackSpeed] = "LUA_CHARACTERINFO_TXT_DESC_" .. Class_BattleSpeed[classType],
    [self._potential._moveSpeed] = "LUA_CHARACTERINFO_TXT_DESC_2",
    [self._potential._critical] = "LUA_CHARACTERINFO_TXT_DESC_3",
    [self._potential._fishTime] = "LUA_CHARACTERINFO_TXT_DESC_4",
    [self._potential._product] = "LUA_CHARACTERINFO_TXT_DESC_5",
    [self._potential._dropChance] = "LUA_CHARACTERINFO_TXT_DESC_6"
  }
  local uiControl, name, desc
  uiControl = self._ui._staticTextPotential_Title[_tipType]
  name = PAGetString(Defines.StringSheet_GAME, string[_tipType])
  registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobal_CharacterInfoBasic:handleMouseOver_CharInfomation(isShow, _tipType)
  if self:checkToolTip(isShow) == false then
    return
  end
  local uiControl, name, desc
  uiControl = self._ui._staticStatus_Title[_tipType]
  if self._status._health == _tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_HPREGEN") .. " : " .. tostring(self._playerGet:getRegenHp())
  elseif self._status._mental == _tipType then
    local mentalType = self._player:getCombatResourceType()
    if CombatType.CombatType_MP == mentalType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_MPREGEN") .. " : " .. tostring(self._playerGet:getRegenMp())
    elseif CombatType.CombatType_FP == mentalType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_FPREGEN") .. " : " .. tostring(self._playerGet:getRegenMp())
    elseif CombatType.CombatType_EP == mentalType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_EPREGEN") .. " : " .. tostring(self._playerGet:getRegenMp())
    elseif CombatType.CombatType_BP == mentalType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_BPREGEN") .. " : " .. tostring(self._playerGet:getRegenMp())
    end
  elseif self._status._weight == _tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_WEIGHT_TOOLTIP")
  end
  registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobal_CharacterInfoBasic:handleMouseOver_Craft(isShow, _slotNo)
  if self:checkToolTip(isShow) == false then
    return
  end
  if 0 == _slotNo then
    return
  end
  local tableNo = _slotNo + 1
  local uiControl, name, desc
  uiControl = self._ui._staticTextCraft_Title[_slotNo]
  name = UI_LifeToolTip[self._craftTable[_slotNo]._type]
  registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobal_CharacterInfoBasic:showWindow()
  self:showIntroduce(false)
  self:update()
end
function PaGlobal_CharacterInfoBasic:hideWindow()
  TooltipSimple_Hide()
  self._toolTipCount = 0
end
function PaGlobal_CharacterInfoBasic:showIntroduce(isShow)
  self._ui._staticIntroduceBG:SetShow(isShow)
  if not isShow then
    UI.ClearFocusEdit()
    return
  end
  local msg = ToClient_GetUserIntroduction()
  self._ui._multilineEdit:SetEditText(msg)
end
function PaGlobal_CharacterInfoBasic:checkToolTip(isShow)
  if false == isShow then
    self._toolTipCount = self._toolTipCount - 1
    if self._toolTipCount < 1 then
      self._toolTipCount = 0
      TooltipSimple_Hide()
    end
    return false
  else
    self._toolTipCount = self._toolTipCount + 1
    return true
  end
end
function PaGlobal_CharacterInfoBasic:updateFacePhoto()
  local classType = self._player:getClassType()
  local TextureName = ToClient_GetCharacterFaceTexturePath(self._player:getCharacterNo_64())
  local isCaptureExist = self._ui._staticCharSlot:ChangeTextureInfoNameNotDDS(TextureName, classType, true)
  if isCaptureExist == true then
    self._ui._staticCharSlot:getBaseTexture():setUV(0, 0, 1, 1)
  else
    local DefaultFace = UI_DefaultFaceTexture[classType]
    self._ui._staticCharSlot:ChangeTextureInfoName(DefaultFace[1])
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._staticCharSlot, DefaultFace[2], DefaultFace[3], DefaultFace[4], DefaultFace[5])
    self._ui._staticCharSlot:getBaseTexture():setUV(x1, y1, x2, y2)
  end
  self._ui._staticCharSlot:setRenderTexture(self._ui._staticCharSlot:getBaseTexture())
end
