local Button_CharacterTag
local isOpenCharacterTag = ToClient_IsContentsGroupOpen("330")
local isAlreadyTaging = false
local hasAwakenCharacter = false
function PaGlobal_CharacterTag_CheckShow()
  local size = getCharacterDataCount()
  local isAlreadyTaging = 0
  local hasAwakenCharacter = false
  local returnBool = false
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  local curLevel = player:get():getLevel()
  for ii = 0, size - 1 do
    local characterData = getCharacterDataByIndex(ii)
    if nil ~= characterData then
      local duelChar_No_s32 = Int64toInt32(characterData._duelCharacterNo)
      local char_Level = characterData._level
      if char_Level > 55 then
        hasAwakenCharacter = true
      end
      if char_Level > 1 and -1 ~= duelChar_No_s32 then
        isAlreadyTaging = isAlreadyTaging + 1
      end
    end
  end
  if isAlreadyTaging > 1 or hasAwakenCharacter == true or curLevel > 55 then
    returnBool = true
  end
  return returnBool
end
function PaGlobal_CharacterTag_SetPosIcon()
  if isFlushedUI() then
    return
  end
  if nil == Button_CharacterTag then
    return
  end
  if true == PaGlobal_TutorialManager:isDoingTutorial() then
    return
  end
  if false == PaGlobal_CharacterTag_CheckShow() then
    Panel_Icon_CharacterTag:SetShow(false)
    return
  end
  if true == isOpenCharacterTag then
    local posX, posY
    if Panel_Icon_Camp:GetShow() then
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
    Panel_Icon_CharacterTag:SetShow(true)
    Panel_Icon_CharacterTag:SetPosX(posX)
    Panel_Icon_CharacterTag:SetPosY(posY)
  else
    Panel_Icon_CharacterTag:SetShow(false)
  end
  PaGlobal_Fairy_SetPosIcon()
end
function PaGlobal_CharacterTag_IconMouseToolTip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_TAG")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_TAGCHAR_ICON_TOOLTIP_DESC")
  control = Button_CharacterTag
  TooltipSimple_Show(control, name, desc)
end
function InitializeTagIcon()
  Panel_Icon_CharacterTag:SetIgnore(false)
  Panel_Icon_CharacterTag:SetShow(true)
  Button_CharacterTag = UI.getChildControl(Panel_Icon_CharacterTag, "Button_TagIcon")
  Button_CharacterTag:ActiveMouseEventEffect(true)
  Button_CharacterTag:addInputEvent("Mouse_LUp", "PaGlobal_CharacterTag_Open()")
  Button_CharacterTag:addInputEvent("Mouse_RUp", "PaGlobal_TagCharacter_Change()")
  Button_CharacterTag:addInputEvent("Mouse_Out", "PaGlobal_CharacterTag_IconMouseToolTip(false)")
  Button_CharacterTag:addInputEvent("Mouse_On", "PaGlobal_CharacterTag_IconMouseToolTip(true)")
  PaGlobal_CharacterTag_SetPosIcon()
end
function FromClient_Tag_SelfPlayerLevelUp()
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  local curLevel = player:get():getLevel()
  if curLevel > 55 and false == Panel_Icon_CharacterTag:GetShow() then
    PaGlobal_CharacterTag_SetPosIcon()
  end
end
registerEvent("FromClient_luaLoadComplete", "InitializeTagIcon")
registerEvent("EventSelfPlayerLevelUp", "FromClient_Tag_SelfPlayerLevelUp")
