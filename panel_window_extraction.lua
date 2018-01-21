local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
Panel_Window_Extraction:SetShow(false, false)
Panel_Window_Extraction:setMaskingChild(true)
Panel_Window_Extraction:ActiveMouseEventEffect(true)
Panel_Window_Extraction:RegisterShowEventFunc(true, "ExtractionShowAni()")
Panel_Window_Extraction:RegisterShowEventFunc(false, "ExtractionHideAni()")
function ExtractionShowAni()
end
function ExtractionHideAni()
end
PaGlobal_Extraction = {
  _screenX = nil,
  _screenY = nil,
  _extractionBG = UI.getChildControl(Panel_Window_Extraction, "ExtractionBackGround"),
  _buttonExtraction_EnchantStone = UI.getChildControl(Panel_Window_Extraction, "Button_Extraction_EnchantStone"),
  _buttonExtraction_Crystal = UI.getChildControl(Panel_Window_Extraction, "Button_Extraction_Crystal"),
  _buttonExtraction_Cloth = UI.getChildControl(Panel_Window_Extraction, "Button_Extraction_Cloth"),
  _buttonExtractionExit = UI.getChildControl(Panel_Window_Extraction, "Button_Exit")
}
function PaGlobal_Extraction:getExtractionButtonEnchantStone()
  return self._buttonExtraction_EnchantStone
end
function PaGlobal_Extraction:getExtractionButtonCrystal()
  return self._buttonExtraction_Crystal
end
function PaGlobal_Extraction:getExtractionButtonCloth()
  return self._buttonExtraction_Cloth
end
function PaGlobal_Extraction:initialize()
  self._extractionBG:setGlassBackground(true)
  self._extractionBG:SetShow(true)
  self._buttonExtraction_EnchantStone:SetShow(true)
  self._buttonExtraction_Crystal:SetShow(true)
  self._buttonExtractionExit:SetShow(true)
  self._buttonExtraction_EnchantStone:addInputEvent("Mouse_LUp", "PaGlobal_Extraction:button_ExtractionEnchantStone_Click()")
  self._buttonExtraction_Crystal:addInputEvent("Mouse_LUp", "PaGlobal_Extraction:button_ExtractionCrystal_Click()")
  self._buttonExtraction_Cloth:addInputEvent("Mouse_LUp", "PaGlobal_Extraction:button_ExtractionCloth_Click()")
  self._buttonExtractionExit:addInputEvent("Mouse_LUp", "PaGlobal_Extraction:openPanel( false )")
end
registerEvent("onScreenResize", "Extraction_Resize")
function PaGlobal_Extraction:extraction_BtnResize()
  local btnEnchantStoneSizeX = self._buttonExtraction_EnchantStone:GetSizeX() + 23
  local btnEnchantStoneTextPosX = btnEnchantStoneSizeX - btnEnchantStoneSizeX / 2 - self._buttonExtraction_EnchantStone:GetTextSizeX() / 2
  local btnCrystalSizeX = self._buttonExtraction_Crystal:GetSizeX() + 23
  local btnCrystalTextPosX = btnCrystalSizeX - btnCrystalSizeX / 2 - self._buttonExtraction_Crystal:GetTextSizeX() / 2
  local btnClothSizeX = self._buttonExtraction_Cloth:GetSizeX() + 23
  local btnClothTextPosX = btnClothSizeX - btnClothSizeX / 2 - self._buttonExtraction_Cloth:GetTextSizeX() / 2
  local btnExitSizeX = self._buttonExtractionExit:GetSizeX() + 23
  local btnExitTextPosX = btnExitSizeX - btnExitSizeX / 2 - self._buttonExtractionExit:GetTextSizeX() / 2
  self._buttonExtraction_EnchantStone:SetTextSpan(btnEnchantStoneTextPosX, 5)
  self._buttonExtraction_Crystal:SetTextSpan(btnCrystalTextPosX, 5)
  self._buttonExtraction_Cloth:SetTextSpan(btnClothTextPosX, 5)
  self._buttonExtractionExit:SetTextSpan(btnExitTextPosX, 5)
end
function Extraction_Resize()
  local self = PaGlobal_Extraction
  self._screenX = getScreenSizeX()
  self._screenY = getScreenSizeY()
  Panel_Window_Extraction:SetSize(self._screenX, Panel_Window_Extraction:GetSizeY())
  Panel_Window_Extraction:ComputePos()
  self._extractionBG:SetSize(self._screenX, self._extractionBG:GetSizeY())
  self._extractionBG:ComputePos()
  if ToClient_IsContentsGroupOpen("1006") or ToClient_IsContentsGroupOpen("1007") then
    self._buttonExtraction_EnchantStone:ComputePos()
    self._buttonExtraction_Crystal:ComputePos()
    self._buttonExtraction_Cloth:ComputePos()
    self._buttonExtraction_Cloth:SetShow(true)
  else
    self._buttonExtraction_EnchantStone:SetPosX(getScreenSizeX() / 2 - self._buttonExtraction_EnchantStone:GetSizeX() / 2 - 10)
    self._buttonExtraction_Crystal:SetPosX(getScreenSizeX() / 2 + self._buttonExtraction_Crystal:GetSizeX() / 2 + 10)
    self._buttonExtraction_Cloth:SetShow(false)
  end
  self._buttonExtractionExit:ComputePos()
end
function PaGlobal_Extraction:openPanel(isShow)
  if true == isShow then
    SetUIMode(Defines.UIMode.eUIMode_Extraction)
    setIgnoreShowDialog(true)
    UIAni.fadeInSCR_Down(Panel_Window_Extraction)
    Equipment_PosSaveMemory()
    Panel_Equipment:SetPosX(10)
    Panel_Equipment:SetPosY(getScreenSizeY() - getScreenSizeY() / 2 - Panel_Equipment:GetSizeY() / 2)
  else
    SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
    setIgnoreShowDialog(false)
    Socket_ExtractionCrystal_WindowClose()
    ExtractionEnchantStone_WindowClose()
    ExtractionCloth_WindowClose()
    PaGlobal_ExtractionCrystal:clearData()
    InventoryWindow_Close()
    Equipment_PosLoadMemory()
    Panel_Equipment:SetShow(false, false)
  end
  Panel_Npc_Dialog:SetShow(not isShow)
  Panel_Window_Extraction:SetShow(isShow, false)
  PaGlobal_Extraction:extraction_BtnResize()
  PaGlobal_TutorialManager:handleOpenExtractionPanel(isShow)
end
function PaGlobal_Extraction:button_ExtractionCrystal_Click()
  if false == Panel_Window_Extraction_Crystal:GetShow() then
    ExtractionEnchantStone_WindowClose()
    ExtractionCloth_WindowClose()
    PaGlobal_ExtractionCrystal:show(true)
    Inventory_SetFunctor(Socket_Extraction_InvenFiler_EquipItem, Panel_Socket_ExtractionCrystal_InteractortionFromInventory, Socket_ExtractionCrystal_WindowClose, nil)
    InventoryWindow_Show()
    Panel_Equipment:SetShow(true, true)
  else
    PaGlobal_ExtractionCrystal:show(false)
    InventoryWindow_Close()
    EquipmentWindow_Close()
  end
  PaGlobal_TutorialManager:handleClickExtractionCrystalButton(Panel_Window_Extraction_Crystal:GetShow())
end
function PaGlobal_Extraction:button_ExtractionEnchantStone_Click()
  if false == Panel_Window_Extraction_EnchantStone:GetShow() then
    Socket_ExtractionCrystal_WindowClose()
    ExtractionCloth_WindowClose()
    ExtractionEnchantStone_WindowOpen()
    Panel_Equipment:SetShow(true, true)
  else
    ExtractionEnchantStone_WindowClose()
    InventoryWindow_Close()
    EquipmentWindow_Close()
  end
  PaGlobal_TutorialManager:handleClickExtractionEnchantStoneButton(Panel_Window_Extraction_EnchantStone:GetShow())
end
function PaGlobal_Extraction:button_ExtractionCloth_Click()
  if false == PaGlobal_ExtractionCloth:getShow() then
    ExtractionEnchantStone_WindowClose()
    Socket_ExtractionCrystal_WindowClose()
    ExtractionCloth_WindowOpen()
    Panel_Equipment:SetShow(true, true)
  else
    ExtractionCloth_WindowClose()
    InventoryWindow_Close()
    EquipmentWindow_Close()
  end
  PaGlobal_TutorialManager:handleClickExtractionClothButton(PaGlobal_ExtractionCloth:getShow())
end
PaGlobal_Extraction:initialize()
