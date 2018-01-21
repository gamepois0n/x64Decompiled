Panel_IntroMovie:SetShow(false, false)
local updateTime = 0
local static_IntroMovie
local IM = CppEnums.EProcessorInputMode
isIntroMoviePlaying = false
local introMoviePlayTime = 20
function InitIntroMoviePanel()
  local uiScale = getGlobalScale()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayerLevel = selfPlayerWrapper:get():getLevel()
  local selfPlayerExp = selfPlayerWrapper:get():getExp_s64()
  if 1 == selfPlayerLevel and false == isSwapCharacter() and static_IntroMovie == nil then
    ShowableFirstExperience(false)
    Panel_IntroMovie:SetShow(true, false)
    local sizeX = getResolutionSizeX()
    local sizeY = getResolutionSizeY()
    sizeX = sizeX / uiScale
    sizeY = sizeY / uiScale
    local movieSizeX = sizeX
    local movieSizeY = sizeX * 9 / 16
    local posX = 0
    local posY = 0
    if sizeY >= movieSizeY then
      posY = (sizeY - movieSizeY) / 2
    else
      movieSizeX = sizeY * 16 / 9
      movieSizeY = sizeY
      posX = (sizeX - movieSizeX) / 2
    end
    Panel_IntroMovie:SetPosX(0)
    Panel_IntroMovie:SetPosY(0)
    Panel_IntroMovie:SetSize(sizeX, sizeY)
    static_IntroMovie = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_WEBCONTROL, Panel_IntroMovie, "WebControl_Movie")
    static_IntroMovie:SetIgnore(false)
    static_IntroMovie:SetPosX(posX)
    static_IntroMovie:SetPosY(posY)
    static_IntroMovie:SetSize(movieSizeX, movieSizeY)
    static_IntroMovie:SetUrl(1280, 720, "coui://UI_Data/UI_Html/Intro_Movie.html")
    isIntroMoviePlaying = true
    setMoviePlayMode(true)
  end
  if isGameTypeKorea() then
    introMoviePlayTime = 60
  elseif isGameTypeJapan() then
    introMoviePlayTime = 60
  elseif isGameTypeEnglish() then
    introMoviePlayTime = 125
  elseif isGameTypeRussia() then
    introMoviePlayTime = 60
  elseif isGameTypeTaiwan() then
    introMoviePlayTime = 125
  else
    introMoviePlayTime = 60
  end
end
function CloseIntroMovie()
  if static_IntroMovie ~= nil then
    static_IntroMovie:TriggerEvent("StopMovie", "")
    static_IntroMovie:SetShow(false)
    static_IntroMovie = nil
  end
  Panel_IntroMovie:SetShow(false, false)
  isIntroMoviePlaying = false
  SetUIMode(Defines.UIMode.eUIMode_Default)
  setMoviePlayMode(false)
  ShowableFirstExperience(true)
  PaGlobal_TutorialManager:handleCloseIntroMovie()
end
local updateTime = 0
function UpdateIntroMovie(deltaTime)
  if isIntroMoviePlaying then
    updateTime = updateTime + deltaTime
    if static_IntroMovie:isReadyView() then
      ShowIntroMovie()
    end
    if introMoviePlayTime < updateTime then
      isIntroMoviePlaying = false
      setMoviePlayMode(false)
    end
  end
end
function ShowIntroMovie()
  static_IntroMovie:TriggerEvent("PlayMovie", "")
  setMoviePlayMode(true)
end
function ToClient_EndIntroMovie(movieId)
  if movieId == 1 and Panel_IntroMovie:IsShow() then
    toClient_FadeIn(1)
    CloseIntroMovie()
  end
end
InitIntroMoviePanel()
Panel_IntroMovie:RegisterUpdateFunc("UpdateIntroMovie")
registerEvent("ToClient_EndGuideMovie", "ToClient_EndIntroMovie")
