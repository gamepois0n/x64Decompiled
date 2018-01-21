local getDailyPay = {
  _btn_GetMoney = UI.getChildControl(Panel_Guild_GetDailyPay, "Button_GetMoney"),
  _btn_Cancel = UI.getChildControl(Panel_Guild_GetDailyPay, "Button_Cancel"),
  _rdo_Inven = UI.getChildControl(Panel_Guild_GetDailyPay, "RadioButton_Inven"),
  _rdo_Warehouse = UI.getChildControl(Panel_Guild_GetDailyPay, "RadioButton_Warehouse")
}
function GetDailyPay_Init()
  local self = getDailyPay
  self._rdo_Inven:SetCheck(true)
  self._rdo_Warehouse:SetCheck(false)
end
function GetDailyPay_Execute()
  local self = getDailyPay
  local isInven = self._rdo_Inven:IsCheck()
  local isWarehouse = self._rdo_Warehouse:IsCheck()
  local isGetCheck = false
  if isInven then
    isGetCheck = false
  elseif isWarehouse then
    isGetCheck = true
  end
  ToClient_TakeMyGuildBenefit(isGetCheck)
  FGlobal_GetDailyPay_Hide()
end
function FGlobal_GetDailyPay_Show()
  local self = getDailyPay
  if not Panel_Guild_GetDailyPay:GetShow() then
    Panel_Guild_GetDailyPay:SetShow(true)
    self._rdo_Inven:SetCheck(true)
    self._rdo_Warehouse:SetCheck(false)
  end
end
function FGlobal_GetDailyPay_Hide()
  Panel_Guild_GetDailyPay:SetShow(false)
end
function FGlobal_GetDailyPay_WarehouseCheckReturn()
  return getDailyPay._rdo_Warehouse:IsCheck()
end
function GetDailyPay_Event()
  local self = getDailyPay
  self._btn_GetMoney:addInputEvent("Mouse_LUp", "GetDailyPay_Execute()")
  self._btn_Cancel:addInputEvent("Mouse_LUp", "FGlobal_GetDailyPay_Hide()")
end
GetDailyPay_Init()
GetDailyPay_Event()
