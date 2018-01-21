Panel_Window_Enchant:setMaskingChild(true)
Panel_Window_Enchant:setGlassBackground(true)
Panel_Window_Enchant:SetDragEnable(true)
Panel_Window_Enchant:SetDragAll(true)
Panel_Window_Enchant:RegisterShowEventFunc(true, "Enchant_ShowAni()")
Panel_Window_Enchant:RegisterShowEventFunc(false, "Enchant_HideAni()")
PaGlobal_Enchant = {
  _enchantCountValue = 0,
  _Xgap = 7,
  _enchantClassifyValue = nil,
  _enchantPerfectEnduranceValue = 3,
  _isEnchantSafeTypeValue = 0,
  _isItemKey = nil,
  _isCash = nil,
  _isEnchantLevel = 0,
  _isContentsEnable = ToClient_IsContentsGroupOpen("74"),
  _isCronBonusOpen = ToClient_IsContentsGroupOpen("222"),
  _isCronEnchantOpen = ToClient_IsContentsGroupOpen("234"),
  _isEnableProtect = false,
  _uiHelpTargetItem = UI.getChildControl(Panel_Window_Enchant, "StaticText_Notice_Slot_0"),
  _uiHelpEnchantItem = UI.getChildControl(Panel_Window_Enchant, "StaticText_Notice_Slot_1"),
  _uiHelpEnchantBtn = UI.getChildControl(Panel_Window_Enchant, "StaticText_Notice_Enchant"),
  _uiHelpPerfectEnchant = UI.getChildControl(Panel_Window_Enchant, "StaticText_Notice_GoGoGo"),
  _uiHelpEnchantFailCnt = UI.getChildControl(Panel_Window_Enchant, "StaticText_EnchantFailCount"),
  _uiEnchantFailDesc = UI.getChildControl(Panel_Window_Enchant, "StaticText_EnchantFailDesc"),
  _uiEnchantPackFailCnt = UI.getChildControl(Panel_Window_Enchant, "StaticText_EnchantFailPackCount"),
  _uiEnchantPcroomFailCnt = UI.getChildControl(Panel_Window_Enchant, "StaticText_EnchantFailPcroomCount"),
  _uiEnchantBottomDesc = UI.getChildControl(Panel_Window_Enchant, "StaticText_Comment"),
  _uiButtonQuestion = UI.getChildControl(Panel_Window_Enchant, "Button_Question"),
  _enchantItemType = 0,
  _slotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true
  },
  _uiButtonApply = UI.getChildControl(Panel_Window_Enchant, "Button_GoGoGo"),
  _uiButtonSureSuccess = UI.getChildControl(Panel_Window_Enchant, "Button_Apply"),
  _uiEnchantEffect = UI.getChildControl(Panel_Window_Enchant, "Static_AddEffect"),
  _uiSkipEnchant = UI.getChildControl(Panel_Window_Enchant, "CheckButton_SkipEnchant"),
  _uiDrasticEnchant = UI.getChildControl(Panel_Window_Enchant, "Radiobutton_DrasticEnchant"),
  _uiMeticulousEnchant = UI.getChildControl(Panel_Window_Enchant, "Radiobutton_MeticulousEnchant"),
  _uiProtectItem_BG = UI.getChildControl(Panel_Window_Enchant, "Static_ProtectItemBG"),
  _uiProtectItem_Icon = UI.getChildControl(Panel_Window_Enchant, "Static_ProtectItemSlot"),
  _uiProtectItem_Count = UI.getChildControl(Panel_Window_Enchant, "StaticText_ProtectItemCount"),
  _uiProtectItem_Name = UI.getChildControl(Panel_Window_Enchant, "StaticText_ProtectItemName"),
  _uiProtectItem_Desc = UI.getChildControl(Panel_Window_Enchant, "StaticText_ProtectItemDesc"),
  _uiProtectItem_Btn = UI.getChildControl(Panel_Window_Enchant, "CheckButton_ProtectItem"),
  _protectItem_SlotNo = nil,
  _descBg = UI.getChildControl(Panel_Window_Enchant, "Static_CommentBG"),
  _desc = UI.getChildControl(Panel_Window_Enchant, "StaticText_Comment"),
  _uiCheckBtn_CronEnchnt = UI.getChildControl(Panel_Window_Enchant, "CheckButton_CronEnchant"),
  _uiCronDescBg = UI.getChildControl(Panel_Window_Enchant, "Static_CronStoneBg"),
  _uiCronDescArrow = UI.getChildControl(Panel_Window_Enchant, "Static_Arrow"),
  _uiCron_StackCount = UI.getChildControl(Panel_Window_Enchant, "StaticText_StackCountBg"),
  _uiCron_ProgressBg = UI.getChildControl(Panel_Window_Enchant, "Static_CronStoneStackBg"),
  _uiCron_Progress = UI.getChildControl(Panel_Window_Enchant, "Progress2_StackCount"),
  _uiCron_StackGrade = {
    [0] = UI.getChildControl(Panel_Window_Enchant, "StaticText_Grade1"),
    [1] = UI.getChildControl(Panel_Window_Enchant, "StaticText_Grade2"),
    [2] = UI.getChildControl(Panel_Window_Enchant, "StaticText_Grade3"),
    [3] = UI.getChildControl(Panel_Window_Enchant, "StaticText_Grade4")
  },
  _uiCron_StackCountValue = {
    [0] = UI.getChildControl(Panel_Window_Enchant, "StaticText_Count1"),
    [1] = UI.getChildControl(Panel_Window_Enchant, "StaticText_Count2"),
    [2] = UI.getChildControl(Panel_Window_Enchant, "StaticText_Count3"),
    [3] = UI.getChildControl(Panel_Window_Enchant, "StaticText_Count4")
  },
  _uiCron_AddValue = UI.getChildControl(Panel_Window_Enchant, "StaticText_CronStackDesc"),
  _buttonSecretExtraction = UI.getChildControl(Panel_Window_Enchant, "Button_SecretExtraction"),
  _slotTargetItem = {},
  _slotEnchantItem = {},
  _isStartEnchantNormal = false,
  _isStartEnchantSureSuccess = false,
  _currentTime = 0,
  _isDoingEnchant = false,
  _btnMouseOnCount = 0,
  _enchantHelpDesc = "",
  savedBoxSizeY = 70,
  _bubbleBasePosY = 295,
  _enchantLevel = 0,
  _isCronEnchant = false
}
function PaGlobal_Enchant:initialize()
  self._uiHelpPerfectEnchant:SetShow(false)
  self._uiHelpPerfectEnchant:SetSize(220, 60)
  self._uiHelpPerfectEnchant:SetPosY(self._uiButtonSureSuccess:GetPosY() - self._uiHelpPerfectEnchant:GetSizeY())
  self._uiEnchantFailDesc:SetShow(false)
  self._uiEnchantFailDesc:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
  self._uiEnchantFailDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_SPRITENCHANT_DESC"))
  self._uiDrasticEnchant:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_DRASTICENCHANT_TITLE"))
  self._uiMeticulousEnchant:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_METICULOUSENCHANT_TITLE"))
  self._uiCron_AddValue:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
  self._uiButtonApply:addInputEvent("Mouse_LUp", "PaGlobal_Enchant:handleMClickedEnchantApplyButton()")
  self._uiButtonSureSuccess:addInputEvent("Mouse_LUp", "PaGlobal_Enchant:handleMClickedSureSuccessButton()")
  self._uiDrasticEnchant:addInputEvent("Mouse_LUp", "PaGlobal_Enchant:handleMClickedEnchantType()")
  self._uiMeticulousEnchant:addInputEvent("Mouse_LUp", "PaGlobal_Enchant:handleMClickedEnchantType()")
  self._uiButtonSureSuccess:SetShow(true)
  self._uiSkipEnchant:SetCheck(false)
  self._uiSkipEnchant:SetEnableArea(0, 0, self._uiSkipEnchant:GetTextSizeX() + 60, self._uiSkipEnchant:GetSizeY())
  self._uiDrasticEnchant:SetCheck(true)
  self._uiMeticulousEnchant:SetCheck(false)
  self._uiDrasticEnchant:SetShow(false)
  self._uiMeticulousEnchant:SetShow(false)
  self._uiDrasticEnchant:SetEnableArea(0, 0, self._uiDrasticEnchant:GetTextSizeX() + 60, self._uiDrasticEnchant:GetSizeY())
  self._uiMeticulousEnchant:SetEnableArea(0, 0, self._uiMeticulousEnchant:GetTextSizeX() + 60, self._uiMeticulousEnchant:GetSizeY())
  self._slotTargetItem.icon = UI.getChildControl(Panel_Window_Enchant, "Static_Slot_0")
  SlotItem.new(self._slotTargetItem, "Slot_0", 0, Panel_Window_Enchant, self._slotConfig)
  self._slotTargetItem:createChild()
  self._slotTargetItem.empty = true
  Panel_Tooltip_Item_SetPosition(0, self._slotTargetItem, "Enchant")
  self._slotEnchantItem.icon = UI.getChildControl(Panel_Window_Enchant, "Static_Slot_1")
  SlotItem.new(self._slotEnchantItem, "Slot_1", 1, Panel_Window_Enchant, self._slotConfig)
  self._slotEnchantItem:createChild()
  self._slotEnchantItem.empty = true
  self._uiProtectItem_Desc:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
  self._uiProtectItem_Desc:SetText(self._uiProtectItem_Desc:GetText())
  self._currentTime = 0
  Panel_Tooltip_Item_SetPosition(1, self._slotEnchantItem, "Enchant")
  self._slotEnchantItem.icon:addInputEvent("Mouse_RUp", "PaGlobal_Enchant:handleMClickedEnchantSlotCancel()")
  self._slotTargetItem.icon:addInputEvent("Mouse_RUp", "PaGlobal_Enchant:handleMClickedEnchantSlotCancel()")
  self._uiButtonApply:addInputEvent("Mouse_On", "PaGlobal_Enchant:handleMOnShowHelpDesc(true)")
  self._uiButtonApply:addInputEvent("Mouse_Out", "PaGlobal_Enchant:handleMOnShowHelpDesc(false)")
  self._uiButtonSureSuccess:addInputEvent("Mouse_On", "PaGlobal_Enchant:handleMOnSureSuccessButton()")
  self._uiButtonSureSuccess:addInputEvent("Mouse_Out", "PaGlobal_Enchant:handleMOutSureSuccessButton()")
  self._slotTargetItem.icon:addInputEvent("Mouse_On", "PaGlobal_Enchant:handleMOnEnchantItemTooltip()")
  self._slotTargetItem.icon:addInputEvent("Mouse_Out", "PaGlobal_Enchant:handleMOutEnchantItemTooltip()")
  self._slotEnchantItem.icon:addInputEvent("Mouse_On", "PaGlobal_Enchant:handleMOnTargetItemTooltip()")
  self._slotEnchantItem.icon:addInputEvent("Mouse_Out", "PaGlobal_Enchant:handleMOutTargetItemTooltip()")
  self._uiSkipEnchant:addInputEvent("Mouse_On", "PaGlobal_Enchant:handleMOnoutSkipEnchantTooltip(true)")
  self._uiSkipEnchant:addInputEvent("Mouse_Out", "PaGlobal_Enchant:handleMOnoutSkipEnchantTooltip(false)")
  self._uiDrasticEnchant:addInputEvent("Mouse_On", "PaGlobal_Enchant:handleMOnoutDifficultyEnchantTooltip(true, 0)")
  self._uiDrasticEnchant:addInputEvent("Mouse_Out", "PaGlobal_Enchant:handleMOnoutDifficultyEnchantTooltip(false, 0)")
  self._uiMeticulousEnchant:addInputEvent("Mouse_On", "PaGlobal_Enchant:handleMOnoutDifficultyEnchantTooltip(true, 1)")
  self._uiMeticulousEnchant:addInputEvent("Mouse_Out", "PaGlobal_Enchant:handleMOnoutDifficultyEnchantTooltip(false, 1)")
  self._uiButtonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"SpiritEnchant\" )")
  self._uiButtonQuestion:addInputEvent("Mouse_On", "HelpMessageQuestion_Show( \"SpiritEnchant\", \"true\")")
  self._uiButtonQuestion:addInputEvent("Mouse_Out", "HelpMessageQuestion_Show( \"SpiritEnchant\", \"false\")")
  self._uiProtectItem_Btn:addInputEvent("Mouse_LUp", "PaGlobal_Enchant:handleClickedProtectCheckBtn()")
  self._uiCheckBtn_CronEnchnt:addInputEvent("Mouse_LUp", "PaGlobal_Enchant:handleClickedCronEnchantBtn()")
  self._uiCheckBtn_CronEnchnt:addInputEvent("Mouse_On", "PaGlobal_Enchant:enchantTooltipShow(true)")
  self._uiCheckBtn_CronEnchnt:addInputEvent("Mouse_Out", "PaGlobal_Enchant:enchantTooltipShow(false)")
  self._buttonSecretExtraction:addInputEvent("Mouse_LUp", "Panel_EnchantExtraction_Show()")
  if isGameTypeJapan() then
    self._uiEnchantBottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_PCROOMENCHANT_DESC_JP"))
  elseif isGameTypeEnglish() then
    self._uiEnchantBottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_PCROOMENCHANT_DESC_NA"))
  elseif isGameTypeRussia() then
    self._uiEnchantBottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_PCROOMENCHANT_DESC_RU"))
  else
    self._uiEnchantBottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_PCROOMENCHANT_DESC"))
  end
  self._uiCheckBtn_CronEnchnt:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_CRONSTONE_TITLE"))
  self._uiCheckBtn_CronEnchnt:SetShow(self._isCronEnchantOpen)
  self._uiCron_StackCount:SetShow(self._isCronEnchantOpen)
  self._uiCron_ProgressBg:SetShow(self._isCronEnchantOpen)
  self._uiCron_Progress:SetShow(self._isCronEnchantOpen)
  self._uiCron_StackGrade[0]:SetShow(self._isCronEnchantOpen)
  self._uiCron_StackGrade[1]:SetShow(self._isCronEnchantOpen)
  self._uiCron_StackGrade[2]:SetShow(self._isCronEnchantOpen)
  self._uiCron_StackGrade[3]:SetShow(self._isCronEnchantOpen)
  self._uiCron_StackCountValue[0]:SetShow(self._isCronEnchantOpen)
  self._uiCron_StackCountValue[1]:SetShow(self._isCronEnchantOpen)
  self._uiCron_StackCountValue[2]:SetShow(self._isCronEnchantOpen)
  self._uiCron_StackCountValue[3]:SetShow(self._isCronEnchantOpen)
  self._uiCron_AddValue:SetShow(self._isCronEnchantOpen)
  if self._isCronBonusOpen then
    self._uiEnchantBottomDesc:SetText(self._uiEnchantBottomDesc:GetText() .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_CRONESTONEDESC"))
  end
  self._uiEnchantBottomDesc:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
  self._uiEnchantBottomDesc:SetText(self._uiEnchantBottomDesc:GetText())
  self._uiEnchantBottomDesc:SetSize(self._uiEnchantBottomDesc:GetSizeX(), self._uiEnchantBottomDesc:GetTextSizeY())
  self._descBg:SetSize(self._descBg:GetSizeX(), self._uiEnchantBottomDesc:GetTextSizeY() + 5)
  if self._isContentsEnable then
    Panel_Window_Enchant:SetSize(Panel_Window_Enchant:GetSizeX(), self._descBg:GetPosY() + self._descBg:GetSizeY() + 10)
  else
    Panel_Window_Enchant:SetSize(Panel_Window_Enchant:GetSizeX(), 220 + self._descBg:GetSizeY() + 15)
  end
  self._descBg:ComputePos()
  self._uiEnchantBottomDesc:ComputePos()
  self._buttonSecretExtraction:SetSpanSize(0, 155)
  self._buttonSecretExtraction:ComputePos()
  PaGlobal_Enchant:enchantFailCount()
  if isGameTypeKR2() then
    self._uiButtonApply:SetSpanSize(-80, 150)
    self._uiButtonSureSuccess:SetSpanSize(80, 150)
  elseif self._isContentsEnable then
    self._uiButtonApply:SetSpanSize(-80, 300)
    self._uiButtonSureSuccess:SetSpanSize(80, 300)
  else
    self._uiButtonApply:SetSpanSize(-80, 180)
    self._uiButtonSureSuccess:SetSpanSize(80, 180)
  end
  self._uiButtonApply:ComputePos()
  self._uiButtonSureSuccess:ComputePos()
  Panel_Window_Enchant:RegisterUpdateFunc("UpdateFunc_DoingEnchant")
  registerEvent("EventEnchantResultShow", "FromClient_EnchantResultShow")
  registerEvent("FromClient_UpgradeItem", "FromClient_UpgradeItem")
  registerEvent("FromClient_UpdateEnchantFailCount", "FromClient_UpdateEnchantFailCount")
  registerEvent("onScreenResize", "OnScreenEvent")
end
PaGlobal_Enchant._uiProtectItem_Btn:SetEnableArea(0, 0, 25 + PaGlobal_Enchant._uiProtectItem_Btn:GetTextSizeX(), PaGlobal_Enchant._uiProtectItem_Btn:GetSizeY())
PaGlobal_Enchant._uiCheckBtn_CronEnchnt:SetEnableArea(0, 0, 25 + PaGlobal_Enchant._uiCheckBtn_CronEnchnt:GetTextSizeX(), PaGlobal_Enchant._uiCheckBtn_CronEnchnt:GetSizeY())
function PaGlobal_Enchant:get()
  return self
end
function PaGlobal_Enchant:getMaterialSlot()
  return self._slotEnchantItem
end
function PaGlobal_Enchant:getTargetItemSlot()
  return self._slotTargetItem
end
function PaGlobal_Enchant:handleClickedProtectCheckBtn()
  if self._uiProtectItem_Btn:IsCheck() then
    self._uiCheckBtn_CronEnchnt:SetCheck(false)
    FGlobal_EnchantArrowSet(true)
  end
  if self._isCronEnchant then
    getEnchantInformation():materialClearData()
    self._isCronEnchant = false
  end
  FGlobal_EnchantMaterialSlotCheck()
  PaGlobal_Enchant:SetTextStartBtn()
end
function PaGlobal_Enchant:handleClickedCronEnchantBtn()
  if self._uiCheckBtn_CronEnchnt:IsCheck() then
    self._uiProtectItem_Btn:SetCheck(false)
    FGlobal_EnchantArrowSet(false)
    self._isCronEnchant = true
  end
  FGlobal_InvenFilterCronEnchant()
end
function PaGlobal_Enchant:enchantTooltipShow(isShow)
  if true == isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_CRONSTONE_TITLE")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_CRONSTONE_DESC")
    TooltipSimple_Show(self._uiCheckBtn_CronEnchnt, name, desc)
  elseif false == isShow then
    TooltipSimple_Hide()
  end
end
function PaGlobal_Enchant:SetTextStartBtn()
  if self._uiCheckBtn_CronEnchnt:IsCheck() then
    self._uiButtonApply:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_GRANT"))
  else
    self._uiButtonApply:SetText(PAGetString(Defines.StringSheet_RESOURCE, "ENCHANT_TEXT_TITLE"))
  end
end
function PaGlobal_Enchant:enchant_Show()
  if Panel_Window_Socket:GetShow() then
    Panel_Window_Socket:SetShow(false, false)
  elseif Panel_SkillAwaken:GetShow() then
    Panel_SkillAwaken:SetShow(false, false)
  end
  PaGlobal_Enchant:enchantFailCount()
  SkillAwaken_Close()
  Panel_Join_Close()
  FGlobal_LifeRanking_Close()
  FGlobal_EnchantExtraction_JustClose()
  self:show()
  self._uiSkipEnchant:SetCheck(false)
  self._uiDrasticEnchant:SetCheck(true)
  self._uiMeticulousEnchant:SetCheck(false)
end
function Enchant_Close()
  local self = PaGlobal_Enchant
  self:clear()
  Equipment_PosLoadMemory()
  self._uiHelpEnchantBtn:SetShow(false)
  InventoryWindow_Close()
  Panel_Equipment:SetShow(false, false)
  ToClient_BlackspiritEnchantClose()
  PaGlobal_TutorialManager:handleCloseEnchantWindow()
  Panel_EnchantExtraction_Close()
  Panel_Window_Enchant:SetShow(false, false)
end
function PaGlobal_Enchant:enchantClose()
  Enchant_Close()
end
function PaGlobal_Enchant:enchantFailCount()
  local selfPlayer = getSelfPlayer():get()
  local failCount = selfPlayer:getEnchantFailCount()
  local failCountPack = selfPlayer:getEnchantValuePackCount()
  self._uiHelpEnchantFailCnt:SetShow(true)
  self._uiHelpEnchantFailCnt:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_HELP", "failCount", failCount))
  if isGameTypeJapan() then
    self._uiEnchantPcroomFailCnt:SetShow(true)
  elseif isGameTypeRussia() then
    self._uiEnchantPcroomFailCnt:SetShow(true)
  elseif isGameTypeKorea() then
    self._uiEnchantPcroomFailCnt:SetShow(true)
  elseif isGameTypeEnglish() then
    self._uiEnchantPcroomFailCnt:SetShow(false)
  end
  self._uiEnchantPcroomFailCnt:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_VALKSCOUNT", "count", failCountPack))
  self._uiHelpEnchantFailCnt:SetSpanSize(0, 48)
  self._uiEnchantPackFailCnt:SetText("( <PAColor0xffffbc1a>+" .. failCountPack .. "<PAOldColor> )")
  local secretExtractionButtonShow = PaGlobal_Enchant:SecretExtractionCheck()
  self._buttonSecretExtraction:SetShow(secretExtractionButtonShow)
end
function PaGlobal_Enchant:SecretExtractionCheck()
  if nil == getSelfPlayer() then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  local failCount = selfPlayer:getEnchantFailCount()
  if failCount < 1 then
    return false
  end
  local useStartSlot = inventorySlotNoUserStart()
  local invenUseSize = selfPlayer:getInventorySlotCount(false)
  local inventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eInventory)
  local invenMaxSize = inventory:sizeXXX()
  for index = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, index)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local maxEnchantParam = itemSSW:getContentsEventParam1()
      if CppEnums.ContentsEventType.ContentsType_ConvertEnchantFailCountToItem == itemSSW:get():getContentsEventType() and failCount <= maxEnchantParam then
        return true
      end
    end
  end
  local useStartSlot = inventorySlotNoUserStart()
  local invenUseSize = selfPlayer:getInventorySlotCount(false)
  local inventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eCashInventory)
  local invenMaxSize = inventory:sizeXXX()
  for index = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, index)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local maxEnchantParam = itemSSW:getContentsEventParam1()
      if CppEnums.ContentsEventType.ContentsType_ConvertEnchantFailCountToItem == itemSSW:get():getContentsEventType() and failCount <= maxEnchantParam then
        return true, true
      end
    end
  end
  return false
end
function PaGlobal_Enchant:enchantItem_FromItemWrapper()
  if nil == self._slotEnchantItem.slotNo then
    return nil
  end
  return (getInventoryItemByType(self._slotEnchantItem.inventoryType, self._slotEnchantItem.slotNo))
end
function PaGlobal_Enchant:enchantItem_ToItemWrapper()
  if nil == self._slotTargetItem.slotNo then
    return nil
  end
  return (getInventoryItemByType(self._slotTargetItem.inventoryType, self._slotTargetItem.slotNo))
end
function PaGlobal_Enchant:enchantItem_ToItemNo()
  if nil == self._slotTargetItem.slotNo then
    return nil
  end
  return (getTItemNoBySlotNo(self._slotTargetItem.slotNo, false))
end
function PaGlobal_Enchant:handleMOnSureSuccessButton()
  self._uiHelpPerfectEnchant:SetShow(true)
  self._uiHelpEnchantBtn:SetShow(false)
  self._uiHelpPerfectEnchant:SetSize(220, self.savedBoxSizeY)
  self._uiHelpPerfectEnchant:SetPosY(self._uiButtonSureSuccess:GetPosY() - self._uiHelpPerfectEnchant:GetSizeY())
end
function PaGlobal_Enchant:handleMOutSureSuccessButton()
  self._uiHelpPerfectEnchant:SetShow(false)
end
function PaGlobal_Enchant:handleMClickedEnchantSlotCancel()
  self:cancelEnchant()
  self:handleMOnShowHelpDesc(false)
  self._uiProtectItem_Btn:SetCheck(false)
  self._uiCheckBtn_CronEnchnt:SetCheck(false)
  FGlobal_EnchantArrowSet(true)
  if self._isContentsEnable then
    self:setProtectItem()
  end
  self._uiDrasticEnchant:SetCheck(true)
  self._uiMeticulousEnchant:SetCheck(false)
  self._uiDrasticEnchant:SetShow(false)
  self._uiMeticulousEnchant:SetShow(false)
end
function PaGlobal_Enchant:handleMClickedEnchantApplyButton()
  if self:isDoingEnchant() then
    self:cancelEnchant()
  else
    local isProtect = self._uiProtectItem_Btn:IsCheck()
    if isProtect then
      if not self._isEnableProtect then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_NOT_ENOUGH_CRONESTONE"))
        return
      end
      getEnchantInformation():setPreventDownGradeItem(CppEnums.ItemWhereType.eInventory, PaGlobal_Enchant._protectItem_SlotNo)
    else
      getEnchantInformation():setPreventDownGradeItem(CppEnums.ItemWhereType.eInventory, 255)
    end
    local skipCheck = self._uiSkipEnchant:IsCheck()
    if skipCheck then
      PaGlobal_Enchant:handleMClickedSkipEnchant()
    else
      local itemWrapper = getInventoryItemByType(self._slotTargetItem.inventoryType, self._slotTargetItem.slotNo)
      local upgradeItem = itemWrapper:checkToUpgradeItem()
      if self._uiCheckBtn_CronEnchnt:IsCheck() then
        if upgradeItem then
          self:startEnchant(false)
        else
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_NOT_CRONESTONEUPGRADE"))
        end
      else
        self:startEnchant(false)
      end
    end
  end
end
function PaGlobal_Enchant:handleMClickedEnchantType()
  local isEasy = self._uiDrasticEnchant:IsCheck()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(CppEnums.GlobalUIOptionType.EnchantType, not isEasy, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_Enchant:handleMClickedSureSuccessButton()
  local skipCheck = self._uiSkipEnchant:IsCheck()
  if skipCheck then
    if self:isDoingEnchant() then
      self:cancelEnchant()
    else
      PaGlobal_Enchant:handleMClickedSkipPerfectEnchant()
    end
  elseif self:isDoingEnchant() then
    self:cancelEnchant()
  else
    self:startEnchant(true)
  end
end
function PaGlobal_Enchant:handleMOnTargetItemTooltip()
  if true == self._slotEnchantItem.empty then
    self._uiHelpTargetItem:SetShow(true)
    self._uiHelpTargetItem:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
    self._uiHelpTargetItem:SetAutoResize(true)
    self._uiHelpTargetItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_HELPMESSAGE1"))
    self._uiHelpTargetItem:SetSize(self._uiHelpTargetItem:GetSizeX() + self._Xgap, self._uiHelpTargetItem:GetSizeY() + 30)
    if not self._isContentsEnable then
      self._uiHelpTargetItem:SetPosY(self._slotEnchantItem.icon:GetPosY() + 100)
    end
  else
    Panel_Tooltip_Item_Show_GeneralNormal(1, "Enchant", true)
  end
end
function PaGlobal_Enchant:handleMOutTargetItemTooltip()
  if true == self._slotEnchantItem.empty then
    self._uiHelpTargetItem:SetShow(false)
    self._uiHelpTargetItem:SetSize(220, 60)
  else
    Panel_Tooltip_Item_Show_GeneralNormal(1, "Enchant", false)
  end
end
function PaGlobal_Enchant:handleMOnEnchantItemTooltip()
  if true == self._slotTargetItem.empty then
    self._uiHelpEnchantItem:SetShow(true)
    self._uiHelpEnchantItem:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
    self._uiHelpEnchantItem:SetAutoResize(true)
    self._uiHelpEnchantItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_HELPMESSAGE2"))
    self._uiHelpEnchantItem:SetSize(self._uiHelpEnchantItem:GetTextSizeX() + self._Xgap, self._uiHelpEnchantItem:GetTextSizeY() + 30)
  else
    Panel_Tooltip_Item_Show_GeneralNormal(0, "Enchant", true)
  end
end
function PaGlobal_Enchant:handleMOutEnchantItemTooltip()
  if true == self._slotTargetItem.empty then
    self._uiHelpEnchantItem:SetShow(false)
    self._uiHelpEnchantItem:SetSize(220, 60)
  else
    Panel_Tooltip_Item_Show_GeneralNormal(0, "Enchant", false)
  end
end
function PaGlobal_Enchant:handleMOnoutSkipEnchantTooltip(isShow)
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_SPRITENCHANT_SKIPENCHANT_TOOLTIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_SPRITENCHANT_SKIPENCHANT_TOOLTIP_DESC")
  control = self._uiSkipEnchant
  if isShow == true then
    registTooltipControl(control, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_Enchant:handleMOnoutDifficultyEnchantTooltip(isShow, tipType)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_DRASTICENCHANT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_DRASTICENCHANT_DESC")
    control = self._uiDrasticEnchant
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_METICULOUSENCHANT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_METICULOUSENCHANT_DESC")
    control = self._uiMeticulousEnchant
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_Enchant:handleMOnShowHelpDesc(isShow)
  if 16 <= self._enchantCountValue and not isGameTypeEnglish() then
    return
  end
  if 0 == self._isEnchantSafeTypeValue then
    if 1 == self._enchantClassifyValue or 2 == self._enchantClassifyValue then
      if 0 == self._btnMouseOnCount % 3 then
        self._enchantHelpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_DESC_1")
      elseif 1 == self._btnMouseOnCount % 3 then
        if 10073 == self._isItemKey or 10273 == self._isItemKey or 10473 == self._isItemKey or 10673 == self._isItemKey or 13273 == self._isItemKey or 13373 == self._isItemKey or 14473 == self._isItemKey or 10078 == self._isItemKey or 10139 == self._isItemKey or 10278 == self._isItemKey or 10339 == self._isItemKey or 10478 == self._isItemKey or 10539 == self._isItemKey or 10678 == self._isItemKey or 10739 == self._isItemKey or 13278 == self._isItemKey or 13039 == self._isItemKey or 13378 == self._isItemKey or 13139 == self._isItemKey or 14478 == self._isItemKey or 14539 == self._isItemKey or 14639 == self._isItemKey then
          self._enchantHelpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SPRITENCHANT_SAFEENCHANT_NEWBIEWEAPONE")
        else
          self._enchantHelpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SPRITENCHANT_SAFEENCHANT_WEAPONE")
        end
      elseif self._isCash then
        self._enchantHelpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_DESC_4")
      else
        self._enchantHelpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_DESC_1")
      end
    elseif 3 == self._enchantClassifyValue then
      if 0 == self._btnMouseOnCount % 3 then
        self._enchantHelpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_DESC_1")
      elseif 1 == self._btnMouseOnCount % 3 then
        if 11066 == self._isItemKey or 11067 == self._isItemKey or 11068 == self._isItemKey or 11069 == self._isItemKey then
          self._enchantHelpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SPRITENCHANT_SAFEENCHANT_NEWBIEWEAPONE")
        else
          self._enchantHelpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SPRITENCHANT_SAFEENCHANT_ARMOR")
        end
      end
    elseif self._isCash then
      self._enchantHelpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_DESC_4")
    else
      self._enchantHelpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_DESC_1")
    end
  elseif 1 == self._isEnchantSafeTypeValue then
    self._enchantHelpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SPRITENCHANT_SAFEENCHANT_FAIL")
  elseif 2 == self._isEnchantSafeTypeValue then
    self._enchantHelpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SPRITENCHANT_SAFEENCHANT_DESTORYED")
  elseif 3 == self._isEnchantSafeTypeValue then
    self._enchantHelpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SPRITENCHANT_SAFEENCHANT_COUNTDOWN")
  elseif 4 == self._isEnchantSafeTypeValue then
    self._enchantHelpDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SPRITENCHANT_SAFEENCHANT_DESTORYED_AND_COUNTDOWN")
  end
  self._uiHelpEnchantBtn:SetShow(isShow)
  self._uiHelpEnchantBtn:SetNotAbleMasking(true)
  self._uiHelpEnchantBtn:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
  self._uiHelpEnchantBtn:SetAutoResize(true)
  self._uiHelpEnchantBtn:SetText(self._enchantHelpDesc)
  local boxSizeY = self._uiHelpEnchantBtn:GetTextSizeY() + 30
  if boxSizeY < 70 then
    boxSizeY = 70
  end
  self._uiHelpEnchantBtn:SetSize(self._uiHelpEnchantBtn:GetSizeX(), boxSizeY)
  self._uiHelpEnchantBtn:SetPosY(self._uiButtonApply:GetPosY() - self._uiHelpEnchantBtn:GetSizeY())
  if true == isShow then
    self._btnMouseOnCount = self._btnMouseOnCount + 1
  end
end
function PaGlobal_Enchant:addFailCountEffectForTutorial()
  self._uiEnchantFailDesc:AddEffect("UI_QustComplete01", true, 0, 0)
end
function PaGlobal_Enchant:removeFailCountEffect()
  self._uiEnchantFailDesc:EraseAllEffect()
end
function PaGlobal_Enchant:addValksCountEffectForTutorial()
  self._uiEnchantPcroomFailCnt:AddEffect("UI_QustComplete02", true, 0, 0)
end
function PaGlobal_Enchant:removeValksCountEffect()
  self._uiEnchantPcroomFailCnt:EraseAllEffect()
end
function PaGlobal_Enchant:addTargetSlotEffectForTutorial()
  self._slotTargetItem.icon:AddEffect("UI_ArrowMark02", true, 0, -50)
  self._slotTargetItem.icon:AddEffect("UI_WorldMap_Ping01", true, 0, 0)
end
function PaGlobal_Enchant:removeTargetSlotEffect()
  self._slotTargetItem.icon:EraseAllEffect()
end
function PaGlobal_Enchant:addMaterialSlotEffectForTutorial()
  self._slotEnchantItem.icon:AddEffect("UI_ArrowMark02", true, 0, -50)
  self._slotEnchantItem.icon:AddEffect("UI_WorldMap_Ping01", true, 0, 0)
end
function PaGlobal_Enchant:removeMaterialSlotEffect()
  self._slotEnchantItem.icon:EraseAllEffect()
end
function PaGlobal_Enchant:addApplyButtonEffectForTutorial()
  self._uiButtonApply:AddEffect("UI_ArrowMark02", true, 0, -50)
  self._uiButtonApply:AddEffect("UI_WorldMap_Ping01", true, 0, 0)
end
function PaGlobal_Enchant:removeApplyButtonEffect()
  self._uiButtonApply:EraseAllEffect()
end
function UpdateFunc_DoingEnchant(deltaTime)
  local self = PaGlobal_Enchant
  if true == self:isDoingEnchant() then
    self._currentTime = self._currentTime + deltaTime
    if self._currentTime >= 6 then
      self:doEnchant()
    end
    self._uiProtectItem_Btn:SetIgnore(true)
    self._uiCheckBtn_CronEnchnt:SetIgnore(true)
  end
end
function OnScreenEvent()
  local self = PaGlobal_Enchant
  local sizeX = getScreenSizeX()
  local sizeY = getScreenSizeY()
  Panel_Window_Enchant:SetPosX(sizeX / 2 - Panel_Window_Enchant:GetSizeX() / 2)
  Panel_Window_Enchant:SetPosY(sizeY - Panel_Window_Enchant:GetPosY() - Panel_Window_Enchant:GetSizeY())
  Panel_Window_Enchant:ComputePos()
  self._uiEnchantFailDesc:ComputePos()
end
PaGlobal_Enchant:initialize()
