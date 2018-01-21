local FairyIcon = {
  _icon = UI.getChildControl(Panel_Window_FairyIcon, "Button_FairyIcon")
}
function PaGlobal_Fairy_SetPosIcon()
  if false == ToClient_IsDevelopment() then
    return
  end
  if isFlushedUI() then
    return
  end
  if nil == FairyIcon._icon then
    return
  end
  if true == PaGlobal_TutorialManager:isDoingTutorial() then
    return
  end
  if 0 < ToClient_getFairyUnsealedList() + ToClient_getFairySealedList() then
    local posX, posY
    if Panel_Icon_CharacterTag:GetShow() then
      posX = Panel_Icon_CharacterTag:GetPosX() + Panel_Icon_CharacterTag:GetSizeX() - 3
      posY = Panel_Icon_CharacterTag:GetPosY()
    elseif Panel_Icon_Camp:GetShow() then
      posX = Panel_Icon_Camp:GetPosX() + Panel_Icon_Camp:GetSizeX() - 3
      posY = Panel_Icon_Camp:GetPosY()
    elseif Panel_Icon_Duel:GetShow() then
      posX = Panel_Icon_Duel:GetPosX() + Panel_Icon_Duel:GetSizeX() - 3
      posY = Panel_Icon_Duel:GetPosY()
    elseif Panel_Icon_Maid:GetShow() then
      posX = Panel_Icon_Maid:GetPosX() + Panel_Icon_Maid:GetSizeX() - 3
      posY = Panel_Icon_Maid:GetPosY()
    elseif Panel_Window_PetIcon:GetShow() then
      posX = Panel_Window_PetIcon:GetPosX() + Panel_Window_PetIcon:GetSizeX() - 3
      posY = Panel_Window_PetIcon:GetPosY()
    elseif Panel_Icon_Camp:GetShow() then
      posX = Panel_Icon_Camp:GetPosX() + Panel_Icon_Camp:GetSizeX() - 3
      posY = Panel_Icon_Camp:GetPosY()
    elseif Panel_Blackspirit_OnOff:GetShow() then
      posX = Panel_Blackspirit_OnOff:GetPosX() + Panel_Blackspirit_OnOff:GetSizeX() - 3
      posY = Panel_Blackspirit_OnOff:GetPosY()
    elseif 0 < FGlobal_HouseIconCount() and Panel_MyHouseNavi:GetShow() then
      posX = Panel_MyHouseNavi:GetPosX() + 60 * FGlobal_HouseIconCount() - 3
      posY = Panel_MyHouseNavi:GetPosY()
    elseif 0 < FGlobal_ServantIconCount() and Panel_Window_Servant:GetShow() then
      posX = Panel_Window_Servant:GetPosX() + 60 * FGlobal_ServantIconCount() - 3
      posY = Panel_Window_Servant:GetPosY()
    else
      posX = 0
      posY = Panel_SelfPlayerExpGage:GetPosY() + Panel_SelfPlayerExpGage:GetSizeY() + 15
    end
    Panel_Window_FairyIcon:SetShow(true)
    Panel_Window_FairyIcon:SetPosX(posX)
    Panel_Window_FairyIcon:SetPosY(posY)
  else
    Panel_Window_FairyIcon:SetShow(false)
  end
end
function InitializeFairyIcon()
  Panel_Window_FairyIcon:SetIgnore(false)
  FairyIcon._icon:addInputEvent("Mouse_LUp", "PaGlobal_FairyList_Open()")
  FairyIcon._icon:ActiveMouseEventEffect(true)
  PaGlobal_Fairy_SetPosIcon()
end
registerEvent("FromClient_luaLoadComplete", "InitializeFairyIcon")
