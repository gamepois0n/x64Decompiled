Panel_ResetSeal:SetShow(false, false)
Panel_ResetSeal:ActiveMouseEventEffect(true)
local ResetSealWindow = {
  _buttonApply = UI.getChildControl(Panel_ResetSeal, "Button_Apply"),
  _buttonCancel = UI.getChildControl(Panel_ResetSeal, "Button_Close"),
  _slotTargetItem = {
    icon = UI.getChildControl(Panel_ResetSeal, "Static_Slot_0"),
    empty = true
  },
  _slotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createCash = true
  },
  _inventoryTypeResetItem = nil,
  _slotNoResetItem = nil,
  _inventoryTypeTargetItem = nil,
  _slotNoTargetItem = nil
}
local ResetSealWindowHelpMessage = {}
function ResetSealWindow:initialize()
  SlotItem.new(self._slotTargetItem, "Slot_0", 0, Panel_ResetSeal, self._slotConfig)
  self._slotTargetItem:createChild()
  self._slotTargetItem.empty = true
  self._buttonApply:addInputEvent("Mouse_LUp", "HandleClicked_ResetSealApplyButton()")
  self._buttonCancel:addInputEvent("Mouse_LUp", "HandleClicked_ResetSealCancelButton()")
  self._slotTargetItem.icon:addInputEvent("Mouse_On", "HandleOn_TargetSlot()")
  self._slotTargetItem.icon:addInputEvent("Mouse_Out", "HandleOut_TargetSlot()")
end
function HandleClicked_ResetSealApplyButton()
  local self = ResetSealWindow
  if false == ResetSealWindow._slotTargetItem.empty then
    ToClient_CarveSealRequest(self._inventoryTypeResetItem, self._slotNoResetItem, self._inventoryTypeTargetItem, self._slotNoTargetItem, false)
  end
end
function HandleClicked_ResetSealCancelButton()
  Inventory_SetFunctor(nil, nil, nil, nil)
  ResetSealWindow._slotTargetItem:clearItem()
  ResetSealWindow._inventoryTypeResetItem = nil
  ResetSealWindow._slotNoResetItem = nil
  ResetSealWindow._inventoryTypeTargetItem = nil
  ResetSealWindow._slotNoTargetItem = nil
  ResetSealWindow._slotTargetItem.empty = true
  Panel_ResetSeal:SetShow(false)
end
function HandleOn_TargetSlot()
  if nil == ResetSealWindow._slotNoTargetItem then
  else
    local itemWrapper = getInventoryItemByType(ResetSealWindow._inventoryTypeTargetItem, ResetSealWindow._slotNoTargetItem)
    Panel_Tooltip_Item_Show(itemWrapper, ResetSealWindow._slotTargetItem.icon, false, true)
  end
end
function HandleOut_TargetSlot()
  if nil == ResetSealWindow._slotNoTargetItem then
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function ResetSeal_InvenFiler(slotNo, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  return false == itemWrapper:isSealed()
end
function HandleResetSeal_InteractionFromInventory(slotNo, itemWrapper, count, inventoryType)
  if itemWrapper:isSealed() then
    ResetSealWindow._slotTargetItem.empty = false
    ResetSealWindow._inventoryTypeTargetItem = inventoryType
    ResetSealWindow._slotNoTargetItem = slotNo
    ResetSealWindow._slotTargetItem:setItem(itemWrapper)
  end
end
function FromClient_ResetSealShow(inventoryType, slotNoReset)
  Inventory_SetFunctor(ResetSeal_InvenFiler, HandleResetSeal_InteractionFromInventory, nil, nil)
  ResetSealWindow._inventoryTypeResetItem = inventoryType
  ResetSealWindow._slotNoResetItem = slotNoReset
  Panel_ResetSeal:SetShow(true)
end
function FromClient_ResetSealHide()
  HandleClicked_ResetSealCancelButton()
end
ResetSealWindow:initialize()
registerEvent("FromClient_ResetSealShow", "FromClient_ResetSealShow")
registerEvent("FromClient_ResetSealHide", "FromClient_ResetSealHide")
