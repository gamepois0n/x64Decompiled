Panel_Window_FairyRegister:SetShow(false)
local IM = CppEnums.EProcessorInputMode
local UI_TM = CppEnums.TextMode
local uiStatic_FairyRegister = UI.getChildControl(Panel_Window_FairyRegister, "Static_FairyRegister")
local uiStatic_FairyBG = UI.getChildControl(uiStatic_FairyRegister, "Static_SettingMainBG")
local FairyRegister = {
  uiSlot_HpItem = UI.getChildControl(uiStatic_FairyBG, "Static_HPItemSlotBig"),
  uiSlot_MpItem = UI.getChildControl(uiStatic_FairyBG, "Static_MPItemSlotBig"),
  uiEdit_FairyName = UI.getChildControl(uiStatic_FairyRegister, "Edit_Naming"),
  uiIcon_FairyIcon = UI.getChildControl(uiStatic_FairyRegister, "Static_FairySlotBG"),
  Radio_HpRate = {
    [10] = UI.getChildControl(uiStatic_FairyBG, "Radiobutton_HP10Percent"),
    [20] = UI.getChildControl(uiStatic_FairyBG, "Radiobutton_HP20Percent"),
    [30] = UI.getChildControl(uiStatic_FairyBG, "Radiobutton_HP30Percent"),
    [50] = UI.getChildControl(uiStatic_FairyBG, "Radiobutton_HP50Percent")
  },
  Radio_MpRate = {
    [10] = UI.getChildControl(uiStatic_FairyBG, "Radiobutton_MP10Percent"),
    [20] = UI.getChildControl(uiStatic_FairyBG, "Radiobutton_MP20Percent"),
    [30] = UI.getChildControl(uiStatic_FairyBG, "Radiobutton_MP30Percent"),
    [50] = UI.getChildControl(uiStatic_FairyBG, "Radiobutton_MP50Percent")
  }
}
function FromClient_InputFairyName(fromWhereType, fromSlotNo)
  tempFromWhereType = fromWhereType
  tempFromSlotNo = fromSlotNo
  local self = FairyRegister
  local petName = self.uiEdit_FairyName:GetEditText()
  local itemWrapper = getInventoryItemByType(fromWhereType, fromSlotNo)
  if nil == itemWrapper then
    return
  end
  local characterKey = itemWrapper:getStaticStatus():get()._contentsEventParam1
  local fairyRegisterPSS = ToClient_getPetStaticStatus(characterKey)
  local fairyIconPath = fairyRegisterPSS:getIconPath()
  self.uiIcon_FairyIcon:ChangeTextureInfoName(fairyIconPath)
  self.uiIcon_FairyIcon:SetShow(true)
  self.uiEdit_FairyName:SetEditText("", true)
  self.uiEdit_FairyName:SetMaxInput(getGameServiceTypePetNameLength())
  HandleClicked_FairyRegister_ClearEdit()
  self:SetPosition()
  Panel_Window_FairyRegister:SetShow(true)
end
function FairyRegister:SetPosition()
  local scrSizeX = getScreenSizeX()
  local scrSizeY = getScreenSizeY()
  local panelSizeX = Panel_Window_FairyRegister:GetSizeX()
  local panelSizeY = Panel_Window_FairyRegister:GetSizeY()
  Panel_Window_FairyRegister:SetPosX(scrSizeX / 2 - panelSizeX - 50)
  Panel_Window_FairyRegister:SetPosY(scrSizeY / 2 - panelSizeY / 2 - 100)
end
function HandleClicked_FairyRegister_ClearEdit()
  local self = FairyRegister
  self.uiEdit_FairyName:SetEditText("", false)
  SetFocusEdit(self.uiEdit_FairyName)
end
