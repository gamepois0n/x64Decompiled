local randerPlayerColorStr = {
  zoneChange = "ZoneChange",
  warAlly = "WarAlly",
  guild = "Guild",
  party = "Party",
  enemy = "Enemy",
  nonWarPlayer = "NonWarPlayer"
}
local chk_Option = {
  FULL_SCREEN_IDX = 0,
  FULL_SCREEN_WINDOWED_IDX = 1,
  WINDOWED_IDX = 2,
  SCREEN_MODE_COUNT = 3,
  screenResolutionList = {},
  SCREEN_RESOLUTION_COUNT,
  SCREENSHOT_BMP = 0,
  SCREENSHOT_JPG = 1,
  SCREENSHOT_PNG = 2,
  SCREENSHOTSIZE_DEFAULT = 0,
  SCREENSHOTSIZE_4k = 1,
  SCREENSHOTSIZE_8k = 2,
  EFFECTLOD_HIGH = 2,
  EFFECTLOD_NORMAL = 1,
  EFFECTLOD_LOW = 0,
  WATERMARK_ALPHA = 0,
  WATERMARK_BOLD = 1,
  WATERMARK_NONE = 2,
  WATERMARK_SERVICE_KR = 0,
  WATERMARK_SERVICE_JP = 1,
  WATERMARK_SERVICE_NA = 2,
  WATERMARK_SERVICE_RU = 3,
  WATERMARK_SERVICE_TW = 4,
  WATERMARK_SERVICE_SA = 5,
  WATERMARK_SERVICE_NONE = 6,
  WATERMARK_POSITION_LT = 0,
  WATERMARK_POSITION_RT = 1,
  WATERMARK_POSITION_LB = 2,
  WATERMARK_POSITION_RB = 3,
  WATERMARK_SCALE_SMALL = 0,
  WATERMARK_SCALE_REGULAR = 1,
  WATERMARK_SCALE_LARGE = 2,
  COLORBLIND_NONE = 0,
  COLORBLIND_PROTANOPIA = 1,
  COLORBLIND_DEUTERANOP = 2,
  TEXTURE_QUALITY_HIGH = 0,
  TEXTURE_QUALITY_NORMAL = 1,
  TEXTURE_QUALITY_LOW = 2,
  TEXTURE_QUALITY_COUNT = 3,
  GRAPHIC_OPTION_HIGH0 = 0,
  GRAPHIC_OPTION_HIGH1 = 1,
  GRAPHIC_OPTION_NORMAL0 = 2,
  GRAPHIC_OPTION_NORMAL1 = 3,
  GRAPHIC_OPTION_LOW0 = 4,
  GRAPHIC_OPTION_LOW1 = 5,
  GRAPHIC_OPTION_VERYLOW = 6,
  GRAPHIC_OPTION_COUNT = 7,
  RESOLUTION_WIDTH = 1280,
  RESOLUTION_HEIGHT = 720,
  currentScreenModeIdx = 0,
  currentScreenShotFormat = 0,
  currentScreenShotSize = 0,
  currentEffectLOD = 0,
  currentColorBlind = 0,
  currentSelfPlayerOnlyEffect = false,
  currentSelfPlayerOnlyLantern = false,
  currentNearestPlayerOnlyEffect = false,
  currentLowPower = false,
  currentUpscaleEnable = false,
  currentCropModeEnable = false,
  currentCropModeScaleX = 0,
  currentCropModeScaleY = 0,
  currentLUT = 0,
  currentAutoOptimization = true,
  currentOptimizationFrame = 20,
  currentEffectOption = true,
  currentEffectOptionFrame = 1,
  currentPlayerEffectOption = true,
  currentPlayerEffectOptionFrame = 50,
  currentCharacterDistUpdate = true,
  currentPlayerHide = false,
  currentScreenResolutionIdx = 0,
  currentTextureQualityIdx = 0,
  currentGraphicOptionIdx = 0,
  currentGammaValue = 0,
  currentContrastValue = 0,
  currentCheckDof = true,
  currentCheckAA = true,
  currentCheckUltra = false,
  currentCheckLensBlood = true,
  currentCheckBloodEffect = true,
  currentCheckSSAO = true,
  currentCheckTessellation = true,
  currentCheckPostFilter = true,
  currentCheckCharacterEffect = true,
  currentCheckUIScale = 1,
  currentCheckRepresent = true,
  currentCheckSnowPoolOnlyInSafeZone = false,
  currentCheckWorkerVisible = true,
  currentMaster = 0,
  currentMusic = 0,
  currentFxSound = 0,
  currentEnvSound = 0,
  currentDlgSound = 0,
  currentHitFxWeight = 0,
  currentPlayerVolume = 0,
  currentCheckMusic = true,
  currentCheckSound = true,
  currentCheckEnvSound = true,
  currentCheckCombatMusic = CppEnums.BattleSoundType.Sound_Nomal,
  currentCheckNpcVoice = getGameServiceResType(),
  currentCheckRiddingMusic = true,
  currentCheckWhisperMusic = true,
  currentCheckTraySoundOnOff = true,
  currentCheckNameTag = false,
  currentCheckShowSkillCmd = true,
  currentCheckShowComboGuide = true,
  currentCheckAutoAim = true,
  currentCheckHideWindowByAttacked = true,
  currentCheckShowGuildLoginMessage = true,
  currentCheckEnableSimpleUI = true,
  currentCheckRenderCharacterColor = true,
  currentCheckEnableOVR = true,
  currentCheckMiniMapRotation = false,
  currentCheckRejectInvitation = false,
  currentCheckEffectAlpha = 1,
  currentCheckCameraMasterPower = 1,
  currentCheckColorByPass = 1,
  currentCheckCameraShakePower = 0.5,
  currentCheckMotionBlurPower = 0.5,
  currentCheckCameraPosPower = 0.7,
  currentCheckCameraFovPower = 0.7,
  currentCheckMouseMove = false,
  currentCheckMouseInvertX = false,
  currentCheckMouseInvertY = false,
  currentCheckMouseSensitivityX = 1.05,
  currentCheckMouseSensitivityY = 1.05,
  currentCheckPadEnable = false,
  currentCheckPadVibration = false,
  currentCheckPadInvertX = false,
  currentCheckPadInvertY = false,
  currentCheckPadSensitivityX = 1.05,
  currentCheckPadSensitivityY = 1.05,
  currentCheckPadConsoleUIMode = false,
  currentCheckPadConsoleComboMode = false,
  currentCheckIsHideMast = true,
  currentCheckShowCashAlert = false,
  currentSelfPlayerNameTagVisible = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  currentOtherPlayerNameTagVisible = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  currentPartyPlayerNameTagVisible = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  currentGuildPlayerNameTagVisible = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  currentRankingPlayerNameTagVisible = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  currentNavPathEffectType = CppEnums.NavPathEffectType.eNavPathEffectType_Arrow,
  currentWorldMapOpenType = CppEnums.WorldMapAnimationStyle.noAnimation,
  currentWorldMapCameraType = CppEnums.WorldMapCameraPitchType.eWorldMapCameraPitchType_Default,
  currentServiceResourceType = CppEnums.ServiceResourceType.eServiceResourceType_KR,
  currentChatChannelType = CppEnums.ServiceResourceType.eServiceResourceType_KR,
  currentFovValue = 50,
  currentCheckIsUIModeMouseLock = false,
  currentCheckShowAttackEffect = true,
  currentCheckBlackSpiritAlert = true,
  currentCheckIsPvpRefuse = false,
  currentCheckIsExchangeRefuse = false,
  currentCheckIsOnScreenSaver = true,
  currentCheckUseNewQuickSlot = false,
  currentGuideLineZoneChange = false,
  currentGuideLineWarAlly = false,
  currentGuideLineGuild = false,
  currentGuideLineQuestLine = true,
  currentGuideLineNonWarPlayer = false,
  currentGuideLineParty = false,
  currentGuideLineHumanRelation = true,
  currentGuideLineEnemy = false,
  currentGuideLinePartyMemberEffect = false,
  appliedScreenModeIdx = 0,
  appliedScreenShotFormat = 0,
  appliedScreenShotSize = 0,
  appliedEffectLOD = 0,
  appliedColorBlind = 0,
  appliedSelfPlayerOnlyEffect = true,
  appliedSelfPlayerOnlyLantern = false,
  appliedLowPower = false,
  appliedUpscaleEnable = false,
  appliedCropModeEnable = false,
  appliedCropModeScaleX = 0,
  appliedCropModeScaleY = 0,
  appliedAutoOptimization = true,
  appliedOptimizationFrame = 20,
  appliedEffectOption = true,
  appliedEffectOptionFrame = 1,
  appliedPlayerEffectOption = true,
  appliedPlayerEffectOptionFrame = 30,
  appliedCharacterDistUpdate = true,
  appliedPlayerHide = false,
  appliedLUT = 0,
  appliedScreenResolutionIdx = 0,
  appliedTextureQualityIdx = 0,
  appliedGraphicOptionIdx = 0,
  appliedGammaValue = 0,
  appliedContrastValue = 0,
  appliedCheckDof = true,
  appliedCheckAA = true,
  appliedCheckUltra = false,
  appliedCheckLensBlood = true,
  appliedCheckBloodEffect = true,
  appliedCheckRepresent = true,
  appliedCheckSnowPoolOnlyInSafeZone = false,
  appliedCheckSSAO = true,
  appliedCheckTessellation = true,
  appliedCheckPostFilter = true,
  appliedCheckCharacterEffect = true,
  appliedCheckUIScale = 1,
  appliedCheckEffectAlpha = 1,
  appliedMaster = 0,
  appliedMusic = 0,
  appliedFxSound = 0,
  appliedEnvSound = 0,
  appliedDlgSound = 0,
  appliedHitFxWeight = 0,
  appliedPlayerVolume = 0,
  appliedCheckMusic = true,
  appliedCheckSound = true,
  appliedCheckEnvSound = true,
  appliedCheckCombatMusic = CppEnums.BattleSoundType.Sound_Nomal,
  appliedCheckNpcVoice = getGameServiceResType(),
  appliedCheckRiddingMusic = true,
  appliedCheckWhisperMusic = true,
  appliedCheckTraySoundOnOff = true,
  appliedCheckNameTag = false,
  appliedCheckShowSkillCmd = true,
  appliedCheckShowComboGuide = true,
  appliedCheckAutoAim = true,
  appliedCheckHideWindowByAttacked = true,
  appliedCheckShowGuildLoginMessage = true,
  appliedCheckEnableSimpleUI = true,
  appliedCheckRenderCharacterColor = true,
  appliedCheckEnableOVR = true,
  appliedCheckMiniMapRotation = false,
  appliedCheckRejectInvitation = false,
  appliedCheckCameraMasterPower = 1,
  appliedCheckCameraShakePower = 0.5,
  appliedCheckMotionBlurPower = 0.5,
  appliedCheckCameraPosPower = 0.7,
  appliedCheckCameraFovPower = 0.7,
  appliedCheckMouseMove = false,
  appliedCheckMouseInvertX = false,
  appliedCheckMouseInvertY = false,
  appliedCheckMouseSensitivityX = 1.05,
  appliedCheckMouseSensitivityY = 1.05,
  appliedCheckPadEnable = false,
  appliedCheckPadVibration = false,
  appliedCheckPadInvertX = false,
  appliedCheckPadInvertY = false,
  appliedCheckPadSensitivityX = 1.05,
  appliedCheckPadSensitivityY = 1.05,
  appliedCheckPadConsoleUIMode = false,
  appliedCheckPadConsoleComboMode = false,
  appliedCheckIsHideMast = true,
  appliedCheckShowCashAlert = false,
  appliedCheckSelfNameShow = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  appliedOtherPlayerNameTagVisible = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  appliedPartyPlayerNameTagVisible = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  appliedGuildPlayerNameTagVisible = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  appliedRankingPlayerNameTagVisible = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  appliedPetObjectShow = CppEnums.PetVisibleType.ePetVisibleType_All,
  appliedWatermarkPosition = CppEnums.WatermarkPositionType.eWatermarkPositionType_RightDown,
  appliedWatermarkScale = CppEnums.WatermarkScaleType.eWatermarkScaleType_Regular,
  appliedWatermarkService = CppEnums.WatermarkServiceType.eWatermarkServiceType_KR,
  appliedWatermarkAlpha = 0.5,
  appliedFontResizeType = 0,
  appliedNavPathEffectType = CppEnums.NavPathEffectType.eNavPathEffectType_Arrow,
  appliedWorldMapOpenType = CppEnums.WorldMapAnimationStyle.noAnimation,
  appliedWorldMapCameraType = CppEnums.WorldMapAnimationStyle.eWorldMapCameraPitchType_Default,
  appliedServiceResourceType = CppEnums.ServiceResourceType.eServiceResourceType_KR,
  appliedChatChannelType = CppEnums.ServiceResourceType.eServiceResourceType_KR,
  appliedFovValue = 50,
  appliedCheckWorkerVisible = true,
  appliedCheckIsUIModeMouseLock = false,
  appliedCheckShowAttackEffect = true,
  appliedCheckBlackSpiritAlert = true,
  appliedCheckIsPvpRefuse = false,
  appliedCheckIsExchangeRefuse = false,
  appliedCheckIsOnScreenSaver = true,
  appliedCheckUseNewQuickSlot = false,
  appliedGuideLineZoneChange = false,
  appliedGuideLineWarAlly = false,
  appliedGuideLineGuild = false,
  appliedGuideLineQuestLine = true,
  appliedGuideLineNonWarPlayer = false,
  appliedGuideLineParty = false,
  appliedGuideLineHumanRelation = true,
  appliedGuideLineEnemy = false,
  appliedGuideLinePartyMemberEffect = false,
  savedScreenModeIdx = 0,
  savedScreenShotFormat = 0,
  savedScreenShotSize = 0,
  savedEffectLOD = 0,
  savedColorBlind = 0,
  savedSelfPlayerOnlyEffect = true,
  savedNearestPlayerOnlyEffect = true,
  savedSelfPlayerOnlyLantern = false,
  savedLowPower = false,
  savedUpscaleEnable = false,
  savedCropModeEnable = false,
  savedCropModeScaleX = 0,
  savedCropModeScaleY = 0,
  savedAutoOptimization = true,
  savedOptimizationFrame = 20,
  savedLUT = 0,
  savedScreenResolutionIdx = 0,
  savedTextureQualityIdx = 0,
  savedGraphicOptionIdx = 0,
  savedGammaValue = 0,
  savedContrastValue = 0,
  savedCheckDof = true,
  savedCheckAA = true,
  savedCheckUltra = false,
  savedCheckLensBlood = true,
  savedCheckBloodEffect = true,
  savedCheckRepresent = true,
  savedCheckSnowPoolOnlyInSafeZone = false,
  savedCheckSSAO = true,
  savedCheckTessellation = true,
  savedCheckPostFilter = true,
  savedCheckCharacterEffect = true,
  savedCheckUIScale = 1,
  savedCheckWorkerVisible = true,
  savedMaster = 0,
  savedMusic = 0,
  savedFxSound = 0,
  savedEnvSound = 0,
  savedDlgSound = 0,
  savedHitFxWeight = 0,
  savedPlayerVolume = 0,
  savedCheckMusic = true,
  savedCheckSound = true,
  savedCheckEnvSound = true,
  savedCheckCombatMusic = CppEnums.BattleSoundType.Sound_Nomal,
  savedCheckNpcVoice = getGameServiceResType(),
  savedCheckRiddingMusic = true,
  savedCheckWhisperMusic = true,
  savedCheckTraySoundOnOff = true,
  savedCheckNameTag = false,
  savedCheckShowSkillCmd = true,
  savedCheckShowComboGuide = true,
  savedCheckAutoAim = true,
  savedCheckHideWindowByAttacked = true,
  savedCheckShowGuildLoginMessage = true,
  savedCheckEnableSimpleUI = true,
  savedCheckRenderCharacterColor = true,
  savedCheckEnableOVR = true,
  savedCheckMiniMapRotation = false,
  savedCheckRejectInvitation = false,
  savedCheckCameraMasterPower = 1,
  savedCheckColorByPass = 1,
  savedCheckCameraShakePower = 0.5,
  savedCheckMotionBlurPower = 0.5,
  savedCheckCameraPosPower = 0.7,
  savedCheckCameraFovPower = 0.7,
  savedCheckEffectAlpha = 1,
  savedCheckMouseMove = false,
  savedCheckMouseInvertX = false,
  savedCheckMouseInvertY = false,
  savedCheckMouseSensitivityX = 1.05,
  savedCheckMouseSensitivityY = 1.05,
  savedCheckPadEnable = false,
  savedCheckPadVibration = false,
  savedCheckPadInvertX = false,
  savedCheckPadInvertY = false,
  savedCheckPadSensitivityX = 1.05,
  savedCheckPadSensitivityY = 1.05,
  savedCheckPadConsoleUIMode = false,
  savedCheckPadConsoleComboMode = false,
  savedCheckIsHideMast = true,
  savedCheckShowCasheAlert = false,
  savedCheckSelfNameShow = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  savedOtherPlayerNameTagVisible = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  savedPartyPlayerNameTagVisible = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  savedGuildPlayerNameTagVisible = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  savedRankingPlayerNameTagVisible = CppEnums.VisibleNameTagType.eVisibleNameTagType_AllwaysShow,
  savedPetObjectShow = CppEnums.PetVisibleType.ePetVisibleType_All,
  savedFontResizeType = 0,
  savedNavPathEffectType = CppEnums.NavPathEffectType.eNavPathEffectType_Arrow,
  savedWorldMapOpenType = CppEnums.WorldMapAnimationStyle.noAnimation,
  savedWorldMapCameraType = CppEnums.WorldMapCameraPitchType.eWorldMapCameraPitchType_Default,
  savedServiceResourceType = CppEnums.ServiceResourceType.eServiceResourceType_KR,
  savedChatChannelType = CppEnums.ServiceResourceType.eServiceResourceType_KR,
  savedFovValue = 50,
  savedCheckIsUIModeMouseLock = false,
  savedCheckShowAttackEffect = true,
  savedCheckBlackSpiritAlert = true,
  savedCheckIsPvpRefuse = false,
  savedCheckIsExchangeRefuse = false,
  savedCheckIsOnScreenSaver = true,
  savedCheckUseNewQuickSlot = false,
  savedCheckGuideLineZoneChange = false,
  savedCheckGuideLineWarAlly = false,
  savedCheckGuideLineGuild = false,
  savedCheckGuideLineQuestLine = true,
  savedCheckGuideLineNonWarPlayer = false,
  savedCheckGuideLineParty = false,
  savedCheckGuideLineHumanRelation = true,
  savedCheckGuideLineEnemy = false,
  savedCheckGuideLinePartyMemberEffect = false,
  petForSiegeOption = false
}
local simpleToolTipIdx = {
  _btn_ScreenMode0 = 0,
  _btn_ScreenMode1 = 1,
  _btn_ScreenMode2 = 2,
  _btn_ScrSize = 3,
  _btn_Trxt = 4,
  _btn_Rndr = 5,
  _btn_AntiAlli = 6,
  _btn_SSAO = 7,
  _btn_PostFilter = 8,
  _btn_DOF = 9,
  _btn_Tessellation = 10,
  _btn_Ultra = 11,
  _btn_BloodEffect = 12,
  _btn_LensBlood = 13,
  _btn_CharacterEffect = 14,
  _btn_SelfPlayerOnlyEffect = 15,
  _btn_SelfPlayerOnlyLantern = 16,
  _btn_CropModeEnable = 17,
  _btn_CropModeScaleX = 18,
  _btn_CropModeScaleY = 19,
  _btn_UpscaleEnable = 20,
  _btn_UIScale = 21,
  _btn_CameraMaster = 22,
  _btn_CameraShake = 23,
  _btn_MotionBlur = 24,
  _btn_CameraPos = 25,
  _btn_CameraFov = 26,
  _btn_LUT = 27,
  _btn_LUT_Reset = 28,
  _btn_Gamma = 29,
  _btn_Contrast = 30,
  _btn_Fov = 31,
  _btn_MusicOnOff = 32,
  _btn_FXOnOff = 33,
  _btn_EnvFXOnOff = 34,
  _btn_TotalVol = 35,
  _btn_MusicVol = 36,
  _btn_FxVol = 37,
  _btn_EnvFxVol = 38,
  _btn_VoiceVol = 39,
  _btn_hitFxVolume = 40,
  _btn_hitFxWeightVolume = 41,
  _btn_otherPlayerVolume = 42,
  _btn_AutoAim = 43,
  _btn_HideWindow = 44,
  _btn_GuildLogin = 45,
  _btn_RejectInvitation = 46,
  _btn_EnableSimpleUI = 47,
  _btn_SpiritGuide = 48,
  _btn_MouseMove = 49,
  _btn_EnableOVR = 50,
  _btn_SelfNameShowAllways = 51,
  _btn_SelfNameShowImportant = 52,
  _btn_SelfNameShowNoShow = 53,
  _btn_OtherNameShow = 54,
  _btn_PartyNameShow = 55,
  _btn_GuildNameShow = 56,
  _btn_Alert_Region = 57,
  _btn_Alert_TerritoryTrade = 58,
  _btn_Alert_RoyalTrade = 59,
  _btn_Alert_Fitness = 60,
  _btn_Alert_TerritoryWar = 61,
  _btn_Alert_GuildWar = 62,
  _btn_Alert_PlayerGotItem = 63,
  _btn_Alert_ItemMarket = 64,
  _btn_Alert_LifeLevUp = 65,
  _btn_Alert_GuildQuest = 66,
  _btn_MouseX = 67,
  _btn_MouseY = 68,
  _btn_MouXSen = 69,
  _btn_MouYSen = 70,
  _btn_UsePad = 71,
  _btn_UseVibe = 72,
  _btn_PadX = 73,
  _btn_PadY = 74,
  _btn_PadXSen = 75,
  _btn_PadYSen = 76,
  _btn_MiniMapRotation = 77,
  _btn_NearestPlayerOnlyEffect = 78,
  _btn_PetAll = 79,
  _btn_PetMine = 80,
  _btn_PetHide = 81,
  _btn_NavGuideNone = 82,
  _btn_NavGuideArrow = 83,
  _btn_NavGuideEffect = 84,
  _btn_NavGuideFairy = 85,
  _btn_ShowAttackEffect = 86,
  _btn_Alert_BlackSpirit = 87,
  _btn_RiddingOnOff = 88,
  _btn_CombatAllwaysOn = 89,
  _btn_CombatAllwaysOff = 90,
  _btn_CombatAllwaysLowOff = 91,
  _btn_UseNewQuickSlot = 92,
  _btn_UseChattingFilter = 93,
  _btn_GuideLineHumanRelation = 94,
  _btn_GuideLineZoneChange = 95,
  _btn_GuideLineWarAlly = 96,
  _btn_GuideLineGuild = 97,
  _btn_GuideLineParty = 98,
  _btn_GuideLineEnemy = 99,
  _btn_GuideLineNonWarPlayer = 100,
  _btn_GuideLineQuestObject = 101,
  _btn_IsOnScreenSaver = 102,
  _btn_WhisperOnOff = 103,
  _btn_UIModeMouseLock = 104,
  _btn_PvpRefuse = 105,
  _btn_TraySoundOnOff = 106,
  _btn_ColorBlind_None = 107,
  _btn_ColorBlind_Red = 108,
  _btn_ColorBlind_Green = 109,
  _btn_WorldMapOpenByWestMaintain = 110,
  _btn_WorldMapOpenByCharacterToWest = 111,
  _btn_WorldMapOpenByCharacterMaintain = 112,
  _btn_WorldMapOpenByNone = 113,
  _btn_WorldMapCameraAngle = 114,
  _btn_WorldMapCameraDefaultAngle = 115,
  _btn_WorldMapCameraDegree30 = 116,
  _btn_WorldMapCameraDegree90 = 117,
  _btn_Alert_NearMonster = 118,
  _btn_GuideLinePartyEffect = 119,
  _btn_WorkerVisible = 120,
  _btn_AutoOptimization = 121,
  _btn_AutoOptimizationSlide = 122,
  _btn_HideMast = 123,
  _btn_ShowCashAlert = 124,
  _btn_FontResizeDefault = 125,
  _btn_FontResizeBig = 126,
  _btn_FontResizeMoreBig = 127,
  _btn_SnowPoolOnlyInSafeZone = 128,
  _btn_Alert_ServantMarket = 129,
  _btn_LowPower = 130,
  _btn_ScreenShotSize_4k = 131,
  _btn_ScreenShotSize_8k = 132,
  _btn_EffectAlpha = 133,
  _btn_ExchangeRefuse = 134,
  _btn_ScreenShotSize_Default = 135,
  _btn_ConsoleMode = 136,
  _btn_ComboMode = 137,
  _btn_RankingNameShow = 138,
  _btn_EffectOption = 139,
  _btn_EffectOptionSlide = 140,
  _btn_PlayerEffectOption = 141,
  _btn_PlayerEffectOptionSlide = 142,
  _btn_CharacterDistUpdate = 144,
  _btn_PlayerHide = 145,
  _btn_WorkerInvisible = 147
}
PaGlobal_GameOption_Optimization = {
  _frame_Optimization = UI.getChildControl(Panel_GameOption_Optimization, "Frame_Optimization")
}
function PaGlobal_GameOption_Optimization:Init()
  self._frameContent_Optimization = UI.getChildControl(self._frame_Optimization, "Frame_1_Content")
  self._ui = {
    _optimization_sld = UI.getChildControl(self._frame_Optimization, "Frame_1_VerticalScroll"),
    _btn_Reset = UI.getChildControl(self._frameContent_Optimization, "Button_Reset"),
    _btn_Trxt = UI.getChildControl(self._frameContent_Optimization, "Button_TexQuality"),
    _btn_Trxt_L = UI.getChildControl(self._frameContent_Optimization, "Button_Txtr_L"),
    _btn_Trxt_R = UI.getChildControl(self._frameContent_Optimization, "Button_Txtr_R"),
    _btn_Rndr = UI.getChildControl(self._frameContent_Optimization, "Button_RenderQuality"),
    _btn_Rndr_L = UI.getChildControl(self._frameContent_Optimization, "Button_Rndr_L"),
    _btn_Rndr_R = UI.getChildControl(self._frameContent_Optimization, "Button_Rndr_R"),
    _btn_AntiAlli = UI.getChildControl(self._frameContent_Optimization, "CheckButton_Anti"),
    _btn_SSAO = UI.getChildControl(self._frameContent_Optimization, "CheckButton_SSAO"),
    _btn_PostFilter = UI.getChildControl(self._frameContent_Optimization, "CheckButton_PostFilter"),
    _btn_DOF = UI.getChildControl(self._frameContent_Optimization, "CheckButton_DOF"),
    _btn_Tessellation = UI.getChildControl(self._frameContent_Optimization, "CheckButton_Tessellation"),
    _btn_Ultra = UI.getChildControl(self._frameContent_Optimization, "CheckButton_Ultra"),
    _btn_CharacterEffect = UI.getChildControl(self._frameContent_Optimization, "CheckButton_CharacterEffect"),
    _btn_Represent = UI.getChildControl(self._frameContent_Optimization, "CheckButton_Representativepartmodel"),
    _btn_SnowPoolOnlyInSafeZone = UI.getChildControl(self._frameContent_Optimization, "CheckButton_SnowPoolOnlyInSafeZone"),
    _txt_FPS = UI.getChildControl(self._frameContent_Optimization, "StaticText_FPS"),
    _slideText_FrameRate = UI.getChildControl(self._frameContent_Optimization, "StaticText_FPS_MID"),
    _btn_AutoOptimization = UI.getChildControl(self._frameContent_Optimization, "CheckButton_AutoOptimization"),
    _slide_AutoOptimization = UI.getChildControl(self._frameContent_Optimization, "Slider_AutoOptimization"),
    _btn_EffectOption = UI.getChildControl(self._frameContent_Optimization, "CheckButton_EffectOption"),
    _slide_AutoOptimization = UI.getChildControl(self._frameContent_Optimization, "Slider_AutoOptimization"),
    _slide_EffectOption = UI.getChildControl(self._frameContent_Optimization, "Slider_EffectOption"),
    _btn_PlayerEffectOption = UI.getChildControl(self._frameContent_Optimization, "CheckButton_PlayerEffectOption"),
    _slide_PlayerEffectOption = UI.getChildControl(self._frameContent_Optimization, "Slider_PlayerEffectOption"),
    _slideText_PlayerEffectFrame = UI.getChildControl(self._frameContent_Optimization, "StaticText_PlayerEffectFrame"),
    _btn_CharacterDistUpdate = UI.getChildControl(self._frameContent_Optimization, "CheckButton_useCharacterDistUpdate"),
    _btn_playerHide = UI.getChildControl(self._frameContent_Optimization, "CheckButton_playerHide"),
    _btn_UpscaleEnable = UI.getChildControl(self._frameContent_Optimization, "CheckButton_Upscale"),
    _btn_LowPower = UI.getChildControl(self._frameContent_Optimization, "CheckButton_LowPower"),
    _btn_ShowAttackEffect = UI.getChildControl(self._frameContent_Optimization, "CheckBox_ShowAttackEffect"),
    _txt_CameraMaster = UI.getChildControl(self._frameContent_Optimization, "StaticText_CameraMaster"),
    _slide_CameraMaster = UI.getChildControl(self._frameContent_Optimization, "Slider_CameraMasterControl"),
    _txt_Fov = UI.getChildControl(self._frameContent_Optimization, "StaticText_FovControl"),
    _slide_Fov = UI.getChildControl(self._frameContent_Optimization, "Slider_FovControl"),
    _btn_PetAll = UI.getChildControl(self._frameContent_Optimization, "RadioButton_PetVisualAll"),
    _btn_PetMine = UI.getChildControl(self._frameContent_Optimization, "RadioButton_PetVisualMine"),
    _btn_PetHide = UI.getChildControl(self._frameContent_Optimization, "RadioButton_PetVisualHide"),
    _btn_WorkerVisible = UI.getChildControl(self._frameContent_Optimization, "RadioButton_WorkerVisual"),
    _btn_WorkerInvisible = UI.getChildControl(self._frameContent_Optimization, "RadioButton_WorkerInvisual")
  }
  self._sld_btn = {
    _btn_AutoOptimizationSlide = UI.getChildControl(self._ui._slide_AutoOptimization, "Slider_AutoOptimization_Button"),
    _btn_CameraMaster = UI.getChildControl(self._ui._slide_CameraMaster, "Slider_CameraMaster_Button"),
    _btn_Fov = UI.getChildControl(self._ui._slide_Fov, "Slider_FovControl_Button"),
    _btn_EffectOptionSlide = UI.getChildControl(self._ui._slide_EffectOption, "Slider_EffectOption_Button"),
    _btn_PlayerEffectOptionSlide = UI.getChildControl(self._ui._slide_PlayerEffectOption, "Slider_PlayerEffectOption_Button"),
    _btn_optimizationSlide = UI.getChildControl(self._ui._optimization_sld, "Frame_1_VerticalScroll_CtrlButton")
  }
  self._pictureTooltip = {
    [0] = UI.getChildControl(self._frameContent_Optimization, "Static_trxt"),
    [1] = UI.getChildControl(self._frameContent_Optimization, "Static_AntiAlli"),
    [2] = UI.getChildControl(self._frameContent_Optimization, "Static_Dof"),
    [3] = UI.getChildControl(self._frameContent_Optimization, "Static_Tesselation"),
    [4] = UI.getChildControl(self._frameContent_Optimization, "Static_Ssao"),
    [5] = UI.getChildControl(self._frameContent_Optimization, "Static_NpcDetail")
  }
  Panel_Window_Option:AddChild(self._frame_Optimization)
  Panel_GameOption_Optimization:RemoveControl(self._frame_Optimization)
end
function PaGlobal_GameOption_Optimization:Show_PictureTooltips(isShow, tooltipType)
  for index = 0, #self._pictureTooltip do
    self._pictureTooltip[index]:SetShow(false)
  end
  Button_Simpletooltips(false)
  if not isShow then
    return
  end
  self._pictureTooltip[tooltipType]:SetShow(true)
  self._pictureTooltip[tooltipType]:ComputePos()
  if 0 == tooltipType then
    local posY = self._ui._btn_Trxt:GetPosY()
    self._pictureTooltip[tooltipType]:SetPosY(posY + 30)
  elseif 1 == tooltipType then
    local posY = self._ui._btn_AntiAlli:GetPosY()
    self._pictureTooltip[tooltipType]:SetPosY(posY + 30)
  elseif 2 == tooltipType then
    local posY = self._ui._btn_DOF:GetPosY()
    self._pictureTooltip[tooltipType]:SetPosY(posY + 30)
  elseif 3 == tooltipType then
    local posY = self._ui._btn_Tessellation:GetPosY()
    self._pictureTooltip[tooltipType]:SetPosY(posY + 30)
  elseif 4 == tooltipType then
    local posY = self._ui._btn_SSAO:GetPosY()
    self._pictureTooltip[tooltipType]:SetPosY(posY + 30)
  elseif 5 == tooltipType then
    local posY = self._ui._btn_Represent:GetPosY()
    self._pictureTooltip[tooltipType]:SetPosY(posY + 30)
  end
end
function PaGlobal_GameOption_Optimization:RegistEvnetHandler()
  self._ui._btn_Reset:addInputEvent("Mouse_LUp", "GameOption_OptimizationReset()")
  self._ui._btn_Trxt:addInputEvent("Mouse_LUp", "GameOption_TextureQualityIncrease()")
  self._ui._btn_Trxt:addInputEvent("Mouse_On", "PaGlobal_GameOption_Optimization:Show_PictureTooltips( true , " .. 0 .. ")")
  self._ui._btn_Trxt:addInputEvent("Mouse_Out", "PaGlobal_GameOption_Optimization:Show_PictureTooltips( false )")
  self._ui._btn_Trxt_L:addInputEvent("Mouse_LUp", "GameOption_TextureQualityDecrease()")
  self._ui._btn_Trxt_R:addInputEvent("Mouse_LUp", "GameOption_TextureQualityIncrease()")
  self._ui._btn_Rndr:addInputEvent("Mouse_LUp", "GameOption_GraphicOptionIncrease()")
  self._ui._btn_Rndr:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_Rndr .. ")")
  self._ui._btn_Rndr:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_Rndr .. ")")
  self._ui._btn_Rndr:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_Rndr_L:addInputEvent("Mouse_LUp", "GameOption_GraphicOptionDecrease()")
  self._ui._btn_Rndr_R:addInputEvent("Mouse_LUp", "GameOption_GraphicOptionIncrease()")
  self._ui._btn_AntiAlli:addInputEvent("Mouse_LUp", "GameOption_CheckAA()")
  self._ui._btn_AntiAlli:addInputEvent("Mouse_On", "PaGlobal_GameOption_Optimization:Show_PictureTooltips( true , " .. 1 .. ")")
  self._ui._btn_AntiAlli:addInputEvent("Mouse_Out", "PaGlobal_GameOption_Optimization:Show_PictureTooltips( false )")
  self._ui._btn_SSAO:addInputEvent("Mouse_LUp", "GameOption_CheckSSAO()")
  self._ui._btn_SSAO:addInputEvent("Mouse_On", "PaGlobal_GameOption_Optimization:Show_PictureTooltips( true , " .. 4 .. ")")
  self._ui._btn_SSAO:addInputEvent("Mouse_Out", "PaGlobal_GameOption_Optimization:Show_PictureTooltips( false )")
  self._ui._btn_PostFilter:addInputEvent("Mouse_LUp", "GameOption_CheckPostFilter()")
  self._ui._btn_PostFilter:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_PostFilter .. ")")
  self._ui._btn_PostFilter:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_PostFilter .. ")")
  self._ui._btn_PostFilter:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_DOF:addInputEvent("Mouse_LUp", "GameOption_CheckDof()")
  self._ui._btn_DOF:addInputEvent("Mouse_On", "PaGlobal_GameOption_Optimization:Show_PictureTooltips( true , " .. 2 .. ")")
  self._ui._btn_DOF:addInputEvent("Mouse_Out", "PaGlobal_GameOption_Optimization:Show_PictureTooltips( false )")
  self._ui._btn_Tessellation:addInputEvent("Mouse_LUp", "GameOption_CheckTessellation()")
  self._ui._btn_Tessellation:addInputEvent("Mouse_On", "PaGlobal_GameOption_Optimization:Show_PictureTooltips( true , " .. 3 .. ")")
  self._ui._btn_Tessellation:addInputEvent("Mouse_Out", "PaGlobal_GameOption_Optimization:Show_PictureTooltips( false )")
  self._ui._btn_Ultra:addInputEvent("Mouse_LUp", "GameOption_CheckUltra()")
  self._ui._btn_Ultra:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_Ultra .. ")")
  self._ui._btn_Ultra:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_Ultra .. ")")
  self._ui._btn_Ultra:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_CharacterEffect:addInputEvent("Mouse_LUp", "GameOption_CheckCharacterEffect()")
  self._ui._btn_CharacterEffect:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_CharacterEffect .. ")")
  self._ui._btn_CharacterEffect:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_CharacterEffect .. ")")
  self._ui._btn_CharacterEffect:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_Represent:addInputEvent("Mouse_LUp", "GameOption_CheckRepresent()")
  self._ui._btn_Represent:addInputEvent("Mouse_On", "PaGlobal_GameOption_Optimization:Show_PictureTooltips( true , " .. 5 .. ")")
  self._ui._btn_Represent:addInputEvent("Mouse_Out", "PaGlobal_GameOption_Optimization:Show_PictureTooltips( false )")
  self._ui._btn_WorkerVisible:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_WorkerVisible .. ")")
  self._ui._btn_WorkerVisible:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_WorkerVisible .. ")")
  self._ui._btn_WorkerVisible:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_WorkerInvisible:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_WorkerInvisible .. ")")
  self._ui._btn_WorkerInvisible:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_WorkerInvisible .. ")")
  self._ui._btn_WorkerInvisible:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_SnowPoolOnlyInSafeZone:addInputEvent("Mouse_LUp", "GameOption_CheckSnowPoolOnlyInSafeZone()")
  self._ui._btn_SnowPoolOnlyInSafeZone:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_SnowPoolOnlyInSafeZone .. ")")
  self._ui._btn_SnowPoolOnlyInSafeZone:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_SnowPoolOnlyInSafeZone .. ")")
  self._ui._btn_SnowPoolOnlyInSafeZone:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_AutoOptimization:addInputEvent("Mouse_LUp", "GameOption_CheckAutoOptimization()")
  self._ui._btn_AutoOptimization:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_AutoOptimization .. ")")
  self._ui._btn_AutoOptimization:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_AutoOptimization .. ")")
  self._ui._btn_AutoOptimization:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._slide_AutoOptimization:addInputEvent("Mouse_LUp", "GameOption_AutoOptimization_slider()")
  self._ui._slide_AutoOptimization:addInputEvent("Mouse_LPress", "GameOption_AutoOptimization_slider()")
  self._ui._btn_EffectOption:addInputEvent("Mouse_LUp", "GameOption_EffectOption()")
  self._ui._btn_EffectOption:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_EffectOption .. ")")
  self._ui._btn_EffectOption:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_EffectOption .. ")")
  self._ui._btn_EffectOption:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_PlayerEffectOption:addInputEvent("Mouse_LUp", "GameOption_PlayerEffectOption()")
  self._ui._btn_PlayerEffectOption:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_PlayerEffectOption .. ")")
  self._ui._btn_PlayerEffectOption:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_PlayerEffectOption .. ")")
  self._ui._btn_PlayerEffectOption:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_CharacterDistUpdate:addInputEvent("Mouse_LUp", "GameOption_CharacterDistUpdate()")
  self._ui._btn_CharacterDistUpdate:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_CharacterDistUpdate .. ")")
  self._ui._btn_CharacterDistUpdate:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_CharacterDistUpdate .. ")")
  self._ui._btn_CharacterDistUpdate:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_playerHide:addInputEvent("Mouse_LUp", "GameOption_PlayerHide()")
  self._ui._btn_playerHide:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_PlayerHide .. ")")
  self._ui._btn_playerHide:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_PlayerHide .. ")")
  self._ui._btn_playerHide:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_UpscaleEnable:addInputEvent("Mouse_LUp", "GameOption_CheckUpscale()")
  self._ui._btn_UpscaleEnable:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_UpscaleEnable .. ")")
  self._ui._btn_UpscaleEnable:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_UpscaleEnable .. ")")
  self._ui._btn_UpscaleEnable:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_LowPower:addInputEvent("Mouse_LUp", "GameOption_CheckLowPower()")
  self._ui._btn_LowPower:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_LowPower .. ")")
  self._ui._btn_LowPower:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_LowPower .. ")")
  self._ui._btn_LowPower:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_ShowAttackEffect:addInputEvent("Mouse_LUp", "GameOption_CheckShowAttackEffect()")
  self._ui._btn_ShowAttackEffect:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_ShowAttackEffect .. ")")
  self._ui._btn_ShowAttackEffect:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_ShowAttackEffect .. ")")
  self._ui._btn_ShowAttackEffect:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._slide_CameraMaster:addInputEvent("Mouse_LPress", "GameOption_CameraMasterPower_slider()")
  self._ui._slide_Fov:addInputEvent("Mouse_LPress", "GameOption_ChangeFov_slider()")
  self._ui._btn_PetAll:addInputEvent("Mouse_LUp", "GameOption_CheckPetObjectShow()")
  self._ui._btn_PetMine:addInputEvent("Mouse_LUp", "GameOption_CheckPetObjectShow()")
  self._ui._btn_PetHide:addInputEvent("Mouse_LUp", "GameOption_CheckPetObjectShow()")
  self._ui._btn_PetAll:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_PetAll .. ")")
  self._ui._btn_PetAll:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_PetAll .. ")")
  self._ui._btn_PetAll:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_PetMine:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_PetMine .. ")")
  self._ui._btn_PetMine:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_PetMine .. ")")
  self._ui._btn_PetMine:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_PetHide:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_PetHide .. ")")
  self._ui._btn_PetHide:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_PetHide .. ")")
  self._ui._btn_PetHide:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._ui._btn_WorkerVisible:addInputEvent("Mouse_LUp", "GameOption_CheckWorkerObjectShow()")
  self._ui._btn_WorkerInvisible:addInputEvent("Mouse_LUp", "GameOption_CheckWorkerObjectShow()")
  self._sld_btn._btn_AutoOptimizationSlide:addInputEvent("Mouse_LUp", "GameOption_AutoOptimization_slider()")
  self._sld_btn._btn_AutoOptimizationSlide:addInputEvent("Mouse_LPress", "GameOption_AutoOptimization_slider()")
  self._sld_btn._btn_CameraMaster:addInputEvent("Mouse_LPress", "GameOption_CameraMasterPower_button()")
  self._sld_btn._btn_CameraMaster:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_CameraMaster .. ")")
  self._sld_btn._btn_CameraMaster:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_CameraMaster .. ")")
  self._sld_btn._btn_CameraMaster:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._sld_btn._btn_Fov:addInputEvent("Mouse_LPress", "GameOption_ChangeFov_button()")
  self._sld_btn._btn_Fov:addInputEvent("Mouse_On", "Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_Fov .. ")")
  self._sld_btn._btn_Fov:setTooltipEventRegistFunc("Button_Simpletooltips( true, " .. simpleToolTipIdx._btn_Fov .. ")")
  self._sld_btn._btn_Fov:addInputEvent("Mouse_Out", "Button_Simpletooltips( false )")
  self._sld_btn._btn_EffectOptionSlide:addInputEvent("Mouse_LUp", "GameOption_EffectOption_slider()")
  self._sld_btn._btn_EffectOptionSlide:addInputEvent("Mouse_LPress", "GameOption_EffectOption_slider()")
  self._sld_btn._btn_PlayerEffectOptionSlide:addInputEvent("Mouse_LUp", "GameOption_PlayerEffectOption_slider()")
  self._sld_btn._btn_PlayerEffectOptionSlide:addInputEvent("Mouse_LPress", "GameOption_PlayerEffectOption_slider()")
  self._ui._slide_EffectOption:addInputEvent("Mouse_LUp", "GameOption_EffectOption_slider()")
  self._ui._slide_EffectOption:addInputEvent("Mouse_LPress", "GameOption_EffectOption_slider()")
end
function PaGlobal_GameOption_Optimization:SetShow(isShow)
  self._frame_Optimization:SetShow(isShow)
end
function GameOption_OptimizationReset()
  local self = PaGlobal_GameOption_Optimization
  self._ui._btn_EffectOption:SetCheck(chk_Option.currentEffectOption)
  self._ui._slide_EffectOption:SetControlPos(chk_Option.currentEffectOptionFrame / 25 * 100)
  GameOption_EffectOption()
  GameOption_EffectOption_slider()
  self._ui._btn_PlayerEffectOption:SetCheck(chk_Option.currentPlayerEffectOption)
  local sliderPos = (chk_Option.currentPlayerEffectOptionFrame - 10) / 10 * 25
  if sliderPos < 0 then
    sliderPos = 0
  elseif sliderPos > 100 then
    sliderPos = 100
  end
  self._ui._slide_PlayerEffectOption:SetControlPos(sliderPos)
  GameOption_PlayerEffectOption()
  GameOption_PlayerEffectOption_slider()
  self._ui._btn_CharacterDistUpdate:SetCheck(chk_Option.currentCharacterDistUpdate)
  self._ui._btn_playerHide:SetCheck(chk_Option.currentPlayerHide)
  GameOption_DisplayOptimizationReset()
end
PaGlobal_GameOption_Optimization:Init()
PaGlobal_GameOption_Optimization:RegistEvnetHandler()
