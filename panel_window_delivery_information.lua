Panel_Window_Delivery_Information:ActiveMouseEventEffect(true)
Panel_Window_Delivery_Information:setMaskingChild(true)
Panel_Window_Delivery_Information:setGlassBackground(true)
Panel_Window_Delivery_Information:RegisterShowEventFunc(true, "DeliveryInformationShowAni()")
Panel_Window_Delivery_Information:RegisterShowEventFunc(false, "DeliveryInformationHideAni()")
local UI_color = Defines.Color
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
function DeliveryInformationShowAni()
  Panel_Window_Delivery_Information:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_Window_Delivery_Information, 0.05, 0.15)
  local aniInfo1 = Panel_Window_Delivery_Information:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1)
  aniInfo1.AxisX = Panel_Window_Delivery_Information:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_Delivery_Information:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = false
  local aniInfo2 = Panel_Window_Delivery_Information:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_Delivery_Information:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_Delivery_Information:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = false
end
function DeliveryInformationHideAni()
  Panel_Window_Delivery_Information:ChangeSpecialTextureInfoName("")
  Panel_Window_Delivery_Information:SetAlpha(1)
  UIAni.AlphaAnimation(0, Panel_Window_Delivery_Information, 0, 0.1)
end
local deliveryInformation = {
  slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  const = {
    deliveryProgressTypeRequest = 0,
    deliveryProgressTypeIng = 1,
    deliveryProgressTypeComplete = 2
  },
  panel_Background = UI.getChildControl(Panel_Window_Delivery_Information, "Static_Bakcground"),
  button_Close = UI.getChildControl(Panel_Window_Delivery_Information, "Button_Win_Close"),
  buttonQuestion = UI.getChildControl(Panel_Window_Delivery_Information, "Button_Question"),
  button_Request = UI.getChildControl(Panel_Window_Delivery_Information, "Button_Send"),
  button_Information = UI.getChildControl(Panel_Window_Delivery_Information, "Button_Cancel_Recieve"),
  button_ReceiveAll = UI.getChildControl(Panel_Window_Delivery_Information, "Button_ReceiveAll"),
  button_Refresh = UI.getChildControl(Panel_Window_Delivery_Information, "Button_Refresh"),
  check_Cancel = UI.getChildControl(Panel_Window_Delivery_Information, "CheckButton_Cancel"),
  check_Recieve = UI.getChildControl(Panel_Window_Delivery_Information, "CheckButton_Recieve"),
  empty_List = UI.getChildControl(Panel_Window_Delivery_Information, "StaticText_Empty_List"),
  list2 = UI.getChildControl(Panel_Window_Delivery_Information, "List2_DeliveryItemList"),
  currentWaypointKey = 0,
  scrollIndex = 0
}
function deliveryInformation:registMessageHandler()
  registerEvent("FromClient_MoveDeliveryItem", "DeliveryInformation_UpdateSlotData")
end
function deliveryInformation:registEventHandler()
  self.button_Close:addInputEvent("Mouse_LUp", "DeliveryInformationWindow_Close()")
  self.buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"DeliveryInformation\" )")
  self.button_Request:addInputEvent("Mouse_LUp", "DeliveryRequestWindow_Open()")
  self.button_Refresh:addInputEvent("Mouse_LUp", "DeliveryInformation_Refresh()")
  self.button_ReceiveAll:addInputEvent("Mouse_LUp", "Delivery_Receive_All()")
  self.buttonQuestion:addInputEvent("Mouse_On", "HelpMessageQuestion_Show( \"DeliveryInformation\", \"true\")")
  self.buttonQuestion:addInputEvent("Mouse_Out", "HelpMessageQuestion_Show( \"DeliveryInformation\", \"false\")")
  self.check_Cancel:addInputEvent("Mouse_LUp", "DeliveryInformation_UpdateSlotData()")
  self.check_Recieve:addInputEvent("Mouse_LUp", "DeliveryInformation_UpdateSlotData()")
  self.check_Recieve:SetAutoDisableTime(4)
end
function deliveryInformation:init()
  local minSize = float2()
  minSize.x = 100
  minSize.y = 50
  local list2 = UI.getChildControl(Panel_Window_Delivery_Information, "List2_DeliveryItemList")
  local list2_Content = UI.getChildControl(list2, "List2_1_Content")
  local slot = {}
  list2:setMinScrollBtnSize(minSize)
  local list2_ItemSlot = UI.getChildControl(list2_Content, "Static_List2_Slot")
  SlotItem.new(slot, "Delivery_Slot_Icon_", 0, list2_ItemSlot, self.slotConfig)
  slot:createChild()
  slot.icon:SetPosX(9)
  slot.icon:SetPosY(9)
  self.list2:changeAnimationSpeed(10)
  self.list2:registEvent(CppEnums.PAUIList2EventType.luaChangeContent, "Delivery_ListControlCreate")
  self.list2:createChildContent(CppEnums.PAUIList2ElementManagerType.list)
  self.check_Cancel:SetCheck(true)
  self.check_Recieve:SetCheck(true)
end
local deliveryCountCache = 0
function deliveryInformation:updateSlot()
  local deliveryList = delivery_list(DeliveryInformation_WaypointKey())
  if nil == deliveryList then
    self.empty_List:SetShow(true)
    return
  else
    self.empty_List:SetShow(false)
  end
  local deliveryCount = deliveryList:size()
  if deliveryCount > deliveryCountCache then
    for idx = deliveryCountCache, deliveryCount - 1 do
      local deliveryInfo = deliveryList:atPointer(idx)
      if self.check_Cancel:IsCheck() and self.const.deliveryProgressTypeRequest == deliveryInfo:getProgressType() or self.check_Recieve:IsCheck() and self.const.deliveryProgressTypeComplete == deliveryInfo:getProgressType() then
        if nil ~= deliveryInfo then
          self.list2:getElementManager():pushKey(toInt64(0, idx))
        end
      else
        self.list2:getElementManager():removeKey(toInt64(0, idx))
      end
    end
  else
    for idx = deliveryCount, deliveryCountCache - 1 do
      self.list2:getElementManager():removeKey(toInt64(0, idx))
    end
  end
  deliveryCountCache = deliveryCount
  if 0 == deliveryCount then
    self.empty_List:SetShow(true)
  else
    self.empty_List:SetShow(false)
  end
  self.list2:moveIndex(self.scrollIndex)
end
function DeliveryInformation_WaypointKey()
  local self = deliveryInformation
  return self.currentWaypointKey
end
function DeliveryInformation_SlotIndex(slotNo)
  local self = deliveryInformation
  return slotNo
end
function DeliveryInformation_UpdateSlotData()
  if not Panel_Window_Delivery_Information:IsShow() then
    return
  end
  local self = deliveryInformation
  if nil ~= DeliveryInformation_WaypointKey() then
    deliveryList = delivery_list(DeliveryInformation_WaypointKey())
  end
  self.list2:getElementManager():clearKey()
  deliveryCountCache = 0
  self:updateSlot()
end
function DeliveryInformationWindow_Open()
  DeliveryRequestWindow_Close()
  Warehouse_SetIgnoreMoneyButton(true)
  if not Panel_Window_Delivery_Information:IsShow() then
    Panel_Window_Delivery_Information:SetAlphaExtraChild(1)
    Panel_Window_Delivery_Information:SetShow(true, true)
    delivery_requsetList()
    if ToClient_WorldMapIsShow() then
      WorldMapPopupManager:increaseLayer(true)
      WorldMapPopupManager:push(Panel_Window_Delivery_Information, true)
    end
  end
  local self = deliveryInformation
  self:updateSlot()
  Panel_Window_Delivery_Information:SetPosX(Panel_Window_Warehouse:GetPosX() - Panel_Window_Delivery_Information:GetSizeX())
  Panel_Window_Delivery_Information:SetPosY(Panel_Window_Warehouse:GetPosY() - 40)
  Panel_Window_Delivery_Request:SetPosX(Panel_Window_Warehouse:GetPosX() - Panel_Window_Delivery_Information:GetSizeX())
  Panel_Window_Delivery_Request:SetPosY(Panel_Window_Warehouse:GetPosY() - 40)
  self.list2:moveTopIndex()
  self.scrollIndex = 0
end
function DeliveryInformationWindow_Close()
  if ToClient_WorldMapIsShow() then
    if Panel_Window_Delivery_Information:GetShow() then
      WorldMapPopupManager:pop()
    end
  elseif Panel_Window_Delivery_Information:GetShow() then
    Panel_Window_Delivery_Information:ChangeSpecialTextureInfoName("")
    Panel_Window_Delivery_Information:SetShow(false, false)
  end
  local self = deliveryInformation
  self.list2:getElementManager():clearKey()
  deliveryCountCache = 0
end
function DeliveryInformation_Refresh()
  delivery_refreshClear()
  delivery_requsetList()
end
function DeliveryInformation_OpenPanelFromWorldmap(waypointKey)
  local self = deliveryInformation
  self.currentWaypointKey = waypointKey
  WorldMapPopupManager:increaseLayer(true)
  WorldMapPopupManager:push(Panel_Window_Delivery_Information, true)
  DeliveryInformationWindow_Open()
end
function DeliveryInformation_OpenPanelFromDialog()
  local self = deliveryInformation
  self.currentWaypointKey = getCurrentWaypointKey()
  Warehouse_OpenPanelFromDialogWithoutInventory(getCurrentWaypointKey(), CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc)
  Panel_Window_Warehouse:SetVerticalMiddle()
  Panel_Window_Warehouse:SetHorizonCenter()
  Panel_Window_Warehouse:SetSpanSize(100, 0)
  DeliveryInformationWindow_Open()
end
function Delivery_Cancel(index)
  local self = deliveryInformation
  local deliveryList = delivery_list(self.currentWaypointKey)
  local deliveryInfo = deliveryList:atPointer(index)
  local itemNo = deliveryInfo:getItemNo()
  delivery_cancelbyItemNo(itemNo)
  self:updateSlot()
end
function Delivery_Receive(index)
  local self = deliveryInformation
  local deliveryList = delivery_list(self.currentWaypointKey)
  local deliveryInfo = deliveryList:atPointer(index)
  local itemNo = deliveryInfo:getItemNo()
  delivery_receiveItemNo(itemNo)
  self:updateSlot()
end
function Delivery_Receive_All()
  delivery_receiveAll(DeliveryInformation_WaypointKey())
  deliveryCountCache = 0
end
function Delivery_ListControlCreate(content, key)
  local self = deliveryInformation
  local index = Int64toInt32(key)
  local deliveryList = delivery_list(DeliveryInformation_WaypointKey())
  local deliveryInfo = deliveryList:atPointer(index)
  local itemWrapper = deliveryInfo:getItemWrapper()
  if nil == itemWrapper then
    return
  end
  local itemBG = UI.getChildControl(content, "Static_List2_ItemBG")
  itemBG:SetPosX(10)
  itemBG:SetPosY(10)
  local slot = {}
  local itemSlot = UI.getChildControl(content, "Static_List2_Slot")
  itemSlot:SetShow(true)
  itemSlot:SetPosX(9)
  itemSlot:SetPosY(9)
  itemSlot:SetSize(40, 40)
  SlotItem.reInclude(slot, "Delivery_Slot_Icon_", 0, itemSlot, self.slotConfig)
  slot:setItem(itemWrapper)
  local carriageType = UI.getChildControl(content, "StaticText_List2_CarriageType")
  carriageType:SetShow(true)
  if 1 == deliveryInfo:getCarriageType() then
    carriageType:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_DeliveryInformation_carriageType_carriage"))
  elseif 2 == deliveryInfo:getCarriageType() then
    carriageType:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_DeliveryInformation_carriageType_Transport"))
  elseif 3 == deliveryInfo:getCarriageType() then
    carriageType:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_DeliveryInformation_carriageType_TradeShip"))
  else
    carriageType:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_DeliveryInformation_carriageType_carriage"))
  end
  local departure = UI.getChildControl(content, "StaticText_List2_Departure")
  departure:SetShow(true)
  departure:SetText(deliveryInfo:getFromRegionName())
  local destination = UI.getChildControl(content, "StaticText_List2_Destination")
  destination:SetShow(true)
  destination:SetText(deliveryInfo:getToRegionName())
  local receive = UI.getChildControl(content, "Button_List2_Receive")
  receive:SetPosX(325)
  receive:SetPosY(14)
  local cancel = UI.getChildControl(content, "Button_List2_Cancel")
  cancel:SetPosX(325)
  cancel:SetPosY(14)
  if 0 == deliveryInfo:getProgressType() then
    receive:SetShow(false)
    cancel:SetShow(true)
  else
    cancel:SetShow(false)
    receive:SetShow(true)
  end
  local arrow = UI.getChildControl(content, "Static_List2_Arrow")
  arrow:SetShow(true)
  arrow:SetPosX(190)
  arrow:SetPosY(40)
  local itemNo = deliveryInfo:getItemNo()
  receive:addInputEvent("Mouse_LUp", "Delivery_Receive(" .. index .. " )")
  cancel:addInputEvent("Mouse_LUp", "Delivery_Cancel(" .. index .. " )")
  slot.icon:addInputEvent("Mouse_On", "DeliveryItem_Tooltip_Show(" .. index .. ", true)")
  slot.icon:addInputEvent("Mouse_Out", "DeliveryItem_Tooltip_Show(" .. index .. ", false)")
  if index > self.scrollIndex then
    self.scrollIndex = index - 8
  else
    self.scrollIndex = index
  end
end
function DeliveryItem_Tooltip_Show(idx, isOn)
  local self = deliveryInformation
  if false == isOn then
    Panel_Tooltip_Item_hideTooltip()
  end
  local control = self.list2
  local contents = control:GetContentByKey(toInt64(0, idx))
  if nil ~= contents then
    local itemIcon = UI.getChildControl(contents, "Static_List2_Slot")
    if true == isOn then
      local deliveryList = delivery_list(DeliveryInformation_WaypointKey())
      local deliveryInfo = deliveryList:atPointer(idx)
      local itemWrapper = deliveryInfo:getItemWrapper()
      local itemSSW = itemWrapper:getStaticStatus()
      Panel_Tooltip_Item_Show(itemSSW, itemIcon, true, false, nil, nil, true)
    end
  end
end
deliveryInformation:init()
deliveryInformation:registEventHandler()
deliveryInformation:registMessageHandler()
