function PaGlobal_Enchant:setNeedPerfectEnchantItemCount(needCount, enchantCount, enchantItemClassify)
  self._uiHelpPerfectEnchant:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
  if needCount > 0 then
    self._uiHelpPerfectEnchant:SetShow(true)
    self._uiHelpPerfectEnchant:SetNotAbleMasking(true)
    local needEnchantStone = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_KIND_OF_STONE_0") .. " "
    if enchantCount < 15 and (1 == enchantItemClassify or 2 == enchantItemClassify) then
      needEnchantStone = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_KIND_OF_STONE_1") .. " "
    elseif enchantCount < 15 and 3 == enchantItemClassify then
      needEnchantStone = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_KIND_OF_STONE_2") .. " "
    elseif enchantCount >= 15 and (1 == enchantItemClassify or 2 == enchantItemClassify) then
      needEnchantStone = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_KIND_OF_STONE_3") .. " "
    elseif enchantCount >= 15 and 3 == enchantItemClassify then
      needEnchantStone = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_KIND_OF_STONE_4") .. " "
    end
    self._uiHelpPerfectEnchant:SetText(needEnchantStone .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_BLACKSTONE_COUNT", "needCount", needCount) .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_DECREASEENDURANCE_PERFECTENCHANT", "enchantPerfectEnduranceValue", self._enchantPerfectEnduranceValue))
    local boxSizeY = self._uiHelpPerfectEnchant:GetTextSizeY() + 30
    if boxSizeY < 70 then
      boxSizeY = 70
    end
    self.savedBoxSizeY = boxSizeY
    self._uiHelpPerfectEnchant:SetSize(self._uiHelpPerfectEnchant:GetSizeX() + self._Xgap, boxSizeY)
  else
    local needEnchantStone = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_KIND_OF_STONE_0") .. " "
    if enchantCount < 15 and (1 == enchantItemClassify or 2 == enchantItemClassify) then
      needEnchantStone = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_KIND_OF_STONE_1") .. " "
    elseif enchantCount < 15 and 3 == enchantItemClassify then
      needEnchantStone = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_KIND_OF_STONE_2") .. " "
    elseif enchantCount >= 15 and (1 == enchantItemClassify or 2 == enchantItemClassify) then
      needEnchantStone = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_KIND_OF_STONE_3") .. " "
    elseif enchantCount >= 15 and 3 == enchantItemClassify then
      needEnchantStone = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_KIND_OF_STONE_4") .. " "
    end
    self._uiHelpPerfectEnchant:SetText(needEnchantStone .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_BLACKSTONE_COUNT", "needCount", needCount) .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_DECREASEENDURANCE_PERFECTENCHANT", "enchantPerfectEnduranceValue", self._enchantPerfectEnduranceValue))
    local boxSizeY = self._uiHelpPerfectEnchant:GetTextSizeY() + 30
    if boxSizeY < 70 then
      boxSizeY = 70
    end
    self._uiHelpPerfectEnchant:SetShow(false)
    self._uiHelpPerfectEnchant:SetSize(220, boxSizeY)
  end
  self._uiHelpPerfectEnchant:SetPosY(self._uiButtonSureSuccess:GetPosY() - self._uiHelpPerfectEnchant:GetSizeY())
end
function PaGlobal_Enchant:clear()
  self._uiHelpPerfectEnchant:SetShow(false)
  self._uiHelpPerfectEnchant:SetSize(220, self.savedBoxSizeY)
  self._slotTargetItem:clearItem()
  self._slotTargetItem.empty = true
  self._slotTargetItem.slotNo = nil
  self._slotTargetItem.inventoryType = nil
  self._slotEnchantItem:clearItem()
  self._slotEnchantItem.empty = true
  self._slotEnchantItem.slotNo = nil
  self._slotEnchantItem.inventoryType = nil
  self._slotEnchantItem.icon:EraseAllEffect()
  self._uiButtonApply:EraseAllEffect()
  self._uiButtonSureSuccess:EraseAllEffect()
  self._uiButtonApply:SetIgnore(true)
  self._uiButtonApply:SetMonoTone(true)
  self._uiButtonSureSuccess:SetIgnore(true)
  self._uiButtonSureSuccess:SetShow(true)
  self._isStartEnchantNormal = false
  self._isStartEnchantSureSuccess = false
  self._isDoingEnchant = false
  self._uiButtonApply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_DOENCHANT"))
  self._uiDrasticEnchant:SetCheck(true)
  self._uiMeticulousEnchant:SetCheck(false)
  self._uiDrasticEnchant:SetShow(false)
  self._uiMeticulousEnchant:SetShow(false)
  self._uiDrasticEnchant:SetIgnore(self._isDoingEnchant)
  self._uiMeticulousEnchant:SetIgnore(self._isDoingEnchant)
  self._uiCheckBtn_CronEnchnt:SetMonoTone(true)
  self._uiCheckBtn_CronEnchnt:SetIgnore(true)
  self._uiHelpEnchantBtn:SetShow(false)
  local dummy, cronCount = self:protectItemCount()
  self._uiProtectItem_Count:SetText(tostring(cronCount) .. "/" .. tostring(0))
  FGlobal_EnchantArrowSet(true)
  getEnchantInformation():ToClient_clearData()
  self._uiProtectItem_Btn:SetIgnore(true)
  self._uiProtectItem_Btn:SetMonoTone(true)
  self._isCronEnchant = false
end
function PaGlobal_Enchant:isDoingEnchant()
  return self._isDoingEnchant
end
function PaGlobal_Enchant:protectItemCount()
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local useStartSlot = inventorySlotNoUserStart()
  local normalInventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eInventory)
  local invenUseSize = selfPlayer:getInventorySlotCount(false)
  local protectItemSSW = FromClient_getPreventDownGradeItem()
  if nil ~= protectItemSSW then
    local protectItemName = protectItemSSW:getName()
    local protectItemSlotNo
    local protectItemCounts = 0
    for idx = useStartSlot, invenUseSize - 1 do
      local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, idx)
      if nil ~= itemWrapper then
        local itemSSW = itemWrapper:getStaticStatus()
        local itemName = itemSSW:getName()
        if protectItemName == itemName then
          protectItemSlotNo = idx
          protectItemCounts = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, idx):get():getCount_s64()
          break
        end
      end
    end
    if nil ~= protectItemSlotNo then
      return protectItemSlotNo, protectItemCounts
    else
      return protectItemSlotNo, toInt64(0, 0)
    end
  end
end
function PaGlobal_Enchant:setProtectItem(itemKey, enchantLevel)
  local itemSSW = FromClient_getPreventDownGradeItem()
  if nil ~= itemSSW then
    local name = itemSSW:getName()
    self._uiProtectItem_Icon:ChangeTextureInfoName("Icon/" .. itemSSW:getIconPath())
    local needCount = toInt64(0, 0)
    local haveCount = toInt64(0, 0)
    if nil ~= itemKey then
      needCount = getEnchantInformation():getNeedCountPreventDownGradeItem(itemKey)
    end
    self._protectItem_SlotNo, haveCount = self:protectItemCount()
    self._uiProtectItem_Btn:SetIgnore(true)
    self._uiProtectItem_Btn:SetMonoTone(true)
    if needCount > haveCount then
      haveCount = "<PAColor0xFFF26A6A>" .. tostring(haveCount) .. "<PAOldColor>"
      if self._uiProtectItem_Btn:IsCheck() then
        self._uiProtectItem_Btn:SetCheck(false)
      end
      self._isEnableProtect = false
    else
      self._isEnableProtect = true
    end
    if nil ~= enchantLevel then
      if enchantLevel > 15 or 4 == self._enchantClassifyValue then
        self._uiProtectItem_Btn:SetIgnore(false)
        self._uiProtectItem_Btn:SetMonoTone(false)
      else
        self._uiProtectItem_Btn:SetIgnore(true)
        self._uiProtectItem_Btn:SetMonoTone(true)
      end
    end
    self._uiProtectItem_Count:SetText(tostring(haveCount) .. "/" .. tostring(needCount))
    self._uiProtectItem_Icon:addInputEvent("Mouse_On", "HandleMOnoutProtectItemToolTip( true )")
    self._uiProtectItem_Icon:addInputEvent("Mouse_Out", "HandleMOnoutProtectItemToolTip( false )")
    self._uiProtectItem_Icon:setTooltipEventRegistFunc("HandleMOnoutProtectItemToolTip( true )")
  end
end
function HandleMOnoutProtectItemToolTip(isShow)
  local self = PaGlobal_Enchant
  local itemSSW = FromClient_getPreventDownGradeItem()
  if isShow then
    registTooltipControl(self._uiProtectItem_Icon, Panel_Tooltip_Item)
    Panel_Tooltip_Item_Show(itemSSW, self._uiProtectItem_Icon, true, false, nil, nil, nil)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function FGlobal_EnchantMaterialSlotCheck()
  local self = PaGlobal_Enchant
  if self._uiProtectItem_Btn:IsCheck() then
    if not self._slotEnchantItem.empty then
      local itemWrapper = getInventoryItemByType(self._slotEnchantItem.inventoryType, self._slotEnchantItem.slotNo)
      if nil ~= itemWrapper then
        local protectItemSSW = FromClient_getPreventDownGradeItem()
        if protectItemSSW:getName() == itemWrapper:getStaticStatus():getName() then
          self._slotEnchantItem.inventoryType = nil
          self._slotEnchantItem.slotNo = nil
          self._slotEnchantItem:clearItem()
          self._slotEnchantItem.empty = true
          self._uiButtonApply:SetIgnore(true)
          self._uiButtonApply:SetMonoTone(true)
          self._uiButtonApply:SetFontColor(Defines.Color.C_FF626262)
        end
      end
    end
    local itemWrapper = getInventoryItemByType(self._slotTargetItem.inventoryType, self._slotTargetItem.slotNo)
    if nil ~= itemWrapper then
      local enchantCount = itemWrapper:get():getKey():getEnchantLevel()
      local itemKey = itemWrapper:getStaticStatus():get()._key
      local needCount = getEnchantInformation():getNeedCountPreventDownGradeItem(itemKey)
      local dummy, cronCount = self:protectItemCount()
      self._enchantLevel = enchantCount
      self._uiProtectItem_Count:SetText(tostring(cronCount) .. "/" .. tostring(needCount))
      Inventory_SetFunctor(EnchantInvenFilerSubItem, EnchantInteractionFromInventory, Enchant_Close, nil)
    end
  end
end
function FGlobal_EnchantArrowSet(isTop)
  local self = PaGlobal_Enchant
  if isTop then
    self._uiCronDescArrow:SetPosY(232)
  else
    self._uiCronDescArrow:SetPosY(210)
    self:SetCronDesc()
  end
  if self._isContentsEnable then
    self._uiProtectItem_Desc:SetShow(true)
    if not isTop then
      self._uiProtectItem_Desc:SetShow(false)
    end
  else
    self._uiProtectItem_Desc:SetShow(false)
  end
  self:CronDescSetShow(not isTop)
end
function PaGlobal_Enchant:CronDescSetShow(isShow)
  self._uiCron_StackCount:SetShow(isShow)
  self._uiCron_ProgressBg:SetShow(isShow)
  self._uiCron_Progress:SetShow(isShow)
  self._uiCron_StackGrade[0]:SetShow(isShow)
  self._uiCron_StackGrade[1]:SetShow(isShow)
  self._uiCron_StackGrade[2]:SetShow(isShow)
  self._uiCron_StackGrade[3]:SetShow(isShow)
  self._uiCron_StackCountValue[0]:SetShow(isShow)
  self._uiCron_StackCountValue[1]:SetShow(isShow)
  self._uiCron_StackCountValue[2]:SetShow(isShow)
  self._uiCron_StackCountValue[3]:SetShow(isShow)
  self._uiCron_AddValue:SetShow(isShow)
end
function PaGlobal_Enchant:SetCronDesc()
  local itemWrapper = getInventoryItemByType(self._slotTargetItem.inventoryType, self._slotTargetItem.slotNo)
  local bonusText = ""
  if nil == itemWrapper then
    self._uiCron_StackCount:SetText("0")
    self._uiCron_AddValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_CRONSTONE_APPLY_NONE"))
    self._uiCron_Progress:SetProgressRate(0)
    for gradeIndex = 0, 3 do
      self._uiCron_StackCountValue[gradeIndex]:SetFontColor(Defines.Color.C_FFC4BEBE)
      self._uiCron_StackGrade[gradeIndex]:SetFontColor(Defines.Color.C_FFC4BEBE)
    end
  else
    local currentEnchantFailCount = itemWrapper:getCronEnchantFailCount()
    if currentEnchantFailCount > 0 then
      if 0 < itemWrapper:getAddedDD() then
        if "" == bonusText then
          bonusText = bonusText .. PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_ATTACK") .. itemWrapper:getAddedDD()
        else
          bonusText = bonusText .. PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_ATTACKB") .. itemWrapper:getAddedDD()
        end
      end
      if 0 < itemWrapper:getAddedHIT() then
        if "" == bonusText then
          bonusText = bonusText .. PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_HIT") .. itemWrapper:getAddedHIT()
        else
          bonusText = bonusText .. PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_HITB") .. itemWrapper:getAddedHIT()
        end
      end
      if 0 < itemWrapper:getAddedDV() then
        if "" == bonusText then
          bonusText = bonusText .. PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_DODGE") .. itemWrapper:getAddedDV()
        else
          bonusText = bonusText .. PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_DODGEB") .. itemWrapper:getAddedDV()
        end
      end
      if 0 < itemWrapper:getAddedPV() then
        if "" == bonusText then
          bonusText = bonusText .. PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_REDUCE") .. itemWrapper:getAddedPV()
        else
          bonusText = bonusText .. PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_REDUCEB") .. itemWrapper:getAddedPV()
        end
      end
      if 0 < itemWrapper:getAddedMaxHP() then
        if "" == bonusText then
          bonusText = bonusText .. PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_HP") .. itemWrapper:getAddedMaxHP()
        else
          bonusText = bonusText .. PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_HPB") .. itemWrapper:getAddedMaxHP()
        end
      end
      if 0 < itemWrapper:getAddedMaxMP() then
        if "" == bonusText then
          bonusText = bonusText .. PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_MP") .. itemWrapper:getAddedMaxMP()
        else
          bonusText = bonusText .. PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_CRONENCHANT_MPB") .. itemWrapper:getAddedMaxMP()
        end
      end
      if "" == bonusText then
        bonusText = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_CRONSTONE_NONE")
      end
    else
      self._uiCron_StackCount:SetText("0")
      self._uiCron_AddValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_CRONSTONE_APPLY_NONE"))
      self._uiCron_Progress:SetProgressRate(0)
      for gradeIndex = 0, 3 do
        self._uiCron_StackCountValue[gradeIndex]:SetFontColor(Defines.Color.C_FFC4BEBE)
        self._uiCron_StackGrade[gradeIndex]:SetFontColor(Defines.Color.C_FFC4BEBE)
      end
    end
    local itemSSW = itemWrapper:getStaticStatus()
    local itemClassifyType = itemSSW:getItemClassify()
    local enchantLevel = itemSSW:get()._key:getEnchantLevel()
    local startPosX = 294
    local gradeCount = ToClient_GetCronEnchnatInfoCount(itemClassifyType, enchantLevel)
    local lastCount = 0
    local lastIndex = gradeCount - 1
    local cronEnchantSSW = ToClient_GetCronEnchantWrapper(itemClassifyType, enchantLevel, lastIndex)
    if nil ~= cronEnchantSSW then
      local enchantablelastCount = cronEnchantSSW:getCount()
      for gradeIndex = 0, gradeCount - 1 do
        local cronEnchantSSW = ToClient_GetCronEnchantWrapper(itemClassifyType, enchantLevel, gradeIndex)
        local enchantableCount = cronEnchantSSW:getCount()
        self._uiCron_StackGrade[gradeIndex]:SetShow(true)
        self._uiCron_StackGrade[gradeIndex]:SetFontColor(Defines.Color.C_FF69BB4C)
        self._uiCron_StackGrade[gradeIndex]:SetPosX(startPosX + 200 * enchantableCount / enchantablelastCount)
        self._uiCron_StackCountValue[gradeIndex]:SetShow(true)
        self._uiCron_StackCountValue[gradeIndex]:SetPosX(startPosX + 200 * enchantableCount / enchantablelastCount)
        self._uiCron_StackCountValue[gradeIndex]:SetText(enchantableCount)
        self._uiCron_StackCountValue[gradeIndex]:SetFontColor(Defines.Color.C_FF69BB4C)
        if currentEnchantFailCount < enchantableCount then
          self._uiCron_StackCountValue[gradeIndex]:SetFontColor(Defines.Color.C_FFC4BEBE)
          self._uiCron_StackGrade[gradeIndex]:SetFontColor(Defines.Color.C_FFC4BEBE)
        end
        if gradeCount - 1 == gradeIndex then
          lastCount = enchantableCount
        end
      end
    end
    self._uiCron_StackCount:SetText(currentEnchantFailCount)
    self._uiCron_AddValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_CRONSTONE_APPLY") .. " " .. bonusText)
    self._uiCron_Progress:SetProgressRate(currentEnchantFailCount / lastCount * 100)
  end
end
function PaGlobal_Enchant:startEnchant(isSureSuccess)
  audioPostEvent_SystemUi(5, 6)
  audioPostEvent_SystemUi(5, 9)
  self._currentTime = 0
  self._isStartEnchantNormal = false == isSureSuccess
  self._isStartEnchantSureSuccess = isSureSuccess
  self._slotTargetItem.icon:EraseAllEffect()
  self._slotEnchantItem.icon:EraseAllEffect()
  self._uiEnchantEffect:EraseAllEffect()
  self._isDoingEnchant = true
  self._uiDrasticEnchant:SetIgnore(self._isDoingEnchant)
  self._uiMeticulousEnchant:SetIgnore(self._isDoingEnchant)
  self._slotTargetItem.icon:AddEffect("fUI_LimitOver01A", false, 0, 0)
  self._slotEnchantItem.icon:AddEffect("fUI_LimitOver01A", false, 0, 0)
  self._uiEnchantEffect:AddEffect("fUI_LimitOver02A", true, 0, 0)
  if self._enchantItemType == 0 then
    self._uiEnchantEffect:AddEffect("UI_LimitOverLine", false, 0, 0)
    self._uiEnchantEffect:AddEffect("fUI_LimitOver_Spark", false, 0, 0)
  elseif self._enchantItemType == 1 then
    self._uiEnchantEffect:AddEffect("UI_LimitOverLine_Red", false, 0, 0)
    self._uiEnchantEffect:AddEffect("fUI_LimitOver_Spark", false, 0, 0)
  end
  self._uiButtonSureSuccess:SetIgnore(true)
  self._uiButtonApply:EraseAllEffect()
  self._uiButtonSureSuccess:EraseAllEffect()
  self._uiButtonApply:SetAlpha(1)
  self._uiButtonApply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_CANCEL"))
  self._uiButtonApply:SetFontColor(Defines.Color.C_FFC4BEBE)
  ToClient_BlackspiritEnchantStart()
end
function PaGlobal_Enchant:doEnchant()
  self._isDoingEnchant = false
  if self._uiCheckBtn_CronEnchnt:IsCheck() then
    ToClient_ReqUpgradeItem(self._slotEnchantItem.inventoryType, self._slotEnchantItem.slotNo, self._slotTargetItem.inventoryType, self._slotTargetItem.slotNo)
  else
    local checkEasy = self._uiDrasticEnchant:IsCheck()
    getEnchantInformation():ToClient_doEnchant(self._isStartEnchantSureSuccess, not checkEasy)
  end
end
function PaGlobal_Enchant:handleMClickedSkipEnchant()
  self._isDoingEnchant = false
  if self._uiCheckBtn_CronEnchnt:IsCheck() then
    ToClient_ReqUpgradeItem(self._slotEnchantItem.inventoryType, self._slotEnchantItem.slotNo, self._slotTargetItem.inventoryType, self._slotTargetItem.slotNo)
  else
    local checkEasy = self._uiDrasticEnchant:IsCheck()
    getEnchantInformation():ToClient_doEnchant(false, not checkEasy)
  end
end
function PaGlobal_Enchant:handleMClickedSkipPerfectEnchant()
  self._isDoingEnchant = false
  getEnchantInformation():ToClient_doEnchant(true, false)
end
function PaGlobal_Enchant:cancelEnchant()
  self:clear()
  Inventory_SetFunctor(EnchantInvenFilerMainItem, EnchantInteractionFromInventory, Enchant_Close, nil)
  self._slotTargetItem.icon:EraseAllEffect()
  self._slotEnchantItem.icon:EraseAllEffect()
  self._uiEnchantEffect:EraseAllEffect()
  self._uiButtonSureSuccess:SetFontColor(Defines.Color.C_FF626262)
  self._uiButtonApply:SetFontColor(Defines.Color.C_FF626262)
  self._uiProtectItem_Btn:SetIgnore(false)
  self._uiProtectItem_Btn:SetCheck(false)
  self._uiDrasticEnchant:SetIgnore(self._isDoingEnchant)
  self._uiMeticulousEnchant:SetIgnore(self._isDoingEnchant)
  ToClient_BlackspiritEnchantCancel()
  self._uiCheckBtn_CronEnchnt:SetCheck(false)
  self._isCronEnchant = false
end
function PaGlobal_Enchant:successEnchant()
  render_setChromaticBlur(40, 1)
  render_setPointBlur(0.05, 0.045)
  render_setColorBypass(0.85, 0.08)
  local itemWrapper = getInventoryItemByType(self._slotTargetItem.inventoryType, self._slotTargetItem.slotNo)
  local enchantCount = itemWrapper:get():getKey():getEnchantLevel()
  local itemKey = itemWrapper:get():getKey():getItemKey()
  local isDifficultyEnchant = itemWrapper:getStaticStatus():getEnchantDifficulty()
  if enchantCount >= 0 and enchantCount <= 14 then
    if CppEnums.EnchantDifficulty.eEnchantDifficulty_Normal == isDifficultyEnchant then
      self._uiDrasticEnchant:SetShow(true)
      self._uiMeticulousEnchant:SetShow(true)
    elseif CppEnums.EnchantDifficulty.eEnchantDifficulty_Hard == isDifficultyEnchant then
      self._uiDrasticEnchant:SetCheck(true)
      self._uiMeticulousEnchant:SetCheck(false)
      self._uiDrasticEnchant:SetShow(false)
      self._uiMeticulousEnchant:SetShow(false)
    end
  else
    self._uiDrasticEnchant:SetCheck(true)
    self._uiMeticulousEnchant:SetCheck(false)
    self._uiDrasticEnchant:SetShow(false)
    self._uiMeticulousEnchant:SetShow(false)
  end
  if enchantCount >= 18 then
    self._uiCheckBtn_CronEnchnt:SetMonoTone(false)
    self._uiCheckBtn_CronEnchnt:SetIgnore(false)
  else
    self._uiCheckBtn_CronEnchnt:SetMonoTone(true)
    self._uiCheckBtn_CronEnchnt:SetIgnore(true)
  end
  audioPostEvent_SystemUi(5, 1)
  self._enchantLevel = enchantCount
  ToClient_BlackspiritEnchantSuccess()
  self._uiButtonApply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_DOENCHANT"))
  PaGlobal_Enchant:enchantFailCount()
end
function PaGlobal_Enchant:failEnchant()
  ToClient_BlackspiritEnchantFail()
  self._uiButtonApply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_DOENCHANT"))
  PaGlobal_Enchant:enchantFailCount()
  local itemWrapper = getInventoryItemByType(self._slotTargetItem.inventoryType, self._slotTargetItem.slotNo)
  if nil == itemWrapper then
    self._uiCheckBtn_CronEnchnt:SetMonoTone(true)
    self._uiCheckBtn_CronEnchnt:SetIgnore(true)
    return
  end
  local enchantCount = itemWrapper:get():getKey():getEnchantLevel()
  if enchantCount >= 18 then
    self._uiCheckBtn_CronEnchnt:SetMonoTone(false)
    self._uiCheckBtn_CronEnchnt:SetIgnore(false)
  else
    self._uiCheckBtn_CronEnchnt:SetMonoTone(true)
    self._uiCheckBtn_CronEnchnt:SetIgnore(true)
  end
  self._enchantLevel = enchantCount
end
function FGlobal_InvenFilterCronEnchant()
  local self = PaGlobal_Enchant
  if self._uiCheckBtn_CronEnchnt:IsCheck() then
    if self._slotTargetItem.empty then
      Inventory_SetFunctor(MainItemFilter_CronEnchant, RclickFunction_CronEnchant, nil, nil)
    elseif self._slotEnchantItem.empty then
      self:SetCronStone()
      Inventory_SetFunctor(CronStoneFilter, nil, nil, nil)
    else
      self._slotEnchantItem:clearItem()
      self:SetCronStone()
      Inventory_SetFunctor(CronStoneFilter, nil, nil, nil)
    end
  elseif self._slotTargetItem.empty then
    Inventory_SetFunctor(EnchantInvenFilerMainItem, EnchantInteractionFromInventory, Enchant_Close, nil)
  else
    local enchantInfo = getEnchantInformation()
    local rv = enchantInfo:ToClient_setEnchantSlot(self._slotTargetItem.inventoryType, self._slotTargetItem.slotNo)
    local itemWrapper = getInventoryItemByType(self._slotTargetItem.inventoryType, self._slotTargetItem.slotNo)
    self:clear()
    Inventory_SetFunctor(EnchantInvenFilerMainItem, EnchantInteractionFromInventory, Enchant_Close, nil)
  end
end
function PaGlobal_Enchant:SetCronStone()
  if nil ~= getSelfPlayer() then
    local protectItemSSW = FromClient_getPreventDownGradeItem()
    local selfPlayer = getSelfPlayer():get()
    local invenUseSize = selfPlayer:getInventorySlotCount(false)
    local useStartSlot = inventorySlotNoUserStart()
    for idx = useStartSlot, invenUseSize - 1 do
      local cronItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, idx)
      if nil ~= cronItemWrapper then
        local itemSSW = cronItemWrapper:getStaticStatus()
        local itemName = itemSSW:getName()
        if protectItemSSW:getName() == itemName then
          self._slotEnchantItem:setItem(cronItemWrapper)
          self._slotEnchantItem.slotNo = idx
          self._slotEnchantItem.inventoryType = CppEnums.ItemWhereType.eInventory
          self._slotEnchantItem.empty = false
          self:EnableEnchantCheck()
          break
        end
      end
    end
  end
end
function PaGlobal_Enchant:EnableEnchantCheck()
  if self._uiCheckBtn_CronEnchnt:IsCheck() then
    local enableCron = Enchat_CronStoneCountCheck()
    self._uiButtonApply:SetIgnore(not enableCron)
    self._uiButtonApply:SetMonoTone(not enableCron)
    if enableCron then
      self._uiButtonApply:SetFontColor(Defines.Color.C_FF96D4FC)
    else
      self._uiButtonApply:SetFontColor(Defines.Color.C_FF626262)
    end
  end
  PaGlobal_Enchant:SetTextStartBtn()
end
function MainItemFilter_CronEnchant(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  local needEndurance = ToClient_GetDecreaseMaxEnduranceToUpgradeItem()
  local currentEndurance = itemWrapper:get():getEndurance()
  if needEndurance > currentEndurance then
    return true
  end
  return not itemWrapper:checkToUpgradeItem()
end
function RclickFunction_CronEnchant(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_Enchant
  if self._slotTargetItem.icon then
    audioPostEvent_SystemUi(0, 16)
    self._slotTargetItem.icon:AddEffect("UI_Button_Hide", false, 0, 0)
  end
  self._slotTargetItem.empty = false
  self._slotTargetItem.slotNo = slotNo
  self._slotTargetItem.inventoryType = inventoryType
  itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  local enchantSSW = itemWrapper:getStaticStatus()
  local enchantItemKey = ItemEnchantKey(enchantSSW:get()._key:getItemKey(), perfectEnchantLevel)
  local perfectEnchantSSW = getItemEnchantStaticStatus(enchantItemKey)
  local enchantItemClassify = itemWrapper:getStaticStatus():getItemClassify()
  local isCashItem = itemWrapper:getStaticStatus():get():isCash()
  local enchantCount = itemWrapper:get():getKey():getEnchantLevel()
  local itemKey = itemWrapper:get():getKey():getItemKey()
  self._enchantClassifyValue = enchantItemClassify
  self._isItemKey = enchantSSW:get()._key:getItemKey()
  self._isCash = isCashItem
  self._isEnchantLevel = enchantCount
  self._enchantLevel = enchantCount
  itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  self._slotTargetItem:setItem(itemWrapper)
  if nil ~= getSelfPlayer() then
    local protectItemSSW = FromClient_getPreventDownGradeItem()
    local selfPlayer = getSelfPlayer():get()
    local invenUseSize = selfPlayer:getInventorySlotCount(false)
    local useStartSlot = inventorySlotNoUserStart()
    for idx = useStartSlot, invenUseSize - 1 do
      local cronItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, idx)
      if nil ~= cronItemWrapper then
        local itemSSW = cronItemWrapper:getStaticStatus()
        local itemName = itemSSW:getName()
        if protectItemSSW:getName() == itemName then
          self._slotEnchantItem:setItem(cronItemWrapper)
          self:EnableEnchantCheck()
          break
        end
      end
    end
  end
  self:SetCronDesc()
  Inventory_SetFunctor(CronStoneFilter, nil, nil, nil)
end
function Enchat_CronStoneCountCheck()
  local self = PaGlobal_Enchant
  local dummy, cronCount = self:protectItemCount()
  local itemWrapper = getInventoryItemByType(self._slotTargetItem.inventoryType, self._slotTargetItem.slotNo)
  if nil == itemWrapper then
    return false
  end
  local itemKey = itemWrapper:get():getKey():get()
  local needCronCount = getTemporaryInformationWrapper():getNeedSourceCountToUpgradeItem(itemKey)
  if self._uiCheckBtn_CronEnchnt:IsCheck() then
    self._uiProtectItem_Count:SetText(tostring(cronCount) .. "/" .. tostring(needCronCount))
  end
  if 1 >= Int64toInt32(needCronCount) then
    return false
  end
  if cronCount >= needCronCount then
    return true
  else
    return false
  end
end
function EnchantInvenFilerMainItem(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  if itemWrapper:checkToValksItem() then
    return false
  end
  if ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return true
  end
  local needEndurance = ToClient_GetDecreaseMaxEnduranceToUpgradeItem()
  local currentEndurance = itemWrapper:get():getEndurance()
  local cronEnchantable = PaGlobal_Enchant._isCronEnchantOpen and needEndurance <= currentEndurance and itemWrapper:checkToUpgradeItem()
  return false == itemWrapper:checkToEnchantItem(false) and not cronEnchantable
end
function EnchantInvenFilerSubItem(slotNo, notUse_itemWrappers, whereType)
  local self = PaGlobal_Enchant
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  if itemWrapper:checkToValksItem() then
    return false
  end
  if CppEnums.ItemWhereType.eCashInventory == whereType then
    return true
  end
  local returnValue = true
  if slotNo ~= getEnchantInformation():ToClient_getNeedItemSlotNo() then
    returnValue = true
  else
    returnValue = false
    if self._slotTargetItem.slotNo == slotNo and CppEnums.ItemWhereType.eInventory ~= whereType then
      returnValue = true
    end
  end
  if ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    returnValue = true
  end
  return returnValue
end
function PaGlobal_Enchant:SetMainAndCronStone(slotNo, itemWrapper, count, inventoryType)
  if not self._uiCheckBtn_CronEnchnt:IsCheck() then
    self._uiProtectItem_Btn:SetCheck(false)
    self._uiCheckBtn_CronEnchnt:SetCheck(true)
    self._uiCheckBtn_CronEnchnt:SetMonoTone(true)
    self._uiCheckBtn_CronEnchnt:SetIgnore(true)
  end
  if self._slotTargetItem.empty then
    if self._slotTargetItem.icon then
      audioPostEvent_SystemUi(0, 16)
      self._slotTargetItem.icon:AddEffect("UI_Button_Hide", false, 0, 0)
    end
    self._slotTargetItem.empty = false
    self._slotTargetItem.slotNo = slotNo
    self._slotTargetItem.inventoryType = inventoryType
    itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    local enchantSSW = itemWrapper:getStaticStatus()
    local enchantItemKey = ItemEnchantKey(enchantSSW:get()._key:getItemKey(), perfectEnchantLevel)
    local perfectEnchantSSW = getItemEnchantStaticStatus(enchantItemKey)
    local enchantItemClassify = itemWrapper:getStaticStatus():getItemClassify()
    local isCashItem = itemWrapper:getStaticStatus():get():isCash()
    local enchantCount = itemWrapper:get():getKey():getEnchantLevel()
    local itemKey = itemWrapper:get():getKey():getItemKey()
    self._enchantClassifyValue = enchantItemClassify
    self._isItemKey = enchantSSW:get()._key:getItemKey()
    self._isCash = isCashItem
    self._isEnchantLevel = enchantCount
    itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    self._slotTargetItem:setItem(itemWrapper)
    self:SetCronStone()
    Inventory_SetFunctor(CronStoneFilter, nil, nil, nil)
  end
  FGlobal_EnchantArrowSet(false)
end
function CronStoneFilter()
  return true
end
function PaGlobal_Enchant:CronEnchantCheck(itemWrapper, enchantCount)
  if (nil == itemWrapper or itemWrapper:checkToUpgradeItem()) and Enchat_CronStoneCountCheck() then
    self._uiCheckBtn_CronEnchnt:SetIgnore(false)
    self._uiCheckBtn_CronEnchnt:SetMonoTone(false)
  elseif enchantCount >= 18 then
    self._uiCheckBtn_CronEnchnt:SetMonoTone(false)
    self._uiCheckBtn_CronEnchnt:SetIgnore(false)
  else
    self._uiCheckBtn_CronEnchnt:SetMonoTone(true)
    self._uiCheckBtn_CronEnchnt:SetIgnore(true)
  end
end
function EnchantInteractionFromInventory(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_Enchant
  local enchantInfo = getEnchantInformation()
  local rv = enchantInfo:ToClient_setEnchantSlot(inventoryType, slotNo)
  if 0 ~= rv then
    if nil ~= itemWrapper then
      if itemWrapper:checkToValksItem() then
        Inventory_UseItemTargetSelf(inventoryType, slotNo, 0)
      elseif itemWrapper:checkToUpgradeItem() and self._isCronEnchantOpen then
        self:SetMainAndCronStone(slotNo, itemWrapper, count, inventoryType)
      end
    end
    return
  end
  if self._slotTargetItem.empty then
    if self._slotTargetItem.icon then
      audioPostEvent_SystemUi(0, 16)
      self._slotTargetItem.icon:AddEffect("UI_Button_Hide", false, 0, 0)
    end
    self._slotTargetItem.empty = false
    self._slotTargetItem.slotNo = slotNo
    self._slotTargetItem.inventoryType = inventoryType
    itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    local enchantSSW = itemWrapper:getStaticStatus()
    local perfectEnchantLevel = enchantSSW:get()._key:getEnchantLevel() + 1
    local enchantItemKey = ItemEnchantKey(enchantSSW:get()._key:getItemKey(), perfectEnchantLevel)
    enchantItemKey:set(enchantSSW:get()._key:getItemKey(), perfectEnchantLevel)
    local perfectEnchantSSW = getItemEnchantStaticStatus(enchantItemKey)
    local enchantPerfectEndurance = perfectEnchantSSW:get():getReduceMaxEnduranceAtPerfectEnchant()
    local isEnchantSafeType = perfectEnchantSSW:getEnchantType()
    local enchantItemClassify = itemWrapper:getStaticStatus():getItemClassify()
    local isCashItem = itemWrapper:getStaticStatus():get():isCash()
    local enchantCount = itemWrapper:get():getKey():getEnchantLevel()
    local itemKey = itemWrapper:get():getKey():getItemKey()
    local isDifficultyEnchant = itemWrapper:getStaticStatus():getEnchantDifficulty()
    if enchantCount >= 0 and enchantCount <= 14 then
      if CppEnums.EnchantDifficulty.eEnchantDifficulty_Normal == isDifficultyEnchant then
        local isEasyEnchantTypeCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(CppEnums.GlobalUIOptionType.EnchantType)
        self._uiDrasticEnchant:SetShow(true)
        self._uiMeticulousEnchant:SetShow(true)
        self._uiDrasticEnchant:SetCheck(not isEasyEnchantTypeCheck)
        self._uiMeticulousEnchant:SetCheck(isEasyEnchantTypeCheck)
      elseif CppEnums.EnchantDifficulty.eEnchantDifficulty_Hard == isDifficultyEnchant then
        self._uiDrasticEnchant:SetShow(false)
        self._uiMeticulousEnchant:SetShow(false)
        self._uiDrasticEnchant:SetCheck(true)
        self._uiMeticulousEnchant:SetCheck(false)
      end
    end
    self._enchantClassifyValue = enchantItemClassify
    self._enchantPerfectEnduranceValue = enchantPerfectEndurance
    self._isEnchantSafeTypeValue = isEnchantSafeType
    self._isItemKey = enchantSSW:get()._key:getItemKey()
    self._isCash = isCashItem
    self._isEnchantLevel = enchantCount
    if nil == itemWrapper:getNeedEnchantItem(true) then
      self._uiEnchantFailDesc:SetShow(true)
      self:handleMOnShowHelpDesc(false)
      self._enchantCountValue = enchantCount
    else
      self._uiEnchantFailDesc:SetShow(false)
      self:handleMOnShowHelpDesc(true)
      self._enchantCountValue = enchantCount
      self:setNeedPerfectEnchantItemCount(itemWrapper:getNeedEnchantItem(true), enchantCount, enchantItemClassify)
    end
    if self._isContentsEnable then
      self:setProtectItem(enchantSSW:get()._key, enchantCount)
    end
    itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    self._slotTargetItem:setItem(itemWrapper)
    Inventory_SetFunctor(EnchantInvenFilerSubItem, EnchantInteractionFromInventory, Enchant_Close, nil)
    self:CronEnchantCheck(itemWrapper, enchantCount)
  elseif self._slotEnchantItem.empty then
    self._slotEnchantItem.empty = false
    self._slotEnchantItem.slotNo = slotNo
    self._slotEnchantItem.inventoryType = inventoryType
    itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    self._slotEnchantItem:setItem(itemWrapper)
    self._slotEnchantItem.icon:EraseAllEffect()
    audioPostEvent_SystemUi(0, 7)
    if 16002 == itemWrapper:get():getKey():getItemKey() then
      self._uiEnchantEffect:AddEffect("fUI_Gauge_Blue", true, 0, 0)
      self._slotEnchantItem.icon:AddEffect("fUI_DarkstoneAura02", false, 0, 0)
      self._slotEnchantItem.icon:AddEffect("UI_Button_Hide", false, 0, 0)
      self._enchantItemType = 0
    elseif 16001 == itemWrapper:get():getKey():getItemKey() then
      self._uiEnchantEffect:AddEffect("fUI_Gauge_Red", true, 0, 0)
      self._slotEnchantItem.icon:AddEffect("fUI_DarkstoneAura01", true, 0, 0)
      self._slotEnchantItem.icon:AddEffect("UI_Button_Hide", false, 0, 0)
      self._enchantItemType = 1
    elseif 16004 == itemWrapper:get():getKey():getItemKey() then
      self:handleMOnShowHelpDesc(false)
    elseif 16005 == itemWrapper:get():getKey():getItemKey() then
      self:handleMOnShowHelpDesc(false)
    end
  else
    UI.ASSERT(false, "Client data, UI data is Mismatch!!!!!")
    return
  end
  local enchantable = 0 == enchantInfo:IsReadyEnchant()
  local enchantablePerfect = 0 == enchantInfo:IsReadyPerfectEnchant()
  self._uiButtonApply:EraseAllEffect()
  if true == enchantable then
    self._uiButtonApply:SetFontColor(Defines.Color.C_FF96D4FC)
  else
    self._uiButtonApply:SetFontColor(Defines.Color.C_FF626262)
  end
  self._uiButtonSureSuccess:EraseAllEffect()
  if true == enchantablePerfect then
    self._uiButtonSureSuccess:SetFontColor(Defines.Color.C_FF69BB4C)
  else
    self._uiButtonSureSuccess:SetFontColor(Defines.Color.C_FF626262)
  end
  self._uiButtonApply:SetIgnore(false == enchantable)
  self._uiButtonApply:SetMonoTone(false == enchantable)
  self._uiButtonSureSuccess:SetIgnore(false == enchantablePerfect)
  if true == enchantable then
    self:handleMOnShowHelpDesc(true)
  end
  if 16 <= self._isEnchantLevel and 3 == self._isEnchantSafeTypeValue or 4 == self._enchantClassifyValue then
    self._uiProtectItem_Btn:SetIgnore(false)
  else
    self._uiProtectItem_Btn:SetCheck(false)
    self._uiProtectItem_Btn:SetIgnore(true)
  end
end
function PaGlobal_Enchant:show()
  self._slotTargetItem.icon:EraseAllEffect()
  self._slotEnchantItem.icon:EraseAllEffect()
  self._uiEnchantEffect:EraseAllEffect()
  self._uiProtectItem_Btn:SetCheck(false)
  self._uiCheckBtn_CronEnchnt:SetCheck(false)
  self._uiCheckBtn_CronEnchnt:SetMonoTone(true)
  self._uiCheckBtn_CronEnchnt:SetIgnore(true)
  FGlobal_EnchantArrowSet(true)
  self:clear()
  Inventory_SetFunctor(EnchantInvenFilerMainItem, EnchantInteractionFromInventory, Enchant_Close, nil)
  FGlobal_SetInventoryDragNoUse(Panel_Window_Enchant)
  self._uiEnchantFailDesc:SetShow(false)
  Panel_Window_Enchant:SetShow(true, true)
  audioPostEvent_SystemUi(1, 0)
  InventoryWindow_Show()
  Equipment_PosSaveMemory()
  Panel_Equipment:SetShow(true, true)
  Panel_Equipment:SetPosX(10)
  Panel_Equipment:SetPosY(getScreenSizeY() - getScreenSizeY() / 2 - Panel_Equipment:GetSizeY() / 2)
  self._btnMouseOnCount = 0
  self._enchantHelpDesc = ""
  Panel_Window_Enchant:SetEnableArea(0, 0, 530, 25)
  if self._isContentsEnable then
    self:setProtectItem()
  end
  self._uiProtectItem_BG:SetShow(self._isContentsEnable)
  self._uiProtectItem_Icon:SetShow(self._isContentsEnable)
  self._uiProtectItem_Count:SetShow(self._isContentsEnable)
  self._uiProtectItem_Btn:SetShow(self._isContentsEnable)
  self._uiCronDescBg:SetShow(self._isContentsEnable)
  self._uiCronDescArrow:SetShow(self._isContentsEnable)
  self._uiProtectItem_Desc:SetShow(self._isContentsEnable)
  self._uiButtonApply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_DOENCHANT"))
  self._uiButtonSureSuccess:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_WIN_ENCHANT_GOGOGO"))
  if self._isContentsEnable then
    self._uiEnchantFailDesc:SetSpanSize(self._uiEnchantFailDesc:GetSpanSize().x, 120)
  else
    self._uiEnchantFailDesc:SetSpanSize(self._uiEnchantFailDesc:GetSpanSize().x, 170)
  end
  local sizeX = getScreenSizeX()
  local sizeY = getScreenSizeY()
  Panel_Window_Enchant:SetPosX(sizeX / 2 - Panel_Window_Enchant:GetSizeX() / 2)
  Panel_Window_Enchant:SetPosY(sizeY - sizeY / 2 - Panel_Window_Enchant:GetSizeY() / 2)
  Panel_Window_Enchant:ComputePos()
end
function FromClient_EnchantResultShow(resultType, mainWhereType, mainSlotNo, subWhereType, subSlotNo)
  local self = PaGlobal_Enchant
  Inventory_SetFunctor(EnchantInvenFilerMainItem, EnchantInteractionFromInventory, Enchant_Close, nil)
  if 0 == resultType then
    self:successEnchant()
    self._slotTargetItem.icon:AddEffect("UI_ItemEnchant01", false, -6, -6)
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_SUCCESSENCHANT"))
  elseif 1 == resultType then
    self:failEnchant()
  elseif 2 == resultType then
    self:failEnchant()
  elseif 3 == resultType then
    self:failEnchant()
  else
    self:failEnchant()
  end
  self:clear()
  local mainInventory = getSelfPlayer():get():getInventoryByType(mainWhereType)
  if false == mainInventory:empty(mainSlotNo) then
    EnchantInteractionFromInventory(mainSlotNo, nil, 0, mainWhereType)
  end
  local subInventory = getSelfPlayer():get():getInventoryByType(subWhereType)
  if false == subInventory:empty(subSlotNo) then
    EnchantInteractionFromInventory(subSlotNo, nil, 0, subWhereType)
  end
  PaGlobal_TutorialManager:handleEnchantResultShow(resultType, mainWhereType, mainSlotNo, subWhereType, subSlotNo)
end
function FromClient_UpgradeItem(itemWhereType, slotNo)
  PaGlobal_Enchant:successEnchant()
  PaGlobal_Enchant:SetCronStone()
  PaGlobal_Enchant:SetCronDesc()
  local self = PaGlobal_Enchant
  if 18 <= self._enchantLevel and self._enchantLevel < 20 then
    self._uiCheckBtn_CronEnchnt:SetMonoTone(false)
    self._uiCheckBtn_CronEnchnt:SetIgnore(false)
  else
    self._uiCheckBtn_CronEnchnt:SetMonoTone(true)
    self._uiCheckBtn_CronEnchnt:SetIgnore(true)
  end
end
function FromClient_UpdateEnchantFailCount()
  if Panel_Window_Enchant:GetShow() then
    PaGlobal_Enchant:enchantFailCount()
  end
end
