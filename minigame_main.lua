local MGT = CppEnums.MiniGameType
local IM = CppEnums.EProcessorInputMode
local currentMiniGame = -1
local lastUIMode
function ActionMiniGame_Main(gameIndex)
  if gameIndex < MGT.MiniGameType_0 or MGT.MiniGameType_17 == gameIndex or gameIndex > MGT.MiniGameType_18 or currentMiniGame == gameIndex then
    return
  end
  if MGT.MiniGameType_0 == gameIndex then
    Panel_Minigame_Gradient_Start()
  elseif MGT.MiniGameType_1 == gameIndex then
    Panel_Minigame_SinGauge_Start()
  elseif MGT.MiniGameType_2 == gameIndex then
    Panel_Minigame_Command_Start()
  elseif MGT.MiniGameType_3 == gameIndex then
    Panel_Minigame_Rhythm_Start()
  elseif MGT.MiniGameType_4 == gameIndex then
    Panel_Minigame_BattleGauge_Start()
  elseif MGT.MiniGameType_5 == gameIndex then
    Panel_Minigame_FillGauge_Start()
  elseif MGT.MiniGameType_6 == gameIndex then
    Panel_Minigame_GradientY_Start()
  elseif MGT.MiniGameType_7 == gameIndex then
    Panel_Minigame_Timing_Start()
  elseif MGT.MiniGameType_8 == gameIndex then
  elseif MGT.MiniGameType_9 == gameIndex then
  elseif MGT.MiniGameType_10 == gameIndex then
    Panel_Minigame_RhythmForAction_Start()
  elseif MGT.MiniGameType_11 == gameIndex then
    Panel_Minigame_HerbMachine_Start()
  elseif MGT.MiniGameType_12 == gameIndex then
    Panel_Minigame_Buoy_Start()
  elseif MGT.MiniGameType_13 == gameIndex then
    Panel_Minigame_Steal_Start()
  elseif MGT.MiniGameType_14 == gameIndex then
    Panel_MiniGame_PowerControl_Start()
  elseif MGT.MiniGameType_15 == gameIndex then
    Panel_MiniGame_Jaksal_Start()
  elseif MGT.MiniGameType_16 == gameIndex then
    Panel_Minigame_Rhythm_Drum_Start()
  elseif MGT.MiniGameType_17 == gameIndex then
    Panel_Minigame_SteeringWheel_Start()
  elseif MGT.MiniGameType_0 == gameIndex then
    Panel_Minigame_Gradient_Start(true)
  end
  lastUIMode = GetUIMode()
  SetUIMode(Defines.UIMode.eUIMode_MiniGame)
  currentMiniGame = gameIndex
end
function ActionMiniGame_Stop()
  if currentMiniGame < MGT.MiniGameType_0 or MGT.MiniGameType_18 < currentMiniGame then
    return
  end
  if MGT.MiniGameType_0 == currentMiniGame then
    Panel_Minigame_Gradient_End()
  elseif MGT.MiniGameType_1 == currentMiniGame then
    Panel_Minigame_SinGauge_End()
  elseif MGT.MiniGameType_2 == currentMiniGame then
    Panel_Minigame_Command_End()
  elseif MGT.MiniGameType_3 == currentMiniGame then
    Panel_Minigame_Rhythm_End()
  elseif MGT.MiniGameType_4 == currentMiniGame then
    Panel_Minigame_BattleGauge_End()
  elseif MGT.MiniGameType_5 == currentMiniGame then
    Panel_Minigame_FillGauge_End()
  elseif MGT.MiniGameType_6 == currentMiniGame then
    Panel_Minigame_GradientY_End()
  elseif MGT.MiniGameType_7 == currentMiniGame then
    Panel_Minigame_Timing_End()
  elseif MGT.MiniGameType_8 == currentMiniGame then
  elseif MGT.MiniGameType_9 == currentMiniGame then
  elseif MGT.MiniGameType_10 == currentMiniGame then
    Panel_Minigame_RhythmForAction_End()
  elseif MGT.MiniGameType_11 == currentMiniGame then
    Panel_Minigame_HerbMachine_End()
  elseif MGT.MiniGameType_12 == currentMiniGame then
    Panel_Minigame_Buoy_End()
  elseif MGT.MiniGameType_13 == currentMiniGame then
    Panel_Minigame_Steal_End()
  elseif MGT.MiniGameType_14 == currentMiniGame then
    Panel_MiniGame_PowerControl_End()
  elseif MGT.MiniGameType_15 == currentMiniGame then
    Panel_MiniGame_Jaksal_End()
  elseif MGT.MiniGameType_16 == currentMiniGame then
    Panel_Minigame_Rhythm_Drum_End()
  elseif MGT.MiniGameType_17 == currentMiniGame then
    Panel_Minigame_SteeringWheel_End()
  elseif MGT.MiniGameType_18 == currentMiniGame then
    Panel_Minigame_Gradient_End()
  end
  SetUIMode(Defines.UIMode.eUIMode_Default)
  CheckChattingInput()
  lastUIMode = nil
  currentMiniGame = -1
end
function Panel_Minigame_EventKeyPress(keyType)
  if currentMiniGame < MGT.MiniGameType_0 or MGT.MiniGameType_18 < currentMiniGame then
    return
  end
  if MGT.MiniGameType_0 == currentMiniGame then
  elseif MGT.MiniGameType_1 == currentMiniGame then
  elseif MGT.MiniGameType_2 == currentMiniGame then
  elseif MGT.MiniGameType_3 == currentMiniGame then
  elseif MGT.MiniGameType_4 == currentMiniGame then
  elseif MGT.MiniGameType_5 == currentMiniGame then
  elseif MGT.MiniGameType_6 == currentMiniGame then
  elseif MGT.MiniGameType_7 == currentMiniGame then
    Panel_Minigame_Timing_Freeze(keyType)
  elseif MGT.MiniGameType_8 == currentMiniGame then
  elseif MGT.MiniGameType_9 == currentMiniGame then
  elseif MGT.MiniGameType_10 == currentMiniGame then
  elseif MGT.MiniGameType_11 == currentMiniGame then
    Panel_Minigame_HerbMachine_Freeze(keyType)
  elseif MGT.MiniGameType_12 == currentMiniGame then
    Panel_Minigame_Buoy_Freeze(keyType)
  elseif MGT.MiniGameType_13 == currentMiniGame then
    Minigame_Steal_PressKey(keyType)
  elseif MGT.MiniGameType_14 == currentMiniGame then
  elseif MGT.MiniGameType_15 == currentMiniGame then
    Panel_MiniGame_Jaksal_KeyPressCheck(keyType)
  elseif MGT.MiniGameType_16 == currentMiniGame then
  end
end
registerEvent("EventActionMiniGameKeyDownOnce", "Panel_Minigame_EventKeyPress")
function Panel_Minigame_UpdateFunc(deltaTime)
  if currentMiniGame < MGT.MiniGameType_0 or MGT.MiniGameType_17 < currentMiniGame then
    return
  end
  if MGT.MiniGameType_0 == currentMiniGame then
    MiniGame_GaugeBarMoveCalc(deltaTime)
  elseif MGT.MiniGameType_1 == currentMiniGame then
  elseif MGT.MiniGameType_2 == currentMiniGame then
    Command_UpdateText(deltaTime)
  elseif MGT.MiniGameType_3 == currentMiniGame then
    RhythmGame_UpdateFunc(deltaTime)
  elseif MGT.MiniGameType_4 == currentMiniGame then
  elseif MGT.MiniGameType_5 == currentMiniGame then
    FillGauge_UpdatePerFrame(deltaTime)
  elseif MGT.MiniGameType_6 == currentMiniGame then
    MiniGame_GaugeBarMoveCalcY(deltaTime)
  elseif MGT.MiniGameType_7 == currentMiniGame then
    Panel_Minigame_Timing_Perframe(deltaTime)
  elseif MGT.MiniGameType_8 == currentMiniGame then
  elseif MGT.MiniGameType_9 == currentMiniGame then
  elseif MGT.MiniGameType_10 == currentMiniGame then
  elseif MGT.MiniGameType_11 == currentMiniGame then
    Panel_Minigame_HerbMachine_Perframe(deltaTime)
  elseif MGT.MiniGameType_12 == currentMiniGame then
    Panel_Minigame_Buoy_Perframe(deltaTime)
  elseif MGT.MiniGameType_13 == currentMiniGame then
  elseif MGT.MiniGameType_14 == currentMiniGame then
  elseif MGT.MiniGameType_15 == currentMiniGame then
  elseif MGT.MiniGameType_16 == currentMiniGame then
    RhythmGame_Drum_UpdateFunc(deltaTime)
  elseif MGT.MiniGameType_17 == currentMiniGame then
    MiniGame_SteeringWhellMoveCalc(deltaTime)
  end
end
local keyDownFunctorList = {}
local keyUpFunctorList = {}
function AddMiniGameKeyDownOnce(miniGameType, functor)
  keyDownFunctorList[miniGameType] = functor
end
function AddMiniGameKeyUp(miniGameType, functor)
  keyUpFunctorList[miniGameType] = functor
end
function EventActionMiniGameKeyDownOnce(keyType)
  local functor = keyDownFunctorList[currentMiniGame]
  if nil ~= functor then
    functor(keyType)
  end
end
function EventActionMiniGameKeyUp(keyType)
  local functor = keyUpFunctorList[currentMiniGame]
  if nil ~= functor then
    functor(keyType)
  end
end
registerEvent("EventStartActionMiniGame", "ActionMiniGame_Main")
registerEvent("EventEndActionMiniGame", "ActionMiniGame_Stop")
registerEvent("EventActionMiniGameKeyDownOnce", "EventActionMiniGameKeyDownOnce")
registerEvent("EventActionMiniGameKeyUp", "EventActionMiniGameKeyUp")
