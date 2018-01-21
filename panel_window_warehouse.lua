Panel_Window_Warehouse:SetShow(false, false)
Panel_Window_Warehouse:setMaskingChild(true)
Panel_Window_Warehouse:ActiveMouseEventEffect(true)
Panel_Window_Warehouse:setGlassBackground(true)
Panel_Window_Warehouse:RegisterShowEventFunc(true, "WarehouseShowAni()")
Panel_Window_Warehouse:RegisterShowEventFunc(false, "WarehouseHideAni()")
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local UI_PUCT = CppEnums.PA_UI_CONTROL_TYPE
local UI_TM = CppEnums.TextMode
function WarehouseShowAni()
  Panel_Window_Warehouse:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_Window_Warehouse, 0, 0.15)
  audioPostEvent_SystemUi(1, 0)
end
function WarehouseHideAni()
  Panel_Window_Warehouse:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_Warehouse:addColorAnimation(0, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
  audioPostEvent_SystemUi(1, 0)
end
local effectScene = {
  newItem = {}
}
local _wareHouse_HelpMovie = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_WEBCONTROL, Panel_Window_Warehouse, "Static_ClassMovie")
local _wareHouse_HelpMovie_Btn = UI.getChildControl(Panel_Window_Warehouse, "Static_MoviePlayButton")
local _wareHouseHelp = UI.getChildControl(Panel_Window_Warehouse, "StaticText_LoaderHelp")
local warehouse = {
  slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCooltime = true,
    createExpiration = true,
    createExpirationBG = true,
    createExpiration2h = true,
    createClassEquipBG = true,
    createEnduranceIcon = true,
    createCash = true,
    createEnduranceIcon = true,
    createCheckBox = true
  },
  config = {
    slotCount = 64,
    slotCols = 8,
    slotRows = 0,
    slotStartX = 19,
    slotStartY = 64,
    slotGapX = 47,
    slotGapY = 47
  },
  blankSlots = Array.new(),
  slots = Array.new(),
  slotNilEffect = {},
  slotFilterEffect = {},
  staticTitle = UI.getChildControl(Panel_Window_Warehouse, "Static_Text_Title"),
  staticCapacity = UI.getChildControl(Panel_Window_Warehouse, "Static_Text_Capacity"),
  staticWeight = UI.getChildControl(Panel_Window_Warehouse, "Static_Text_Weight"),
  staticMoney = UI.getChildControl(Panel_Window_Warehouse, "Static_Text_Money"),
  buttonMoney = UI.getChildControl(Panel_Window_Warehouse, "Button_Money"),
  buttonMoney2 = UI.getChildControl(Panel_Window_Warehouse, "Button_Money_2"),
  buttonClose = UI.getChildControl(Panel_Window_Warehouse, "Button_Win_Close"),
  buttonQuestion = UI.getChildControl(Panel_Window_Warehouse, "Button_Question"),
  checkSort = UI.getChildControl(Panel_Window_Warehouse, "CheckButton_ItemSort"),
  BtnMarketRegist = UI.getChildControl(Panel_Window_Warehouse, "Button_ItemMarketRegist"),
  BtnManufacture = UI.getChildControl(Panel_Window_Warehouse, "Button_Manufacture"),
  _buttonDelivery = UI.getChildControl(Panel_Window_Warehouse, "Button_DeliveryInformation"),
  BtnGuildUpdate = UI.getChildControl(Panel_Window_Warehouse, "Button_GuildUpdate"),
  _scroll = UI.getChildControl(Panel_Window_Warehouse, "Scroll_WareHouse"),
  moneyTitle = UI.getChildControl(Panel_Window_Warehouse, "StaticText_MoneyTitle"),
  bottomBG = UI.getChildControl(Panel_Window_Warehouse, "Static_BlackPanel_Bottom1"),
  assetBG = UI.getChildControl(Panel_Window_Warehouse, "Static_BlackPanel_Bottom2"),
  assetTitle = UI.getChildControl(Panel_Window_Warehouse, "StaticText_AssetValueTitle"),
  assetValue = UI.getChildControl(Panel_Window_Warehouse, "StaticText_AssetValue"),
  _currentWaypointKey = 0,
  _currentRegionName = "None",
  _fromType = CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap,
  _installationActorKeyRaw = 0,
  _targetActorKeyRaw = nil,
  _deleteSlotNo = nil,
  _s64_deleteCount = Defines.s64_const.s64_0,
  _startSlotIndex = 0,
  _tooltipSlotNo = nil,
  _myAsset = toInt64(0, 0),
  itemMarketFilterFunc = nil,
  itemMarketRclickFunc = nil,
  manufactureFilterFunc = nil,
  manufactureRclickFunc = nil,
  addSizeY = 30,
  sellCheck = false
}
function warehouse:init()
  _wareHouse_HelpMovie_Btn:addInputEvent("Mouse_On", "Panel_WareHouse_MovieHelpFunc( true )")
  _wareHouse_HelpMovie_Btn:addInputEvent("Mouse_Out", "Panel_WareHouse_MovieHelpFunc( false )")
  self.config.slotRows = self.config.slotCount / self.config.slotCols
  for ii = 0, self.config.slotCount - 1 do
    local slotNo = ii + 1
    local slot = {}
    slot.empty = UI.createAndCopyBasePropertyControl(Panel_Window_Warehouse, "Static_Slot", Panel_Window_Warehouse, "Warehouse_Slot_Base_" .. ii)
    slot.lock = UI.createAndCopyBasePropertyControl(Panel_Window_Warehouse, "Static_LockedSlot", Panel_Window_Warehouse, "Warehouse_Slot_Lock_" .. ii)
    slot.plus = UI.createAndCopyBasePropertyControl(Panel_Window_Warehouse, "Static_PlusSlot", Panel_Window_Warehouse, "Warehouse_Slot_Plus_" .. ii)
    slot.onlyPlus = UI.createAndCopyBasePropertyControl(Panel_Window_Warehouse, "Static_OnlyPlus", Panel_Window_Warehouse, "Warehouse_Slot_OnlyPlus_" .. ii)
    UIScroll.InputEventByControl(slot.empty, "Warehouse_Scroll")
    local row = math.floor(ii / self.config.slotCols)
    local column = ii % self.config.slotCols
    slot.empty:SetPosX(self.config.slotStartX + self.config.slotGapX * column)
    slot.empty:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.lock:SetPosX(self.config.slotStartX + self.config.slotGapX * column)
    slot.lock:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.plus:SetPosX(self.config.slotStartX + self.config.slotGapX * column)
    slot.plus:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.onlyPlus:SetPosX(self.config.slotStartX + self.config.slotGapX * column)
    slot.onlyPlus:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.empty:SetShow(false)
    slot.lock:SetShow(true)
    slot.plus:SetShow(false)
    slot.onlyPlus:SetShow(false)
    self.blankSlots[ii] = slot
  end
  for ii = 0, self.config.slotCount - 1 do
    local slot = {}
    SlotItem.new(slot, "ItemIcon_" .. ii, ii, Panel_Window_Warehouse, self.slotConfig)
    slot:createChild()
    local row = math.floor(ii / self.config.slotCols)
    local column = ii % self.config.slotCols
    slot.icon:SetPosX(self.config.slotStartX + self.config.slotGapX * column)
    slot.icon:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.icon:SetEnableDragAndDrop(true)
    slot.icon:SetAutoDisableTime(0.5)
    slot.icon:addInputEvent("Mouse_RUp", "HandleClickedWarehouseItem(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_LUp", "Warehouse_DropHandler(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_LDown", "Warehouse_LDownClick(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_PressMove", "Warehouse_SlotDrag(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_On", "Warehouse_IconOver(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_Out", "Warehouse_IconOut(" .. ii .. ")")
    UIScroll.InputEventByControl(slot.icon, "Warehouse_Scroll")
    Panel_Tooltip_Item_SetPosition(ii, slot, "WareHouse")
    self.slots[ii] = slot
  end
  self.BtnManufacture:addInputEvent("Mouse_LUp", "HandleClicked_ManufactureOpen()")
  self.BtnMarketRegist:addInputEvent("Mouse_LUp", "HandleClicked_WhItemMarketRegistItem_Open()")
  self.BtnMarketRegist:SetShow(false)
  self.BtnGuildUpdate:addInputEvent("Mouse_LUp", "HandleClicked_GuildWareHouseUpdate()")
  self._scroll:SetShow(true)
  _wareHouse_HelpMovie:SetSize(320, 240)
  _wareHouse_HelpMovie:SetSpanSize(-1, 0)
  _wareHouse_HelpMovie:SetShow(false)
  self.BtnManufacture:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WAREHOUSE_BTNTEXT_1"))
  self.BtnMarketRegist:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WAREHOUSE_BTNTEXT_2"))
  local btnDeliverySizeX = self._buttonDelivery:GetSizeX() + 23
  local btnDeliveryTextPosX = btnDeliverySizeX - btnDeliverySizeX / 2 - self._buttonDelivery:GetTextSizeX() / 2
  self._buttonDelivery:SetTextSpan(btnDeliveryTextPosX, 5)
end
local btnMarketRegSpanSizeY = warehouse.BtnMarketRegist:GetSpanSize().y
function warehouse:update()
  local warehouseWrapper = self:getWarehouse()
  if nil == warehouseWrapper then
    return
  end
  local addSizeY = 0
  if warehouse:isNpc() then
    addSizeY = self.addSizeY
  end
  local useStartSlot = 1
  local itemCount = warehouseWrapper:getSize()
  local useMaxCount = warehouseWrapper:getUseMaxCount()
  local freeCount = warehouseWrapper:getFreeCount()
  local money_s64 = warehouseWrapper:getMoney_s64()
  local maxCount = warehouseWrapper:getMaxCount()
  if itemCount > useMaxCount - useStartSlot then
    self.staticCapacity:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "Lua_WareHouse_OverCapacity", "HaveCount", tostring(itemCount), "FullCount", tostring(useMaxCount - useStartSlot)))
  else
    self.staticCapacity:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "Lua_WareHouse_Capacity", "HaveCount", tostring(itemCount), "FullCount", tostring(useMaxCount - useStartSlot)))
  end
  self.staticMoney:SetText(makeDotMoney(money_s64))
  local slotNoList = Array.new()
  slotNoList:fill(useStartSlot, maxCount - 1)
  if self.checkSort:IsCheck() then
    local sortList = Array.new()
    sortList:fill(useStartSlot, useMaxCount - 1)
    sortList:quicksort(Warehouse_ItemComparer)
    for ii = 1, useMaxCount - 1 do
      slotNoList[ii] = sortList[ii]
    end
  end
  for ii = 0, self.config.slotCount - 1 do
    local slot = self.blankSlots[ii]
    slot.empty:SetShow(false)
    slot.lock:SetShow(false)
    slot.plus:SetShow(false)
    slot.onlyPlus:SetShow(false)
    if ii < useMaxCount - useStartSlot - self._startSlotIndex then
      slot.empty:SetShow(true)
    elseif ii == useMaxCount - useStartSlot - self._startSlotIndex then
      if isGameServiceTypeDev() then
        if self.slots[ii].icon:GetShow() then
          slot.onlyPlus:SetShow(true)
        else
          slot.plus:SetShow(true)
        end
        Panel_Window_Warehouse:SetChildIndex(slot.plus, 15099)
        Panel_Window_Warehouse:SetChildIndex(slot.onlyPlus, 15100)
      else
        slot.lock:SetShow(true)
      end
    else
      slot.lock:SetShow(true)
    end
  end
  UIScroll.SetButtonSize(self._scroll, self.config.slotCount, maxCount - useStartSlot)
  for ii = 0, self.config.slotCount - 1 do
    local slot = self.slots[ii]
    slot:clearItem()
    slot.icon:SetEnable(true)
    slot.icon:SetMonoTone(true)
  end
  if not self:isGuildHouse() then
    self._myAsset = toInt64(0, 0)
    if useMaxCount >= 2 then
      for ii = 0, useMaxCount - 2 do
        local slotNo = slotNoList[1 + ii + 0]
        local itemWrapper = warehouseWrapper:getItem(slotNo)
        if nil ~= itemWrapper then
          local itemSSW = itemWrapper:getStaticStatus()
          local itemEnchantKey = itemSSW:get()._key:get()
          local itemCount_s64 = itemWrapper:get():getCount_s64()
          local npcSellPrice_s64 = itemSSW:get()._sellPriceToNpc_s64
          local tradeInfo
          local tradeSummaryInfo = getItemMarketSummaryInClientByItemEnchantKey(itemEnchantKey)
          local tradeMasterInfo = getItemMarketMasterByItemEnchantKey(itemEnchantKey)
          if nil ~= tradeSummaryInfo then
            tradeInfo = tradeSummaryInfo
          elseif nil ~= tradeMasterInfo then
            tradeInfo = tradeMasterInfo
          else
            tradeInfo = nil
          end
          if nil ~= tradeInfo then
            if nil ~= tradeSummaryInfo and toInt64(0, 0) ~= tradeSummaryInfo:getDisplayedTotalAmount() then
              self._myAsset = self._myAsset + (tradeInfo:getDisplayedLowestOnePrice() + tradeInfo:getDisplayedHighestOnePrice()) / toInt64(0, 2) * itemCount_s64
            else
              self._myAsset = self._myAsset + (tradeMasterInfo:getMinPrice() + tradeMasterInfo:getMaxPrice()) / toInt64(0, 2) * itemCount_s64
            end
          else
            self._myAsset = self._myAsset + npcSellPrice_s64 * itemCount_s64
          end
        end
      end
    end
    self.assetTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WAREHOUSE_ASSETS"))
    self.assetValue:SetText(makeDotMoney(self._myAsset + money_s64))
  end
  for ii = 0, self.config.slotCount - 1 do
    local slot = self.slots[ii]
    local slotNo = slotNoList[1 + ii + self._startSlotIndex]
    slot.slotNo = slotNo
    local row = math.floor(ii / self.config.slotCols)
    local column = ii % self.config.slotCols
    slot.icon:SetPosX(self.config.slotStartX + self.config.slotGapX * column)
    slot.icon:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.icon:SetMonoTone(false)
    slot.count:SetShow(false)
    local itemExist = false
    local itemWrapper = warehouseWrapper:getItem(slotNo)
    if nil ~= itemWrapper then
      slot:setItem(itemWrapper)
      if nil ~= self.itemMarketFilterFunc then
        if false == self.itemMarketFilterFunc(slot.icon, itemWrapper) then
          if self.slotFilterEffect[ii] then
            slot.icon:EraseEffect(self.slotFilterEffect[ii])
            self.slotFilterEffect[ii] = nil
          end
          self.slotFilterEffect[ii] = slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
          slot.icon:SetMonoTone(false)
          slot.icon:SetEnable(true)
          slot.icon:SetIgnore(false)
        else
          if self.slotFilterEffect[ii] then
            slot.icon:EraseEffect(self.slotFilterEffect[ii])
            self.slotFilterEffect[ii] = nil
          end
          slot.icon:SetMonoTone(true)
          slot.icon:SetEnable(false)
          slot.icon:SetIgnore(true)
        end
      elseif nil ~= self.manufactureFilterFunc then
        if false == self.manufactureFilterFunc(slot.slotNo, itemWrapper) then
          if self.slotFilterEffect[ii] then
            slot.icon:EraseEffect(self.slotFilterEffect[ii])
            self.slotFilterEffect[ii] = nil
          end
          self.slotFilterEffect[ii] = slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
          slot.icon:SetMonoTone(false)
          slot.icon:SetEnable(true)
          slot.icon:SetIgnore(false)
        else
          if self.slotFilterEffect[ii] then
            slot.icon:EraseEffect(self.slotFilterEffect[ii])
            self.slotFilterEffect[ii] = nil
          end
          slot.icon:SetMonoTone(true)
          slot.icon:SetEnable(false)
          slot.icon:SetIgnore(true)
        end
      else
        if self.slotFilterEffect[ii] then
          slot.icon:EraseEffect(self.slotFilterEffect[ii])
          self.slotFilterEffect[ii] = nil
        end
        slot.icon:SetMonoTone(false)
        slot.icon:SetEnable(true)
        slot.icon:SetIgnore(false)
      end
      if nil ~= self.itemMarketRclickFunc then
      end
      if nil == self.itemMarketFilterFunc then
        local packingCount_s64 = delivery_getPackItemCount(slotNo)
        if Defines.s64_const.s64_0 == itemWrapper:get():getCount_s64() then
          slot.icon:SetMonoTone(true)
        else
          slot.count:SetShow(true)
        end
      end
      itemExist = true
      if self.sellCheck then
        if not warehouse_itemMarketFilterFunc(nil, itemWrapper) and not itemWrapper:isCash() and itemWrapper:getStaticStatus():isDisposalWareHouse() then
          local isCheck = warehouseWrapper:isSellToSystem(slotNo)
          slot.checkBox:SetShow(true)
          slot.checkBox:SetCheck(isCheck)
          slot.checkBox:addInputEvent("Mouse_LUp", "Warehouse_CheckBoxSet(" .. slotNo .. ")")
          slot.icon:SetMonoTone(false)
        else
          slot.icon:SetMonoTone(true)
        end
      else
        slot.checkBox:SetShow(false)
      end
    else
      if nil ~= self.slotFilterEffect[ii] then
        slot.icon:EraseEffect(self.slotFilterEffect[ii])
        self.slotFilterEffect[ii] = nil
      end
      slot.icon:SetMonoTone(false)
      slot.icon:SetEnable(true)
      slot.icon:SetIgnore(false)
    end
    if not itemExist then
      slot:clearItem()
      slot.icon:SetEnable(true)
      slot.icon:SetMonoTone(true)
      slot.icon:SetIgnore(false)
    end
  end
  if true == self:isGuildHouse() or true == self:isFurnitureWareHouse() then
    self.bottomBG:SetSize(self.bottomBG:GetSizeX(), 55)
    self.assetBG:SetShow(false)
    self.assetTitle:SetShow(false)
    self.assetValue:SetShow(false)
    self.buttonMoney2:SetShow(false)
  else
    self.bottomBG:SetSize(self.bottomBG:GetSizeX(), 85)
    self.assetBG:SetShow(true)
    self.assetTitle:SetShow(true)
    self.assetValue:SetShow(true)
    self.buttonMoney2:SetShow(true)
  end
  Panel_Tooltip_Item_hideTooltip()
  WareHouse_PanelSize_Change(warehouse:isNpc())
end
function warehouse:isNpc()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc == self._fromType
end
function warehouse:isInstallation()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation == self._fromType
end
function warehouse:isWorldMapNode()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap == self._fromType
end
function warehouse:isGuildHouse()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_GuildHouse == self._fromType
end
function warehouse:isMaid()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid == self._fromType
end
function warehouse:isManufacture()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture == self._fromType
end
function warehouse:isFurnitureWareHouse()
  if true == isFurnitureWarehouse_chk() then
    return CppEnums.WarehoouseFromType.eWarehoouseFromType_Furniture == self._fromType
  else
    return false
  end
end
function warehouse:isDeliveryWindow()
  return (Panel_Window_Delivery_Request:GetShow())
end
function warehouse:getWarehouse()
  local warehouseWrapper
  if warehouse:isGuildHouse() then
    warehouseWrapper = warehouse_getGuild()
  elseif warehouse:isFurnitureWareHouse() then
    warehouseWrapper = ToClient_getFurniturewarehouse()
  else
    warehouseWrapper = warehouse_get(self._currentWaypointKey)
  end
  return warehouseWrapper
end
function FGlobal_WarehouseOpenByMaidCheck()
  return warehouse:isMaid()
end
function FGlobal_Warehouse_CurrentWaypointKey()
  local self = warehouse
  return warehouse._currentWaypointKey
end
function Panel_WareHouse_MovieHelpFunc(isOn)
  _wareHouse_HelpMovie:SetPosX(Panel_Window_Warehouse:GetSizeX())
  _wareHouse_HelpMovie:SetPosY(70)
  _wareHouseHelp:SetPosX(_wareHouse_HelpMovie:GetPosX())
  _wareHouseHelp:SetPosY(_wareHouse_HelpMovie:GetPosY() - _wareHouseHelp:GetSizeY())
  if isOn == true then
    _wareHouseHelp:SetShow(true)
    _wareHouseHelp:SetSize(320, 40)
    _wareHouseHelp:SetTextMode(UI_TM.eTextMode_AutoWrap)
    _wareHouseHelp:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_WAREHOUSE_HELP"))
    _wareHouse_HelpMovie:SetShow(true)
    _wareHouse_HelpMovie:TriggerEvent("PlayMovie", "coui://UI_Movie/Movie_Guide/WareHouse_AddSlot_KR.webm")
  else
    _wareHouseHelp:SetShow(false)
    _wareHouse_HelpMovie:SetShow(false)
  end
end
function warehouse:registMessageHandler()
  registerEvent("FromClient_WarehouseOpenByInstallation", "FromClient_WarehouseOpenByInstallation")
  registerEvent("EventWarehouseUpdate", "FromClient_WarehouseUpdate")
  registerEvent("FromClient_WarehouseClose", "FromClient_WarehouseClose")
  registerEvent("EventGuildWarehouseUpdate", "FromClient_GuildWarehouseUpdate")
  registerEvent("FromClient_FurnitureWarehouseUpdate", "FromClient_FurnitureWarehouseUpdate")
end
function warehouse:registEventHandler()
  UIScroll.InputEvent(self._scroll, "Warehouse_Scroll")
  UIScroll.InputEventByControl(Panel_Window_Warehouse, "Warehouse_Scroll")
  self.buttonClose:addInputEvent("Mouse_LUp", "Warehouse_Close()")
  self.buttonMoney:addInputEvent("Mouse_LUp", "HandleClickedWarehousePopMoney()")
  self.buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"WareHouse\" )")
  self.buttonQuestion:addInputEvent("Mouse_On", "HelpMessageQuestion_Show( \"WareHouse\", \"true\")")
  self.buttonQuestion:addInputEvent("Mouse_Out", "HelpMessageQuestion_Show( \"WareHouse\", \"false\")")
  self._buttonDelivery:addInputEvent("Mouse_LUp", "Warehouse_OpenDelivery()")
  self.checkSort:addInputEvent("Mouse_LUp", "Warehouse_CheckSort()")
end
function FGlobal_Warehouse_IsMoveItem()
  local self = warehouse
  if self:isNpc() or self:isInstallation() or not self:isWorldMapNode() or self:isDeliveryWindow() or self:isGuildHouse() or self:isMaid() or self:isFurnitureWareHouse() then
    return true
  end
  return false
end
function FromClient_WarehouseUpdate()
  if not Panel_Window_Warehouse:GetShow() then
    return
  end
  local self = warehouse
  self:update()
end
function FromClient_WarehouseClose()
  Warehouse_Close()
end
function FromClient_GuildWarehouseUpdate(bForcedOpen, bForcedClose)
  if Worldmap_Grand_GuildHouseControl:GetShow() or Worldmap_Grand_GuildCraft:GetShow() then
    return
  end
  if Panel_Window_NpcShop:IsShow() then
    NpcShop_UpdateContent()
    return
  end
  if false == bForcedOpen and false == Panel_Window_Warehouse:GetShow() then
    return
  end
  if true == bForcedClose then
    Warehouse_Close()
    return
  end
  if Panel_Window_Warehouse:GetShow() and not warehouse.BtnGuildUpdate:GetShow() then
    return
  end
  local self = warehouse
  self._currentWaypointKey = 0
  self._fromType = CppEnums.WarehoouseFromType.eWarehoouseFromType_GuildHouse
  self._currentRegionName = PAGetString(Defines.StringSheet_GAME, "Lua_WareHouse_CurrentRegionName")
  self.staticTitle:SetText(self._currentRegionName)
  self:update()
  if FGlobal_Warehouse_IsMoveItem() then
    self.buttonMoney:SetIgnore(false)
  else
    self.buttonMoney:SetIgnore(true)
  end
  warehouse.BtnMarketRegist:SetShow(false)
  warehouse.BtnManufacture:SetShow(false)
  warehouse._buttonDelivery:SetShow(false)
  warehouse.BtnGuildUpdate:SetShow(true)
  Warehouse_SetIgnoreMoneyButton(true)
  Panel_Window_Warehouse:ChangeSpecialTextureInfoName("")
  Panel_Window_Warehouse:SetAlphaExtraChild(1)
  Panel_Window_Warehouse:SetShow(true, true)
  Warehouse_OpenWithInventory()
end
function FromClient_FurnitureWarehouseUpdate()
  if false == isFurnitureWarehouse_chk() then
    return
  end
  local self = warehouse
  self._currentWaypointKey = 0
  self._fromType = CppEnums.WarehoouseFromType.eWarehoouseFromType_Furniture
  self._currentRegionName = PAGetString(Defines.StringSheet_GAME, "Lua_WareHouse_FurnitureName")
  self.staticTitle:SetText(self._currentRegionName)
  self:update()
  self.buttonMoney:SetIgnore(true)
  warehouse.BtnMarketRegist:SetShow(false)
  warehouse.BtnManufacture:SetShow(false)
  warehouse._buttonDelivery:SetShow(false)
  warehouse.BtnGuildUpdate:SetShow(false)
  warehouse.staticMoney:SetShow(false)
  warehouse.buttonMoney:SetShow(false)
  Warehouse_SetIgnoreMoneyButton(true)
  Panel_Window_Warehouse:ChangeSpecialTextureInfoName("")
  Panel_Window_Warehouse:SetAlphaExtraChild(1)
  Panel_Window_Warehouse:SetShow(true, true)
  if false == Panel_Window_Inventory:IsShow() then
    local self = warehouse
    Inventory_SetFunctor(FGlobal_FurnitureWarehouse_Filter, FGlobal_PopupMoveItem_InitByInventory, Warehouse_Close, nil)
    InventoryWindow_Show()
    self._startSlotIndex = 0
    self._scroll:SetControlTop()
    ServantInventory_OpenAll()
    Panel_Window_Warehouse:SetPosX(10)
    Panel_Window_Warehouse:SetPosY(280)
  end
end
function FGlobal_FurnitureWarehouse_Filter(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  if true == itemWrapper:getStaticStatus():isItemInstallation() then
    return false
  end
  return true
end
local panelSizeY = Panel_Window_Warehouse:GetSizeY()
local bg1_y = warehouse.bottomBG:GetSizeY()
local bg2_y = warehouse.assetBG:GetSizeY()
local assetTitlePosY = warehouse.assetTitle:GetPosY()
local assetValuePosY = warehouse.assetValue:GetPosY()
local staticCapacityPosY = warehouse.staticCapacity:GetPosY()
local moneyValuePosY = warehouse.staticMoney:GetPosY()
function WareHouse_PanelSize_Change(isNpc)
  local self = warehouse
  local bigSizeY
  if isNpc then
    bigSizeY = self.addSizeY
    self.moneyTitle:SetShow(true)
    if self.BtnManufacture:GetShow() or self.BtnMarketRegist:GetShow() then
      self.staticCapacity:SetPosY(staticCapacityPosY - 14)
    else
      self.staticCapacity:SetPosY(staticCapacityPosY + bigSizeY)
    end
  else
    bigSizeY = 0
    self.moneyTitle:SetShow(false)
    self.staticCapacity:SetPosY(staticCapacityPosY + bigSizeY)
  end
  if not self:isGuildHouse() then
    Panel_Window_Warehouse:SetSize(Panel_Window_Warehouse:GetSizeX(), panelSizeY + bigSizeY)
  else
    Panel_Window_Warehouse:SetSize(Panel_Window_Warehouse:GetSizeX(), panelSizeY - bigSizeY)
  end
  self.bottomBG:SetSize(self.bottomBG:GetSizeX(), bg1_y + bigSizeY)
  self.assetBG:SetSize(self.assetBG:GetSizeX(), bg2_y + bigSizeY)
  self.assetTitle:SetPosY(assetTitlePosY + bigSizeY)
  self.assetValue:SetPosY(assetValuePosY + bigSizeY)
  self.staticMoney:SetPosY(moneyValuePosY + bigSizeY)
  self.buttonMoney:SetSpanSize(self.staticMoney:GetTextSizeX() + self.buttonMoney:GetSizeX() + 2, self.staticMoney:GetSpanSize().y - 7)
  self.buttonMoney2:SetSpanSize(self.assetValue:GetTextSizeX() + self.buttonMoney2:GetSizeX() + 5, self.assetValue:GetSpanSize().y - 7)
end
function Warehouse_ItemComparer(ii, jj)
  return Global_ItemComparer(ii, jj, Warehouse_GetItem)
end
function Warehouse_CheckSort()
  local self = warehouse
  if self.sellCheck then
  end
  audioPostEvent_SystemUi(0, 0)
  local isSorted = self.checkSort:IsCheck()
  ToClient_SetSortedWarehouse(isSorted)
  FromClient_WarehouseUpdate()
end
function Warehouse_OpenDelivery()
  local self = warehouse
  DeliveryInformation_OpenPanelFromWorldmap(self._currentWaypointKey)
end
function HandleClickedWarehousePopMoney()
  local self = warehouse
  local slotNo = getMoneySlotNo()
  if not FGlobal_Warehouse_IsMoveItem() then
    return
  end
  HandleClickedWarehouseItemXXX(slotNo)
end
function HandleClickedWarehouseItem(index)
  if Warehouse_DropHandler(index) then
    return
  end
  if not FGlobal_Warehouse_IsMoveItem() then
    return
  end
  local self = warehouse
  local slotNo = self.slots[index].slotNo
  if nil == self.itemMarketRclickFunc and nil == self.manufactureRclickFunc then
    HandleClickedWarehouseItemXXX(slotNo)
  else
    local warehouseWrapper = self:getWarehouse()
    local itemWrapper = warehouseWrapper:getItem(slotNo)
    if nil ~= self.manufactureRclickFunc then
      self.manufactureRclickFunc(slotNo, itemWrapper, itemWrapper:get():getCount_s64())
    elseif nil ~= itemWrapper then
      warehouse_itemMarketRclickFunc(slotNo, itemWrapper, itemWrapper:get():getCount_s64())
    end
  end
end
function HandleClickedWarehouseItemXXX(slotNo)
  local self = warehouse
  local warehouseWrapper = self:getWarehouse()
  local itemWrapper = warehouseWrapper:getItem(slotNo)
  if nil == itemWrapper then
    return
  end
  if Defines.s64_const.s64_0 == itemWrapper:get():getCount_s64() then
    return
  end
  FGlobal_PopupMoveItem_Init(nil, slotNo, CppEnums.MoveItemToType.Type_Warehouse, nil, true)
end
function HandleClicked_WhItemMarketRegistItem_Open(byMaid)
  local self = warehouse
  if self.sellCheck then
    Proc_ShowMessage_Ack("\236\160\149\235\166\172 \237\149\180\236\160\156 \237\155\132 \236\130\172\236\154\169\237\149\180\236\163\188\236\132\184\236\154\148.")
    return
  end
  local isOpenWarehouse = true
  Inventory_SetFunctor(nil, nil, nil, nil)
  FGlobal_ItemMarketRegistItem_Open(isOpenWarehouse, byMaid)
  self.itemMarketFilterFunc = warehouse_itemMarketFilterFunc
  self.itemMarketRclickFunc = warehouse_itemMarketRclickFunc
  Panel_Window_Warehouse:SetPosX(0)
  self:update()
end
function HandleClicked_ManufactureOpen()
  local self = warehouse
  if self.sellCheck then
    Proc_ShowMessage_Ack("\236\160\149\235\166\172 \237\149\180\236\160\156 \237\155\132 \236\130\172\236\154\169\237\149\180\236\163\188\236\132\184\236\154\148.")
    return
  end
  Manufacture_Show(nil, CppEnums.ItemWhereType.eWarehouse, true, nil, self._currentWaypointKey)
end
function Warehouse_CheckBoxSet(slotNo)
  warehouse_checkSellToSystem(slotNo)
  local self = warehouse
  local warehouseWrapper = self:getWarehouse()
  local isCheck = warehouseWrapper:isSellToSystem(slotNo)
  self.slots[slotNo - 1].checkBox:SetCheck(isCheck)
  self:update()
end
function warehouse_itemMarketFilterFunc(slot, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  local isAble = requestIsRegisterItemForItemMarket(itemWrapper:get():getKey())
  return not isAble
end
function warehouse_itemMarketRclickFunc(slotNo, itemWrapper, s64_count)
  local self = warehouse
  _PA_LOG("cylee", "warehouse_itemMarketRclickFunc() waypointKey:" .. tostring(self._currentWaypointKey))
  if Defines.s64_const.s64_1 == s64_count then
    FGlobal_ItemMarketRegistItemFromInventory(1, slotNo, CppEnums.ItemWhereType.eWarehouse, self._currentWaypointKey)
  else
    local masterInfo = getItemMarketMasterByItemEnchantKey(itemWrapper:get():getKey():get())
    if masterInfo ~= nil and s64_count > masterInfo:getMaxRegisterCount() then
      s64_count = masterInfo:getMaxRegisterCount()
    end
    Panel_NumberPad_Show(true, s64_count, slotNo, FGlobal_ItemMarketRegistItemFromInventory, nil, CppEnums.ItemWhereType.eWarehouse, nil, self._currentWaypointKey)
  end
end
function HandleClicked_WhItemMarketItemSet_Close()
  FGlobal_WareHouseItemMarketRegistItem_Close()
end
function HandleClicked_GuildWareHouseUpdate()
  warehouse_requestGuildWarehouseInfo()
end
function Warehouse_PushFromInventoryItem(s64_count, whereType, slotNo, fromActorKeyRaw)
  local self = warehouse
  self._targetActorKeyRaw = fromActorKeyRaw
  Panel_NumberPad_Show_MaxCount(true, s64_count, slotNo, Warehouse_PushFromInventoryItemXXX, nil, whereType)
end
function Warehouse_PushFromInventoryItemXXX(s64_count, slotNo, whereType)
  local self = warehouse
  if self:isNpc() or Panel_RemoteWarehouse:GetShow() then
    warehouse_pushFromInventoryItemByNpc(whereType, slotNo, s64_count, self._targetActorKeyRaw)
  elseif self:isInstallation() then
    warehouse_pushFromInventoryItemByInstallation(self._installationActorKeyRaw, whereType, slotNo, s64_count, self._targetActorKeyRaw)
  elseif self:isGuildHouse() then
    warehouse_pushFromInventoryItemByGuildHouse(whereType, slotNo, s64_count, self._targetActorKeyRaw)
  elseif self:isFurnitureWareHouse() then
    ToClient_pushFromInventoryItemByFurnitureWarehouse(whereType, slotNo)
  elseif self:isMaid() then
    local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
    if nil == regionInfo then
      return
    end
    local warehouseInMaid = checkMaid_WarehouseIn(true)
    if warehouseInMaid then
      warehouse_pushFromInventoryItemByMaid(whereType, slotNo, s64_count, self._targetActorKeyRaw)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_COOLTIME"))
    end
  end
end
function Warehouse_PopToSomewhere(s64_count, slotNo, toActorKeyRaw)
  local self = warehouse
  self._targetActorKeyRaw = toActorKeyRaw
  if FGlobal_WarehouseOpenByMaidCheck() then
    local warehouseWrapper = warehouse:getWarehouse()
    local itemWrapper = warehouseWrapper:getItem(slotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local weight = Int64toInt32(itemSSW:get()._weight) / 10000
      if Int64toInt32(s64_count) < 0 then
        s64_count = toInt64(0, 2147483647)
      end
      s64_count = toInt64(0, math.min(math.floor(100 / weight), Int64toInt32(s64_count)))
    end
  end
  Panel_NumberPad_Show(true, s64_count, slotNo, Warehouse_PopToSomewhereXXX)
end
function Warehouse_PopToSomewhereXXX(s64_count, slotNo)
  local self = warehouse
  if Panel_Window_Inventory:GetShow() and GetUIMode() ~= Defines.UIMode.eUIMode_WorldMap then
    if self:isNpc() then
      warehouse_popToInventoryByNpc(slotNo, s64_count, self._targetActorKeyRaw)
    elseif self:isInstallation() then
      warehouse_popToInventoryByInstallation(self._installationActorKeyRaw, slotNo, s64_count, self._targetActorKeyRaw)
    elseif self:isGuildHouse() then
      warehouse_popToInventoryByGuildHouse(slotNo, s64_count, self._targetActorKeyRaw)
    elseif self:isFurnitureWareHouse() then
      ToClient_popToInventoryByFurnitureWarehouse(slotNo)
    elseif self:isMaid() then
      local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
      if nil == regionInfo then
        return
      end
      local warehouseOutMaid = checkMaid_WarehouseOut(true)
      if warehouseOutMaid then
        warehouse_popToInventoryByMaid(slotNo, s64_count, self._targetActorKeyRaw)
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_COOLTIME"))
      end
    end
  elseif Panel_Window_Delivery_Request:GetShow() then
    DeliveryRequest_PushPackingItem(slotNo, s64_count)
  end
end
function Warehouse_Scroll(isUp)
  local self = warehouse
  local useStartSlot = 1
  local warehouseWrapper = self:getWarehouse()
  if nil == warehouseWrapper then
    return
  end
  local maxSize = warehouseWrapper:getMaxCount() - useStartSlot
  self._startSlotIndex = UIScroll.ScrollEvent(self._scroll, isUp, self.config.slotRows, maxSize, self._startSlotIndex, self.config.slotCols)
  self:update()
end
function Warehouse_SlotDrag(index)
  local self = warehouse
  local slotNo = self.slots[index].slotNo
  local warehouseWrapper = self:getWarehouse()
  local itemWrapper = warehouseWrapper:getItem(slotNo)
  if nil == itemWrapper then
    return
  end
  if Defines.s64_const.s64_0 == itemWrapper:get():getCount_s64() then
    return
  end
  DragManager:setDragInfo(Panel_Window_Warehouse, nil, slotNo, "Icon/" .. itemWrapper:getStaticStatus():getIconPath(), Warehouse_GroundClick, nil)
end
function Warehouse_DropHandler(index)
  local self = warehouse
  if nil == DragManager.dragStartPanel then
    return false
  end
  return (DragManager:itemDragMove(CppEnums.MoveItemToType.Type_Warehouse, nil))
end
function Warehouse_GroundClick(whereType, slotNo)
  if false == Panel_Window_Warehouse:GetShow() then
    return
  end
  local self = warehouse
  local warehouseWrapper = self:getWarehouse()
  local itemWrapper = warehouseWrapper:getItem(slotNo)
  if nil == itemWrapper then
    return
  end
  s64_count = itemWrapper:get():getCount_s64()
  itemName = itemWrapper:getStaticStatus():getName()
  if Defines.s64_const.s64_1 == s64_count then
    Warehouse_GroundClick_Message(Defines.s64_const.s64_1, slotNo)
  else
    Panel_NumberPad_Show(true, s64_count, slotNo, Warehouse_GroundClick_Message)
  end
end
function Warehouse_LDownClick(index)
  local self = warehouse
  local warehouseWrapper = self:getWarehouse()
  if nil == warehouseWrapper then
    return
  end
  local useStartSlot = 1
  local useMaxCount = warehouseWrapper:getUseMaxCount()
  if index == useMaxCount - useStartSlot - self._startSlotIndex and isGameServiceTypeDev() then
    PaGlobal_EasyBuy:Open(3, 7, 4, 1)
  end
end
function Warehouse_GroundClick_Message(s64_count, slotNo)
  local self = warehouse
  self._deleteSlotNo = slotNo
  self._s64_deleteCount = s64_count
  local luaDeleteItemMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETEITEM_MSG", "itemName", itemName, "itemCount", tostring(s64_count))
  local luaDelete = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETE")
  local messageContent = luaDeleteItemMsg
  local messageboxData = {
    title = luaDelete,
    content = messageContent,
    functionYes = Warehouse_Delete_Yes,
    functionNo = Warehouse_Delete_No,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function Warehouse_Delete_Yes()
  local self = warehouse
  if nil == self._deleteSlotNo then
    return
  end
  local warehouseWrapper = self:getWarehouse()
  local itemWrapper = warehouseWrapper:getItem(self._deleteSlotNo)
  if nil == itemWrapper then
    return
  end
  if itemWrapper:isCash() then
    PaymentPassword(Warehouse_Delete_YesXXX)
    return
  end
  Warehouse_Delete_YesXXX()
end
function Warehouse_Delete_YesXXX()
  local self = warehouse
  if self:isNpc() then
    warehouse_deleteItemByNpc(self._deleteSlotNo, self._s64_deleteCount)
  elseif self:isInstallation() then
    warehouse_deleteItemByInstallation(self._installationActorKeyRaw, self._deleteSlotNo, self._s64_deleteCount)
  end
  self._deleteSlotNo = nil
  self._s64_deleteCount = Defines.s64_const.s64_0
  DragManager:clearInfo()
end
function Warehouse_Delete_No()
  local self = warehouse
  self._deleteSlotNo = nil
  self._s64_deleteCount = Defines.s64_const.s64_0
end
function Warehouse_IconOver(index)
  local self = warehouse
  local slot = self.slots[index]
  if self.slotNilEffect[index] then
    slot.icon:EraseEffect(self.slotNilEffect[index])
    self.slotNilEffect[index] = slot.icon:AddEffect("UI_Inventory_EmptySlot", false, -1.5, -1.5)
  else
    self.slotNilEffect[index] = slot.icon:AddEffect("UI_Inventory_EmptySlot", false, -1.5, -1.5)
  end
  self._tooltipSlotNo = slot.slotNo
  Panel_Tooltip_Item_Show_GeneralNormal(index, "WareHouse", true)
end
function Warehouse_IconOut(index)
  local self = warehouse
  local slot = self.slots[index]
  self._tooltipSlotNo = nil
  Panel_Tooltip_Item_Show_GeneralNormal(index, "WareHouse", false)
end
function Warehouse_GetToopTipItem()
  local self = warehouse
  local warehouseWrapper = self:getWarehouse()
  if nil == warehouseWrapper then
    return nil
  end
  if nil == self._tooltipSlotNo then
    return nil
  end
  return (warehouseWrapper:getItem(self._tooltipSlotNo))
end
function Warehouse_GetItem(slotNo)
  local self = warehouse
  local warehouseWrapper = self:getWarehouse()
  if nil == warehouseWrapper then
    return nil
  end
  return (warehouseWrapper:getItem(slotNo))
end
function Warehouse_SetIgnoreMoneyButton(setIgnore)
  local self = warehouse
  if setIgnore == true then
    self.buttonMoney:SetIgnore(true)
  else
    self.buttonMoney:SetIgnore(false)
  end
end
function FromClient_WarehouseOpenByInstallation(actorKeyRaw, waypointKey)
  local self = warehouse
  self._installationActorKeyRaw = actorKeyRaw
  Warehouse_OpenPanel(waypointKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation)
  Warehouse_SetIgnoreMoneyButton(false)
  Warehouse_OpenWithInventory()
end
function Warehouse_OpenPanelFromDialog()
  local self = warehouse
  self.sellCheck = false
  warehouse_clearSellToSystem()
  if true == ToClient_IsDevelopment() then
    FGlobal_SearchMenuWareHouse_Open()
  end
  Warehouse_OpenPanel(getCurrentWaypointKey(), CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc)
  Warehouse_SetIgnoreMoneyButton(false)
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  if not ToClient_WorldMapIsShow() then
    Panel_Window_Warehouse:SetVerticalMiddle()
    Panel_Window_Warehouse:SetHorizonCenter()
    if screenSizeX <= 1400 then
      Panel_Window_Warehouse:SetSpanSize(screenSizeX / 2 - Panel_Window_Warehouse:GetPosX() / 2 - 490, -30)
    else
      Panel_Window_Warehouse:SetSpanSize(screenSizeX / 2 - Panel_Window_Warehouse:GetPosX() / 2 - 400, -30)
    end
  end
  Warehouse_OpenWithInventory()
  if Panel_Window_ItemMarket_RegistItem:GetShow() then
    FGlobal_ItemMarketRegistItem_Close()
  end
end
function Warehouse_OpenPanelFromDialogWithoutInventory(waypointKey, fromType)
  local self = warehouse
  Warehouse_OpenPanel(waypointKey, fromType)
  Warehouse_SetIgnoreMoneyButton(true)
  if ToClient_WorldMapIsShow() then
    Panel_Window_Warehouse:SetVerticalMiddle()
    Panel_Window_Warehouse:SetHorizonCenter()
    Panel_Window_Warehouse:SetSpanSize(100, 0)
  end
end
function Warehouse_OpenPanelFromWorldmap(waypointKey, fromType)
  local self = warehouse
  if ToClient_WorldMapIsShow() then
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Window_Warehouse, true)
    if isWorldMapGrandOpen() then
      Panel_Window_Warehouse:SetHorizonRight()
      Panel_Window_Warehouse:SetVerticalMiddle()
    else
      Panel_Window_Warehouse:SetHorizonRight()
      Panel_Window_Warehouse:SetVerticalBottom()
      Panel_Window_Warehouse:SetPosY(Panel_Window_Warehouse:GetPosY() - 50)
    end
  end
  Warehouse_OpenPanel(waypointKey, fromType)
  Warehouse_SetIgnoreMoneyButton(true)
  if not FGlobal_Warehouse_IsMoveItem() then
    DeliveryRequestWindow_Close()
    DeliveryInformationWindow_Close()
  end
  if true == self.BtnMarketRegist:GetShow() then
    self.BtnMarketRegist:SetShow(false)
  end
end
function Warehouse_OpenPanelFromMaid()
  local self = warehouse
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if nil == regionInfo then
    return
  end
  local regionInfoWrapper = getRegionInfoWrapper(regionInfo:getAffiliatedTownRegionKey())
  local plantWayKey = regionInfoWrapper:getPlantKeyByWaypointKey():getWaypointKey()
  local regionKey = regionInfoWrapper:getRegionKey()
  if ToClient_IsAccessibleRegionKey(regionKey) == false then
    plantWayKey = ToClient_GetOtherRegionKey_NeerByTownRegionKey()
    if 0 == plantWayKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CANTFIND_WAREHOUSE_INTERRITORY"))
      return
    end
  end
  warehouse._currentWaypointKey = plantWayKey
  Warehouse_OpenPanel(plantWayKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid)
  Warehouse_SetIgnoreMoneyButton(false)
  Warehouse_OpenWithInventory()
end
local btnMarketRegistSizeX = warehouse.BtnMarketRegist:GetSizeX()
function Warehouse_OpenPanel(waypointKey, fromType)
  local self = warehouse
  self._currentWaypointKey = waypointKey
  self._fromType = fromType
  self._currentRegionName = getRegionNameByWaypointKey(self._currentWaypointKey)
  self.staticTitle:SetText(self._currentRegionName)
  local isSorted = ToClient_IsSortedWarehouse()
  self.checkSort:SetCheck(isSorted)
  self._buttonDelivery:SetShow(false)
  if self:isWorldMapNode() then
    local regionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(waypointKey)
    if nil ~= regionInfoWrapper and regionInfoWrapper:get():hasDeliveryNpc() then
      self._buttonDelivery:SetShow(true)
    end
  end
  clearDeliveryPack()
  self.BtnManufacture:SetShow(false)
  if (CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc == self._fromType or CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture == self._fromType) and ToClient_isPossibleManufactureAtWareHouse() then
    self.BtnManufacture:SetShow(true)
  end
  local myRegionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local hasItemMarket = myRegionInfo:get():hasItemMarketNpc()
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if hasItemMarket and nil ~= dialog_getTalker() and dialog_isTalking() and not self:isGuildHouse() then
    self.BtnMarketRegist:SetShow(true)
  else
    self.BtnMarketRegist:SetShow(false)
  end
  if FGlobal_Warehouse_IsMoveItem() then
    self.buttonMoney:SetIgnore(false)
  else
    self.buttonMoney:SetIgnore(true)
  end
  warehouse.BtnGuildUpdate:SetShow(false)
  WareHouse_PanelSize_Change(warehouse:isNpc())
  if CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc == self._fromType then
    if self.BtnMarketRegist:GetShow() then
      if self.BtnManufacture:GetShow() then
        self.BtnMarketRegist:SetSize(btnMarketRegistSizeX - 30, self.BtnMarketRegist:GetSizeY())
        self.BtnManufacture:SetSize(btnMarketRegistSizeX - 30, self.BtnMarketRegist:GetSizeY())
        self.BtnMarketRegist:SetSpanSize(25 + self.BtnManufacture:GetSizeX() + 5, btnMarketRegSpanSizeY + self.addSizeY)
      else
        self.BtnMarketRegist:SetSize(btnMarketRegistSizeX, self.BtnMarketRegist:GetSizeY())
        self.BtnManufacture:SetSize(btnMarketRegistSizeX, self.BtnMarketRegist:GetSizeY())
        self.BtnMarketRegist:SetSpanSize(25, btnMarketRegSpanSizeY + self.addSizeY)
      end
    end
  elseif self.BtnManufacture:GetShow() then
    self.BtnMarketRegist:SetSpanSize(25 + self.BtnManufacture:GetSizeX() + 5, btnMarketRegSpanSizeY)
  end
  self.BtnManufacture:SetTextSpan((self.BtnManufacture:GetSizeX() + 26) / 2 - self.BtnManufacture:GetTextSizeX() / 2, self.BtnManufacture:GetSizeY() / 2 - self.BtnManufacture:GetTextSizeY() / 2)
  self.BtnMarketRegist:SetTextSpan((self.BtnMarketRegist:GetSizeX() + 26) / 2 - self.BtnMarketRegist:GetTextSizeX() / 2, self.BtnMarketRegist:GetSizeY() / 2 - self.BtnMarketRegist:GetTextSizeY() / 2)
  Panel_Window_Warehouse:ChangeSpecialTextureInfoName("")
  Panel_Window_Warehouse:SetAlphaExtraChild(1)
  Panel_Window_Warehouse:SetShow(true, true)
  self._startSlotIndex = 0
  self._scroll:SetControlTop()
  self._scroll:SetControlPos(0)
  warehouse_requestInfo(self._currentWaypointKey)
  if CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid == fromType then
    Panel_Window_Warehouse:SetPosX(getScreenSizeX() - Panel_Window_Inventory:GetSizeX() - Panel_Window_Warehouse:GetSizeX())
    Panel_Window_Warehouse:SetPosY(getScreenSizeY() / 2 - Panel_Window_Warehouse:GetSizeY() / 2)
  elseif CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture == fromType then
    Panel_Window_Warehouse:SetPosX(Panel_Manufacture:GetPosX() + Panel_Manufacture:GetSizeX() - 20)
    Panel_Window_Warehouse:SetPosY(Panel_Manufacture:GetPosY())
  end
  self:update()
end
function Warehouse_OpenWithInventory()
  local self = warehouse
  Inventory_SetFunctor(nil, FGlobal_PopupMoveItem_InitByInventory, Warehouse_Close, nil)
  InventoryWindow_Show()
  self._startSlotIndex = 0
  self._scroll:SetControlTop()
  ServantInventory_OpenAll()
end
function Warehouse_Close()
  local self = warehouse
  self._fromType = CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap
  if Panel_Window_Warehouse:GetShow() then
    if Panel_Window_Delivery_Information:GetShow() then
      DeliveryInformationWindow_Close()
    end
    if Panel_Window_Delivery_Request:GetShow() then
      DeliveryRequestWindow_Close()
    end
    if Panel_Window_Inventory:GetShow() then
      InventoryWindow_Close()
    end
    FGlobal_SearchMenuWareHouse_Close()
  end
  if nil ~= self.itemMarketFilterFunc then
    self.itemMarketFilterFunc = nil
    self.itemMarketRclickFunc = nil
  end
  if nil ~= self.manufactureRclickFunc then
    self.manufactureFilterFunc = nil
    self.manufactureRclickFunc = nil
  end
  if ToClient_WorldMapIsShow() then
    WorldMapPopupManager:pop()
  else
    Panel_Window_Warehouse:SetShow(false, false)
  end
  Panel_Window_Warehouse:ChangeSpecialTextureInfoName("")
  if ToClient_CheckExistSummonMaid() then
    ToClient_CallHandlerMaid("_maidLogOut")
  end
end
function Warehouse_GetWarehouseWarpper()
  local self = warehouse
  return self:getWarehouse()
end
function Warehouse_updateSlotData()
  FromClient_WarehouseUpdate()
end
function Warehouse_SetFunctor(filterFunc, rClickFunc)
  local self = warehouse
  if nil ~= filterFunc and "function" ~= type(filterFunc) then
    filterFunc = nil
    UI.ASSERT(false, "Param 1 must be Function type")
  end
  if nil ~= rClickFunc and "function" ~= type(rClickFunc) then
    rClickFunc = nil
    UI.ASSERT(false, "Param 2 must be Function type")
  end
  warehouse.manufactureFilterFunc = filterFunc
  warehouse.manufactureRclickFunc = rClickFunc
end
function FGlobal_Warehouse_ResetFilter()
  local self = warehouse
  if true == ToClient_IsDevelopment() and false == Panel_Window_SearchMenuWareHouse:GetShow() then
    FGlobal_SearchMenuWareHouse_Show(true)
  end
  if nil ~= self.itemMarketFilterFunc then
    self.itemMarketFilterFunc = nil
    self.itemMarketRclickFunc = nil
  end
  self:update()
end
function Warehouse_OpenPanelFromManufacture()
  Warehouse_OpenPanel(getCurrentWaypointKey(), CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture)
end
warehouse:init()
warehouse:registEventHandler()
warehouse:registMessageHandler()
