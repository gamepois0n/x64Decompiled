Panel_Window_StableFunction:SetShow(false, false)
Panel_Window_StableFunction:setMaskingChild(true)
Panel_Window_StableFunction:ActiveMouseEventEffect(true)
Panel_Window_StableFunction:RegisterShowEventFunc(true, "")
Panel_Window_StableFunction:RegisterShowEventFunc(false, "")
local _stableBG = UI.getChildControl(Panel_Window_StableFunction, "Static_StableTitle")
_stableBG:setGlassBackground(true)
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local IM = CppEnums.EProcessorInputMode
local stableFunction = {
  config = {},
  _buttonRegister = UI.getChildControl(Panel_Window_StableFunction, "Button_RegisterByItem"),
  _textRegist = UI.getChildControl(Panel_Window_StableFunction, "StaticText_Purpose"),
  _buttonMix = UI.getChildControl(Panel_Window_StableFunction, "Button_HorseMix"),
  _buttonMating = UI.getChildControl(Panel_Window_StableFunction, "Button_ListMating"),
  _buttonMarket = UI.getChildControl(Panel_Window_StableFunction, "Button_ListMarket"),
  _buttonExit = UI.getChildControl(Panel_Window_StableFunction, "Button_Exit"),
  _buttonLink = UI.getChildControl(Panel_Window_StableFunction, "Button_HorseLink"),
  textCaution = UI.getChildControl(Panel_Window_StableFunction, "StaticText_Caution")
}
function stableFunction:init()
  stableFunction._textRegist:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEFUNCTION_TEXTREGIST"))
  stableFunction._textRegist:SetShow(false)
end
function stableFunction:SetBtnPosition()
  local btnRegisterSizeX = self._buttonRegister:GetSizeX() + 23
  local btnRegisterTextPosX = btnRegisterSizeX - btnRegisterSizeX / 2 - self._buttonRegister:GetTextSizeX() / 2
  local btnMixSizeX = self._buttonMix:GetSizeX() + 23
  local btnMixTextPosX = btnMixSizeX - btnMixSizeX / 2 - self._buttonMix:GetTextSizeX() / 2
  local btnMatingSizeX = self._buttonMating:GetSizeX() + 23
  local btnMatingTextPosX = btnMatingSizeX - btnMatingSizeX / 2 - self._buttonMating:GetTextSizeX() / 2
  local btnMarketSizeX = self._buttonMarket:GetSizeX() + 23
  local btnMarketTextPosX = btnMarketSizeX - btnMarketSizeX / 2 - self._buttonMarket:GetTextSizeX() / 2
  local btnExitSizeX = self._buttonExit:GetSizeX() + 23
  local btnExitTextPosX = btnExitSizeX - btnExitSizeX / 2 - self._buttonExit:GetTextSizeX() / 2
  local btnLinkSizeX = self._buttonLink:GetSizeX() + 23
  local btnLinkTextPosX = btnLinkSizeX - btnLinkSizeX / 2 - self._buttonLink:GetTextSizeX() / 2
  self._buttonRegister:SetTextSpan(btnRegisterTextPosX, 5)
  self._buttonMix:SetTextSpan(btnMixTextPosX, 5)
  self._buttonMating:SetTextSpan(btnMatingTextPosX, 5)
  self._buttonMarket:SetTextSpan(btnMarketTextPosX, 5)
  self._buttonExit:SetTextSpan(btnExitTextPosX, 5)
  self._buttonLink:SetTextSpan(btnLinkTextPosX, 5)
end
function stableFunction:registEventHandler()
  self._buttonRegister:addInputEvent("Mouse_LUp", "StableFunction_Button_RegisterReady()")
  self._buttonMating:addInputEvent("Mouse_LUp", "StableFunction_Button_Mating()")
  self._buttonMarket:addInputEvent("Mouse_LUp", "StableFunction_Button_Market()")
  self._buttonMix:addInputEvent("Mouse_LUp", "StableFunction_Button_Mix()")
  self._buttonLink:addInputEvent("Mouse_LUp", "StableFunction_Button_Link()")
  self._buttonExit:addInputEvent("Mouse_LUp", "StableFunction_Close()")
end
function stableFunction:registMessageHandler()
  registerEvent("onScreenResize", "StableFunction_Resize")
  registerEvent("FromClient_ServantUpdate", "StableFunction_RegisterAck")
end
function StableFunction_Resize()
  local self = stableFunction
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  Panel_Window_StableFunction:SetSize(screenX, Panel_Window_StableFunction:GetSizeY())
  _stableBG:SetSize(screenX, Panel_Window_StableFunction:GetSizeY())
  Panel_Window_StableFunction:ComputePos()
  _stableBG:ComputePos()
  self._buttonRegister:ComputePos()
  self._buttonMating:ComputePos()
  self._buttonMarket:ComputePos()
  self._buttonMix:ComputePos()
  self._buttonExit:ComputePos()
  self._textRegist:ComputePos()
  self._buttonMix:ComputePos()
  self._textRegist:SetSpanSize(0, -screenY * 3 / 4)
  self.textCaution:SetSize(self.textCaution:GetTextSizeX() + 20, self.textCaution:GetTextSizeY() + 15)
end
function StableFunction_Button_RegisterReady(slotNo)
  if Panel_Window_StableMarket:GetShow() then
    StableMarket_Close()
  end
  if Panel_Window_StableMating:GetShow() then
    StableMating_Close()
  end
  if Panel_Window_StableMix:GetShow() then
    StableMix_Close()
  end
  Inventory_SetFunctor(InvenFiler_Mapae, StableFunction_Button_Register, Servant_InventoryClose, nil)
  Inventory_ShowToggle()
  audioPostEvent_SystemUi(0, 0)
end
function StableFunction_Button_Register(slotNo, itemWrapper, count_s64, inventoryType)
  StableRegister_OpenByInventory(inventoryType, slotNo)
end
function StableFunction_Button_Mating()
  audioPostEvent_SystemUi(0, 0)
  StableList_ButtonClose()
  audioPostEvent_SystemUi(1, 0)
  StableMating_Open(CppEnums.AuctionType.AuctionGoods_ServantMating)
end
function StableFunction_Button_Market()
  audioPostEvent_SystemUi(0, 0)
  StableList_ButtonClose()
  audioPostEvent_SystemUi(1, 0)
  StableMarket_Open()
end
function StableFunction_Button_Mix()
  StableList_ButtonClose()
  StableMix_Open()
end
function StableFunction_Button_Link()
  StableList_ButtonClose()
  stableCarriage_Open()
end
function StableFunction_RegisterAck()
  if GetUIMode() == Defines.UIMode.eUIMode_Default then
    return
  end
  if false == Panel_Window_StableList:GetShow() then
    return
  end
  if Panel_Window_StableStallion:GetShow() then
    return
  end
  Inventory_SetFunctor(nil)
  InventoryWindow_Close()
  StableRegister_Close()
  local self = stableFunction
  self._buttonRegister:EraseAllEffect()
end
local funcBtnCount = 0
local funcBtnRePos = {}
function StableFunction_Open()
  if not stable_doHaveRegisterItem() then
    stableFunction._textRegist:SetShow(false)
  end
  if Panel_Window_StableFunction:GetShow() then
  end
  Servant_SceneOpen(Panel_Window_StableFunction)
  StableList_Open()
  stableFunction._textRegist:SetShow(false)
  stableFunction:SetBtnPosition()
  funcBtnRePos = {}
  funcBtnCount = 0
  local self = stableFunction
  local talker = dialog_getTalker()
  local npcActorproxy = talker:get()
  local npcPosition = npcActorproxy:getPosition()
  local npcRegionInfo = getRegionInfoByPosition(npcPosition)
  local horseCheck = false
  local carriageCheck = false
  local isCarriage = false
  for index = 0, stable_count() - 1 do
    local servantInfo = stable_getServant(index)
    if npcRegionInfo:getAreaName() == servantInfo:getRegionName() then
      local isUnLinkedHorse = not servantInfo:isLink() and CppEnums.VehicleType.Type_Horse == servantInfo:getVehicleType()
      if isUnLinkedHorse then
        horseCheck = true
      end
      if CppEnums.VehicleType.Type_Carriage == servantInfo:getVehicleType() then
        local maxLinkCount = servantInfo:getLinkCount()
        local currentLinkCount = servantInfo:getCurrentLinkCount()
        if maxLinkCount > currentLinkCount then
          carriageCheck = true
        end
        isCarriage = true
      end
    end
  end
  self._buttonLink:SetShow(false)
  self._buttonMix:SetShow(false)
  if stable_isCarriage() then
    self._buttonLink:SetShow(true)
    funcBtnRePos[funcBtnCount] = self._buttonLink
    funcBtnCount = funcBtnCount + 1
  end
  if stable_isMix() then
    self._buttonMix:SetShow(true)
    funcBtnRePos[funcBtnCount] = self._buttonMix
    funcBtnCount = funcBtnCount + 1
  end
  self._buttonMating:SetShow(false)
  self._buttonMarket:SetShow(false)
  if stable_isMating() then
    self._buttonMating:SetShow(true)
    funcBtnRePos[funcBtnCount] = self._buttonMating
    funcBtnCount = funcBtnCount + 1
  end
  if stable_isMarket() then
    self._buttonMarket:SetShow(true)
    funcBtnRePos[funcBtnCount] = self._buttonMarket
    funcBtnCount = funcBtnCount + 1
  end
  if stable_doHaveRegisterItem() then
    local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
    local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REGISTERITEM_MSG")
    local messageboxData = {
      title = messageboxTitle,
      content = messageboxMemo,
      functionApply = FGlobal_NeedStableRegistItem_Print,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    stableFunction._buttonRegister:EraseAllEffect()
    stableFunction._buttonRegister:AddEffect("UI_ArrowMark01", true, 25, -38)
  else
    stableFunction._buttonRegister:EraseAllEffect()
  end
  funcBtnRePos[funcBtnCount] = self._buttonRegister
  funcBtnCount = funcBtnCount + 1
  funcBtnRePos[funcBtnCount] = self._buttonExit
  funcBtnCount = funcBtnCount + 1
  funcButtonRePosition(funcBtnCount)
end
function funcButtonRePosition(funcBtnCount)
  local gapX = 16
  local startPosX = getScreenSizeX() / 2 - (stableFunction._buttonExit:GetSizeX() / 2 * funcBtnCount + (funcBtnCount - 1) * gapX)
  for index = 0, funcBtnCount - 1 do
    funcBtnRePos[index]:SetPosX(startPosX + index * (stableFunction._buttonExit:GetSizeX() + gapX))
  end
end
function FGlobal_NeedStableRegistItem_Print()
  if stable_doHaveRegisterItem() then
    stableFunction._textRegist:SetShow(true)
  else
    stableFunction._textRegist:SetShow(false)
  end
end
function StableFunction_Close()
  audioPostEvent_SystemUi(0, 0)
  local self = stableFunction
  self._buttonRegister:EraseAllEffect()
  InventoryWindow_Close()
  StableList_Close()
  StableInfo_Close()
  StableShop_Close()
  StableMating_Close()
  StableMarket_Close()
  StableMix_Close()
  if not Panel_Window_StableFunction:GetShow() then
    return
  end
  Servant_SceneClose(Panel_Window_StableFunction)
  Dialog_updateButtons(true)
end
function StableFunction_Buttonclose()
  Panel_Window_StableFunction:SetShow(false)
end
function StableFunction_ButtonOpen()
  Panel_Window_StableFunction:SetShow(true)
end
stableFunction:init()
stableFunction:registEventHandler()
stableFunction:registMessageHandler()
StableFunction_Resize()
