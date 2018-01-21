local UI_color = Defines.Color
local ServantStable_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_ServantStable")
local WareHouse_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_WareHouse")
local Quest_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_Quest")
local Transport_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_Transport")
local transportAlert = UI.getChildControl(Panel_WorldMap, "Static_TransportAlert")
local ItemMarket_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_ItemMarket")
local WorkerList_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_WorkerList")
local HelpMenu_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_HelpMovie")
local Exit_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_Exit")
local WorkerTrade_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_WorkerTrade")
local StableMarket_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_StableMarket")
local NpcFind = UI.getChildControl(Panel_WorldMap, "BottomMenu_NpcFind")
local isWorkerTradeOpen = ToClient_IsContentsGroupOpen("209")
local currentNodeKey
local popupType = {
  stable = 0,
  wareHouse = 1,
  quest = 2,
  transport = 3,
  itemMarket = 4,
  workerList = 5,
  helpMovie = 6,
  workerTrade = 7,
  workerTradeCaravan = 8,
  stableMarket = 9,
  npcNavi = 10
}
local popupTypeCount = 11
local popupPanelList = {}
Panel_WorldMap:SetShow(false, false)
local function worldMap_Init()
  Exit_Btn:SetSize(44, 44)
  HelpMenu_Btn:SetSize(44, 44)
  WorkerList_Btn:SetSize(44, 44)
  ItemMarket_Btn:SetSize(44, 44)
  Transport_Btn:SetSize(44, 44)
  Quest_Btn:SetSize(44, 44)
  WareHouse_Btn:SetSize(44, 44)
  ServantStable_Btn:SetSize(44, 44)
  WorkerTrade_Btn:SetSize(44, 44)
  StableMarket_Btn:SetSize(44, 44)
  NpcFind:SetSize(44, 44)
  transportAlert:SetShow(false)
  Exit_Btn:SetSpanSize(5, 5)
  HelpMenu_Btn:SetSpanSize(Exit_Btn:GetSpanSize().x + Exit_Btn:GetSizeX() + 3, 5)
  WorkerList_Btn:SetSpanSize(HelpMenu_Btn:GetSpanSize().x + HelpMenu_Btn:GetSizeX() + 3, 5)
  ItemMarket_Btn:SetSpanSize(WorkerList_Btn:GetSpanSize().x + WorkerList_Btn:GetSizeX() + 3, 5)
  Transport_Btn:SetSpanSize(ItemMarket_Btn:GetSpanSize().x + ItemMarket_Btn:GetSizeX() + 3, 5)
  transportAlert:SetSpanSize(ItemMarket_Btn:GetSpanSize().x + ItemMarket_Btn:GetSizeX(), 33)
  Quest_Btn:SetSpanSize(Transport_Btn:GetSpanSize().x + Transport_Btn:GetSizeX() + 3, 5)
  WareHouse_Btn:SetSpanSize(Quest_Btn:GetSpanSize().x + Quest_Btn:GetSizeX() + 3, 5)
  ServantStable_Btn:SetSpanSize(WareHouse_Btn:GetSpanSize().x + WareHouse_Btn:GetSizeX() + 3, 5)
  StableMarket_Btn:SetSpanSize(ServantStable_Btn:GetSpanSize().x + ServantStable_Btn:GetSizeX() + 3, 5)
  NpcFind:SetSpanSize(StableMarket_Btn:GetSpanSize().x + StableMarket_Btn:GetSizeX() + 3, 5)
  WorkerTrade_Btn:SetSpanSize(NpcFind:GetSpanSize().x + StableMarket_Btn:GetSizeX() + 3, 5)
  ServantStable_Btn:addInputEvent("Mouse_LUp", "BtnEvent_ServantStable()")
  WareHouse_Btn:addInputEvent("Mouse_LUp", "BtnEvent_WareHouse()")
  Quest_Btn:addInputEvent("Mouse_LUp", "BtnEvent_Quest()")
  Transport_Btn:addInputEvent("Mouse_LUp", "BtnEvent_Transport()")
  ItemMarket_Btn:addInputEvent("Mouse_LUp", "BtnEvent_ItemMarket()")
  WorkerList_Btn:addInputEvent("Mouse_LUp", "BtnEvent_WorkerList()")
  HelpMenu_Btn:addInputEvent("Mouse_LUp", "BtnEvent_HelpMovie()")
  Exit_Btn:addInputEvent("Mouse_LUp", "BtnEvent_Exit()")
  StableMarket_Btn:addInputEvent("Mouse_LUp", "BtnEvent_StableMarket()")
  WorkerTrade_Btn:addInputEvent("Mouse_LUp", "BtnEvent_WorkerTrade()")
  NpcFind:addInputEvent("Mouse_LUp", "BtnEvent_NpcNavi()")
  ServantStable_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 0 .. " )")
  ServantStable_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 0 .. " )")
  ServantStable_Btn:setTooltipEventRegistFunc("HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 0 .. " )")
  WareHouse_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 1 .. " )")
  WareHouse_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 1 .. " )")
  WareHouse_Btn:setTooltipEventRegistFunc("HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 1 .. " )")
  Quest_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 2 .. " )")
  Quest_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 2 .. " )")
  Quest_Btn:setTooltipEventRegistFunc("HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 2 .. " )")
  Transport_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 3 .. " )")
  Transport_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 3 .. " )")
  Transport_Btn:setTooltipEventRegistFunc("HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 3 .. " )")
  ItemMarket_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 4 .. " )")
  ItemMarket_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 4 .. " )")
  ItemMarket_Btn:setTooltipEventRegistFunc("HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 4 .. " )")
  WorkerList_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 5 .. " )")
  WorkerList_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 5 .. " )")
  WorkerList_Btn:setTooltipEventRegistFunc("HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 5 .. " )")
  HelpMenu_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 6 .. " )")
  HelpMenu_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 6 .. " )")
  HelpMenu_Btn:setTooltipEventRegistFunc("HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 6 .. " )")
  Exit_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 7 .. " )")
  Exit_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 7 .. " )")
  Exit_Btn:setTooltipEventRegistFunc("HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 7 .. " )")
  WorkerTrade_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 8 .. " )")
  WorkerTrade_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 8 .. " )")
  WorkerTrade_Btn:setTooltipEventRegistFunc("HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 8 .. " )")
  StableMarket_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 9 .. " )")
  StableMarket_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 9 .. " )")
  StableMarket_Btn:setTooltipEventRegistFunc("HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 9 .. " )")
  NpcFind:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 10 .. " )")
  NpcFind:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 10 .. " )")
  NpcFind:setTooltipEventRegistFunc("HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 10 .. " )")
end
function GrandWorldMap_CheckPopup(openPanel)
  for idx = 0, popupTypeCount - 1 do
    if openPanel ~= idx and popupPanelList[idx].panelname:GetShow() then
      popupPanelList[idx].closeFunc()
    end
  end
  PaGlobal_TutorialManager:handleGrandWorldMap_CheckPopup(openPanel, popupPanelList[openPanel].panelname)
end
function BtnEvent_ServantStable()
  if not Panel_NodeStable:GetShow() then
    if nil ~= currentNodeKey then
      GrandWorldMap_CheckPopup(popupType.stable)
      StableOpen_FromWorldMap(currentNodeKey)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_WRONG_STABLE"))
      return
    end
  else
    StableClose_FromWorldMap()
  end
end
function BtnEvent_StableMarket()
  if true == Panel_Window_StableMarket:GetShow() then
    StableMarket_Close()
  else
    GrandWorldMap_CheckPopup(popupType.stableMarket)
    StableMarket_Open()
  end
end
function BtnEvent_WorkerTrade()
  if not ToClient_IsActiveWorkerTrade() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_WORKERTRADEALERT"))
    return
  end
  if Panel_WorkerTrade:GetShow() then
    WorkerTrade_Close()
  else
    GrandWorldMap_CheckPopup(popupType.workerTrade)
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_WorkerTrade, true)
    FGlobal_WorkerTrade_Update()
  end
end
function BtnEvent_NpcNavi()
  if Panel_NpcNavi:GetShow() then
    NpcNavi_ShowToggle()
  else
    GrandWorldMap_CheckPopup(popupType.npcNavi)
    NpcNavi_ShowToggle()
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_NpcNavi, true)
  end
end
function BtnEvent_WareHouse()
  if Panel_Window_Warehouse:GetShow() then
    Warehouse_Close()
  elseif nil ~= currentNodeKey then
    GrandWorldMap_CheckPopup(popupType.wareHouse)
    Warehouse_OpenPanelFromWorldmap(currentNodeKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap)
  end
end
function BtnEvent_Quest()
  if Panel_CheckedQuest:GetShow() then
    FGlobal_QuestWidget_Close()
  else
    GrandWorldMap_CheckPopup(popupType.quest)
    FGlobal_QuestWidget_Open()
  end
end
function BtnEvent_Transport()
  if Panel_Window_Delivery_InformationView:GetShow() then
    DeliveryInformationView_Close()
  else
    GrandWorldMap_CheckPopup(popupType.transport)
    DeliveryInformationView_Open()
  end
end
function BtnEvent_ItemMarket()
  if Panel_Window_ItemMarket:IsShow() then
    FGolbal_ItemMarketNew_Close()
  else
    GrandWorldMap_CheckPopup(popupType.itemMarket)
    FGlobal_ItemMarket_Open_ForWorldMap(1)
  end
end
function BtnEvent_WorkerList()
  if Panel_WorkerManager:GetShow() then
    workerManager_Close()
  else
    GrandWorldMap_CheckPopup(popupType.workerList)
    if nil ~= currentNodeKey then
      FGlobal_workerManager_UpdateNode(ToClient_convertWaypointKeyToPlantKey(currentNodeKey))
    else
      FGlobal_workerManager_OpenWorldMap()
    end
  end
end
function BtnEvent_HelpMovie()
  if true == Panel_WorldMap_MovieGuide:GetShow() then
    Panel_Worldmap_MovieGuide_Close()
  else
    GrandWorldMap_CheckPopup(popupType.helpMovie)
    Panel_Worldmap_MovieGuide_Open()
  end
end
function BtnEvent_Exit()
  FGlobal_CloseWorldmapForLuaKeyHandling()
end
local function makePopupPanelList()
  popupPanelList = {
    [popupType.stable] = {panelname = Panel_NodeStable, closeFunc = StableClose_FromWorldMap},
    [popupType.wareHouse] = {panelname = Panel_Window_Warehouse, closeFunc = Warehouse_Close},
    [popupType.quest] = {panelname = Panel_CheckedQuest, closeFunc = FGlobal_QuestWidget_Close},
    [popupType.transport] = {panelname = Panel_Window_Delivery_InformationView, closeFunc = DeliveryInformationView_Close},
    [popupType.itemMarket] = {panelname = Panel_Window_ItemMarket, closeFunc = FGolbal_ItemMarketNew_Close},
    [popupType.workerList] = {panelname = Panel_WorkerManager, closeFunc = workerManager_Close},
    [popupType.helpMovie] = {panelname = Panel_WorldMap_MovieGuide, closeFunc = Panel_Worldmap_MovieGuide_Close},
    [popupType.workerTrade] = {panelname = Panel_WorkerTrade, closeFunc = WorkerTrade_Close},
    [popupType.workerTradeCaravan] = {panelname = Panel_WorkerTrade_Caravan, closeFunc = FGlobal_WorkerTradeCaravan_Hide},
    [popupType.stableMarket] = {panelname = Panel_Window_StableMarket, closeFunc = StableMarket_Close},
    [popupType.npcNavi] = {panelname = Panel_NpcNavi, closeFunc = NpcNavi_ShowToggle}
  }
end
function FGlobal_WorldMapOpenForMenu()
  ServantStable_Btn:SetShow(true, false)
  WareHouse_Btn:SetShow(true, false)
  Quest_Btn:SetShow(true, false)
  Transport_Btn:SetShow(true, false)
  ItemMarket_Btn:SetShow(true, false)
  WorkerList_Btn:SetShow(true, false)
  HelpMenu_Btn:SetShow(true, false)
  Exit_Btn:SetShow(true, false)
  WorkerTrade_Btn:SetShow(isWorkerTradeOpen, false)
  StableMarket_Btn:SetShow(true, false)
  NpcFind:SetShow(true, false)
  makePopupPanelList()
  Panel_WorldMap:SetShow(true, false)
  Panel_Worldmap_MovieGuide_Init()
  if isGameTypeKR2() then
    HelpMenu_Btn:SetShow(false)
  elseif isGameTypeTH() then
    HelpMenu_Btn:SetShow(false)
  end
end
function WorldmapGrand_setAlpha(boolValue)
  local returnValue = ""
  if true == boolValue then
    returnValue = 1
  else
    returnValue = 0.7
  end
  return returnValue
end
function HandleOnOut_WorldmapGrand_MenuButtonTooltip(isShow, buttonType)
  if isShow then
    local control
    local name = ""
    local desc
    if 0 == buttonType then
      control = ServantStable_Btn
      name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_MENUBUTTONTOOLTIP_STABLE")
    elseif 1 == buttonType then
      control = WareHouse_Btn
      name = PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_WAREHOUSE")
    elseif 2 == buttonType then
      control = Quest_Btn
      name = PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_QUEST")
    elseif 3 == buttonType then
      control = Transport_Btn
      name = PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_DELIVERY")
    elseif 4 == buttonType then
      control = ItemMarket_Btn
      name = PAGetString(Defines.StringSheet_GAME, "GAME_ITEM_MARKET_NAME")
    elseif 5 == buttonType then
      control = WorkerList_Btn
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_WORKERTITLE")
    elseif 6 == buttonType then
      control = HelpMenu_Btn
      name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_MENUBUTTONTOOLTIP_HELPMOVIE")
    elseif 7 == buttonType then
      control = Exit_Btn
      name = PAGetString(Defines.StringSheet_RESOURCE, "UICONTROL_BTN_GAMEEXIT")
    elseif 8 == buttonType then
      control = WorkerTrade_Btn
      name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_HELPWORKERTRADE")
    elseif 9 == buttonType then
      control = StableMarket_Btn
      name = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_FUNCTION_BTN_MARKET")
    elseif 10 == buttonType then
      control = StableMarket_Btn
      name = PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_NOTDRAGABLE")
    end
    registTooltipControl(control, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function FGlobal_WorldmapGrand_Bottom_MenuSet(waypointKey)
  if nil ~= waypointKey then
    currentNodeKey = waypointKey
    local isStableOpen = false
    local isWareHouseOpen = false
    local regionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(waypointKey)
    if nil ~= regionInfoWrapper then
      isStableOpen = regionInfoWrapper:get():hasStableNpc()
      isWareHouseOpen = regionInfoWrapper:get():hasWareHouseNpc()
    end
    ServantStable_Btn:SetAlpha(WorldmapGrand_setAlpha(isStableOpen))
    ServantStable_Btn:SetIgnore(not isStableOpen)
    WareHouse_Btn:SetAlpha(WorldmapGrand_setAlpha(isWareHouseOpen))
    WareHouse_Btn:SetIgnore(not isWareHouseOpen)
    WorkerTrade_Btn:SetAlpha(WorldmapGrand_setAlpha(not isWorkerTradeOpen))
    WorkerTrade_Btn:SetIgnore(isWorkerTradeOpen)
  else
    currentNodeKey = nil
    ServantStable_Btn:SetAlpha(WorldmapGrand_setAlpha(false))
    ServantStable_Btn:SetIgnore(true)
    WareHouse_Btn:SetAlpha(WorldmapGrand_setAlpha(false))
    WareHouse_Btn:SetIgnore(true)
    WorkerTrade_Btn:SetAlpha(WorldmapGrand_setAlpha(isWorkerTradeOpen))
    WorkerTrade_Btn:SetIgnore(not isWorkerTradeOpen)
  end
end
function worldmapGrand_Base_OnScreenResize()
  Panel_WorldMap:SetSize(getScreenSizeX(), getScreenSizeY())
  ServantStable_Btn:ComputePos()
  WareHouse_Btn:ComputePos()
  Quest_Btn:ComputePos()
  Transport_Btn:ComputePos()
  ItemMarket_Btn:ComputePos()
  WorkerList_Btn:ComputePos()
  HelpMenu_Btn:ComputePos()
  Exit_Btn:ComputePos()
  WorkerTrade_Btn:ComputePos()
  StableMarket_Btn:ComputePos()
  NpcFind:ComputePos()
  transportAlert:ComputePos()
end
function FromClient_isCompletedTransport(isComplete)
  if nil == isComplete then
    return
  end
end
worldMap_Init()
registerEvent("onScreenResize", "worldmapGrand_Base_OnScreenResize")
registerEvent("FromClient_isCompletedTransport", "FromClient_isCompletedTransport")
