local renderMode = RenderModeWrapper.new(100, {
  Defines.RenderMode.eRenderMode_IngameCustomize
}, false)
local gameExitPhoto = false
local characterInfoPhoto = false
local CharacterSlotIndex = 0
function IngameCustomize_Show()
  if isDeadInWatchingMode() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BEAUTYOPENALERT_INDEAD"))
    return
  end
  ToClient_SaveUiInfo(false)
  if isFlushedUI() then
    return
  end
  local terraintype = selfPlayerNaviMaterial()
  if 8 == terraintype or 9 == terraintype then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_DONTOPEN_INWATER"))
    return
  end
  if not FGlobal_IsCommercialService() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_NOTUSE"))
    return
  end
  if GetUIMode() == Defines.UIMode.eUIMode_Gacha_Roulette then
    return
  end
  if nil == getCustomizingManager() then
    return
  end
  if true == getCustomizingManager():isShow() then
    return
  end
  local isShowSuccess = getCustomizingManager():show()
  if false == isShowSuccess then
    return
  end
  if Panel_Win_System:GetShow() then
    allClearMessageData()
  end
  if Panel_CustomizingAlbum:GetShow() then
    CustomizingAlbum_Close()
  end
  FGlobal_WebHelper_ForceClose()
  audioPostEvent_SystemUi(1, 2)
  SetUIMode(Defines.UIMode.eUIMode_InGameCustomize)
  renderMode:set()
end
function IngameCustomize_Hide()
  if nil == getCustomizingManager() then
    return
  end
  if false == getCustomizingManager():isShow() then
    return
  end
  if true == isChangedCustomizationData() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECUSTOMIZATION_MSGBOX_CANCEL")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = HandleClicked_CloseIngameCustomization,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    HandleClicked_CloseIngameCustomization()
  end
  if true == gameExitPhoto then
    GameExitShowToggle(false)
    refreshCharacterInfoData(CharacterSlotIndex + 1)
  end
  if true == characterInfoPhoto then
    PaGlobal_CharacterInfoBasic:updateFacePhoto()
  end
  gameExitPhoto = false
  characterInfoPhoto = false
end
function HandleClicked_CloseIngameCustomization()
  CloseCharacterCustomization()
  getCustomizingManager():hide()
  renderMode:reset()
  SetUIMode(Defines.UIMode.eUIMode_Default)
  Panel_CustomizationMessage:SetShow(false)
  Panel_CustomizationStatic:SetShow(false)
  Panel_Chat0:SetShow(true)
  Panel_Cash_Customization:SetShow(false)
  CashCumaBuy_Close()
  allClearMessageData()
  CustomizingAlbum_Close()
  closeExplorer()
  Panel_CustomizationVoice:SetShow(false)
end
function IsGameExitPhoto(isCheck)
  gameExitPhoto = isCheck
end
function characterSlot_Index(index)
  CharacterSlotIndex = index
end
function FGlobal_InGameCustomize_SetCharacterInfo(isCheck)
  characterInfoPhoto = isCheck
end
renderMode:setClosefunctor(renderMode, IngameCustomize_Hide)
