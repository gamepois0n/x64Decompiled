Panel_DeadNodeSelect:SetShow(false)
Panel_DeadNodeSelect:setIgnoreFlashPanel(true)
Panel_DeadMessage:setIgnoreFlashPanel(true)
local _deadBlackHole = UI.getChildControl(Panel_DeadMessage, "deadBlackHole")
local _deadQuestion = UI.getChildControl(Panel_DeadMessage, "Button_Question")
local _deadMessage = UI.getChildControl(Panel_DeadMessage, "Static_DeadText")
local _button_MoveTown = UI.getChildControl(Panel_DeadMessage, "Button_MoveTown")
local _button_MoveExploration = UI.getChildControl(Panel_DeadMessage, "Button_MoveExploration")
local _button_Immediate = UI.getChildControl(Panel_DeadMessage, "Button_Immediate")
local _button_AdvancedBase = UI.getChildControl(Panel_DeadMessage, "Button_AdvancedBase")
local _button_LocalWar = UI.getChildControl(Panel_DeadMessage, "Button_LocalWar")
local _button_GuildSpawn = UI.getChildControl(Panel_DeadMessage, "Button_GuildSpawn")
local _button_SavageOut = UI.getChildControl(Panel_DeadMessage, "Button_SavageOut")
local _text_ImmediateCount = UI.getChildControl(Panel_DeadMessage, "StaticText_ImmediateCount")
local _text_reviveNotify = UI.getChildControl(Panel_DeadMessage, "StaticText_reviveNotify")
local _button_SiegeIng = UI.getChildControl(Panel_DeadMessage, "Button_Siegeing")
local _button_Volunteer = UI.getChildControl(Panel_DeadMessage, "Button_MoveValunteer")
local _regenTime = UI.getChildControl(Panel_DeadMessage, "ResurrectionTime")
local _useCashItemBG = UI.getChildControl(Panel_DeadMessage, "Static_UseCasheItemBG")
local _checkBoxUseCache = UI.getChildControl(Panel_DeadMessage, "CheckBox_UseCacheItem")
local _checkBoxUseFairy = UI.getChildControl(Panel_DeadMessage, "CheckBox_UseFairy")
local _tooltip = UI.getChildControl(Panel_DeadMessage, "StaticText_Tooltip")
local _text_AdvancedBaseAlert = UI.getChildControl(Panel_DeadMessage, "StaticText_AdvancedBase_Alert")
local _button_ObserverMode = UI.getChildControl(Panel_DeadMessage, "Button_ObserverMode")
local reviveBG = UI.getChildControl(Panel_DeadNodeSelect, "Static_AllBG")
local reviveScroll = UI.getChildControl(Panel_DeadNodeSelect, "Scroll_List")
local _deadNodeSelectClose = UI.getChildControl(Panel_DeadNodeSelect, "Button_Close")
reviveScroll:SetShow(false)
reviveScroll:SetShow(false)
_checkBoxUseFairy:SetShow(false)
_deadNodeSelectClose:addInputEvent("Mouse_LUp", "deadNodeSelectClose()")
local STATIC_DROP_ITEM = {}
for ii = 0, 9 do
  STATIC_DROP_ITEM[ii] = UI.getChildControl(Panel_DeadMessage, "Static_DropItem_" .. ii)
end
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local UI_PUCT = CppEnums.PA_UI_CONTROL_TYPE
local CPP_slotNoString = CppEnums.EquipSlotNoString
enRespawnType = {
  respawnType_None = 0,
  respawnType_Immediate = 1,
  respawnType_ByOtherPlayer = 2,
  respawnType_Exploration = 3,
  respawnType_NearTown = 4,
  respawnType_TimeOver = 5,
  respawnType_InSiegeingFortress = 6,
  respawnType_LocalWar = 7,
  respawnType_AdvancedBase = 8,
  respawnType_GuildSpawn = 9,
  respawnType_Competition = 10,
  respawnType_SavageDefence = 11,
  respawnType_Volunteer = 12,
  respawnType_GuildBatle = 13,
  respawnType_Count = 14
}
local revivalTime = 600
local DROP_ITEM_COUNT = 1
local startTimer = false
local isEnableImmediateRevival = false
local isPvPMatchRevive = false
local matchReviveTime = 10
local buttonAbleTime = 10
local isUseButtonAbleTime = false
local isSiegeBeingInDead = false
local ResurrectionTime = revivalTime
local CurrentTime = 0
local revivalCacheItemCount = 0
local isHasRestoreExperience = false
local reviveStartIdx = 0
local reviveListPool = {}
local reviveListCount = 5
local function deadMessage_ClearDropItems()
  for ii = 0, #STATIC_DROP_ITEM do
    STATIC_DROP_ITEM[ii]:SetShow(false)
    STATIC_DROP_ITEM[ii]:SetText(" ")
  end
  DROP_ITEM_COUNT = 1
end
local function create_reviveList()
  for idx = 0, reviveListCount - 1 do
    do
      local slot = {}
      slot.bg = UI.createAndCopyBasePropertyControl(Panel_DeadNodeSelect, "Static_Channel_BG", reviveBG, "DeadNodeSelect_SlotBG_" .. idx)
      slot.text = UI.createAndCopyBasePropertyControl(Panel_DeadNodeSelect, "StaticText_ChannelName", slot.bg, "DeadNodeSelect_Slot_" .. idx)
      slot.btn = UI.createAndCopyBasePropertyControl(Panel_DeadNodeSelect, "Button_Select", slot.bg, "DeadNodeSelect_Slot_Count_" .. idx)
      slot.btn:addInputEvent("Mouse_LUp", "deadNodeSelect( " .. idx .. " )")
      slot.bg:SetPosX(5)
      slot.bg:SetPosY(5 + (slot.bg:GetSizeY() + 5) * idx)
      slot.text:SetPosX(10)
      slot.text:SetPosY(slot.bg:GetSizeY() / 2 - slot.text:GetSizeY() / 2)
      slot.btn:SetPosX(slot.bg:GetSizeX() - (slot.btn:GetSizeX() + 5))
      slot.btn:SetPosY(slot.bg:GetSizeY() / 2 - slot.btn:GetSizeY() / 2)
      function slot:showControl(isVisible)
        slot.bg:SetShow(isVisible)
        slot.text:SetShow(isVisible)
        slot.btn:SetShow(isVisible)
      end
      function slot:SetRegionText(regionText)
        slot.text:SetText(regionText)
      end
      function slot:clear()
        slot.showControl(false)
        slot.setDisable(true)
        slot.text:SetText("")
      end
      function slot:setDisable(isDisable)
        if isDisable then
          slot.btn:SetShow(false)
        else
          slot.btn:SetShow(true)
        end
        slot.bg:SetDisableColor(isDisable)
        slot.text:SetDisableColor(isDisable)
      end
      reviveListPool[idx] = slot
    end
  end
end
create_reviveList()
local function fillFortressInfo()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local fortressSize = temporaryWrapper:getMyFortressSize()
  for idx = 0, reviveListCount - 1 do
    reviveListPool[idx].clear()
  end
  for ii = 0, fortressSize do
    if ii < reviveListCount then
      local buildingInfo = temporaryWrapper:getMyfortressAt(ii)
      if nil ~= buildingInfo then
        local buildingRegionKey
        if ToClient_IsVillageSiegeBeing() then
          buildingRegionKey = buildingInfo:getBuildingRegionKey()
        else
          buildingRegionKey = buildingInfo:getAffiliatedRegionKey()
        end
        local regionInfo = getRegionInfoByRegionKey(buildingRegionKey)
        if nil ~= regionInfo then
          reviveListPool[ii]:showControl(true)
          local posi = buildingInfo:getPosition()
          local fortressToPlayerDistance = Util.Math.calculateDistance(posi, getSelfPlayer():get():getPosition())
          fortressToPlayerDistance = fortressToPlayerDistance / 100
          local fortressToPlayerDistance2 = string.format("%.1f", fortressToPlayerDistance)
          local linkSiegeWrapper = ToClient_getVillageSiegeRegionInfoWrapperByPosition(posi)
          local explorationWrapper = linkSiegeWrapper:getExplorationStaticStatusWrapper()
          local villageWarZone = linkSiegeWrapper:get():isVillageWarZone()
          local warZoneName = ""
          if nil ~= explorationWrapper and true == villageWarZone then
            warZoneName = explorationWrapper:getName()
          else
            warZoneName = regionInfo:getAreaName()
          end
          if fortressToPlayerDistance > 100000 then
            reviveListPool[ii].btn:SetShow(false)
          end
          reviveListPool[ii]:SetRegionText(warZoneName .. "\n" .. tostring(fortressToPlayerDistance2) .. "m")
        end
      end
    end
  end
  fortressSize = temporaryWrapper:getMyFortressSize()
  Panel_DeadNodeSelect:SetShow(fortressSize > 0)
  if 0 == fortressSize then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_NoPossibleRevivalPostion"))
  end
  if 1 == fortressSize then
    deadNodeSelect(0)
  end
end
function deadNodeSelect(idx)
  local temporaryWrapper = getTemporaryInformationWrapper()
  local buildingInfo = temporaryWrapper:getMyfortressAt(idx)
  if nil ~= buildingInfo then
    local buildingRegionKey
    if ToClient_IsVillageSiegeBeing() then
      buildingRegionKey = buildingInfo:getBuildingRegionKey()
    else
      buildingRegionKey = buildingInfo:getAffiliatedRegionKey()
    end
    if 0 == buildingRegionKey:get() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_NoPossibleRevivalPostion"))
      return
    end
    deadMessage_Revival(enRespawnType.respawnType_InSiegeingFortress, 255, 0, buildingRegionKey, false, toInt64(0, 0))
    deadMessage_ClearDropItems()
    Panel_DeadNodeSelect:SetShow(false)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_NoPossibleRevivalPostion"))
    return
  end
end
function deadNodeSelectClose()
  Panel_DeadNodeSelect:SetShow(false)
end
function deadMessage_Resize()
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  Panel_DeadMessage:SetSize(screenX, screenY)
  _deadBlackHole:SetPosX(screenX / 2 - _deadBlackHole:GetSizeX() / 2)
  _deadBlackHole:SetPosY(screenY / 2 - _deadBlackHole:GetSizeY() / 2)
  _deadMessage:SetPosX(screenX / 2 - 25)
  _deadMessage:SetPosY(100)
  local buttonHalfSizeX = _button_Immediate:GetSizeX() / 2
  local buttonSizeY = _button_Immediate:GetSizeY()
  _useCashItemBG:SetPosX(screenX / 2 - buttonHalfSizeX)
  _useCashItemBG:SetPosY(screenY / 2 + buttonSizeY * 2.4)
  _checkBoxUseCache:SetPosX(screenX / 2 - (buttonHalfSizeX - 5))
  _checkBoxUseCache:SetPosY(screenY / 2 + buttonSizeY * 2.43)
  _checkBoxUseFairy:SetPosX(screenX / 2 - (buttonHalfSizeX - 5))
  _checkBoxUseFairy:SetPosY(screenY / 2 + buttonSizeY * 2)
  _text_reviveNotify:SetPosX(screenX / 2 - _text_reviveNotify:GetSizeX() / 2)
  _text_reviveNotify:SetPosY(_checkBoxUseCache:GetPosY() - _text_reviveNotify:GetSizeY() - 20)
  _button_ObserverMode:SetPosX(screenX / 2 - buttonHalfSizeX)
  _button_ObserverMode:SetPosY(screenY / 2 + buttonSizeY + 30)
  _button_Immediate:SetPosX(screenX / 2 - buttonHalfSizeX)
  _button_Immediate:SetPosY(screenY / 2 + buttonSizeY * 2 + 50)
  _deadQuestion:SetPosX(screenX / 2 + buttonHalfSizeX - 40)
  _deadQuestion:SetPosY(screenY / 2 + buttonSizeY * 2 + 10)
  _text_ImmediateCount:SetPosX(screenX / 2 - _text_ImmediateCount:GetSizeX() / 2)
  _text_ImmediateCount:SetPosY(_button_Immediate:GetPosY() + 33)
  _button_MoveTown:SetPosX(screenX / 2 - buttonHalfSizeX)
  _button_MoveTown:SetPosY(screenY / 2 + buttonSizeY * 2 + 115)
  _button_SavageOut:SetPosX(screenX / 2 - buttonHalfSizeX)
  _button_SavageOut:SetPosY(_button_ObserverMode:GetPosY() + _button_ObserverMode:GetSizeY())
  _button_MoveExploration:SetPosX(screenX / 2 - buttonHalfSizeX)
  _button_MoveExploration:SetPosY(screenY / 2 + buttonSizeY * 2 + 165)
  _button_Volunteer:SetPosX(screenX / 2 - buttonHalfSizeX)
  _button_Volunteer:SetPosY(screenY / 2 + buttonSizeY * 2 + 215)
  _button_SiegeIng:SetPosX(_button_Immediate:GetPosX())
  _button_SiegeIng:SetPosY(_button_Immediate:GetPosY())
  _button_AdvancedBase:SetPosX(screenX / 2 - buttonHalfSizeX)
  _button_AdvancedBase:SetPosY(screenY / 2 + buttonSizeY * 2 + 215)
  _text_AdvancedBaseAlert:SetPosX(screenX / 2 - _text_AdvancedBaseAlert:GetSizeX() / 2)
  _text_AdvancedBaseAlert:SetPosY(screenY / 2 + buttonSizeY * 2 + 245)
  _button_GuildSpawn:SetPosX(screenX / 2 - _button_GuildSpawn:GetSizeX() / 2)
  _button_GuildSpawn:SetPosY(screenY / 2 + buttonSizeY * 2 + 280)
  _button_LocalWar:SetPosX(_button_Immediate:GetPosX())
  _button_LocalWar:SetPosY(_button_Immediate:GetPosY())
  _regenTime:SetPosX(screenX / 2 - _regenTime:GetSizeX() / 2)
  _regenTime:SetPosY(_deadMessage:GetPosY() + 45)
  local dropItemPosX = screenX / 2 - STATIC_DROP_ITEM[0]:GetSizeX() / 2
  local dropItemPosY = _regenTime:GetPosY() + 100
  for ii = 0, #STATIC_DROP_ITEM do
    STATIC_DROP_ITEM[ii]:SetShow(true)
    STATIC_DROP_ITEM[ii]:SetPosX(dropItemPosX)
    STATIC_DROP_ITEM[ii]:SetPosY(dropItemPosY + ii * STATIC_DROP_ITEM[ii]:GetSizeY() + ii * 40)
  end
  _checkBoxUseCache:SetCheck(false)
  _checkBoxUseFairy:SetCheck(false)
  if true == ToClient_IsDevelopment() then
    _checkBoxUseFairy:SetShow(true)
  else
    _checkBoxUseFairy:SetShow(false)
  end
end
local function deadMessage_Animation()
  Panel_DeadMessage:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  local aniInfo1 = _deadBlackHole:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo1:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo1.IsChangeChild = false
  local aniInfo2 = _deadBlackHole:addScaleAnimation(3, 15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_LINEAR_2)
  aniInfo2:SetStartScale(1)
  aniInfo2:SetEndScale(1.5)
  aniInfo2.AxisX = 128
  aniInfo2.AxisY = 128
  aniInfo2.IsChangeChild = false
  local aniInfo3 = _button_MoveTown:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo3:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo3.IsChangeChild = true
  aniInfo3:SetDisableWhileAni(true)
  local aniInfo3 = _button_MoveTown:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo3:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = true
  aniInfo3:SetDisableWhileAni(true)
  local aniInfo4 = _button_MoveTown:addScaleAnimation(2.5, 3.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo4:SetStartScale(0.5)
  aniInfo4:SetEndScale(1)
  aniInfo4.IsChangeChild = true
  aniInfo4:SetDisableWhileAni(true)
  local aniQuestion1 = _deadQuestion:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniQuestion1:SetStartColor(UI_color.C_00FFFFFF)
  aniQuestion1:SetEndColor(UI_color.C_00FFFFFF)
  aniQuestion1.IsChangeChild = true
  aniQuestion1:SetDisableWhileAni(true)
  local aniQuestion1 = _deadQuestion:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniQuestion1:SetStartColor(UI_color.C_00FFFFFF)
  aniQuestion1:SetEndColor(UI_color.C_FFFFFFFF)
  aniQuestion1.IsChangeChild = true
  aniQuestion1:SetDisableWhileAni(true)
  local aniQuestion2 = _deadQuestion:addScaleAnimation(2.5, 3.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniQuestion2:SetStartScale(0.5)
  aniQuestion2:SetEndScale(1)
  aniQuestion2.IsChangeChild = true
  aniQuestion2:SetDisableWhileAni(true)
  local aniInfoNotify1 = _text_reviveNotify:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoNotify1:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoNotify1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoNotify1.IsChangeChild = true
  aniInfoNotify1:SetDisableWhileAni(true)
  local aniInfoNotify2 = _text_reviveNotify:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoNotify2:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoNotify2:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoNotify2.IsChangeChild = true
  aniInfoNotify2:SetDisableWhileAni(true)
  local aniInfoNotify3 = _text_reviveNotify:addScaleAnimation(2.5, 3.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoNotify3:SetStartScale(0.5)
  aniInfoNotify3:SetEndScale(1)
  aniInfoNotify3.IsChangeChild = true
  aniInfoNotify3:SetDisableWhileAni(true)
  local aniInfoExplore3 = _button_MoveExploration:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoExplore3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoExplore3:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoExplore3.IsChangeChild = true
  aniInfoExplore3:SetDisableWhileAni(true)
  aniInfoExplore3 = _button_MoveExploration:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoExplore3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoExplore3:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoExplore3.IsChangeChild = true
  aniInfoExplore3:SetDisableWhileAni(true)
  local aniInfoExplore4 = _button_MoveExploration:addScaleAnimation(2.5, 3.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoExplore4:SetStartScale(0.5)
  aniInfoExplore4:SetEndScale(1)
  aniInfoExplore4.IsChangeChild = true
  aniInfoExplore4:SetDisableWhileAni(true)
  local aniInfoObserverMode = _button_ObserverMode:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoObserverMode:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoObserverMode:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoObserverMode.IsChangeChild = true
  aniInfoObserverMode:SetDisableWhileAni(true)
  aniInfoObserverMode = _button_ObserverMode:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoObserverMode:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoObserverMode:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoObserverMode.IsChangeChild = true
  aniInfoObserverMode:SetDisableWhileAni(true)
  local aniInfoImmediate3 = _button_Immediate:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoImmediate3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoImmediate3:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoImmediate3.IsChangeChild = true
  aniInfoImmediate3:SetDisableWhileAni(true)
  aniInfoImmediate3 = _button_Immediate:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoImmediate3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoImmediate3:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoImmediate3.IsChangeChild = true
  aniInfoImmediate3:SetDisableWhileAni(true)
  local aniInfoImmediate4 = _text_ImmediateCount:addScaleAnimation(2.5, 3.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoImmediate4:SetStartScale(0.5)
  aniInfoImmediate4:SetEndScale(1)
  aniInfoImmediate4.IsChangeChild = true
  aniInfoImmediate4:SetDisableWhileAni(true)
  local aniInfoImmediate5 = _text_ImmediateCount:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoImmediate5:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoImmediate5:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoImmediate5.IsChangeChild = true
  aniInfoImmediate5:SetDisableWhileAni(true)
  aniInfoImmediate5 = _text_ImmediateCount:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoImmediate5:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoImmediate5:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoImmediate5.IsChangeChild = true
  aniInfoImmediate5:SetDisableWhileAni(true)
  local aniInfoImmediate6 = _text_ImmediateCount:addScaleAnimation(2.5, 3.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoImmediate6:SetStartScale(0.5)
  aniInfoImmediate6:SetEndScale(1)
  aniInfoImmediate6.IsChangeChild = true
  aniInfoImmediate6:SetDisableWhileAni(true)
  local aniInfoSiege3 = _button_SiegeIng:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoSiege3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoSiege3:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoSiege3.IsChangeChild = true
  aniInfoSiege3 = _button_SiegeIng:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoSiege3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoSiege3:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoSiege3.IsChangeChild = true
  local aniInfoSiege4 = _button_SiegeIng:addScaleAnimation(2.5, 3.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoSiege4:SetStartScale(0.5)
  aniInfoSiege4:SetEndScale(1)
  aniInfoSiege4.IsChangeChild = true
  local aniInfoAdvancedBase = _button_AdvancedBase:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoAdvancedBase:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoAdvancedBase:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoAdvancedBase.IsChangeChild = true
  aniInfoAdvancedBase = _button_AdvancedBase:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoAdvancedBase:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoAdvancedBase:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoAdvancedBase.IsChangeChild = true
  local aniInfoAdvancedBase2 = _button_AdvancedBase:addScaleAnimation(2.5, 3.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoAdvancedBase2:SetStartScale(0.5)
  aniInfoAdvancedBase2:SetEndScale(1)
  aniInfoAdvancedBase2.IsChangeChild = true
  local aniInfoAdvancedBaseText1 = _text_AdvancedBaseAlert:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoAdvancedBaseText1:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoAdvancedBaseText1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoAdvancedBaseText1.IsChangeChild = true
  aniInfoAdvancedBaseText1:SetDisableWhileAni(true)
  local aniInfoAdvancedBaseText2 = _text_AdvancedBaseAlert:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoAdvancedBaseText2:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoAdvancedBaseText2:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoAdvancedBaseText2.IsChangeChild = true
  aniInfoAdvancedBaseText2:SetDisableWhileAni(true)
  local aniInfoAdvancedBaseText3 = _text_AdvancedBaseAlert:addScaleAnimation(2.5, 3.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoAdvancedBaseText3:SetStartScale(0.5)
  aniInfoAdvancedBaseText3:SetEndScale(1)
  aniInfoAdvancedBaseText3.IsChangeChild = true
  aniInfoAdvancedBaseText3:SetDisableWhileAni(true)
  local aniInfoLocalWar = _button_LocalWar:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoLocalWar:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoLocalWar:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoLocalWar.IsChangeChild = true
  aniInfoLocalWar = _button_LocalWar:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoLocalWar:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoLocalWar:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoLocalWar.IsChangeChild = true
  local aniInfoLocalWar2 = _button_LocalWar:addScaleAnimation(2.5, 3.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoLocalWar2:SetStartScale(0.5)
  aniInfoLocalWar2:SetEndScale(1)
  aniInfoLocalWar2.IsChangeChild = true
  local aniInfoSavage = _button_SavageOut:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoSavage:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoSavage:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoSavage.IsChangeChild = true
  aniInfoSavage = _button_SavageOut:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoSavage:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoSavage:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoSavage.IsChangeChild = true
  local aniInfoSavage2 = _button_SavageOut:addScaleAnimation(2.5, 3.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoSavage2:SetStartScale(0.5)
  aniInfoSavage2:SetEndScale(1)
  aniInfoSavage2.IsChangeChild = true
  local aniInfoGuildSpawn = _button_GuildSpawn:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoGuildSpawn:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoGuildSpawn:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoGuildSpawn.IsChangeChild = true
  aniInfoGuildSpawn = _button_GuildSpawn:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoGuildSpawn:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoGuildSpawn:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoGuildSpawn.IsChangeChild = true
  local aniInfoGuildSpawn2 = _button_GuildSpawn:addScaleAnimation(2.5, 3.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoGuildSpawn2:SetStartScale(0.5)
  aniInfoGuildSpawn2:SetEndScale(1)
  aniInfoGuildSpawn2.IsChangeChild = true
  local aniInfoVolunteer = _button_Volunteer:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoVolunteer:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoVolunteer:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoVolunteer.IsChangeChild = true
  aniInfoVolunteer = _button_Volunteer:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoVolunteer:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoVolunteer:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoVolunteer.IsChangeChild = true
  local aniInfoVolunteer2 = _button_Volunteer:addScaleAnimation(2.5, 3.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoVolunteer2:SetStartScale(0.5)
  aniInfoVolunteer2:SetEndScale(1)
  aniInfoVolunteer2.IsChangeChild = true
  local aniInfoCheckBox5 = _checkBoxUseCache:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoCheckBox5:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoCheckBox5:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoCheckBox5.IsChangeChild = true
  aniInfoCheckBox5 = _checkBoxUseCache:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoCheckBox5:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoCheckBox5:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoCheckBox5.IsChangeChild = true
  local aniInfoCheckBoxBG5 = _useCashItemBG:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoCheckBoxBG5:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoCheckBoxBG5:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoCheckBoxBG5:SetDisableWhileAni(true)
  aniInfoCheckBoxBG5.IsChangeChild = true
  aniInfoCheckBoxBG5 = _useCashItemBG:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoCheckBoxBG5:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoCheckBoxBG5:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoCheckBoxBG5.IsChangeChild = true
  local aniInfoCheckBox6 = _checkBoxUseCache:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoCheckBox6:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoCheckBox6:SetEndColor(UI_color.C_00FFFFFF)
  aniInfoCheckBox6.IsChangeChild = true
  aniInfoCheckBox6 = _checkBoxUseCache:addColorAnimation(3, 4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfoCheckBox6:SetStartColor(UI_color.C_00FFFFFF)
  aniInfoCheckBox6:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfoCheckBox6.IsChangeChild = true
  local aniInfo3 = _deadMessage:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo3:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo3.IsChangeChild = true
  local aniInfo7 = _deadMessage:addScaleAnimation(0.7, 2.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo7:SetStartScale(0.5)
  aniInfo7:SetEndScale(1)
  aniInfo7.IsChangeChild = true
  local aniInfo8 = _deadMessage:addColorAnimation(1.5, 2.3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo8:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo8:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo8.IsChangeChild = true
  local aniInfo9 = _regenTime:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo9:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo9:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo9.IsChangeChild = true
  local aniInfo9 = _regenTime:addColorAnimation(2.2, 2.7, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo9:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo9:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo9.IsChangeChild = true
  startTimer = true
end
function deadMessage_Show(attackerActorKeyRaw, isSkipDeathPenalty, isHasRestoreExp, isAblePvPMatchRevive, respawnTime)
  if Panel_GameExit:GetShow() then
    Panel_GameExit:SetShow(false)
  end
  if Panel_ChannelSelect:GetShow() then
    FGlobal_ChannelSelect_Hide()
  end
  SetUIMode(Defines.UIMode.eUIMode_DeadMessage)
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  _button_SavageOut:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_WAVE_OUT"))
  _button_ObserverMode:SetShow(false)
  local attackerActorProxyWrapper = getActor(attackerActorKeyRaw)
  isPvPMatchRevive = isAblePvPMatchRevive
  local isMilitia = false
  local playerActorProxyWrapper = getPlayerActor(attackerActorKeyRaw)
  if nil ~= playerActorProxyWrapper then
    isMilitia = playerActorProxyWrapper:get():isVolunteer()
  end
  if selfProxy:get():isBattleGroundDefine() then
    _button_SiegeIng:SetShow(false)
    _button_MoveExploration:SetShow(false)
    _button_MoveTown:SetShow(false)
    _button_AdvancedBase:SetShow(false)
    _text_AdvancedBaseAlert:SetShow(false)
    _text_reviveNotify:SetShow(false)
    _button_Immediate:SetShow(true)
    _button_GuildSpawn:SetShow(false)
    _button_Immediate:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_IMMEDIATE_RESURRECTION"))
    _useCashItemBG:SetShow(false)
    _checkBoxUseCache:SetShow(false)
    _checkBoxUseFairy:SetShow(false)
    _text_ImmediateCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PVPBATTLE_IMMEDIATECOUNT_TEXT"))
    _text_ImmediateCount:SetShow(true)
    _button_LocalWar:SetShow(false)
    _button_SavageOut:SetShow(false)
    _button_Volunteer:SetShow(false)
    _deadQuestion:SetShow(false)
    if nil == attackerActorProxyWrapper then
      _deadMessage:SetText(PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg"))
    elseif isMilitia then
      _deadMessage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA")))
    else
      _deadMessage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerActorProxyWrapper:getOriginalName()))
    end
    ResurrectionTime = revivalTime
    Panel_DeadMessage:SetShow(true, false)
    deadMessage_Animation()
    return
  end
  if selfProxy:get():isCompetitionDefined() then
    local hostCanSelfRebirth = selfProxy:get():isCompetitionHost()
    _button_SiegeIng:SetShow(false)
    _button_MoveExploration:SetShow(false)
    _button_MoveTown:SetShow(false)
    _button_AdvancedBase:SetShow(false)
    _text_AdvancedBaseAlert:SetShow(false)
    _text_reviveNotify:SetShow(false)
    _button_Immediate:SetShow(hostCanSelfRebirth)
    _button_Immediate:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_IMMEDIATE_RESURRECTION"))
    _text_ImmediateCount:SetShow(hostCanSelfRebirth)
    _text_ImmediateCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PVPBATTLE_IMMEDIATECOUNT_TEXT"))
    _button_GuildSpawn:SetShow(false)
    _useCashItemBG:SetShow(false)
    _checkBoxUseCache:SetShow(false)
    _checkBoxUseFairy:SetShow(false)
    _button_SavageOut:SetShow(false)
    _button_Volunteer:SetShow(false)
    _deadQuestion:SetShow(false)
    _button_LocalWar:SetShow(false)
    _button_ObserverMode:SetShow(true)
    if nil == attackerActorProxyWrapper then
      _deadMessage:SetText(PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg"))
    elseif isMilitia then
      _deadMessage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA")))
    else
      _deadMessage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerActorProxyWrapper:getOriginalName()))
    end
    Panel_DeadMessage:SetShow(true, false)
    ResurrectionTime = ToClient_CompetitionMatchTimeLimit() + ToClient_GetMaxWaitTime()
    _regenTime:SetShow(false)
    if selfProxy:get():isCompetitionHost() == false then
      _text_ImmediateCount:SetShow(false)
    end
    deadMessage_Animation()
    return
  end
  if ToClient_getPlayNowSavageDefence() then
    _button_SiegeIng:SetShow(false)
    _button_MoveExploration:SetShow(false)
    _button_MoveTown:SetShow(false)
    _button_AdvancedBase:SetShow(false)
    _text_AdvancedBaseAlert:SetShow(false)
    _text_reviveNotify:SetShow(false)
    _button_Immediate:SetShow(false)
    _button_GuildSpawn:SetShow(false)
    _button_Immediate:SetShow(false)
    _useCashItemBG:SetShow(false)
    _checkBoxUseCache:SetShow(false)
    _checkBoxUseFairy:SetShow(false)
    _text_ImmediateCount:SetShow(false)
    _text_ImmediateCount:SetShow(false)
    _button_LocalWar:SetShow(false)
    _button_ObserverMode:SetShow(true)
    _button_SavageOut:SetShow(true)
    _button_Volunteer:SetShow(false)
    _deadQuestion:SetShow(false)
    ResurrectionTime = revivalTime
    Panel_DeadMessage:SetShow(true, false)
    deadMessage_Animation()
    return
  end
  if ToClient_getJoinGuildBattle() then
    _button_SiegeIng:SetShow(false)
    _button_MoveExploration:SetShow(false)
    _button_MoveTown:SetShow(false)
    _button_AdvancedBase:SetShow(false)
    _text_AdvancedBaseAlert:SetShow(false)
    _text_reviveNotify:SetShow(false)
    _button_GuildSpawn:SetShow(false)
    _useCashItemBG:SetShow(false)
    _checkBoxUseCache:SetShow(false)
    _button_Immediate:SetShow(false)
    _checkBoxUseFairy:SetShow(false)
    _button_Immediate:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_IMMEDIATE_RESURRECTION"))
    _text_ImmediateCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PVPBATTLE_IMMEDIATECOUNT_TEXT"))
    _text_ImmediateCount:SetShow(false)
    _button_LocalWar:SetShow(false)
    _button_ObserverMode:SetShow(true)
    _button_SavageOut:SetShow(false)
    _button_Volunteer:SetShow(false)
    _deadQuestion:SetShow(false)
    ResurrectionTime = revivalTime
    Panel_DeadMessage:SetShow(true, false)
    deadMessage_Animation()
    return
  end
  if isPvPMatchRevive then
    _button_SiegeIng:SetShow(false)
    _button_MoveExploration:SetShow(false)
    _button_MoveTown:SetShow(false)
    _button_AdvancedBase:SetShow(false)
    _text_AdvancedBaseAlert:SetShow(false)
    _text_reviveNotify:SetShow(false)
    _button_Immediate:SetShow(true)
    _button_GuildSpawn:SetShow(false)
    _button_Immediate:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_IMMEDIATE_RESURRECTION"))
    _useCashItemBG:SetShow(false)
    _checkBoxUseCache:SetShow(false)
    _checkBoxUseFairy:SetShow(false)
    _text_ImmediateCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PVPBATTLE_IMMEDIATECOUNT_TEXT"))
    _text_ImmediateCount:SetShow(true)
    _button_LocalWar:SetShow(false)
    _button_SavageOut:SetShow(false)
    _button_Volunteer:SetShow(false)
    _deadQuestion:SetShow(false)
    if nil == attackerActorProxyWrapper then
      _deadMessage:SetText(PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg"))
    elseif isMilitia then
      _deadMessage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA")))
    else
      _deadMessage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerActorProxyWrapper:getOriginalName()))
    end
    ResurrectionTime = revivalTime
    Panel_DeadMessage:SetShow(true, false)
    deadMessage_Animation()
    return
  end
  if 0 ~= ToClient_GetMyTeamNoLocalWar() then
    _button_SiegeIng:SetShow(false)
    _button_MoveExploration:SetShow(false)
    _button_MoveTown:SetShow(false)
    _button_AdvancedBase:SetShow(false)
    _text_AdvancedBaseAlert:SetShow(false)
    _text_reviveNotify:SetShow(false)
    _button_Immediate:SetShow(false)
    _button_GuildSpawn:SetShow(false)
    _useCashItemBG:SetShow(false)
    _checkBoxUseCache:SetShow(false)
    _checkBoxUseFairy:SetShow(false)
    _text_ImmediateCount:SetShow(false)
    _button_LocalWar:SetShow(true)
    _button_SavageOut:SetShow(false)
    _button_Volunteer:SetShow(false)
    _deadQuestion:SetShow(false)
    Panel_DeadMessage:SetShow(true, false)
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  if regionInfo:isPrison() or goToPrison() then
    _button_SiegeIng:SetShow(false)
    _button_MoveExploration:SetShow(false)
    _button_MoveTown:SetShow(false)
    _button_AdvancedBase:SetShow(false)
    _text_AdvancedBaseAlert:SetShow(false)
    _text_reviveNotify:SetShow(false)
    _button_Immediate:SetShow(false)
    _button_GuildSpawn:SetShow(false)
    _useCashItemBG:SetShow(false)
    _checkBoxUseCache:SetShow(false)
    _checkBoxUseFairy:SetShow(false)
    _text_ImmediateCount:SetShow(false)
    _button_LocalWar:SetShow(false)
    _button_SavageOut:SetShow(false)
    _button_Volunteer:SetShow(false)
    _deadQuestion:SetShow(false)
    Panel_DeadMessage:SetShow(true, false)
    ResurrectionTime = 2
    return
  end
  if 0 == ToClient_GetMyTeamNoLocalWar() and false == ToClient_getPlayNowSavageDefence() and true == ToClient_isSpecialCharacter() then
    _button_SiegeIng:SetShow(false)
    _button_MoveExploration:SetShow(false)
    _button_MoveTown:SetShow(false)
    _button_AdvancedBase:SetShow(false)
    _text_AdvancedBaseAlert:SetShow(false)
    _text_reviveNotify:SetShow(false)
    _button_Immediate:SetShow(true)
    _button_GuildSpawn:SetShow(false)
    _button_Immediate:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_IMMEDIATE_RESURRECTION"))
    _useCashItemBG:SetShow(false)
    _checkBoxUseCache:SetShow(false)
    _checkBoxUseFairy:SetShow(false)
    _text_ImmediateCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PVPBATTLE_IMMEDIATECOUNT_TEXT"))
    _text_ImmediateCount:SetShow(true)
    _button_LocalWar:SetShow(false)
    _button_SavageOut:SetShow(false)
    _button_Volunteer:SetShow(false)
    _deadQuestion:SetShow(false)
    if nil == attackerActorProxyWrapper then
      _deadMessage:SetText(PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg"))
    elseif isMilitia then
      _deadMessage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA")))
    else
      _deadMessage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerActorProxyWrapper:getOriginalName()))
    end
    ResurrectionTime = revivalTime
    Panel_DeadMessage:SetShow(true, false)
    deadMessage_Animation()
    return
  end
  isHasRestoreExperience = isHasRestoreExp
  local linkedSiegeRegionInfoWrapper = ToClient_getVillageSiegeRegionInfoWrapperByPosition(selfProxy:get():getPosition())
  local isKingOrLordWarZone = regionInfo:get():isKingOrLordWarZone()
  local isVillageWarZone = linkedSiegeRegionInfoWrapper:get():isVillageWarZone()
  isSiegeBeingInDead = deadMessage_isSiegeBeingInCurrentPosition()
  local isArena = regionInfo:get():isArenaArea()
  local isMyChannelSiegeBeing = deadMessage_isSiegeBeingMyChannel()
  buttonAbleTime = -1
  isUseButtonAbleTime = false
  if isSiegeBeingInDead and deadMessage_isInSiegeBattle() or 0 ~= selfProxy:get():getVolunteerTeamNoForLua() then
    respawnTime = respawnTime / 1000
    local buttonDelayTime = respawnTime
    if 0 ~= buttonDelayTime then
      isUseButtonAbleTime = true
      buttonAbleTime = respawnTime
      _button_SiegeIng:SetEnable(false)
      _button_MoveExploration:SetEnable(false)
      _button_MoveTown:SetEnable(false)
      _button_AdvancedBase:SetEnable(false)
      _button_Immediate:SetEnable(false)
      _button_GuildSpawn:SetEnable(false)
      _button_Volunteer:SetEnable(false)
    end
    ResurrectionTime = respawnTime
    _regenTime:SetShow(true)
  else
    ResurrectionTime = 0
    _regenTime:SetShow(false)
  end
  local freeRevivalLevel = FromClient_getFreeRevivalLevel()
  local isFreeArea = regionInfo:get():isFreeRevivalArea()
  FGlobal_PopCloseWorldMap()
  local selfPlayerExp = selfProxy:get():getExp_s64()
  if isSkipDeathPenalty then
    local static = STATIC_DROP_ITEM[0]
    static:SetShow(true)
    static:SetText(PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_NoDeathPenalty"))
  elseif selfPlayerExp > Defines.s64_const.s64_0 and false == isArena then
    deadMessage_ExpDown()
  end
  Panel_DeadMessage:SetShow(true, false)
  deadMessage_Animation()
  local displayText = ""
  if attackerActorKeyRaw == selfProxy:getActorKey() then
    displayText = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg")
  elseif nil ~= attackerActorProxyWrapper then
    if isMilitia then
      displayText = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA"))
    else
      displayText = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerActorProxyWrapper:getOriginalName())
    end
  else
    displayText = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg")
  end
  _deadMessage:SetText(displayText)
  _button_SiegeIng:SetShow(false)
  _button_MoveExploration:SetShow(true)
  _button_MoveTown:SetShow(true)
  _button_AdvancedBase:SetShow(false)
  _text_AdvancedBaseAlert:SetShow(false)
  _button_LocalWar:SetShow(false)
  _button_SavageOut:SetShow(false)
  _text_reviveNotify:SetShow(false)
  _button_Volunteer:SetShow(false)
  _button_GuildSpawn:SetShow(false)
  if nil ~= attackerActorProxyWrapper then
    local isAttackPlayer = attackerActorProxyWrapper:get():isPlayer()
    if isAttackPlayer then
      if ToClient_isDontPvPDecreaseTendency() then
        _deadQuestion:SetShow(false)
      else
        _deadQuestion:SetShow(true)
      end
    else
      _deadQuestion:SetShow(false)
    end
  end
  if FGlobal_IsCommercialService() then
    _button_Immediate:SetShow(true)
    _useCashItemBG:SetShow(true)
    if freeRevivalLevel >= selfProxy:get():getLevel() and isFreeArea then
      _checkBoxUseCache:SetShow(false)
      _useCashItemBG:SetShow(false)
      _checkBoxUseFairy:SetShow(false)
    else
      _checkBoxUseCache:SetShow(true)
      _useCashItemBG:SetShow(true)
      if true == ToClient_IsDevelopment() then
        _checkBoxUseFairy:SetShow(true)
      end
    end
    _button_Immediate:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_IMMEDIATE_RESURRECTION"))
    _text_ImmediateCount:SetShow(true)
    local setMessage = ""
    local revivalItemCount = ToClient_InventorySizeByProductCategory(CppEnums.ItemWhereType.eCashInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival)
    if isFreeArea and freeRevivalLevel >= selfProxy:get():getLevel() then
      setMessage = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_RESURRECTION_POSSIBLE", "freeRevivalLevel", freeRevivalLevel)
    elseif revivalItemCount <= 0 then
      setMessage = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_ITEM_RESURRECTION")
    else
      setMessage = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_GET_ITEM_RESURRECTION", "revivalItemCount", revivalItemCount)
    end
    _text_ImmediateCount:SetText(setMessage)
  else
    if true == isArena then
      _button_Immediate:SetShow(true)
      _button_Immediate:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_IMMEDIATE_RESURRECTION"))
    else
      _button_Immediate:SetShow(false)
    end
    _text_ImmediateCount:SetShow(false)
    _useCashItemBG:SetShow(false)
    _checkBoxUseCache:SetShow(false)
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local fortressSize = temporaryWrapper:getMyFortressSize()
  if true == isMyChannelSiegeBeing then
    if true == deadMessage_isInSiegeBattle() then
      _button_Immediate:SetShow(false)
      _text_ImmediateCount:SetShow(false)
      _button_SiegeIng:SetShow(true)
    elseif true == isSiegeBeingInDead then
      _button_Immediate:SetShow(false)
      _text_ImmediateCount:SetShow(false)
    elseif true == isHasFortress() and false == isSiegeBeingInDead then
      _text_reviveNotify:SetShow(true)
    elseif false == getNoAccessArea() then
      _button_MoveTown:SetShow(false)
      _button_Immediate:SetShow(false)
      _text_ImmediateCount:SetShow(false)
    end
    _deadQuestion:SetShow(false)
    if regionInfo:get():isMajorSiegeBeing() or linkedSiegeRegionInfoWrapper:get():isMinorSiegeBeing() then
      _button_MoveExploration:SetShow(false)
    end
    _button_Immediate:SetShow(false)
    _text_ImmediateCount:SetShow(false)
    if selfProxy:get():isVolunteer() then
      _button_Volunteer:SetShow(true)
    end
    local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
    if nil ~= myGuildInfo then
      local guildNo = myGuildInfo:getGuildNo_s64()
      if ToClient_IsInSiegeBattle(guildNo) then
        _button_ObserverMode:SetShow(true)
      end
    end
  elseif false == getNoAccessArea() then
    _button_Immediate:SetShow(false)
    _text_ImmediateCount:SetShow(false)
  end
  local guildUnSealCount = guildstable_getUnsealGuildServantCount()
  if 0 ~= guildUnSealCount then
    for index = 0, guildUnSealCount - 1 do
      local servantInfo = guildStable_getUnsealGuildServantAt(index)
      if nil ~= servantInfo and (34 == servantInfo:getVehicleType() or 44 == servantInfo:getVehicleType()) then
        _button_GuildSpawn:SetShow(true)
      end
    end
  end
  if selfProxy:get():isGuildMember() and selfProxy:get():isAdvancedBaseActorKey() then
    _button_AdvancedBase:SetShow(true)
    _text_AdvancedBaseAlert:SetShow(true)
  end
  revivalCacheItemCount = ToClient_InventorySizeByProductCategory(CppEnums.ItemWhereType.eCashInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival)
end
function deadMessage_UpdatePerFrame(deltaTime)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer or not selfPlayer:isDead() then
    Panel_DeadMessage:SetShow(false, false)
    return
  end
  if isUseButtonAbleTime then
    buttonAbleTime = buttonAbleTime - deltaTime
    if buttonAbleTime < 0 then
      isUseButtonAbleTime = false
      _button_SiegeIng:SetEnable(true)
      _button_MoveExploration:SetEnable(true)
      _button_MoveTown:SetEnable(true)
      _button_AdvancedBase:SetEnable(true)
      _button_Immediate:SetEnable(true)
      _button_GuildSpawn:SetEnable(true)
      _button_Volunteer:SetEnable(true)
    end
  end
  if nil == ResurrectionTime then
    return
  end
  if ResurrectionTime > 0 then
    ResurrectionTime = ResurrectionTime - deltaTime
    local regenTime = math.floor(ResurrectionTime)
    if CurrentTime ~= regenTime then
      if isUseButtonAbleTime and not isSiegeBeingInDead then
        _regenTime:SetText(PAGetString(Defines.StringSheet_GAME, DEADMESSAGE_TEXT_RespawnWaitting))
      else
        _regenTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_TIME", "regenTime", tostring(regenTime)))
      end
      CurrentTime = regenTime
      if regenTime <= 0 then
        if goToPrison() then
          deadMessage_Revival(enRespawnType.respawnType_TimeOver, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
          SetUIMode(Defines.UIMode.eUIMode_Default)
          return
        end
        _regenTime:SetShow(false)
        if isSiegeBeingInDead or 0 ~= getSelfPlayer():get():getVolunteerTeamNoForLua() then
        else
          Panel_DeadMessage:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
          local aniInfo1 = Panel_DeadMessage:addColorAnimation(0, 1, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
          aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
          aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
          aniInfo1.IsChangeChild = true
          aniInfo1:SetHideAtEnd(true)
          aniInfo1:SetDisableWhileAni(true)
          deadMessage_ClearDropItems()
          deadMessage_Revival(enRespawnType.respawnType_TimeOver, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
          SetUIMode(Defines.UIMode.eUIMode_Default)
        end
      end
    end
  else
    local isObserverMode = false
    if getSelfPlayer():get():isCompetitionDefined() then
      isObserverMode = true
    end
    _button_ObserverMode:SetShow(isObserverMode)
    _regenTime:SetShow(false)
  end
end
local undefinedEnchantLevel = 0
function deadMessage_AddDropItem(itemName, count, enchantLevel, dropType)
  if #STATIC_DROP_ITEM < DROP_ITEM_COUNT then
    return
  end
  local strDropType = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_DRIPTYPE1")
  if 1 == dropType then
    strDropType = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_DRIPTYPE2")
  end
  local static = STATIC_DROP_ITEM[DROP_ITEM_COUNT]
  static:SetShow(true)
  if undefinedEnchantLevel ~= enchantLevel then
    static:SetText("+" .. enchantLevel .. " " .. itemName .. "[" .. count .. "]" .. " (" .. strDropType .. ")")
  else
    static:SetText(itemName .. "[" .. count .. "]" .. " (" .. strDropType .. ")")
  end
  static:SetFontColor(UI_color.C_FFD20000)
  local aniInfo5 = static:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo5:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo5:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo5.IsChangeChild = true
  local aniInfo6 = static:addColorAnimation(3, 3.4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo6:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo6:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo6.IsChangeChild = true
  DROP_ITEM_COUNT = DROP_ITEM_COUNT + 1
end
function deadMessage_WeakEquipCantPushinventory(notify)
  if #STATIC_DROP_ITEM < DROP_ITEM_COUNT then
    return
  end
  local static = STATIC_DROP_ITEM[DROP_ITEM_COUNT]
  DROP_ITEM_COUNT = DROP_ITEM_COUNT + 1
  static:SetText(notify)
  static:SetFontColor(UI_color.C_FF96D4FC)
  static:SetShow(true)
  local aniInfo5 = static:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo5:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo5:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo5.IsChangeChild = true
  local aniInfo6 = static:addColorAnimation(3, 3.4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo6:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo6:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo6.IsChangeChild = true
end
function deadMessage_WeakEquip(slotNo)
  if #STATIC_DROP_ITEM < DROP_ITEM_COUNT then
    return
  end
  local static = STATIC_DROP_ITEM[DROP_ITEM_COUNT]
  DROP_ITEM_COUNT = DROP_ITEM_COUNT + 1
  static:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DownEnchantMsg", "enchantDownSlot", CPP_slotNoString[slotNo]))
  static:SetFontColor(UI_color.C_FF96D4FC)
  static:SetShow(true)
  local aniInfo5 = static:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo5:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo5:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo5.IsChangeChild = true
  local aniInfo6 = static:addColorAnimation(3, 3.4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo6:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo6:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo6.IsChangeChild = true
end
function deadMessage_DestroyJewel(destoryJewel01, destoryJewel02, destoryJewel03, destoryJewel04, destoryJewel05)
  if #STATIC_DROP_ITEM < DROP_ITEM_COUNT then
    return
  end
  local jewelKey = {
    [0] = destoryJewel01,
    [1] = destoryJewel02,
    [2] = destoryJewel03,
    [3] = destoryJewel04,
    [4] = destoryJewel05
  }
  local jewelName = ""
  for idx = 0, #jewelKey do
    if "" ~= jewelName then
      if nil ~= jewelKey[idx] and 0 ~= jewelKey[idx] then
        local itemStaticStatus = getItemEnchantStaticStatus(ItemEnchantKey(jewelKey[idx]))
        local itemName = itemStaticStatus:getName()
        jewelName = jewelName .. ", " .. itemName
      end
    elseif nil ~= jewelKey[idx] and 0 ~= jewelKey[idx] then
      jewelName = getItemEnchantStaticStatus(ItemEnchantKey(jewelKey[idx])):getName()
    end
  end
  local static = STATIC_DROP_ITEM[DROP_ITEM_COUNT]
  static:SetShow(true)
  static:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_JEWELDESTROYED") .. " " .. jewelName)
  static:SetFontColor(UI_color.C_FFD20000)
  local aniInfo5 = static:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo5:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo5:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo5.IsChangeChild = true
  local aniInfo6 = static:addColorAnimation(3, 3.4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo6:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo6:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo6.IsChangeChild = true
  DROP_ITEM_COUNT = DROP_ITEM_COUNT + 1
end
function deadMessage_ExpDown()
  local static = STATIC_DROP_ITEM[0]
  local aniInfo5 = static:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo5:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo5:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo5.IsChangeChild = true
  local aniInfo6 = static:addColorAnimation(3, 3.4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo6:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo6:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo6.IsChangeChild = true
end
function deadMessage_ButtonPushed_MoveToVillage()
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local linkedSiegeRegionInfoWrapper = ToClient_getVillageSiegeRegionInfoWrapperByPosition(selfProxy:get():getPosition())
  local isVillageWarZone = linkedSiegeRegionInfoWrapper:get():isVillageWarZone()
  local isSiegeHasFortress = deadMessage_isSiegingGuildInCurrentPosition()
  local isKingOrLordWarZone = regionInfo:get():isKingOrLordWarZone()
  local isSiegeBeing = deadMessage_isSiegeBeingInCurrentPosition()
  local prevExp = selfProxy:get():getPrevExp_s64()
  local currentExp = selfProxy:get():getExp_s64()
  local isBadPlayer = false
  if selfProxy:get():getTendency() < 0 then
    isBadPlayer = true
  end
  local isCheck = _checkBoxUseCache:IsCheck()
  local isFairyCheck = _checkBoxUseFairy:IsCheck()
  local isArena = regionInfo:get():isArenaArea()
  local freeRevivalLevel = FromClient_getFreeRevivalLevel()
  local isFreeArea = regionInfo:get():isFreeRevivalArea()
  if isCheck and false == isArena and (isHasRestoreExperience or prevExp > currentExp) then
    useCheckCacheItem(enRespawnType.respawnType_NearTown)
  elseif isFairyCheck then
    useCheckFairy(enRespawnType.respawnType_NearTown)
  else
    local contentString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_TO_VILLAGE")
    if isSiegeBeing and (true == isKingOrLordWarZone or true == isVillageWarZone) then
    else
      if isHasRestoreExperience or prevExp > currentExp then
        contentString = contentString .. "\n" .. PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_EXP_DOWN")
      else
      end
      if ToClient_IsOpendDesertPK() and true == isBadPlayer and 0 ~= regionInfo:getVillainRespawnWaypointKey() then
        contentString = contentString .. "\n" .. PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_BadPlayerMoveVillage")
      end
    end
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_MB_TITLE"),
      content = contentString,
      functionYes = deadMessage_RevivalVillage_Confirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_1
    }
    MessageBox.showMessageBox(messageboxData)
  end
  deadMessage_ClearDropItems()
end
function deadMessage_RevivalVillage_Confirm()
  deadMessage_Revival(enRespawnType.respawnType_NearTown, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
  SetUIMode(Defines.UIMode.eUIMode_Default)
end
function deadMessage_ButtonPushed_Volunteer()
  deadMessage_Revival(enRespawnType.respawnType_Volunteer, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
  SetUIMode(Defines.UIMode.eUIMode_Default)
end
function deadMessage_ButtonPushed_MoveExploration()
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local linkedSiegeRegionInfoWrapper = ToClient_getVillageSiegeRegionInfoWrapperByPosition(selfProxy:get():getPosition())
  local isVillageWarZone = linkedSiegeRegionInfoWrapper:get():isVillageWarZone()
  local isKingOrLordWarZone = regionInfo:get():isKingOrLordWarZone()
  local isSiegeBeing = deadMessage_isSiegeBeingInCurrentPosition()
  local prevExp = selfProxy:get():getPrevExp_s64()
  local currentExp = selfProxy:get():getExp_s64()
  local isCheck = _checkBoxUseCache:IsCheck()
  local isFairyCheck = _checkBoxUseFairy:IsCheck()
  local freeRevivalLevel = FromClient_getFreeRevivalLevel()
  local isFreeArea = regionInfo:get():isFreeRevivalArea()
  local isArena = regionInfo:get():isArenaArea()
  if isCheck and false == isArena and (isHasRestoreExperience or prevExp > currentExp) then
    useCheckCacheItem(enRespawnType.respawnType_Exploration)
  elseif isFairyCheck then
    useCheckFairy(enRespawnType.respawnType_NearTown)
  else
    local contentString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_TO_EXPLORE")
    if isSiegeBeing and (true == isKingOrLordWarZone or true == isVillageWarZone) then
    else
      if isHasRestoreExperience or prevExp > currentExp then
        contentString = contentString .. "\n" .. PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_EXP_DOWN")
      else
      end
    end
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_MB_TITLE"),
      content = contentString,
      functionYes = deadMessage_RevivalExploration_Confirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_1
    }
    MessageBox.showMessageBox(messageboxData)
  end
  deadMessage_ClearDropItems()
end
function deadMessage_RevivalExploration_Confirm()
  deadMessage_Revival(enRespawnType.respawnType_Exploration, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
  SetUIMode(Defines.UIMode.eUIMode_Default)
end
function deadMessage_ButtonPushed_Immediate()
  local revivalItemCount = 0
  revivalItemCount = ToClient_InventorySizeByProductCategory(CppEnums.ItemWhereType.eCashInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival)
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local isArena = regionInfo:get():isArenaArea()
  local isCompetition = selfProxy:get():isCompetitionDefined()
  local isGuildBattle = ToClient_getJoinGuildBattle()
  local freeRevivalLevel = FromClient_getFreeRevivalLevel()
  local isFreeArea = regionInfo:get():isFreeRevivalArea()
  if isGuildBattle then
    deadMessage_Revival(enRespawnType.respawnType_GuildBatle, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
  elseif true == isArena then
    deadMessage_Revival(enRespawnType.respawnType_Immediate, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
  elseif isFreeArea and freeRevivalLevel >= selfProxy:get():getLevel() then
    deadMessage_Revival(enRespawnType.respawnType_Immediate, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
  elseif true == isPvPMatchRevive or true == isCompetition then
    deadMessage_Revival(enRespawnType.respawnType_Immediate, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), isPvPMatchRevive, toInt64(0, 0))
  elseif 1 == revivalItemCount then
    HandleClicked_Apply_CashRevivalItem(enRespawnType.respawnType_Immediate)
  elseif revivalItemCount > 1 then
    CashRevivalBuy_Open(enRespawnType.respawnType_Immediate)
  else
    HandleClicked_Buy_CashRevivalItem(enRespawnType.respawnType_Immediate)
  end
  FGlobal_ImmediatelyResurrection(selfProxy:get():getMaxHp())
  deadMessage_ClearDropItems()
end
function deadMessage_ButtonPushed_SiegeIng()
  local buildingRegionKey = 0
  local currentBuildInfo = ToClient_getCurrentBuildingInfo()
  if nil == currentBuildInfo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_NOSIEGEBUILDING"))
    return
  end
  if ToClient_IsVillageSiegeBeing() then
    buildingRegionKey = currentBuildInfo:getBuildingRegionKey()
  else
    buildingRegionKey = currentBuildInfo:getAffiliatedRegionKey()
  end
  deadMessage_Revival(enRespawnType.respawnType_InSiegeingFortress, 255, 0, buildingRegionKey, false, toInt64(0, 0))
  deadMessage_ClearDropItems()
end
function deadMessage_ButtonPushed_AdvancedBase()
  deadMessage_Revival(enRespawnType.respawnType_AdvancedBase, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
end
function deadMessage_ButtonPushed_LocalWar()
  deadMessage_Revival(enRespawnType.respawnType_LocalWar, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
end
function deadMessage_ButtonPushed_SavageDefence()
  local executeUnjoin = function()
    ToClient_SavageDefenceUnJoin()
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_SAVAGEDEAD")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = executeUnjoin,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function deadMessage_RevivalGuildSpawn_Confirm()
  local servantNo = 0
  local guildServantCount = guildServant_count()
  local selfPosition = getSelfPlayer():get():getPosition()
  local distance = 99999999
  for index = 0, guildServantCount do
    local servantInfo = guildStable_getServantByOrder(index)
    if nil ~= servantInfo then
      local giantActorPosition = getGiantActorPosition(servantInfo:getActorKeyRaw())
      if nil ~= giantActorPosition then
        local shipToPlayerDistance = Util.Math.calculateDistance(giantActorPosition, selfPosition)
        if distance > shipToPlayerDistance then
          distance = shipToPlayerDistance
          servantNo = servantInfo:getServantNo()
        end
      end
    end
  end
  if 0 == servantNo then
    return
  end
  deadMessage_Revival(enRespawnType.respawnType_GuildSpawn, 255, 0, getSelfPlayer():getRegionKey(), false, servantNo)
  SetUIMode(Defines.UIMode.eUIMode_Default)
end
function deadMessage_ButtonPushed_GuildSpawn()
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local linkedSiegeRegionInfoWrapper = ToClient_getVillageSiegeRegionInfoWrapperByPosition(selfProxy:get():getPosition())
  local isVillageWarZone = linkedSiegeRegionInfoWrapper:get():isVillageWarZone()
  local isKingOrLordWarZone = regionInfo:get():isKingOrLordWarZone()
  local isSiegeBeing = deadMessage_isSiegeBeingInCurrentPosition()
  local prevExp = selfProxy:get():getPrevExp_s64()
  local currentExp = selfProxy:get():getExp_s64()
  local isCheck = _checkBoxUseCache:IsCheck()
  local isFairyCheck = _checkBoxUseFairy:IsCheck()
  local isArena = regionInfo:get():isArenaArea()
  local freeRevivalLevel = FromClient_getFreeRevivalLevel()
  if isCheck and false == isArena and (isHasRestoreExperience or prevExp > currentExp) then
    useCheckCacheItem(enRespawnType.respawnType_GuildSpawn)
  elseif isFairyCheck then
    useCheckFairy(enRespawnType.respawnType_NearTown)
  else
    local contentString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_GUILDSPAWN")
    if isSiegeBeing and (true == isKingOrLordWarZone or true == isVillageWarZone) then
    else
      if isHasRestoreExperience or prevExp > currentExp then
        contentString = contentString .. "\n" .. PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_EXP_DOWN")
      else
      end
    end
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_RESPAWN_MB_TITLE"),
      content = contentString,
      functionYes = deadMessage_RevivalGuildSpawn_Confirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_1
    }
    MessageBox.showMessageBox(messageboxData)
  end
  deadMessage_ClearDropItems()
end
function useCheckCacheItem(respawnType)
  local revivalItemCount = 0
  revivalItemCount = ToClient_InventorySizeByProductCategory(CppEnums.ItemWhereType.eCashInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival)
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local isArena = regionInfo:get():isArenaArea()
  if true == isArena and respawnType == enRespawnType.respawnType_Immediate then
    deadMessage_Revival(enRespawnType.respawnType_Immediate, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
  elseif 1 == revivalItemCount then
    HandleClicked_Apply_CashRevivalItem(respawnType)
  elseif revivalItemCount > 1 then
    CashRevivalBuy_Open(respawnType)
  else
    HandleClicked_Buy_CashRevivalItem(respawnType)
  end
end
function useCheckFairy(respawnType)
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfProxy:get():getPosition())
  local isArena = regionInfo:get():isArenaArea()
  if true == isArena and respawnType == enRespawnType.respawnType_Immediate then
    deadMessage_Revival(enRespawnType.respawnType_Immediate, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), false)
  else
    deadMessage_Revival(enRespawnType.respawnType_Immediate, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), true)
  end
end
function deadMessage_SimpleTooltips(isShow)
  local uiControl, name, desc
  name = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_TOOLTIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_TOOLTIP_DESC")
  uiControl = _useCashItemBG
  registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
  if isShow == true then
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function deadMessage_PkPenalty_Tooltip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_PK_PENALTY_TOOLTIP_TITLE")
  if isGameTypeKorea() or isGameTypeJapan() then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_PK_PENALTY_TOOLTIP_DESC")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_PK_PENALTY_TOOLTIP_DESC_OTHER")
  end
  control = _deadQuestion
  TooltipSimple_Show(control, name, desc)
end
function deadMessage_ButtonPushed_ObserverMode()
  if Panel_DeadMessage:GetShow() then
    Panel_DeadMessage:SetShow(false)
  end
  observerCameraModeStart()
  ShowCommandFunc(ResurrectionTime)
end
function deadMessage_ResurrectionTimeReturn(Rtime)
  ResurrectionTime = Rtime
  buttonAbleTime = Rtime
end
function FromClient_ResurrectionTimeResetByKingOrLordTentDestroy(notifyType, regionKeyRaw)
  local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
  if nil == regionInfoWrapper then
    return
  end
  deadMessage_ResurrectionTimeReturn(0)
end
function deadMessage_registEventHandler()
  _button_MoveTown:addInputEvent("Mouse_LUp", "deadMessage_ButtonPushed_MoveToVillage()")
  _button_MoveExploration:addInputEvent("Mouse_LUp", "deadMessage_ButtonPushed_MoveExploration()")
  _button_Immediate:addInputEvent("Mouse_LUp", "deadMessage_ButtonPushed_Immediate()")
  _button_SiegeIng:addInputEvent("Mouse_LUp", "deadMessage_ButtonPushed_SiegeIng()")
  _button_AdvancedBase:addInputEvent("Mouse_LUp", "deadMessage_ButtonPushed_AdvancedBase()")
  _button_LocalWar:addInputEvent("Mouse_LUp", "deadMessage_ButtonPushed_LocalWar()")
  _button_SavageOut:addInputEvent("Mouse_LUp", "deadMessage_ButtonPushed_SavageDefence()")
  _button_GuildSpawn:addInputEvent("Mouse_LUp", "deadMessage_ButtonPushed_GuildSpawn()")
  _useCashItemBG:addInputEvent("Mouse_On", "deadMessage_SimpleTooltips( true )")
  _useCashItemBG:addInputEvent("Mouse_Out", "deadMessage_SimpleTooltips( false )")
  _useCashItemBG:setTooltipEventRegistFunc("deadMessage_SimpleTooltips( true )")
  _button_ObserverMode:addInputEvent("Mouse_LUp", "deadMessage_ButtonPushed_ObserverMode()")
  _button_Volunteer:addInputEvent("Mouse_LUp", "deadMessage_ButtonPushed_Volunteer()")
  _deadQuestion:addInputEvent("Mouse_On", "deadMessage_PkPenalty_Tooltip(true)")
  _deadQuestion:addInputEvent("Mouse_Out", "deadMessage_PkPenalty_Tooltip(false)")
end
function deadMessage_registMessageHandler()
  registerEvent("EventSelfPlayerDead", "deadMessage_Show")
  registerEvent("Event_DeadMessage_AddDropItem", "deadMessage_AddDropItem")
  registerEvent("Event_DeadMessage_WeakEquip", "deadMessage_WeakEquip")
  registerEvent("Event_DeadMessage_WeakEquipCantPushInventory", "deadMessage_WeakEquipCantPushinventory")
  registerEvent("Event_DeadMessage_DestroyJewel", "deadMessage_DestroyJewel")
  registerEvent("onScreenResize", "deadMessage_Resize")
end
Panel_DeadMessage:RegisterUpdateFunc("deadMessage_UpdatePerFrame")
deadMessage_Resize()
deadMessage_registEventHandler()
deadMessage_registMessageHandler()
